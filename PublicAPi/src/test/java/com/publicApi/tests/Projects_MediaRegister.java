package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.io.IOException;

/**
 * Created by Nirmala.Sankaran on 27/11/2015.
 */
public class Projects_MediaRegister extends ProjectsBaseTest {

    @Test
    public void mediaRegisterTest() throws IOException {

        apiCall = new HeadlessAPICalls();

        responsePayLoad =  apiCall.createProject();
        setProjectId(responsePayLoad.getId());

        responsePayLoad = apiCall.projectMediaRegister(getProjectId());
        setMediaId(responsePayLoad.getId());
        setReference(responsePayLoad.getReference());
        setUrl(responsePayLoad.getUrl());

        Assert.assertTrue(apiCall.mediaUploadToGdn(getUrl(), getReference()),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, 'Media Upload to GDN");
    }
}
