package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import com.publicApi.jsonPayLoads.ExpectedData;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 08/02/2016.
 */
public class UsageRights_UpdateUsageRights extends ProjectsBaseTest {

    @Test
    public void updateUsageRights_FilesTests() {
        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createProject();
        setProjectId(responsePayLoad.getId());
        setProjectName(responsePayLoad.getMeta().getCommon().getName());

        //create  file
        responsePayLoad = apiCall.createProjectFile(getProjectId());
        setParentFileId(responsePayLoad.getId());

        //update usage rights
        responsePayLoad = apiCall.updateUsageRights("files", getParentFileId());

        Assert.assertEquals(responsePayLoad.getLastStartDate(), ExpectedData.USAGERIGHTSSTARTDATE,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed for 'files', due to, ");

        responsePayLoad=apiCall.getUsageRights("files", getParentFileId());

        Assert.assertEquals(responsePayLoad.getLastStartDate(), ExpectedData.USAGERIGHTSSTARTDATE,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed for 'files', due to, ");
    }

    @Test
    public void updateUsageRights_AssetsTests() {
        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createProject();
        setProjectId(responsePayLoad.getId());
        setProjectName(responsePayLoad.getMeta().getCommon().getName());

        //create  file
        responsePayLoad = apiCall.createProjectFile(getProjectId());
        setParentFileId(responsePayLoad.getId());

        //update usage rights
        responsePayLoad = apiCall.updateUsageRights("assets", getParentFileId());

        Assert.assertEquals(responsePayLoad.getLastStartDate(), ExpectedData.USAGERIGHTSSTARTDATE,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed for 'Assets', due to, ");

        responsePayLoad=apiCall.getUsageRights("assets", getParentFileId());

        Assert.assertEquals(responsePayLoad.getLastStartDate(), ExpectedData.USAGERIGHTSSTARTDATE,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed for 'Assets', due to, ");
    }
}