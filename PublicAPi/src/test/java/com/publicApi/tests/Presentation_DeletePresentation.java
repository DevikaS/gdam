package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.LibraryBaseTests;
import org.testng.Assert;
import org.testng.annotations.Test;


/**
 * Created by Swathi.Battula on 25/05/2016.
 */
public class Presentation_DeletePresentation extends LibraryBaseTests {

    @Test
    public void deletePresentation() {
        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createPresentation();
        setPresentationId(responsePayLoad.getId());

        Assert.assertTrue(apiCall.deletePresentation(getPresentationId()),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}