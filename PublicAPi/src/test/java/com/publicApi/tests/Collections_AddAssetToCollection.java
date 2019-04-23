package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.LibraryBaseTests;
import com.publicApi.jsonPayLoads.ExpectedData;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Raja.Gone on 28/07/2016.
 */
public class Collections_AddAssetToCollection extends LibraryBaseTests{

    @Test
    public void addAssetToCollectionTest(){
        apiCall = new HeadlessAPICalls();

        //create asset
        responsePayLoad = apiCall.createAsset();
        setAssetId(responsePayLoad.getId());

        responsePayLoad = apiCall.createCollection();
        setCollectionId(responsePayLoad.getId());

        apiCall.addAssetToCollection(getCollectionId(),getAssetId());

        // Verify fields in response
        actual_list.clear();
        actual_list.add(responsePayLoad.getMeta().getCommon().getName());
        actual_list.add(responsePayLoad.getType());
        actual_list.add(responsePayLoad.getDocumentType());

        expected_list.clear();;
        expected_list.add(ExpectedData.COLLECTION_NAME);
        expected_list.add("asset_filter_collection");
        expected_list.add("asset_filter");

        Assert.assertEquals(actual_list,expected_list,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");

        // Note: Currently CORE doesn't provide asset level information in collection. So to validate if asset added to collection check via ListCollectionAssets endpoint

        Assert.assertTrue(apiCall.listCollectionAssets(getCollectionId()).contains(getAssetId()),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}
