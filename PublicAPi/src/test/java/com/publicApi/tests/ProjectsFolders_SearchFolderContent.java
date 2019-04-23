package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import com.publicApi.jsonPayLoads.ExpectedData;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.io.IOException;


public class ProjectsFolders_SearchFolderContent extends ProjectsBaseTest{

    @Test
    public void projectsFoldersSearchFolderContentTest() throws InterruptedException{
        apiCall = new HeadlessAPICalls();

        responsePayLoad =  apiCall.createProject();
        setProjectId(responsePayLoad.getId());

        responsePayLoad = apiCall.searchProjectFolderId(getProjectId());
        setParentFileId(responsePayLoad.getId());

        responsePayLoad =  apiCall.createFolder(getParentFileId());
        setFolderId(responsePayLoad.getId());

        responsePayLoad = apiCall.createFile(getFolderId());
        setFileId(responsePayLoad.getId());
        setFileName(responsePayLoad.getMeta().getCommon().getName());

        Thread.sleep(5000);

        responsePayLoad=apiCall.projectsFoldersSearchFolderContent(getFolderId());

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

    @Test
    public void projectsFoldersSearchFolderContentWithApprovalInfoTest() throws IOException {

        apiCall = new HeadlessAPICalls();

        responsePayLoad =  apiCall.createProject();
        setProjectId(responsePayLoad.getId());
        setProjectName(responsePayLoad.getMeta().getCommon().getName());

        responsePayLoad = apiCall.projectMediaRegister(getProjectId());
        setMediaId(responsePayLoad.getId());
        setReference(responsePayLoad.getReference());
        setUrl(responsePayLoad.getUrl());
        apiCall.mediaUploadToGdn(getUrl(), getReference());

        responsePayLoad=apiCall.projectMediaComplete(getProjectId(), getMediaId(), ExpectedData.ASSETFILENAME);
        setParents(responsePayLoad.getParents()[0]);
        setRevisionId(responsePayLoad.getRevisions()[0].getRevisionId());
        setFileId(responsePayLoad.getId());
        setShortId(responsePayLoad.getShort_id());

        responsePayLoad=apiCall.projectCreateApproval(getMediaId(), getFileId(), getRevisionId(), getShortId(), getProjectId(), getProjectName(), getParents());
        setApproverId(responsePayLoad.getApproval().get_id());

        responsePayLoad=apiCall.projectCreateApprovalStage(getApproverId(),false,"WaitAll");
        setStageId(responsePayLoad.getStage().getStageId());

        responsePayLoad = apiCall.projectStartApproval(getMediaId(), getFileId(), getApproverId());
        String approvalId = responsePayLoad.getApproval().get_id();

        waitFor(5000);
        String queryString = "expand=status";
        responsePayLoad=apiCall.projectsFoldersSearchFolderContent(getParents(), queryString);
        Assert.assertTrue(responsePayLoad.getApproval().get_id().equalsIgnoreCase(approvalId), ": End Point Failed due to, ");

    }
}
