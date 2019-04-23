package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.io.IOException;

public class ProjectFiles_CreateACommentForAFile extends ProjectsBaseTest {

    @Test
    public void projectFiles_CreateACommentForAFileTest() throws IOException{
        apiCall = new HeadlessAPICalls();

        responsePayLoad =  apiCall.createProject();
        setProjectId(responsePayLoad.getId());

        responsePayLoad = apiCall.projectMediaRegister(getProjectId());
        setMediaId(responsePayLoad.getId());
        setReference(responsePayLoad.getReference());
        setUrl(responsePayLoad.getUrl());

        Assert.assertTrue(apiCall.mediaUploadToGdn(getUrl(), getReference()),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, 'Media Upload to GDN");

        responsePayLoad=apiCall.projectMediaComplete(getProjectId(), getMediaId(), ExpectedData.ASSETFILENAME);

        setFileId(responsePayLoad.getId());
        String revisionId = responsePayLoad.getRevisions()[0].getRevisionId();
        String comment = "Test to verify - ProjectFiles_Create A Comment For A File";

        // Add a new comment
        responsePayLoad=apiCall.projectFilesCreateACommentForAFile(comment, getFileId(),revisionId,null);

        Assert.assertEquals(responsePayLoad.getText(),comment,this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");

        String commentId_AnswerTo=responsePayLoad.get_id();
        comment = "Test to verify reply for previous comment - ProjectFiles_Create A Comment For A File";

        // Reply to existing comment
        responsePayLoad=apiCall.projectFilesCreateACommentForAFile(comment, getFileId(),revisionId,commentId_AnswerTo);

        Assert.assertEquals(responsePayLoad.getText(),comment,this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}