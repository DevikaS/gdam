package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.tests.testsBase.LibraryBaseTests;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.io.IOException;

public class Asset_UpdateAPublicShare extends LibraryBaseTests {

    private String xA5Agency=null;
    private String expiration=null;
    private String recipients=null;
    private boolean allowDownloadMaster=true;
    private boolean allowDownloadProxy=true;
    private String message=null;

    public Asset_UpdateAPublicShare(){
        apiCall = new HeadlessAPICalls();
    }

    @Test
    public void asset_updateAPublicShareTest_neverExpires_masterTrue_proxyFalse() throws IOException {

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

        Assert.assertEquals(responsePayLoad.getDocumentType(),"public_share",this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");

        // Now update the public share with below details:
        allowDownloadMaster=true;
        allowDownloadProxy=true;

        responsePayLoad=apiCall.assetUpdateAPublicShare(getAssetId(),xA5Agency,expiration,allowDownloadMaster,allowDownloadProxy,message);

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