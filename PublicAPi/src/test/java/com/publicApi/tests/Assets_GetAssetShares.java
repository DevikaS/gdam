package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.tests.testsBase.LibraryBaseTests;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.io.IOException;

public class Assets_GetAssetShares extends LibraryBaseTests {
    private String xA5Agency=null;
    private String expiration=null;
    private String recipients=null;
    private boolean allowDownloadMaster=true;
    private boolean allowDownloadProxy=true;
    private String message=null;
    @Test
    public void assets_GetAssetSharesTest() throws InterruptedException, IOException {

        apiCall = new HeadlessAPICalls();
        responsePayLoad = apiCall.uploadAsset();
        setUrl(responsePayLoad.getUrl());
        setMediaID(responsePayLoad.getId());

        setReference(ExpectedData.ASSETPATH);
        setMediaName(ExpectedData.ASSETFILENAME);

        apiCall.mediaUploadToGdn(getUrl(), getReference());

        responsePayLoad = apiCall.completeAsset(getMediaID(), getMediaName());

        setAssetId(responsePayLoad.getId());

        waitFor(5000); // To finish transcoding.

        recipients="libraryAssets@getAssetShares.com";
        expiration=null; // neverExpire
        allowDownloadMaster=false;
        allowDownloadProxy=true;
        message=""; // with blank message
        responsePayLoad=apiCall.shareAsset(getAssetId(),xA5Agency,expiration,recipients,allowDownloadMaster,allowDownloadProxy,message);
        String response = apiCall.assets_GetAssetShares(getAssetId());

        Assert.assertTrue((response.contains("libraryAssets@getAssetShares.com") && response.contains("downloadProxy")),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed. Check response for 'email=libraryAssets@getAssetShares.com' OR 'access=downloadProxy'");
    }
}
