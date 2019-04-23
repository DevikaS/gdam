package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.SearchResult;
import com.adstream.automate.babylon.JsonObjects.projectsaccessrure.ProjectsAccessRuleTerm;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.Gen;
import com.google.gson.JsonParser;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 9/24/14
 * Time: 6:01 PM

 */
public class UpdateManyAssetsTest extends CreateAssetTest {
    protected static List<Content> assets = new ArrayList<Content>();
    protected static List<String> assetsList  = new ArrayList<String>();
    private static String agencyId;


    @Override
    public void runOnce() {
    }

    @Override
    public void beforeStart() {
        super.beforeStart();
        int count = 500 - assets.size();
        if (count > 0) {
            SearchResult<Content> result =
                    getService().findAssets(getMyAssetsCategoryId(), new LuceneSearchingParams().setResultsOnPage(count).setPageNumber(1));
            assets.addAll(result.getResult());
            count -= result.getResult().size();
            for (int i = 0; i < count; i++) {
                assets.add(createAsset());
            }
        }
        if (assetsList.size()<500) {
            for (int i=0; i<100; i++) {
                assetsList.add(assets.get(i).getId());
                /*if (assetsList.contains(assets.get(i).getId()))
                    assetsList.remove(assets.get(i).getId());
                else {
                    assetsList.add(assets.get(i).getId());
                } */

            }
        }
        agencyId = getService().getAsset(assetsList.get(0)).getAgency().getId();
    }

    @Override
    public void start() {


        // 1. select 100+ assets from current list
        //getBabylonMiddlewareService().updateAssetsBulkMetadate(temp, new HashMap<String, String>());
        String responseBody = getService().updateAssetsBulkMetadata(assetsList, agencyId, Gen.getHumanReadableString(10));
        String processId = new JsonParser().parse(responseBody).getAsJsonObject().get("bulkMetadata").getAsJsonObject().get("processId").getAsString();
        long startTime = System.currentTimeMillis();
        int status = Integer.parseInt(getService().getProcessStatus(processId, 0));
        while (status < 3) {
            Common.sleep(100);
            status = Integer.parseInt(getService().getProcessStatus(processId, 0));
            if (System.currentTimeMillis() - startTime > 300000)
                fail("Update is more than 5 minute");
        }
        System.out.println("TIME: " + (System.currentTimeMillis() - startTime) + " ms.");
        if (status == 4)
            fail("Update was failed");
    }

    @Override
    public void afterRun() {
    }

}
