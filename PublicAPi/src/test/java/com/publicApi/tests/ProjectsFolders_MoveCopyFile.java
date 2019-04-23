package com.publicApi.tests;

import com.google.gson.Gson;
import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.jsonPayLoads.GsonClasses.BaseOfBase;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 10/11/2015.
 */
public class ProjectsFolders_MoveCopyFile extends ProjectsBaseTest {

    Gson gson;

    public ProjectsFolders_MoveCopyFile() {
        apiCall = new HeadlessAPICalls();
        gson = new Gson();
    }

    @Test
    public void projectsFoldersCopyFileTest() {

        String destFolderId = createProjectAndFolders(apiCall);

        uploadFileToFolder(apiCall);

        // COPY file from one folder to another
        responsePayLoad = apiCall.moveCopyFile(destFolderId, getMediaId(), "false", true);
        Assert.assertTrue(responsePayLoad.getFileSize() > 0);
        Assert.assertEquals(responsePayLoad.getMeta().getCommon().getName(), ExpectedData.ASSETFILENAME);

        waitFor(9999); // To even-out previous endpoint operation

        // Check file available in destination folder after COPY operation
        String response = apiCall.projectsFoldersSearchFile_WithoutSchema(destFolderId);

        // Verify fields in response
        gson.fromJson(response, BaseOfBase.class);

        actual_list.getClass();
        actual_list.add("Subtype:".concat(responsePayLoad.getSubtype()));
        actual_list.add("FolderName:".concat(responsePayLoad.getMeta().getCommon().getName()));
        actual_list.add("DocumentType:".concat(responsePayLoad.getDocumentType()));

        expected_list.clear();
        expected_list.add("Subtype:element");
        expected_list.add("FolderName:".concat(ExpectedData.ASSETFILENAME));
        expected_list.add("DocumentType:fsobject");

        Assert.assertEquals(actual_list, expected_list,
                this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");

        // Check file still available in source folder after COPY operation
        Assert.assertNotNull(apiCall.projectsFoldersSearchFile_WithoutSchema(getFolderId()));
    }


    @Test
    public void projectsFoldersMoveFileTest() {

        String destFolderId = createProjectAndFolders(apiCall);

        uploadFileToFolder(apiCall);

        // MOVE file from one folder to another
        responsePayLoad = apiCall.moveCopyFile(destFolderId, getMediaId(), "true", true);
        Assert.assertTrue(responsePayLoad.getFileSize() == ExpectedData.ASSETSIZE);
        Assert.assertEquals(responsePayLoad.getMeta().getCommon().getName(), ExpectedData.ASSETFILENAME);

        waitFor(9999); // To even-out previous endpoint operation

        // Check file available in destination folder after COPY operation
        String response = apiCall.projectsFoldersSearchFile_WithoutSchema(destFolderId);

        // Verify fields in response
        gson.fromJson(response, BaseOfBase.class);
        actual_list.clear();
        actual_list.add("Subtype:".concat(responsePayLoad.getSubtype()));
        actual_list.add("FolderName:".concat(responsePayLoad.getMeta().getCommon().getName()));
        actual_list.add("DocumentType:".concat(responsePayLoad.getDocumentType()));

        expected_list.clear();
        expected_list.add("Subtype:element");
        expected_list.add("FolderName:".concat(ExpectedData.ASSETFILENAME));
        expected_list.add("DocumentType:fsobject");

        Assert.assertEquals(actual_list, expected_list,
                this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");

        // Check file not available in source folder after MOVE operation
        response = apiCall.projectsFoldersSearchFile_WithoutSchema(getFolderId());

        if (response.contains("id"))
            Assert.fail("Check file 'MOVE' operation. File still exists in source folder: '" + getFolderId() + "' after move operation.");
    }


    @Test
    public void projectsFoldersCopyFolderTest() {

        String destFolderId = createProjectAndFolders(apiCall);

        // COPY a folder to another folder
        responsePayLoad = apiCall.moveCopyFile(destFolderId, getFolderId(), "false", false);

        waitFor(9999); // To even-out previous endpoint operation

        // Check folder available in destination folder after COPY operation
        responsePayLoad = apiCall.projectsFoldersSearchFolderContent(destFolderId);

        Assert.assertTrue(responsePayLoad.getMeta().getCommon().getName().equals(getFolderName()),
                "Check Folder 'COPY' operation. Source Folder id '" + getFolderId() + "' not copied to destination folder id '" + destFolderId);
    }

    @Test
    public void projectsFoldersMoveFolderTest() {

        String destFolderId = createProjectAndFolders(apiCall);

        // MOVE a folder to another folder
        responsePayLoad = apiCall.moveCopyFile(destFolderId, getFolderId(), "true", false);

        waitFor(9999); // To even-out previous endpoint operation

        // Check folder available in destination folder after MOVE operation
        responsePayLoad = apiCall.projectsFoldersSearchFolderContent(destFolderId);

        Assert.assertTrue(responsePayLoad.getMeta().getCommon().getName().equals(getFolderName()),
                "Check Folder 'MOVE' operation. Source Folder id '" + getFolderId() + "' not moved to destination folder id '" + destFolderId);
    }


    private String createProjectAndFolders(HeadlessAPICalls apiCall) {
        responsePayLoad = apiCall.createProject();
        setProjectId(responsePayLoad.getId());

        responsePayLoad = apiCall.searchProjectFolderId(getProjectId());
        setParentFileId(responsePayLoad.getId());

        responsePayLoad = apiCall.createFolder(getParentFileId());
        setFolderId(responsePayLoad.getId());
        setFolderName(responsePayLoad.getMeta().getCommon().getName());
        verifyFolderCreation(responsePayLoad.getMeta().getCommon().getName());

        responsePayLoad = apiCall.createFolder(getParentFileId());
        verifyFolderCreation(responsePayLoad.getMeta().getCommon().getName());
        return responsePayLoad.getId();
    }

    private void verifyFolderCreation(String folderName) {
        Assert.assertNotNull(folderName);
        Assert.assertTrue(folderName.contains("FolderNameAPI_"));
    }

    private void uploadFileToFolder(HeadlessAPICalls apiCall) {
        try {
            responsePayLoad = apiCall.projectsFoldersMediaRegister(getFolderId());

            setUrl(responsePayLoad.getUrl());
            setMediaId(responsePayLoad.getId());
            setReference(responsePayLoad.getReference());

            Assert.assertEquals(responsePayLoad.getA4Status(), "succeeded", "Failed to register a placeholder for a file under a specified folder.");
            Assert.assertEquals(responsePayLoad.getReference(), ExpectedData.ASSETPATH,
                    this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");

            Assert.assertTrue(apiCall.mediaUploadToGdn(getUrl(), getReference()),
                    this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, 'Media Upload to GDN ");

            responsePayLoad = apiCall.ProjectsFolderMediaComplete(getFolderId(), ExpectedData.ASSETFILENAME, getMediaId());
            Assert.assertEquals(responsePayLoad.getMeta().getCommon().getName(), ExpectedData.ASSETFILENAME);

            setMediaId(responsePayLoad.getId());

            waitFor(25000); // Explicitly wait for 25 sec's to finish transcode.
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
