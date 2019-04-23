package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.io.IOException;


/**
 * Created by Nirmala.Sankaran on 30/11/2015.
 */
public class Media_CompleteMedia extends ProjectsBaseTest {


    @Test
    public void mediaCompleteTest() throws IOException{

        apiCall = new HeadlessAPICalls();
        responsePayLoad = apiCall.mediaUpload();

        setUrl(responsePayLoad.getUrl());
        setMediaId(responsePayLoad.getId());
        setReference(responsePayLoad.getReference());

        Assert.assertTrue(apiCall.mediaUploadToGdn(getUrl(), getReference()),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, 'Media Upload to GDN ");

        Assert.assertTrue(apiCall.completeMedia(getMediaId()),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due ");
    }
}
