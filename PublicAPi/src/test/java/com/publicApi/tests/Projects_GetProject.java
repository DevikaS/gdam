package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import com.publicApi.jsonPayLoads.ExpectedData;
import org.testng.Assert;
import org.testng.annotations.Test;


/**
 * Created by Nirmala.Sankaran on 24/11/2015.
 */
public class Projects_GetProject extends ProjectsBaseTest {

    @Test
    public void GetProject() {
        apiCall = new HeadlessAPICalls();

        responsePayLoad =  apiCall.createProject();
        setProjectId(responsePayLoad.getId());
        setProjectName(responsePayLoad.getMeta().getCommon().getName());

        responsePayLoad=apiCall.getProject(getProjectId());

        // verify fields in response
        actual_list.clear();
        actual_list.add("Project ID:".concat(responsePayLoad.getId()));
        actual_list.add("Project MediaType:".concat(responsePayLoad.getMeta().getCommon().getProjectMediaType()[0]));
        actual_list.add("Project Name:".concat(responsePayLoad.getMeta().getCommon().getName()));
        actual_list.add(("Project Published:".concat(responsePayLoad.getMeta().getCommon().isPublished()==true?"true":"false")));
        actual_list.add("Project Subtype:".concat(responsePayLoad.getSubtype()));
        actual_list.add("Project DocumentType:".concat(responsePayLoad.getDocumentType()));

        expected_list.clear();
        expected_list.add("Project ID:".concat(getProjectId()));
        expected_list.add("Project MediaType:".concat(ExpectedData.PROJECT_MEDIATYPE));
        expected_list.add("Project Name:".concat(ExpectedData.PROJECT_NAME));
        expected_list.add("Project Published:".concat(ExpectedData.PROJECT_ISPUBLISHED.toString()));
        expected_list.add("Project Subtype:".concat("project"));
        expected_list.add("Project DocumentType:fsobject");

        Assert.assertEquals(actual_list,expected_list,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");


    }
}