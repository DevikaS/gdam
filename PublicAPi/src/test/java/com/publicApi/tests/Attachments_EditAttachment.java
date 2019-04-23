package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import com.publicApi.jsonPayLoads.ExpectedData;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.io.IOException;

/**
 * Created by Nirmala.Sankaran on 25/01/2016.
 */
public class Attachments_EditAttachment extends ProjectsBaseTest {


    @Test
    public void editAttachment_FilesTest() throws IOException {
        apiCall = new HeadlessAPICalls();

        responsePayLoad =  apiCall.createProject();
        setProjectId(responsePayLoad.getId());

        responsePayLoad = apiCall.createProjectFile(getProjectId());
        setFileId(responsePayLoad.getId());

        //Upload Media file for attachment
        responsePayLoad = apiCall.mediaUpload();
        setUrl(responsePayLoad.getUrl());
        setMediaId(responsePayLoad.getId());
        setReference(responsePayLoad.getReference());
        setMediaName(responsePayLoad.getFilename());
        setMediaSize(Integer.toString(responsePayLoad.getSize()));

        Assert.assertTrue(apiCall.mediaUploadToGdn(getUrl(), getReference()),this.getClass().getSimpleName().toUpperCase()+
                ": End Point Failed due to, 'Media Upload to GDN', Check for URL: "+getUrl());

        //Create Attachment
        responsePayLoad=apiCall.createAttachments( "files", getFileId(), getMediaId(), getMediaName(), getMediaSize());
        setAttachmentId(responsePayLoad.getId());

        //Edit Attachment
        responsePayLoad=apiCall.editAttachment("files", getFileId(), getMediaId(), getMediaName(), getMediaSize(), getAttachmentId());

        // Verify fields in response
        actual_list.clear();
        actual_list.add(responsePayLoad.getName());
        actual_list.add(responsePayLoad.getDescription());
        actual_list.add(responsePayLoad.getMedia().getId());
        actual_list.add(responsePayLoad.getMedia().getSize());

        expected_list.clear();
        expected_list.add(getMediaName());
        expected_list.add(ExpectedData.ASSETDESC);
        expected_list.add(getMediaId());
        expected_list.add(getMediaSize());

        Assert.assertEquals(actual_list, expected_list,
                this.getClass().getSimpleName().toUpperCase() + "_Files: End Point Failed due to, ");
    }

    @Test
    public void editAttachment_AssetsTest() throws IOException {
        apiCall = new HeadlessAPICalls();

        responsePayLoad= apiCall.createAsset();
        setAssetId(responsePayLoad.getId());

        //Upload Media file for attachment
        responsePayLoad = apiCall.mediaUpload();
        setUrl(responsePayLoad.getUrl());
        setMediaId(responsePayLoad.getId());
        setReference(responsePayLoad.getReference());
        setMediaName(responsePayLoad.getFilename());
        setMediaSize(Integer.toString(responsePayLoad.getSize()));

        Assert.assertTrue(apiCall.mediaUploadToGdn(getUrl(), getReference()),this.getClass().getSimpleName().toUpperCase()+
                ": End Point Failed due to, 'Media Upload to GDN', Check for URL: "+getUrl());

        //Create Attachment
        responsePayLoad=apiCall.createAttachments( "assets", getAssetId(), getMediaId(), getMediaName(), getMediaSize());
        String attachmentId=responsePayLoad.getId();

        //Edit Attachment
        responsePayLoad=apiCall.editAttachment("assets", getAssetId(), getMediaId(), getMediaName(), getMediaSize(), attachmentId);

        // Verify fields in response
        actual_list.clear();
        actual_list.add(responsePayLoad.getName());
        actual_list.add(responsePayLoad.getDescription());
        actual_list.add(responsePayLoad.getMedia().getId());
        actual_list.add(responsePayLoad.getMedia().getSize());

        expected_list.clear();
        expected_list.add(getMediaName());
        expected_list.add(ExpectedData.ASSETDESC);
        expected_list.add(getMediaId());
        expected_list.add(getMediaSize());

        Assert.assertEquals(actual_list, expected_list,
                this.getClass().getSimpleName().toUpperCase() + "_Assets: End Point Failed due to, ");
    }
}