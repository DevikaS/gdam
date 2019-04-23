package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 23/11/2015.
 */
public class Projects_DeleteProject extends ProjectsBaseTest {

    @Test
    public void deleteProjectTest(){

        apiCall = new HeadlessAPICalls();

        responsePayLoad =  apiCall.createProject();
        setProjectId(responsePayLoad.getId());

        Assert.assertTrue(apiCall.deleteProject(getProjectId()),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}
