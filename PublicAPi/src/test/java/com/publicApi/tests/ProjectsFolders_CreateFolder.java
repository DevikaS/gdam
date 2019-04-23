package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import com.publicApi.jsonPayLoads.ExpectedData;
import org.testng.Assert;
import org.testng.annotations.Test;


/**
 * Created by Nirmala.Sankaran on 10/11/2015.
 */
public class ProjectsFolders_CreateFolder extends ProjectsBaseTest {

    @Test
    public void ProjectsFoldersCreateFolderTest() {

        apiCall = new HeadlessAPICalls();

        responsePayLoad =  apiCall.createProject();
        setProjectId(responsePayLoad.getId());

        responsePayLoad = apiCall.searchProjectFolderId(getProjectId());
        setParentFileId(responsePayLoad.getId());

        responsePayLoad =  apiCall.createFolder(getParentFileId());

        // Verify fields in response
        actual_list.clear();
        actual_list.add("Subtype:".concat(responsePayLoad.getSubtype()));
        actual_list.add("DocumentType:".concat(responsePayLoad.getDocumentType()));
        actual_list.add("FolderName:".concat(responsePayLoad.getMeta().getCommon().getName()));

        expected_list.clear();
        expected_list.add("Subtype:folder");
        expected_list.add("DocumentType:fsobject");
        expected_list.add("FolderName:".concat(ExpectedData.PROJECT_FOLDER_NAME));

        Assert.assertEquals(actual_list,expected_list,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}