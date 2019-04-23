package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;


/**
 * Created by Nirmala.Sankaran on 25/11/2015.
 */
public class ProjectsFolders_GetAllowedRolesForSharing extends ProjectsBaseTest {

    @Test
    public void projectsFolders_GetAllowedRolesForSharingTest() {

        apiCall = new HeadlessAPICalls();

        responsePayLoad =  apiCall.createProject();
        setProjectId(responsePayLoad.getId());

        responsePayLoad = apiCall.searchProjectFolderId(getProjectId());
        setParentFileId(responsePayLoad.getId());

        responsePayLoad =  apiCall.createFolder(getParentFileId());
        setFolderId(responsePayLoad.getId());

        String response =  apiCall.projectsFolders_GetAllowedRolesForSharing(getFolderId());

        Assert.assertTrue(response.contains("Project Observer") && response.contains("Project Contributor") && response.contains("Project  User"),
                "One of the project role {'Project Observer', 'Project Contributor', 'Project  User'} is missing: "+this.getClass().getSimpleName().toUpperCase());
    }
}
