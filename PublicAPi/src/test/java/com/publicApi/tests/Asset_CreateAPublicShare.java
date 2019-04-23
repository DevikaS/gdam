package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.tests.testsBase.LibraryBaseTests;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.io.IOException;

public class Asset_CreateAPublicShare extends LibraryBaseTests {

    private String xA5Agency=null;
    private String expiration=null;
    private String recipients=null;
    private boolean allowDownloadMaster=true;
    private boolean allowDownloadProxy=true;
    private String message=null;

    public Asset_CreateAPublicShare(){
        apiCall = new HeadlessAPICalls();
    }

    @Test
    public void asset_CreateAPublicShareTest_neverExpires_masterTrue_proxyFalse() throws IOException {

        responsePayLoad = apiCall.uploadAsset();
        setUrl(responsePayLoad.getUrl());
        setMediaID(responsePayLoad.getId());

        setReference(ExpectedData.ASSETPATH);
        setMediaName(ExpectedData.ASSETFILENAME);

        apiCall.mediaUploadToGdn(getUrl(), getReference());

        responsePayLoad = apiCall.completeAsset(getMediaID(), getMediaName());

        setAssetId(responsePayLoad.getId());

        waitFor(5000); // To finish transcoding.

        recipients="asset_CreateAPublicShare1@yopmail.com";
        expiration=null; // neverExpire
        allowDownloadMaster=true;
        allowDownloadProxy=false;
        message=""; // with blank message
        responsePayLoad=apiCall.assetCreateAPublicShare(getAssetId(),xA5Agency,expiration,recipients,allowDownloadMaster,allowDownloadProxy,message);

        Assert.assertEquals(responsePayLoad.getDocumentType(),"public_share",this.getClass().getSimpleName().toUpperCase()+"_Files: End Point Failed due to, ");
    }

    @Test
    public void asset_CreateAPublicShareTest_inactiveShare_masterTrue_proxyTrue() throws IOException {

        responsePayLoad = apiCall.uploadAsset();
        setUrl(responsePayLoad.getUrl());
        setMediaID(responsePayLoad.getId());

        setReference(ExpectedData.ASSETPATH);
        setMediaName(ExpectedData.ASSETFILENAME);

        apiCall.mediaUploadToGdn(getUrl(), getReference());

        responsePayLoad = apiCall.completeAsset(getMediaID(), getMediaName());

        setAssetId(responsePayLoad.getId());
        waitFor(5000); // To finish transcoding.

        recipients="asset_CreateAPublicShare2@yopmail.com";
        expiration="0"; // "0" for inactive share
        allowDownloadMaster=true;
        allowDownloadProxy=true;
        message="Asset shared with inactive"; // with a message
        responsePayLoad=apiCall.assetCreateAPublicShare(getAssetId(),xA5Agency,expiration,recipients,allowDownloadMaster,allowDownloadProxy,message);

        Assert.assertEquals(responsePayLoad.getDocumentType(),"public_share",this.getClass().getSimpleName().toUpperCase()+"_Files: End Point Failed due to, ");
    }

    @Test
    public void asset_CreateAPublicShareTest_neverExpires_masterTrue_proxyTrue_withMessage() throws IOException {

        responsePayLoad = apiCall.uploadAsset();
        setUrl(responsePayLoad.getUrl());
        setMediaID(responsePayLoad.getId());

        setReference(ExpectedData.ASSETPATH);
        setMediaName(ExpectedData.ASSETFILENAME);

        apiCall.mediaUploadToGdn(getUrl(), getReference());

        responsePayLoad = apiCall.completeAsset(getMediaID(), getMediaName());

        setAssetId(responsePayLoad.getId());
        waitFor(5000); // To finish transcoding.

        recipients="asset_CreateAPublicShare3@yopmail.com";
        expiration=null; // neverExpire
        allowDownloadMaster=true;
        allowDownloadProxy=true;
        message="Asset shared with neverExpire"; // with a message
        responsePayLoad=apiCall.assetCreateAPublicShare(getAssetId(),xA5Agency,expiration,recipients,allowDownloadMaster,allowDownloadProxy,message);

        Assert.assertEquals(responsePayLoad.getDocumentType(),"public_share",this.getClass().getSimpleName().toUpperCase()+"_Files: End Point Failed due to, ");
    }

    @Test
    public void asset_CreateAPublicShareTest_expiryDate_masterTrue_proxyTrue_withMessage() throws IOException {

        responsePayLoad = apiCall.uploadAsset();
        setUrl(responsePayLoad.getUrl());
        setMediaID(responsePayLoad.getId());

        setReference(ExpectedData.ASSETPATH);
        setMediaName(ExpectedData.ASSETFILENAME);

        apiCall.mediaUploadToGdn(getUrl(), getReference());

        responsePayLoad = apiCall.completeAsset(getMediaID(), getMediaName());

        setAssetId(responsePayLoad.getId());
        waitFor(5000); // To finish transcoding.

        recipients="asset_CreateAPublicShare4@yopmail.com";
        expiration="2020-01-01"; // expiry date
        allowDownloadMaster=true;
        allowDownloadProxy=true;
        message="Asset shared with expiry date"; // with a message
        responsePayLoad=apiCall.assetCreateAPublicShare(getAssetId(),xA5Agency,expiration,recipients,allowDownloadMaster,allowDownloadProxy,message);

        Assert.assertEquals(responsePayLoad.getDocumentType(),"public_share",this.getClass().getSimpleName().toUpperCase()+"_Files: End Point Failed due to, ");
    }
}