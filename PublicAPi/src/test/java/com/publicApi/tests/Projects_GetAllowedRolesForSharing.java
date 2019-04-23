package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;


/**
 * Created by Nirmala.Sankaran on 25/11/2015.
 */
public class Projects_GetAllowedRolesForSharing extends ProjectsBaseTest {

    @Test
    public void projects_GetAllowedRolesForSharingTest() {

        apiCall = new HeadlessAPICalls();

        String response =  apiCall.projects_GetAllowedRolesForSharing(ExpectedData.PROJECT_LOGO_ENTITY_ID); // Pass project_id, in this case it's   "PROJECT_LOGO_ENTITY_ID"

        Assert.assertTrue(response.contains("Project Observer") && response.contains("project.admin") && response.contains("Project Contributor") && response.contains("Project  User"),
                "One of the project role {'Project Observer', 'project.admin', 'Project Contributor', 'Project  User'} is missing: "+this.getClass().getSimpleName().toUpperCase());
    }
}
