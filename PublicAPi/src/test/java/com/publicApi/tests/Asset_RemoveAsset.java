package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.LibraryBaseTests;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 21/12/2015.
 */
public class Asset_RemoveAsset extends LibraryBaseTests {

    @Test
    public void removeAssetTest() throws InterruptedException{
        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createAsset();
        setAssetId(responsePayLoad.getId());

        Thread.sleep(5000);

        //Remove asset
        Assert.assertTrue(apiCall.removeAsset(getAssetId()),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}
