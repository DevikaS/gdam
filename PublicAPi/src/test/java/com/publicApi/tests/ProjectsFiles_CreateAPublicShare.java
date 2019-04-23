package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.io.IOException;

public class ProjectsFiles_CreateAPublicShare extends ProjectsBaseTest{

    private String xA5Agency=null;
    private String expiration=null;
    private String recipients=null;
    private boolean allowDownloadMaster=true;
    private boolean allowDownloadProxy=true;
    private String message=null;

    public ProjectsFiles_CreateAPublicShare(){
        apiCall = new HeadlessAPICalls();
    }

    @Test
    public void projectFiles_CreateAPublicShareTest_neverExpires_masterTrue_proxyFalse() throws IOException {

        responsePayLoad =  apiCall.createProject();
        setProjectId(responsePayLoad.getId());

        responsePayLoad = apiCall.projectMediaRegister(getProjectId());
        setMediaId(responsePayLoad.getId());
        setReference(responsePayLoad.getReference());
        setUrl(responsePayLoad.getUrl());

        Assert.assertTrue(apiCall.mediaUploadToGdn(getUrl(), getReference()),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, 'Media Upload to GDN");

        responsePayLoad=apiCall.projectMediaComplete(getProjectId(), getMediaId(), ExpectedData.ASSETFILENAME);

        setFileId(responsePayLoad.getId());

        recipients="projectFiles_CreateAPublicShare1@yopmail.com";
        expiration=null; // neverExpire
        allowDownloadMaster=true;
        allowDownloadProxy=false;
        message=""; // with blank message
        responsePayLoad=apiCall.projectFilesCreateAPublicShare(getFileId(),xA5Agency,expiration,recipients,allowDownloadMaster,allowDownloadProxy,message);

        Assert.assertEquals(responsePayLoad.getDocumentType(),"public_share",this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }

    @Test
    public void projectFiles_CreateAPublicShareTest_inactiveShare_masterTrue_proxyTrue() throws IOException {

        responsePayLoad =  apiCall.createProject();
        setProjectId(responsePayLoad.getId());

        responsePayLoad = apiCall.projectMediaRegister(getProjectId());
        setMediaId(responsePayLoad.getId());
        setReference(responsePayLoad.getReference());
        setUrl(responsePayLoad.getUrl());

        Assert.assertTrue(apiCall.mediaUploadToGdn(getUrl(), getReference()),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, 'Media Upload to GDN");

        responsePayLoad=apiCall.projectMediaComplete(getProjectId(), getMediaId(), ExpectedData.ASSETFILENAME);

        setFileId(responsePayLoad.getId());

        recipients="projectFiles_CreateAPublicShare2@yopmail.com";
        expiration="0"; // "0" for inactive share
        allowDownloadMaster=true;
        allowDownloadProxy=true;
        message="Project File shared with inactive"; // with a message
        responsePayLoad=apiCall.projectFilesCreateAPublicShare(getFileId(),xA5Agency,expiration,recipients,allowDownloadMaster,allowDownloadProxy,message);

        Assert.assertEquals(responsePayLoad.getDocumentType(),"public_share",this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }

    @Test
    public void projectFiles_CreateAPublicShareTest_neverExpires_masterTrue_proxyTrue_withMessage() throws IOException {

        responsePayLoad =  apiCall.createProject();
        setProjectId(responsePayLoad.getId());

        responsePayLoad = apiCall.projectMediaRegister(getProjectId());
        setMediaId(responsePayLoad.getId());
        setReference(responsePayLoad.getReference());
        setUrl(responsePayLoad.getUrl());

        Assert.assertTrue(apiCall.mediaUploadToGdn(getUrl(), getReference()),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, 'Media Upload to GDN");

        responsePayLoad=apiCall.projectMediaComplete(getProjectId(), getMediaId(), ExpectedData.ASSETFILENAME);

        setFileId(responsePayLoad.getId());

        recipients="projectFiles_CreateAPublicShare3@yopmail.com";
        expiration=null; // neverExpire
        allowDownloadMaster=true;
        allowDownloadProxy=true;
        message="Project File shared with neverExpire"; // with a message
        responsePayLoad=apiCall.projectFilesCreateAPublicShare(getFileId(),xA5Agency,expiration,recipients,allowDownloadMaster,allowDownloadProxy,message);

        Assert.assertEquals(responsePayLoad.getDocumentType(),"public_share",this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }

    @Test
    public void projectFiles_CreateAPublicShareTest_expiryDate_masterTrue_proxyTrue_withMessage() throws IOException {

        responsePayLoad =  apiCall.createProject();
        setProjectId(responsePayLoad.getId());

        responsePayLoad = apiCall.projectMediaRegister(getProjectId());
        setMediaId(responsePayLoad.getId());
        setReference(responsePayLoad.getReference());
        setUrl(responsePayLoad.getUrl());

        Assert.assertTrue(apiCall.mediaUploadToGdn(getUrl(), getReference()),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, 'Media Upload to GDN");

        responsePayLoad=apiCall.projectMediaComplete(getProjectId(), getMediaId(), ExpectedData.ASSETFILENAME);

        setFileId(responsePayLoad.getId());

        recipients="projectFiles_CreateAPublicShare4@yopmail.com";
        expiration="2020-01-01"; // expiry date
        allowDownloadMaster=true;
        allowDownloadProxy=true;
        message="Project File shared with expiry date"; // with a message
        responsePayLoad=apiCall.projectFilesCreateAPublicShare(getFileId(),xA5Agency,expiration,recipients,allowDownloadMaster,allowDownloadProxy,message);

        Assert.assertEquals(responsePayLoad.getDocumentType(),"public_share",this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}