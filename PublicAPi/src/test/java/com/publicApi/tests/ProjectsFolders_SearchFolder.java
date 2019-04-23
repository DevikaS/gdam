package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;


/**
 * Created by Nirmala.Sankaran on 10/11/2015.
 */
public class ProjectsFolders_SearchFolder extends ProjectsBaseTest {

    @Test
    public void projectsFoldersSearchFolderTest() {

        apiCall = new HeadlessAPICalls();

        responsePayLoad =  apiCall.createProject();
        setProjectId(responsePayLoad.getId());

        responsePayLoad = apiCall.searchProjectFolderId(getProjectId());
        setParentFileId(responsePayLoad.getId());

        responsePayLoad =  apiCall.createFolder(getParentFileId());
        setFolderId(responsePayLoad.getId());

        String response = apiCall.projectsFolderSearchFolder();

        Assert.assertTrue(response.contains(getFolderId()),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}
