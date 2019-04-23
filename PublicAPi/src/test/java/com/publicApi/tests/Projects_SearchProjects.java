package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;


/**
 * Created by Nirmala.Sankaran on 30/11/2015.
 */
public class Projects_SearchProjects extends ProjectsBaseTest {

    @Test
    public void searchProjectTest() {
        apiCall = new HeadlessAPICalls();

        String response = apiCall.searchProjects();

        Assert.assertNotNull(response,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}
