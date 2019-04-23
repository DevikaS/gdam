package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.LibraryBaseTests;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Raja.Gone on 28/07/2016.
 */
public class Collections_RemoveAssetFromCollection extends LibraryBaseTests{

    @Test
    public void removeAssetFromCollectionTest(){
        apiCall = new HeadlessAPICalls();

        //create asset
        responsePayLoad = apiCall.createAsset();
        setAssetId(responsePayLoad.getId());

        responsePayLoad = apiCall.createCollection();
        setCollectionId(responsePayLoad.getId());

        apiCall.addAssetToCollection(getCollectionId(),getAssetId());

        // Note: Currently CORE doesn't provide asset level information in a collection. So to validate if asset added to collection check via ListCollectionAssets endpoint

        Assert.assertTrue(apiCall.listCollectionAssets(getCollectionId()).contains(getAssetId()),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");

        Assert.assertTrue(apiCall.removeAssetFromCollection(getCollectionId(),getAssetId()),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}
