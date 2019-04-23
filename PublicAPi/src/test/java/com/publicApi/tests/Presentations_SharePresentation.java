package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.LibraryBaseTests;
import org.testng.Assert;
import org.testng.annotations.Test;


/**
 * Created by Nirmala.Sankaran on 22/12/2015.
 */
public class Presentations_SharePresentation extends LibraryBaseTests {

    @Test
    public void sharePresentationTest() {
        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createPresentation();
        setPresentationId(responsePayLoad.getId());

        //Share Presentation
        Assert.assertTrue(apiCall.sharePresentation(getPresentationId()),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}
