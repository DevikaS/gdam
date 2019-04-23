package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import com.publicApi.jsonPayLoads.ExpectedData;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 30/11/2015.
 */
public class ProjectsFiles_GetFile extends ProjectsBaseTest{

    @Test
    public void projectsFielsGetFileTest() {
        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createProject();
        setProjectId(responsePayLoad.getId());

        responsePayLoad = apiCall.createProjectFile(getProjectId());
        setFileId(responsePayLoad.getId());

        //Get File API
        apiCall.getFile(getFileId());

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
