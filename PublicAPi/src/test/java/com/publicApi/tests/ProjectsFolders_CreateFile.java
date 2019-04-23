package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import com.publicApi.jsonPayLoads.ExpectedData;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 10/11/2015.
 */
public class ProjectsFolders_CreateFile extends ProjectsBaseTest {

    @Test
    public void ProjectsCreateFolderFileTest() {

        apiCall = new HeadlessAPICalls();

        responsePayLoad =  apiCall.createProject();
        setProjectId(responsePayLoad.getId());

        responsePayLoad = apiCall.searchProjectFolderId(getProjectId());
        setParentFileId(responsePayLoad.getId());

        responsePayLoad =  apiCall.createFolder(getParentFileId());
        setFolderId(responsePayLoad.getId());

        responsePayLoad=apiCall.createFile(getFolderId());

        // Verify values in response
        actual_list.clear();
        actual_list.add("Document Type:".concat(responsePayLoad.getDocumentType()));
        actual_list.add(("SubType:".concat(responsePayLoad.getSubtype())));
        actual_list.add("ProjectFolderFileName:".concat(responsePayLoad.getMeta().getCommon().getName()));

        expected_list.clear();
        expected_list.add("Document Type:fsobject");
        expected_list.add("SubType:element");
        expected_list.add("ProjectFolderFileName:".concat(ExpectedData.PROJECT_FOLDER_FIlENAME));

        Assert.assertEquals(actual_list,expected_list,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}