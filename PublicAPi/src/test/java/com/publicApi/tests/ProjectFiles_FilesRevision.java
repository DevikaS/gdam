package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 30/11/2015.
 */
public class ProjectFiles_FilesRevision extends ProjectsBaseTest {

    @Test
    public void projectsFilesRevisionTest() {
        apiCall = new HeadlessAPICalls();

        responsePayLoad =  apiCall.createProject();
        setProjectId(responsePayLoad.getId());

        responsePayLoad = apiCall.createProjectFile(getProjectId());
        setFileId(responsePayLoad.getId());

        responsePayLoad = apiCall.mediaUpload();
        setMediaId(responsePayLoad.getId());

        setUrl(responsePayLoad.getUrl());
        setMediaId(responsePayLoad.getId());
        setMediaName(responsePayLoad.getFilename());
        setMediaSize(Integer.toString(responsePayLoad.getSize()));

        // first revision
        Assert.assertTrue(apiCall.projectsFilesRevision(getFileId(), getMediaId(),"v1"),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to revision version 'v1', ");

        // For second revision, Re-upload the same file
        Assert.assertTrue(apiCall.projectsFilesRevision(getFileId(), getMediaId(),"v2"),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to revision version 'v2', ");
    }
}
