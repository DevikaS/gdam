package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.LibraryBaseTests;
import org.testng.Assert;
import org.testng.annotations.Test;

public class Presentations_UpdateAPublicShare extends LibraryBaseTests {

    private String xA5Agency=null;
    private String expiration=null;
    private String recipients=null;
    private boolean allowDownloadMaster=true;
    private boolean allowDownloadProxy=true;
    private String message=null;

    public Presentations_UpdateAPublicShare(){
        apiCall = new HeadlessAPICalls();
    }

    @Test
    public void presentations_updateAPublicShareTest_neverExpires_masterTrue_proxyFalse() {

        //create asset
        responsePayLoad = apiCall.createAsset();
        setAssetId(responsePayLoad.getId());

        responsePayLoad = apiCall.createPresentation();
        setPresentationId(responsePayLoad.getId());

        waitFor(3000);

        //add asset to presentation
        apiCall.addPresentationAssets(getPresentationId(), getAssetId());

        recipients = "presentations_CreateAPublicShare1@yopmail.com";
        expiration = null; // neverExpire
        allowDownloadMaster = true;
        allowDownloadProxy = false;
        message = ""; // with blank message
        responsePayLoad = apiCall.presentationsCreateAPublicShare(getPresentationId(), xA5Agency, expiration, recipients, allowDownloadMaster, allowDownloadProxy, message);

        Assert.assertEquals(responsePayLoad.getDocumentType(), "public_share", this.getClass().getSimpleName().toUpperCase() + "_Files: End Point Failed due to, ");

        // Now update the public share with below details:
        allowDownloadMaster=true;
        allowDownloadProxy=true;

        responsePayLoad=apiCall.presentationsUpdateAPublicShare(getPresentationId(),xA5Agency,expiration,allowDownloadMaster,allowDownloadProxy,message);

        int isPermissionFound=0;
        String[] expectedPermissions = {"sharedFile.downloadMaster","file.download","sharedFile.downloadProxy", "proxy.download"};

        for(int j=0;j<expectedPermissions.length;j++)
            for(int i=0;i<responsePayLoad.getPermissions().length;i++)
                if(responsePayLoad.getPermissions()[i].equals(expectedPermissions[j]))
                {
                    isPermissionFound++;
                    break;
                }

        Assert.assertTrue(isPermissionFound>=4,this.getClass().getSimpleName().toUpperCase()+": End Point Failed as one of the permissions from " +
                "{\"sharedFile.downloadMaster\",\"file.download\",\"sharedFile.downloadProxy\", \"proxy.download\"} missing in response payload, ");
    }
}