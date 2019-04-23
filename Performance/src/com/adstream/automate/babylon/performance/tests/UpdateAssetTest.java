package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.SearchResult;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.utils.Gen;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * User: ruslan.semerenko
 * Date: 29.10.12 9:43
 */
public class UpdateAssetTest extends CreateAssetTest {
    protected static List<Content> assets = new ArrayList<Content>();

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
    }

    @Override
    public void start() {
        Content asset = getAsset();
        asset.setName(Gen.getHumanReadableString(8));
        asset = getService().updateAsset(asset);
        if (asset == null)
            fail("Can not update asset");
    }

    private Content getAsset() {
        return assets.get(Gen.getInt(assets.size()));
    }
}
