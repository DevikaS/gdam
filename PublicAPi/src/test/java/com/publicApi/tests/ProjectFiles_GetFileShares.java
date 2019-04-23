package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;

public class ProjectFiles_GetFileShares extends ProjectsBaseTest{

    @Test
    public void projectFiles_GetFileSharesTest() {

        apiCall = new HeadlessAPICalls();

        String response = apiCall.projectFiles_GetFileSharesTest(ExpectedData.PROJECT_FILE_ID);

        Assert.assertTrue((response.contains("projectFiles@getFileShares.com") && response.contains("downloadProxy")),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed. Check response for 'email=projectFiles@getFileShares.com' OR 'access=downloadProxy'");
    }
}
