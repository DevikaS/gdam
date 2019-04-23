package com.adstream.automate.babylon.tests.api.tests;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.core.AbstractTranscodingChecker;
import com.adstream.automate.utils.Common;
import org.testng.annotations.Test;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * User: Ruslan Semerenko
 * Date: 26.01.14 21:08
 */
public class AssetCRUDTest extends AbstractTest {
    private final long TRANSCODING_TIMEOUT_MS = 60 * 1000; // 1 minute

    @Test
    public void createAssetTest() {
        final File FILE_TO_UPLOAD = getResource("files/image.jpg");

        final Content asset = getDefaultRestService().uploadAsset(FILE_TO_UPLOAD);
        Common.sleep(3000);
        new AbstractTranscodingChecker() {
            @Override
            public List<Content> getFiles() {
                return Arrays.asList(getDefaultRestService().getAsset(asset.getId()));
            }
        }.withTimeLimit(TRANSCODING_TIMEOUT_MS).process(true);

        Content checkAsset = getDefaultRestService().getAsset(asset.getId());
        assertThat("File name", checkAsset.getName(), equalTo(FILE_TO_UPLOAD.getName()));
        assertThat("Revisions count", checkAsset.getRevisions().length, equalTo(1));

        FileRevision revision = checkAsset.getRevisions()[0];
        assertThat("File size", revision.getMaster().getFileSize(), equalTo(FILE_TO_UPLOAD.length()));
        assertThat("Preview count", revision.getPreview().size(), equalTo(2));
        for (FilePreview preview : revision.getPreview()) {
            assertThat("Preview a5 type", preview.getA5Type(), isOneOf("image_proxy", "thumbnail"));
        }
    }

    @Test
    public void readAssetTest() {
        final File FILE_TO_UPLOAD = getResource("files/qwerty.jpg");

        final Content asset = getDefaultRestService().uploadAsset(FILE_TO_UPLOAD);
        Common.sleep(3000);
        new AbstractTranscodingChecker() {
            @Override
            public List<Content> getFiles() {
                return Arrays.asList(getDefaultRestService().getAsset(asset.getId()));
            }
        }.withTimeLimit(TRANSCODING_TIMEOUT_MS).process(true);

        Content readAsset = getDefaultRestService().getAsset(asset.getId());
        assertThat("Asset id", readAsset.getId(), equalTo(asset.getId()));
        assertThat("Asset name", readAsset.getName(), equalTo(asset.getName()));
    }

    @Test
    public void updateAssetTest() {
        final String ASSET_NAME_NEW = "UpdateAssetTest";
        final File FILE_TO_UPLOAD = getResource("files/asdfgh.jpg");

        final Content asset = getDefaultRestService().uploadAsset(FILE_TO_UPLOAD);
        Common.sleep(3000);
        new AbstractTranscodingChecker() {
            @Override
            public List<Content> getFiles() {
                return Arrays.asList(getDefaultRestService().getAsset(asset.getId()));
            }
        }.withTimeLimit(TRANSCODING_TIMEOUT_MS).process(true);

        asset.setName(ASSET_NAME_NEW);
        Content newAsset = getDefaultRestService().updateAsset(asset);
        Common.sleep(3000);

        assertThat("Asset id", newAsset.getId(), equalTo(asset.getId()));
        assertThat("Asset name", newAsset.getName(), equalTo(ASSET_NAME_NEW));

        AssetFilter collection = getDefaultRestService().getAssetsFilterByName("Everything", "");
        SearchResult<Content> result = getDefaultRestService().findAssets(collection.getId(), new LuceneSearchingParams());
        List<String> assetsNames = new ArrayList<>();
        for (Content assetFromSearch : result.getResult()) {
            assetsNames.add(assetFromSearch.getName());
        }
        assertThat("Old asset doesn't exist", assetsNames.contains(FILE_TO_UPLOAD.getName()), is(false));
        assertThat("New asset is present", assetsNames.contains(ASSET_NAME_NEW), is(true));
    }

    @Test
    public void deleteAssetTest() {
        final File FILE_TO_UPLOAD = getResource("files/zxcvbn.jpg");

        final Content asset = getDefaultRestService().uploadAsset(FILE_TO_UPLOAD);
        Common.sleep(3000);
        new AbstractTranscodingChecker() {
            @Override
            public List<Content> getFiles() {
                return Arrays.asList(getDefaultRestService().getAsset(asset.getId()));
            }
        }.withTimeLimit(TRANSCODING_TIMEOUT_MS).process(true);

        getDefaultRestService().deleteAsset(asset.getId());
        Common.sleep(3000);

        AssetFilter collection = getDefaultRestService().getAssetsFilterByName("Everything", "");
        SearchResult<Content> result = getDefaultRestService().findAssets(collection.getId(), new LuceneSearchingParams());
        List<String> assetsNames = new ArrayList<>();
        for (Content assetFromSearch : result.getResult()) {
            assetsNames.add(assetFromSearch.getName());
        }

        assertThat("Deleted asset doesn't exist", assetsNames.contains(FILE_TO_UPLOAD.getName()), is(false));
    }
}
