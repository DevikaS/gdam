package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;

public class Projects_SearchProjectsTemplates extends ProjectsBaseTest {

    private String xA5Agency=null;

    public Projects_SearchProjectsTemplates(){
        apiCall = new HeadlessAPICalls();
    }

    @Test
    public void projectsSearchProjectsTemplatesTest_FromAllBUs() {
        xA5Agency=null;
        String response=apiCall.projects_SearchProjectsTemplates(xA5Agency);

        // check that response contains Project_Template_Names from all the BU's
        Assert.assertTrue(response.contains("Project Template Test") && response.contains("ProjectTemplateSharedFromTestAuotomation02"));
    }

    @Test
    public void projectsSearchProjectsTemplatesTest_ForSameBU() {
        xA5Agency = ExpectedData.PRIMARY_BU_ID;
        String response = apiCall.projects_SearchProjectsTemplates(xA5Agency);

        // check that response contains Project_Template_Name from same BU but not from another BU
        Assert.assertTrue(response.contains("Project Template Test"));
        Assert.assertFalse(response.contains("ProjectTemplateSharedFromTestAuotomation02"), "End Point Failed due to, ");
    }

    @Test
    public void projectsSearchProjectsTemplatesTest_SharedFromAnotherBU() {
        xA5Agency = ExpectedData.SECONDARY_BU_ID;
        String response=apiCall.projects_SearchProjectsTemplates(xA5Agency);

        // check that response contains Project_Template_Name from another BU but not from same BU
        Assert.assertFalse(response.contains("Project Template Test"));
        Assert.assertTrue(response.contains("ProjectTemplateSharedFromTestAuotomation02"), "End Point Failed due to, ");
    }
}