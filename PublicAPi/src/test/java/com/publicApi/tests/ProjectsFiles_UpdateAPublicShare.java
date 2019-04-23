package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.io.IOException;

public class ProjectsFiles_UpdateAPublicShare extends ProjectsBaseTest{

    private String xA5Agency=null;
    private String expiration=null;
    private String recipients=null;
    private boolean allowDownloadMaster=true;
    private boolean allowDownloadProxy=true;
    private String message=null;

    public ProjectsFiles_UpdateAPublicShare(){
        apiCall = new HeadlessAPICalls();
    }

    @Test
    public void projectsFiles_updateAPublicShareTest_neverExpires_masterTrue_proxyFalse() throws IOException{

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

        // Now update the public share with below details:
        allowDownloadMaster=true;
        allowDownloadProxy=true;

        responsePayLoad=apiCall.projectFilesUpdateAPublicShare(getFileId(),xA5Agency,expiration,allowDownloadMaster,allowDownloadProxy,message);

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