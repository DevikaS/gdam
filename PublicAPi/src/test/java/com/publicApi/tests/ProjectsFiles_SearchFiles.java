package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 30/11/2015.
 */
public class ProjectsFiles_SearchFiles extends ProjectsBaseTest {

    @Test
    public void projectsFilesSearchFilesTest() {

        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createProject();
        setProjectId(responsePayLoad.getId());

        responsePayLoad = apiCall.createProjectFile(getProjectId());
        setFileId(responsePayLoad.getId());

        waitFor(10000); // Wait few seconds before searching for file presence

        String queryParams = "?sort=modified&order=DESC"; // needed as the search response is now limited to 100
        String response = apiCall.projectsFilesSearchFiles(queryParams);

        Assert.assertTrue(response.contains(getFileId()),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}