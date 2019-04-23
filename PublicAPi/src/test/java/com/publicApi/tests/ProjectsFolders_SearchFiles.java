package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import com.publicApi.jsonPayLoads.ExpectedData;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 10/11/2015.
 */
public class ProjectsFolders_SearchFiles extends ProjectsBaseTest {

    @Test
    public void projectsFolderSearchFilesTest() throws InterruptedException{

        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createProject();
        setProjectId(responsePayLoad.getId());

        responsePayLoad = apiCall.searchProjectFolderId(getProjectId());
        setParentFileId(responsePayLoad.getId());

        responsePayLoad = apiCall.createFolder(getParentFileId());
        setFolderId(responsePayLoad.getId());

        responsePayLoad = apiCall.createFile(getFolderId());

        Thread.sleep(5000);

       responsePayLoad=apiCall.projectsFoldersSearchFile(getFolderId());

        // Verify fields in response

        actual_list.getClass();
        actual_list.add("Subtype:".concat(responsePayLoad.getSubtype()));
        actual_list.add("FolderName:".concat(responsePayLoad.getMeta().getCommon().getName()));
        actual_list.add("DocumentType:".concat(responsePayLoad.getDocumentType()));

        expected_list.clear();;
        expected_list.add("Subtype:element");
        expected_list.add("FolderName:".concat(ExpectedData.PROJECT_FOLDER_FIlENAME));
        expected_list.add("DocumentType:fsobject");

        Assert.assertEquals(actual_list,expected_list,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}