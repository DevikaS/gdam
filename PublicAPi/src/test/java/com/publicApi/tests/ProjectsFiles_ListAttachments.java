package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.io.IOException;

/**
 * Created by Nirmala.Sankaran on 30/11/2015.
 */
public class ProjectsFiles_ListAttachments extends ProjectsBaseTest {

    @Test
    public void projectsFilesListAttachmentsTest() throws IOException{
            apiCall = new HeadlessAPICalls();

            responsePayLoad =  apiCall.createProject();
            setProjectId(responsePayLoad.getId());


            responsePayLoad = apiCall.createProjectFile(getProjectId());
            setFileId(responsePayLoad.getId());
            setFileName(responsePayLoad.getMeta().getCommon().getName());

            //Register Media
            responsePayLoad = apiCall.mediaUpload();
            setUrl(responsePayLoad.getUrl());
            setReference(responsePayLoad.getReference());
            setMediaId(responsePayLoad.getId());
            setMediaName(responsePayLoad.getFilename());
            setMediaSize(Integer.toString(responsePayLoad.getSize()));


            Assert.assertTrue(apiCall.mediaUploadToGdn(getUrl(), getReference()),
                            this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, 'Media Upload to GDN");

            responsePayLoad =  apiCall.projectsFilesCreateAttachments(getFileId(),getMediaId(),getMediaName(),getMediaSize());

            responsePayLoad=apiCall.projectsFilesListAttachments(getFileId());

            // Verify fields in response

            actual_list.clear();
            actual_list.add("MediaName:".concat(responsePayLoad.getName()));
            actual_list.add("MediaId:".concat(responsePayLoad.getMedia().getId()));
            actual_list.add("MediaSize:".concat(responsePayLoad.getMedia().getSize()));

            expected_list.clear();
            expected_list.add("MediaName:".concat(getMediaName()));
            expected_list.add("MediaId:".concat(getMediaId()));
            expected_list.add("MediaSize:".concat(getMediaSize()));
    }
}