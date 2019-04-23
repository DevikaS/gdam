package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.LibraryBaseTests;
import org.testng.Assert;
import org.testng.annotations.Test;

public class Presentations_CreateAPublicShare extends LibraryBaseTests {

    private String xA5Agency = null;
    private String expiration = null;
    private String recipients = null;
    private boolean allowDownloadMaster = true;
    private boolean allowDownloadProxy = true;
    private String message = null;

    public Presentations_CreateAPublicShare() {
        apiCall = new HeadlessAPICalls();
    }

    @Test
    public void presentations_CreateAPublicShareTest_neverExpires_masterTrue_proxyFalse() {

        addAssetsToPresentation();

        recipients = "presentations_CreateAPublicShare1@yopmail.com";
        expiration = null; // neverExpire
        allowDownloadMaster = true;
        allowDownloadProxy = false;
        message = ""; // with blank message
        responsePayLoad = apiCall.presentationsCreateAPublicShare(getPresentationId(), xA5Agency, expiration, recipients, allowDownloadMaster, allowDownloadProxy, message);

        Assert.assertEquals(responsePayLoad.getDocumentType(), "public_share", this.getClass().getSimpleName().toUpperCase() + "_Files: End Point Failed due to, ");
    }

    @Test
    public void presentations_CreateAPublicShareTest_inactiveShare_masterTrue_proxyTrue() {

        addAssetsToPresentation();

        recipients="presentations_CreateAPublicShare2@yopmail.com";
        expiration="0"; // "0" for inactive share
        allowDownloadMaster=true;
        allowDownloadProxy=true;
        message="Asset shared with inactive"; // with a message
        responsePayLoad=apiCall.presentationsCreateAPublicShare(getPresentationId(),xA5Agency,expiration,recipients,allowDownloadMaster,allowDownloadProxy,message);

        Assert.assertEquals(responsePayLoad.getDocumentType(),"public_share",this.getClass().getSimpleName().toUpperCase()+"_Files: End Point Failed due to, ");
    }

    @Test
    public void presentations_CreateAPublicShareTest_neverExpires_masterTrue_proxyTrue_withMessage() {

        addAssetsToPresentation();

        recipients="presentations_CreateAPublicShare3@yopmail.com";
        expiration=null; // neverExpire
        allowDownloadMaster=true;
        allowDownloadProxy=true;
        message="Asset shared with neverExpire"; // with a message
        responsePayLoad=apiCall.presentationsCreateAPublicShare(getPresentationId(),xA5Agency,expiration,recipients,allowDownloadMaster,allowDownloadProxy,message);

        Assert.assertEquals(responsePayLoad.getDocumentType(),"public_share",this.getClass().getSimpleName().toUpperCase()+"_Files: End Point Failed due to, ");
    }

    @Test
    public void presentations_CreateAPublicShareTest_expiryDate_masterTrue_proxyTrue_withMessage() {

        addAssetsToPresentation();

        recipients="presentations_CreateAPublicShare4@yopmail.com";
        expiration="2020-01-01"; // expiry date
        allowDownloadMaster=true;
        allowDownloadProxy=true;
        message="Asset shared with expiry date"; // with a message
        responsePayLoad=apiCall.presentationsCreateAPublicShare(getPresentationId(),xA5Agency,expiration,recipients,allowDownloadMaster,allowDownloadProxy,message);

        Assert.assertEquals(responsePayLoad.getDocumentType(),"public_share",this.getClass().getSimpleName().toUpperCase()+"_Files: End Point Failed due to, ");
    }

    @Test
    public void presentations_CreateAPublicShareTest_expiryDate_masterFalse_proxyFalse_withMessage() {

        addAssetsToPresentation();

        recipients="presentations_CreateAPublicShare5@yopmail.com";
        expiration="2020-01-01"; // expiry date
        allowDownloadMaster=false;
        allowDownloadProxy=false;
        message="Asset shared with expiry date"; // with a message
        responsePayLoad=apiCall.presentationsCreateAPublicShare(getPresentationId(),xA5Agency,expiration,recipients,allowDownloadMaster,allowDownloadProxy,message);

        Assert.assertEquals(responsePayLoad.getDocumentType(),"public_share",this.getClass().getSimpleName().toUpperCase()+"_Files: End Point Failed due to, ");
    }

    private void addAssetsToPresentation(){
        responsePayLoad=null;

        //create asset
        responsePayLoad = apiCall.createAsset();
        setAssetId(responsePayLoad.getId());

        responsePayLoad = apiCall.createPresentation();
        setPresentationId(responsePayLoad.getId());

        waitFor(1000); // Wait for a second for previous endpoint to sync the data. Else array.list would return empty in "addPresentationAssets" endpoint

        //add asset to presentation
        apiCall.addPresentationAssets(getPresentationId(), getAssetId());
    }
}