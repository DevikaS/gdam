package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;


/**
 * Created by Nirmala.Sankaran on 25/11/2015.
 */
public class Projects_RoleUpdate extends ProjectsBaseTest {

    @Test
    public void roleUpdateTest() {
        apiCall = new HeadlessAPICalls();

        responsePayLoad =  apiCall.createProject();
        setProjectId(responsePayLoad.getId());

        Assert.assertTrue(apiCall.roleCreateProject(getProjectId()),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");

        Assert.assertTrue(apiCall.roleUpdateProject(getProjectId()),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}
