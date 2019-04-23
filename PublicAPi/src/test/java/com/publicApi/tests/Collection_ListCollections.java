package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.LibraryBaseTests;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 22/12/2015.
 */
public class Collection_ListCollections extends LibraryBaseTests {

    @Test
    public void listCollectionTest() {

        apiCall = new HeadlessAPICalls();

        responsePayLoad=apiCall.createCollection();
        setCollectionId(responsePayLoad.getId());

        //List Collections
        Assert.assertTrue(apiCall.listCollections().contains(getCollectionId()),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}
