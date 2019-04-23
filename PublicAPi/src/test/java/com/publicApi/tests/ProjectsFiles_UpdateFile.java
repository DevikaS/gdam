package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import com.publicApi.jsonPayLoads.ExpectedData;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 30/11/2015.
 */
public class ProjectsFiles_UpdateFile extends ProjectsBaseTest {

    @Test
    public void projectsFielsUpdateFileTest() {

        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createProject();
        setProjectId(responsePayLoad.getId());

        responsePayLoad = apiCall.createProjectFile(getProjectId());
        setFileId(responsePayLoad.getId());
        setFileName(responsePayLoad.getMeta().getCommon().getName());

        responsePayLoad=apiCall.projectsFilesUpdateFile(getFileId());

        // Verify fields in response

        actual_list.clear();
        actual_list.add("DocumentType:".concat(responsePayLoad.getDocumentType()));
        actual_list.add("SubType:".concat(responsePayLoad.getSubtype()));
        actual_list.add("ProjectFileName:".concat(responsePayLoad.getMeta().getCommon().getName()));

        expected_list.clear();;
        expected_list.add("DocumentType:fsobject");
        expected_list.add("SubType:element");
        expected_list.add("ProjectFileName:".concat(ExpectedData.PROJECT_FILENAME_UPDATE));
    }
}
