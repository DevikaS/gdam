package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.LibraryBaseTests;
import com.publicApi.jsonPayLoads.ExpectedData;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 22/12/2015.
 */
public class Presentations_GetPresentation extends LibraryBaseTests {
    @Test
    public void getPresentationTest() {

        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createPresentation();
        setPresentationId(responsePayLoad.getId());

        apiCall.getPresentation(getPresentationId());

        // Verify fields in response
        actual_list.add(responsePayLoad.getMeta().getCommon().getName());
        actual_list.add(responsePayLoad.getDocumentType());

        expected_list.add(ExpectedData.PRESENTATION_NAME);
        expected_list.add("presentation");

        Assert.assertEquals(actual_list,expected_list,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}
