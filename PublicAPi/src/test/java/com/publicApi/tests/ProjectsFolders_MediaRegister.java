package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.GsonClasses.Media;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import com.publicApi.jsonPayLoads.ExpectedData;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 21/12/2015.
 */
public class ProjectsFolders_MediaRegister extends ProjectsBaseTest{

    @Test
    public void projectsFoldersMediaRegister() {

        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createProject();
        setProjectId(responsePayLoad.getId());

        responsePayLoad = apiCall.searchProjectFolderId(getProjectId());
        setParentFileId(responsePayLoad.getId());

        responsePayLoad = apiCall.createFolder(getParentFileId());
        setFolderId(responsePayLoad.getId());

        responsePayLoad=apiCall.projectsFoldersMediaRegister(getFolderId());

        // Verify fields in response

        Assert.assertEquals(responsePayLoad.getReference(), ExpectedData.ASSETPATH,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
        Assert.assertEquals(responsePayLoad.getA4Status(),"succeeded","Failed to register a placeholder for a file under, a specfied folder.");
    }
}
