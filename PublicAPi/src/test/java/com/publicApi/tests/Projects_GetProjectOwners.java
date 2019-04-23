package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;

public class Projects_GetProjectOwners extends ProjectsBaseTest {

    @Test
    public void getProjectOwnersTest() {
        apiCall = new HeadlessAPICalls();

        responsePayLoad=apiCall.getProjectOwners(ExpectedData.PROJECT_LOGO_ENTITY_ID);

        // verify Project Owner ID in response
        Assert.assertEquals(responsePayLoad.getId(),ExpectedData.USERID,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}