package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.io.IOException;


/**
 * Created by Devika on 22/12/2016.
 */
public class ProjectApprovalStages_UpdateApprovalStage extends ProjectsBaseTest {

    @Test
    public void updateProjectApprovalStage() throws IOException {

        apiCall = new HeadlessAPICalls();

        responsePayLoad =  apiCall.createProject();
        setProjectId(responsePayLoad.getId());
        setProjectName(responsePayLoad.getMeta().getCommon().getName());

        responsePayLoad = apiCall.createProjectFile(getProjectId());
        setFileId(responsePayLoad.getId());
        setShortId(responsePayLoad.getShort_id());

        responsePayLoad = apiCall.projectMediaRegister(getProjectId());
        setMediaId(responsePayLoad.getId());
        setReference(responsePayLoad.getReference());
        setUrl(responsePayLoad.getUrl());
        apiCall.mediaUploadToGdn(getUrl(), getReference());

        responsePayLoad=apiCall.projectMediaComplete(getProjectId(), getMediaId(), ExpectedData.ASSETFILENAME);
        setParents(responsePayLoad.getParents()[0]);
        setRevisionId(responsePayLoad.getRevisions()[0].getRevisionId());

        responsePayLoad=apiCall.projectCreateApproval(getMediaId(), getFileId(), getRevisionId(), getShortId(), getProjectId(), getProjectName(), getParents());
        setApproverId(responsePayLoad.getApproval().get_id());

        responsePayLoad=apiCall.projectCreateApprovalStage(getApproverId(),false,"WaitAll");
        setStageId(responsePayLoad.getStage().getStageId());

        responsePayLoad=apiCall.projectUpdateApprovalStage(getApproverId(), getStageId(),false);
        Assert.assertEquals(responsePayLoad.getStage().getName(), ExpectedData.PROJECT_APPROVALSTAGENAME_AFTERUPDATE, this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");

        responsePayLoad=apiCall.projectGetApprovalStage(getApproverId(), getStageId(),false);
        Assert.assertEquals(ExpectedData.PROJECT_APPROVALSTAGENAME_AFTERUPDATE,responsePayLoad.getStage().getName(), "End Point Failed due to, ");
    }
}
