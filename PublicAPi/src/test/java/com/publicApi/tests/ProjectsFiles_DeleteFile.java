package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;


/**
 * Created by Nirmala.Sankaran on 30/11/2015.
 */
public class ProjectsFiles_DeleteFile extends ProjectsBaseTest {

    @Test
    public void projectsFilesDeleteFileTest() {

        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createProject();
        setProjectId(responsePayLoad.getId());

        responsePayLoad = apiCall.createProjectFile(getProjectId());
        setFileId(responsePayLoad.getId());

        Assert.assertTrue(apiCall.projectsFilesDeleteFile(getFileId()),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}
