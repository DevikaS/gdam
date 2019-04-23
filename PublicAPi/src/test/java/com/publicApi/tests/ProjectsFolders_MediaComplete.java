package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.GsonClasses.Media;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import com.publicApi.jsonPayLoads.ExpectedData;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.io.IOException;


/**
 * Created by Nirmala.Sankaran on 21/12/2015.
 */
public class ProjectsFolders_MediaComplete extends ProjectsBaseTest{

    @Test
    public void projectsFolders_CompleteMedia() throws IOException {

        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createProject();
        setProjectId(responsePayLoad.getId());

        responsePayLoad = apiCall.searchProjectFolderId(getProjectId());
        setParentFileId(responsePayLoad.getId());

        responsePayLoad = apiCall.createFolder(getParentFileId());
        setFolderId(responsePayLoad.getId());

        responsePayLoad = apiCall.projectsFoldersMediaRegister(getFolderId());
        Assert.assertEquals(responsePayLoad.getA4Status(),"succeeded","Failed to register a placeholder for a file under, a specfied folder.");
        Assert.assertEquals(responsePayLoad.getReference(), ExpectedData.ASSETPATH,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
        setUrl(responsePayLoad.getUrl());
        setMediaId(responsePayLoad.getId());
        setReference(responsePayLoad.getReference());

        Assert.assertTrue(apiCall.mediaUploadToGdn(getUrl(), getReference()),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, 'Media Upload to GDN ");

        responsePayLoad = apiCall.ProjectsFolderMediaComplete(getFolderId(), ExpectedData.ASSETFILENAME, getMediaId());

        // verify fields in response
        actual_list.clear();
        actual_list.add("Document Type:".concat(responsePayLoad.getDocumentType()));
        actual_list.add("SubType:".concat(responsePayLoad.getSubtype()));
        actual_list.add("MediaFileName:".concat(responsePayLoad.getMeta().getCommon().getName()));

        expected_list.clear();
        expected_list.add("Document Type:".concat("fsobject"));
        expected_list.add("SubType:".concat("element"));
        expected_list.add("MediaFileName:".concat(ExpectedData.ASSETFILENAME));

        Assert.assertEquals(actual_list,expected_list,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}
