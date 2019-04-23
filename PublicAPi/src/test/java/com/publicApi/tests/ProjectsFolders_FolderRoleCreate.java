package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.jsonPayLoads.GsonClasses.Users;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;


public class ProjectsFolders_FolderRoleCreate extends ProjectsBaseTest {

    @Test
    public void projectsFolders_FolderRoleCreate() {
        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createProject();
        setProjectId(responsePayLoad.getId());

        responsePayLoad = apiCall.searchProjectFolderId(getProjectId());
        setParentFileId(responsePayLoad.getId());

        responsePayLoad = apiCall.createFolder(getParentFileId());
        setFolderId(responsePayLoad.getId());

        //Call Folder Role Create
        Boolean result = apiCall.folderRoleCreate(getFolderId());

        Assert.assertTrue(result, this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");
    }

}