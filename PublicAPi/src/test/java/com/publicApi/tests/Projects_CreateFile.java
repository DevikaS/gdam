package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import com.publicApi.jsonPayLoads.ExpectedData;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 17/11/2015.
 */
public class Projects_CreateFile extends ProjectsBaseTest {

    @Test
    public void createFileTest() {

        apiCall = new HeadlessAPICalls();

        responsePayLoad =  apiCall.createProject();
        setProjectId(responsePayLoad.getId());

        responsePayLoad = apiCall.createProjectFile(getProjectId());

        // Verify fields in response
        actual_list.clear();
        actual_list.add("Project DocumentType:".concat(responsePayLoad.getDocumentType()));
        actual_list.add("Project Subtype:".concat(responsePayLoad.getSubtype()));
        actual_list.add("Project File Name:".concat(responsePayLoad.getMeta().getCommon().getName()));

        expected_list.clear();
        expected_list.add("Project DocumentType:fsobject");
        expected_list.add("Project Subtype:element");
        expected_list.add("Project File Name:".concat(ExpectedData.PROJECT_FILENAME));

        Assert.assertEquals(actual_list,expected_list,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}
