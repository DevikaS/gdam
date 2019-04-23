package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.SearchResult;
import com.adstream.automate.babylon.LuceneSearchingParams;

/**
 * User: ruslan.semerenko
 * Date: 14.11.12 10:24
 */
public class SearchAssetsTest extends CreateAssetTest {
    private static boolean assetsCreated = false;

    @Override
    public void beforeStart() {
        super.beforeStart();
        ensureAssetsCapacity();
    }

    @Override
    public void start() {
        SearchResult<Content> result = getAssets(getParamInt("assetsOnPage"));
        if (result == null || result.getResult().size() == 0)
            fail("Error while searching assets");
    }

    private void ensureAssetsCapacity() {
        if (!assetsCreated) {
            int assetsNeed = getParamInt("assetsCount");
            int assetsToCreate = assetsNeed - getAssets(assetsNeed).getResult().size();
            log.info(String.format("Need to create %d assets", assetsToCreate));
            for (int i = 0; i < assetsToCreate; i++) {
                if (i % 100 == 99)
                    log.info(String.format("Created %d assets", i + 1));
                super.start();
            }
            assetsCreated = true;
        }
    }

    private SearchResult<Content> getAssets(int count) {
        return getService().findAssets(getMyAssetsCategoryId(), new LuceneSearchingParams().setResultsOnPage(count).setPageNumber(1));
    }
}
