package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.LibraryBaseTests;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Swathi.Battula on 25/05/2016.
 */
public class Collection_DeleteCollection extends LibraryBaseTests {

    @Test
    public void deleteCollectionTest() {

        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createCollection();
        setCollectionId(responsePayLoad.getId());

        Assert.assertTrue(apiCall.deleteCollection(getCollectionId()),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}
