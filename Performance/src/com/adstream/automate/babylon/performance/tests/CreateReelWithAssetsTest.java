package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.Reel;
import com.adstream.automate.babylon.JsonObjects.SearchResult;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.utils.Gen;

import java.util.ArrayList;
import java.util.List;

/**
 * User: ruslan.semerenko
 * Date: 07.08.13 17:41
 */
public class CreateReelWithAssetsTest extends CreateAssetTest {
    private List<Content> assets;
    private Reel defaultReel;

    @Override
    public void beforeStart() {
        super.beforeStart();
        if (assets == null) {
            int assetsCount = getParamInt("assetsCount");
            assets = new ArrayList<>();
            SearchResult<Content> result;
            int i = 1;
            do {
                LuceneSearchingParams query = new LuceneSearchingParams()
                        .setQuery("").setPageNumber(i++).setResultsOnPage(25);
                result = getService().findAssets(getEverythingCategoryId(), query);
                assets.addAll(result.getResult());
            } while (result.hasMore() && assets.size() < assetsCount);
            for (i = assets.size(); i < assetsCount; i++) {
                assets.add(createAsset());
            }
        }
    }

    @Override
    public void start() {
        getService().createReel(getReel());
    }

    private Reel getReel() {
        if (defaultReel == null) {
            String[] assetsIds = new String[assets.size()];
            for (int i = 0; i < assetsIds.length; i++) {
                assetsIds[i] = assets.get(i).getId();
            }
            Reel reel = new Reel();
            reel.getAssets().put("assetsOrder", assetsIds);
            defaultReel = reel;
        }
        defaultReel.setName(Gen.getHumanReadableString(6, true));
        return defaultReel;
    }
}
