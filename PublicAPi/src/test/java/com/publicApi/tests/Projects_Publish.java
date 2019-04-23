package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;


/**
 * Created by Nirmala.Sankaran on 25/11/2015.
 */
public class Projects_Publish  extends ProjectsBaseTest{

    @Test
    public void projectPublishTest() {

        apiCall = new HeadlessAPICalls();

        responsePayLoad =  apiCall.createProject();
        setProjectId(responsePayLoad.getId());

        responsePayLoad = apiCall.publishProject(getProjectId());

        Assert.assertTrue(responsePayLoad.getMeta().getCommon().isPublished(),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}
