package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;

public class ProjectsFiles_EditFile extends ProjectsBaseTest {

    @Test
    public void projectsFielsUpdateFileTest() {

        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createProject();
        setProjectId(responsePayLoad.getId());

        responsePayLoad = apiCall.createProjectFile(getProjectId());
        setFileId(responsePayLoad.getId());
        setFileName(responsePayLoad.getMeta().getCommon().getName());

        // Update the file with more metadata
        responsePayLoad = apiCall.projectsFilesUpdateFile(getFileId());

        // Edit file with valid name - should update only name and other metadata should be persisted
        responsePayLoad = apiCall.projectFilesEditFile(getFileId(), true);

        actual_list.clear();
        actual_list.add("DocumentType:".concat(responsePayLoad.getDocumentType()));
        actual_list.add("SubType:".concat(responsePayLoad.getSubtype()));
        actual_list.add("ProjectFileName:".concat(responsePayLoad.getMeta().getCommon().getName()));
        actual_list.add("ProjectFileCampaign:".concat(responsePayLoad.getMeta().getCommon().getCampaign()));
        actual_list.add("ProjectFileAdvertiser:".concat(responsePayLoad.getMeta().getCommon().getAdvertiser()[0]));

        expected_list.clear();
        expected_list.add("DocumentType:fsobject");
        expected_list.add("SubType:element");
        expected_list.add("ProjectFileName:".concat(ExpectedData.PROJECT_FILENAME_UPDATE));
        expected_list.add("ProjectFileCampaign:".concat(ExpectedData.CAMPAIGN));
        expected_list.add("ProjectFileAdvertiser:".concat(ExpectedData.ADVERTISER));

        Assert.assertEquals(actual_list, expected_list,
                this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");

        //Edit the mandatory name attribute to empty string (invalid) - should be successful with patch update
        responsePayLoad = apiCall.projectFilesEditFile(getFileId(), false);

        actual_list.clear();
        actual_list.add("DocumentType:".concat(responsePayLoad.getDocumentType()));
        actual_list.add("SubType:".concat(responsePayLoad.getSubtype()));
        actual_list.add("ProjectFileName:".concat(responsePayLoad.getMeta().getCommon().getName()));
        actual_list.add("ProjectFileCampaign:".concat(responsePayLoad.getMeta().getCommon().getCampaign()));
        actual_list.add("ProjectFileAdvertiser:".concat(responsePayLoad.getMeta().getCommon().getAdvertiser()[0]));

        expected_list.clear();
        expected_list.add("DocumentType:fsobject");
        expected_list.add("SubType:element");
        expected_list.add("ProjectFileName:".concat(""));
        expected_list.add("ProjectFileCampaign:".concat(ExpectedData.CAMPAIGN));
        expected_list.add("ProjectFileAdvertiser:".concat(ExpectedData.ADVERTISER));

        Assert.assertEquals(actual_list, expected_list,
                this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");

    }
}
