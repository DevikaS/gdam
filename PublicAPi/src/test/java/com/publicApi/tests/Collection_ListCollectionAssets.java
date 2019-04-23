package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.LibraryBaseTests;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 22/12/2015.
 */
public class Collection_ListCollectionAssets extends LibraryBaseTests {

    @Test
    public void listCollectionAssetsTest() {
        apiCall = new HeadlessAPICalls();

        //create asset
        responsePayLoad = apiCall.createAsset();
        setAssetId(responsePayLoad.getId());

        responsePayLoad = apiCall.createCollection();
        setCollectionId(responsePayLoad.getId());

        waitFor(2000); // Wait for 3 secs so that collect is created and synced. Else list endpoint wouldn't return last created collection
        //List Collections
        Assert.assertTrue(apiCall.listCollectionAssets(getCollectionId()).contains(getAssetId()),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}
