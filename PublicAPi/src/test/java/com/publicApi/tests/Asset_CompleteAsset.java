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
public class Asset_CompleteAsset extends LibraryBaseTests {

    @Test
    public void completeAssetTest() throws IOException {

        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.uploadAsset();
        setUrl(responsePayLoad.getUrl());
        setMediaID(responsePayLoad.getId());

        setReference(ExpectedData.ASSETPATH);
        setMediaName(ExpectedData.ASSETFILENAME);

        Assert.assertTrue(apiCall.mediaUploadToGdn(getUrl(), getReference()),this.getClass().getSimpleName().toUpperCase()
                +": End Point Failed due to, 'Media Upload to GDN': Check upload URL: "+getUrl());

        responsePayLoad = apiCall.completeAsset(getMediaID(), getMediaName());
        String actualAssetName = responsePayLoad.getMeta().getCommon().getName();

        Assert.assertEquals(actualAssetName,getMediaName(),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, 'Complete Asset' ");
    }
}