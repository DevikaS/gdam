package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.LibraryBaseTests;
import com.publicApi.jsonPayLoads.ExpectedData;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.io.IOException;


/**
 * Created by Nirmala.Sankaran on 21/12/2015.
 */
public class Asset_UploadAsset extends LibraryBaseTests {

    @Test
    public void uploadAssetTest() throws IOException {

        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createAsset();
        setAssetId(responsePayLoad.getId());

        responsePayLoad = apiCall.uploadAsset();
        setUrl(responsePayLoad.getUrl());
        setId(responsePayLoad.getId());
        setReference(ExpectedData.ASSETPATH);

        Assert.assertTrue(apiCall.mediaUploadToGdn(getUrl(), getReference()),
                this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, 'Media Upload to GDN' ");
    }
}