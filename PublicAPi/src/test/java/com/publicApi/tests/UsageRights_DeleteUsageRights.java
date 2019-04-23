package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import com.publicApi.jsonPayLoads.ExpectedData;
import org.testng.Assert;
import org.testng.annotations.Test;


/**
 * Created by Nirmala.Sankaran on 08/02/2016.
 */
public class UsageRights_DeleteUsageRights extends ProjectsBaseTest {

    @Test
    public void deleteUsageRights_FilesTest() {
        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createProject();
        setProjectId(responsePayLoad.getId());
        setProjectName(responsePayLoad.getMeta().getCommon().getName());

        //create  file
        responsePayLoad = apiCall.createProjectFile(getProjectId());
        setParentFileId(responsePayLoad.getId());

        //update usage rights
        responsePayLoad = apiCall.updateUsageRights("files", getParentFileId());

        responsePayLoad=apiCall.getUsageRights("files", getParentFileId());

        Assert.assertEquals(responsePayLoad.getLastStartDate(), ExpectedData.USAGERIGHTSSTARTDATE,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed for 'files', due to, ");

        Assert.assertTrue(apiCall.deleteUsageRights("files", getParentFileId()),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed for 'Files' due to, ");
    }

    @Test
    public void deleteUsageRights_AssetsTest() {
        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createProject();
        setProjectId(responsePayLoad.getId());
        setProjectName(responsePayLoad.getMeta().getCommon().getName());

        //create  file
        responsePayLoad = apiCall.createProjectFile(getProjectId());
        setParentFileId(responsePayLoad.getId());

        //update usage rights
        responsePayLoad = apiCall.updateUsageRights("assets", getParentFileId());

        responsePayLoad=apiCall.getUsageRights("assets", getParentFileId());

        Assert.assertEquals(responsePayLoad.getLastStartDate(), ExpectedData.USAGERIGHTSSTARTDATE,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed for 'Assets', due to, ");

        Assert.assertTrue(apiCall.deleteUsageRights("assets", getParentFileId()),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed for 'Assets' due to, ");
    }
}