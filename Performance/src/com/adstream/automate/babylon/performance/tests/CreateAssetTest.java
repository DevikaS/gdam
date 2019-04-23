package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.AssetFilter;
import com.adstream.automate.babylon.JsonObjects.AssetFilters;
import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.utils.Gen;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

/**
 * User: ruslan.semerenko
 * Date: 26.10.12 19:48
 */
public class CreateAssetTest extends AbstractPerformanceTestServiceWrapper {
    @Override
    public void runOnce() {
    }

    @Override
    public void beforeStart() {
        logIn(getParam("login"), getParam("password"));
    }

    @Override
    public void start() {
        Content asset = createAsset();
        if (asset == null)
            fail("Could not create asset");
    }

    @Override
    public void afterRun() {
    }

    protected Content createAsset() {
        return uploadAsset(new File(getParam("filePath")));
    }
}
