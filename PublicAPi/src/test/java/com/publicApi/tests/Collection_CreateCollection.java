package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.LibraryBaseTests;
import com.publicApi.jsonPayLoads.ExpectedData;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 22/12/2015.
 */
public class Collection_CreateCollection extends LibraryBaseTests {

    @Test
    public void createCollectionTest() {

        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createCollection();

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
    }
}