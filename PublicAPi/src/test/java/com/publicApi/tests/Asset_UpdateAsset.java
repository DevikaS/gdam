package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.LibraryBaseTests;
import com.publicApi.jsonPayLoads.ExpectedData;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 21/12/2015.
 */
public class Asset_UpdateAsset extends LibraryBaseTests {

    @Test
    public void updateAsset_WithDifferentNameTest() throws InterruptedException{

        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createAsset();
        setAssetId(responsePayLoad.getId());

        Thread.sleep(5000);

        //update asset
        responsePayLoad=apiCall.updateAsset( getAssetId());

        Assert.assertEquals(responsePayLoad.getMeta().getCommon().getName(),ExpectedData.CREATEASSETNAME_UPDATE,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}
