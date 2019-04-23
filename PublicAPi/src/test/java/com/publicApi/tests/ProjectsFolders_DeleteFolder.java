package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 10/11/2015.
 */
public class ProjectsFolders_DeleteFolder extends ProjectsBaseTest {

    @Test
    public void projectsFoldersDeleteFolderTest() throws InterruptedException{

        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createProject();
        setProjectId(responsePayLoad.getId());

        responsePayLoad = apiCall.searchProjectFolderId(getProjectId());
        setParentFileId(responsePayLoad.getId());

        responsePayLoad = apiCall.createFolder(getParentFileId());
        setFolderId(responsePayLoad.getId());

        Thread.sleep(2000);

        Boolean status= apiCall.projectsFoldersDeleteFolder(getFolderId());

        Assert.assertTrue(status, this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");

    }
}