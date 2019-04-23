package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.utils.Gen;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * User: lynda-k
 * Date: 31.10.13 13:00
 */
public class AddAssetsToNewCollectionTest extends UpdateAssetTest {
    @Override
    public void beforeStart() {
        super.beforeStart();
        Collections.shuffle(assets);
    }

    @Override
    public void start() {
        getService().addAssetsToNewCollection(getAssetIds(), Gen.getHumanReadableString(8, true));
    }

    protected List<String> getAssetIds() {
        List<String> assetIds = new ArrayList<>();
        for (Content asset : assets.subList(0, getParamInt("assetsToAdd"))) {
            assetIds.add(asset.getId());
        }
        return assetIds;
    }
}
