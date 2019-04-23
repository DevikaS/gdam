package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.tests.testsBase.LibraryBaseTests;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 21/12/2015.
 */
public class Asset_CreateAsset extends LibraryBaseTests {

    @Test
    public void createAssetTest() {
        apiCall = new HeadlessAPICalls();
        responsePayLoad = apiCall.createAsset();

        Assert.assertEquals(responsePayLoad.getMeta().getCommon().getName(), ExpectedData.CREATEASSETNAME,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}