package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.LibraryBaseTests;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 22/12/2015.
 */
public class Collection_CreateChildCollection extends LibraryBaseTests {

    @Test
    public void createChildCollectionTest() {

        apiCall = new HeadlessAPICalls();

        //create Collection
        responsePayLoad = apiCall.createCollection();
        setCollectionId(responsePayLoad.getId());

        //child Collection
        responsePayLoad = apiCall.createChildCollection(getCollectionId());

        actual_list.clear();
        actual_list.add(responsePayLoad.getId());
        actual_list.add(responsePayLoad.getMeta().getCommon().getQuery());
        actual_list.add(Integer.toString(responsePayLoad.getVersion()));

        expected_list.clear();;
        expected_list.add(getCollectionId());
        expected_list.add("{\"and\":[{\"terms\":{\"_cm.common.name\":[\"name\"]}},{\"terms\":{\"_cm.common.video.accountDirector\":[\"test\"]}}]}"); // Expected value hard-coded based on'RequestPayLoads.createChildCollectionPayLoad()'
        expected_list.add("2");

        Assert.assertEquals(actual_list,expected_list, this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}
