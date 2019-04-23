package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.LibraryBaseTests;
import com.publicApi.jsonPayLoads.ExpectedData;
import org.testng.Assert;
import org.testng.annotations.Test;


/**
 * Created by Nirmala.Sankaran on 22/12/2015.
 */
public class Presentations_CreatePresentation extends LibraryBaseTests {
    @Test
    public void createPresentationTest() {
        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createPresentation();

        // Verify fields in response
        actual_list.clear();;
        actual_list.add(responsePayLoad.getMeta().getCommon().getName());
        actual_list.add(responsePayLoad.getDocumentType());

        expected_list.clear();
        expected_list.add(ExpectedData.PRESENTATION_NAME);
        expected_list.add("presentation");

        Assert.assertEquals(actual_list,expected_list,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}