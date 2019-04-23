package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;


/**
 * Created by Nirmala.Sankaran on 24/11/2015.
 */
public class Projects_AssignTeam extends ProjectsBaseTest {

    @Test
    public void assignTeam() {
        apiCall = new HeadlessAPICalls();

        responsePayLoad =  apiCall.createProject();
        setProjectId(responsePayLoad.getId());

        String response = apiCall.assignTeamToProject(getProjectId());

        // Below verifications are hardcoded. Currently  ExpectedData.TEAMNAME_ID is created with projectContributor role.
        Assert.assertTrue(response.contains("Project Contributor"),
        this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");

        Assert.assertTrue(response.contains("509a93c29e02c7ba9d977f25"),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}