package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import com.publicApi.jsonPayLoads.ExpectedData;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 24/11/2015.
 */
public class Projects_UpdateProject extends ProjectsBaseTest {

    @Test
    public void updateProjectTest() {
        apiCall = new HeadlessAPICalls();

        responsePayLoad =  apiCall.createProject();
        setProjectId(responsePayLoad.getId());

        waitFor(15000);
        String response = apiCall.updateProject(getProjectId());

        // verify fields in response
        Assert.assertTrue(response.contains(ExpectedData.PROJECT_MEDIATYPE_UPDATE),"Check 'Project MediaType': ");
        Assert.assertTrue(response.contains(ExpectedData.PROJECT_NAME_UPDATE),"Check 'Project Name after update': ");
    }
}
