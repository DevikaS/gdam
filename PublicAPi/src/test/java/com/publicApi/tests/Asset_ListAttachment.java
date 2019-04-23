package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.tests.testsBase.LibraryBaseTests;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.io.IOException;

/**
 * Created by Nirmala.Sankaran on 21/12/2015.
 */
public class Asset_ListAttachment extends LibraryBaseTests {

    @Test
    public void assetlistAttachmentTest() throws IOException {
        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createAsset();
        setAssetId(responsePayLoad.getId());

        //upload media for attachment
        responsePayLoad = apiCall.uploadAsset();
        setUrl(responsePayLoad.getUrl());
        setMediaID(responsePayLoad.getId());

        setReference(ExpectedData.ASSETPATH);
        setMediaName(ExpectedData.ASSETFILENAME);
        setMediaSize(Integer.toString(ExpectedData.ASSETSIZE));

        Assert.assertTrue(apiCall.mediaUploadToGdn(getUrl(), getReference()),this.getClass().getSimpleName().toUpperCase()
                +": End Point Failed due to, 'Media Upload to GDN': Check upload URL: "+getUrl());


        // Create Attachment
        apiCall.assetCreateAttachment(getAssetId(), getMediaID(), getMediaName(), getMediaSize());

        // List Attachments
        responsePayLoad = apiCall.assetListAttachments(getAssetId());

        // Verify fields in response
        actual_list.clear();
        actual_list.add(responsePayLoad.getName());
        actual_list.add(responsePayLoad.getMedia().getId());
        actual_list.add(responsePayLoad.getMedia().getSize());

        expected_list.clear();
        expected_list.add(getMediaName());
        expected_list.add(getMediaID());
        expected_list.add(getMediaSize());

        Assert.assertEquals(actual_list, expected_list,
                this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");
    }
}