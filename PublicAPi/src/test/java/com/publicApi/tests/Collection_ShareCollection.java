package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.LibraryBaseTests;
import com.publicApi.jsonPayLoads.ExpectedData;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 22/12/2015.
 */
public class Collection_ShareCollection  extends LibraryBaseTests{

    @Test
    public void shareCollectionTest()throws InterruptedException{
        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createCollection();
        setCollectionId(responsePayLoad.getId());

        Thread.sleep(5000);

        //Share Collection
        responsePayLoad = apiCall.shareCollection(getCollectionId());

        actual_list.clear();
        actual_list.add(responsePayLoad.getMeta().getCommon().getName());
        actual_list.add(responsePayLoad.getSubtype());
        actual_list.add(responsePayLoad.getDocumentType());

        expected_list.clear();;
        expected_list.add(ExpectedData.LIBRARY_TEAM_NAME);
        expected_list.add("user_group");
        expected_list.add("group");

        Assert.assertEquals(actual_list,expected_list,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}