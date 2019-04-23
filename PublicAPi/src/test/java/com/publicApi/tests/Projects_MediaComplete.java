package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import com.publicApi.jsonPayLoads.ExpectedData;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.io.IOException;

/**
 * Created by Nirmala.Sankaran on 27/11/2015.
 */
public class Projects_MediaComplete extends ProjectsBaseTest {

    @Test
    public void mediaCompleteTest() throws IOException{
        apiCall = new HeadlessAPICalls();

        responsePayLoad =  apiCall.createProject();
        setProjectId(responsePayLoad.getId());

        responsePayLoad = apiCall.projectMediaRegister(getProjectId());
        setMediaId(responsePayLoad.getId());
        setReference(responsePayLoad.getReference());
        setUrl(responsePayLoad.getUrl());

        Assert.assertTrue(apiCall.mediaUploadToGdn(getUrl(), getReference()),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, 'Media Upload to GDN");

        responsePayLoad=apiCall.projectMediaComplete(getProjectId(), getMediaId(), ExpectedData.ASSETFILENAME);

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
