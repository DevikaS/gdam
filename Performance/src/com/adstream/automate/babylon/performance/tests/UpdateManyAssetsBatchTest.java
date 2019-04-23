package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.ContentBatchUpdate;
import com.adstream.automate.babylon.JsonObjects.CustomMetadata;
import com.adstream.automate.babylon.JsonObjects.SearchResult;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.Gen;
import com.google.gson.JsonParser;

import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 9/26/14
 * Time: 5:54 PM
 * To change this template use File | Settings | File Templates.
 */
public class UpdateManyAssetsBatchTest extends CreateAssetTest  {
    protected static List<Content> assets = new ArrayList<Content>();
    protected static List<ContentBatchUpdate> assetsUpdate = new ArrayList<ContentBatchUpdate>();


    @Override
    public void runOnce() {
    }

    @Override
    public void beforeStart() {
        super.beforeStart();
        int count = 50 - assets.size();
        if (count > 0) {
            SearchResult<Content> result =
                    getService().findAssets(getMyAssetsCategoryId(), new LuceneSearchingParams().setResultsOnPage(count).setPageNumber(1));
            assets.addAll(result.getResult());
            count -= result.getResult().size();
            for (int i = 0; i < count; i++) {
                assets.add(createAsset());
            }
        }
        if (assetsUpdate.size()<50) {
            for (int i=0; i< 50; i++) {
                ContentBatchUpdate contentBatchUpdate = new ContentBatchUpdate();
                contentBatchUpdate.set_id(assets.get(i).getId());
                contentBatchUpdate.getCmCommon().put("name", Gen.getHumanReadableString(10));
                assetsUpdate.add(contentBatchUpdate);
            }
        }
    }

    @Override
    public void start() {
        String responseBody = getService().updateAssetsButchMetadata(assetsUpdate);
        String processId = new JsonParser().parse(responseBody).getAsJsonObject().get("processId").getAsString();
        long startTime = System.currentTimeMillis();
        int status = getStatusOfProcess(getService().getBatchProcessStatus(processId));
        while (status < 3) {
            Common.sleep(1000);
            status = getStatusOfProcess(getService().getBatchProcessStatus(processId));
            if (System.currentTimeMillis() - startTime > 300000)
                fail("Update is more than 5 minute");
        }
        if (status == 4)
            fail("Update was failed");

    }

    private int getStatusOfProcess(String responseProcess) {
        return new JsonParser().parse(responseProcess).getAsJsonObject().get("list").getAsJsonArray().get(0).getAsJsonObject().get("taskStatus").getAsInt();
    }
}
