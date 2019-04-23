package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;


/**
 * Created by Nirmala.Sankaran on 30/11/2015.
 */
public class ProjectsFiles_CreateAttachments extends ProjectsBaseTest {

    @Test
    public void projectsFilesCreateAttachmentsTest() {
        apiCall = new HeadlessAPICalls();

        responsePayLoad =  apiCall.createProject();
        setProjectId(responsePayLoad.getId());

        responsePayLoad = apiCall.createProjectFile(getProjectId());
        setFileId(responsePayLoad.getId());

        //Register Media
        responsePayLoad = apiCall.mediaUpload();

        setUrl(responsePayLoad.getUrl());
        setMediaId(responsePayLoad.getId());
        setMediaName(responsePayLoad.getFilename());
        setMediaSize(Integer.toString(responsePayLoad.getSize()));

        responsePayLoad=apiCall.projectsFilesCreateAttachments(getFileId(),getMediaId(),getMediaName(),getMediaSize());

        // Verify fields in response
        actual_list.clear();
        actual_list.add(responsePayLoad.getName());
        actual_list.add(responsePayLoad.getMedia().getId());
        actual_list.add(responsePayLoad.getMedia().getSize());

        expected_list.clear();
        expected_list.add(getMediaName());
        expected_list.add(getMediaId());
        expected_list.add(getMediaSize());

        Assert.assertEquals(actual_list,expected_list,
                this.getClass().getSimpleName().toUpperCase()+"_Files: End Point Failed due to, ");
    }
}
