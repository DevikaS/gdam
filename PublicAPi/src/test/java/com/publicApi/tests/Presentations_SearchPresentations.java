package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.LibraryBaseTests;
import org.testng.Assert;
import org.testng.annotations.Test;


/**
 * Created by Nirmala.Sankaran on 22/12/2015.
 */
public class Presentations_SearchPresentations extends LibraryBaseTests {

    @Test
    public void searchPresentationTest() throws InterruptedException{
        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createPresentation();
        setPresentationId(responsePayLoad.getId());

        Thread.sleep(5000);

        //search Presentation
        Assert.assertTrue(apiCall.searchPresentation().contains(getPresentationId()),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}
