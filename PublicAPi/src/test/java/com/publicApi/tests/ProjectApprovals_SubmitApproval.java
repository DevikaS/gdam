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
public class ProjectApprovals_SubmitApproval extends ProjectsBaseTest {

    public ProjectApprovals_SubmitApproval(){
        apiCall = new HeadlessAPICalls();
    }

    @Test
    public void projectSubmitApproval_StatusApproved() throws IOException {

        responsePayLoad=null;
        responsePayLoad =  apiCall.createProject();
        setProjectId(responsePayLoad.getId());
        setProjectName(responsePayLoad.getMeta().getCommon().getName());

        responsePayLoad = apiCall.projectMediaRegister(getProjectId());
        setMediaId(responsePayLoad.getId());
        setReference(responsePayLoad.getReference());
        setUrl(responsePayLoad.getUrl());
        apiCall.mediaUploadToGdn(getUrl(), getReference());

        responsePayLoad=apiCall.projectMediaComplete(getProjectId(), getMediaId(), ExpectedData.ASSETFILENAME);
        setFileId(responsePayLoad.getId());
        setShortId(responsePayLoad.getShort_id());
        setParents(responsePayLoad.getParents()[0]);
        setRevisionId(responsePayLoad.getRevisions()[0].getRevisionId());

        responsePayLoad=apiCall.projectCreateApproval(getMediaId(), getFileId(), getRevisionId(), getShortId(), getProjectId(), getProjectName(), getParents());
        setApproverId(responsePayLoad.getApproval().get_id());

        responsePayLoad=apiCall.projectCreateApprovalStage(getApproverId(),false,"WaitAll");
        setStageId(responsePayLoad.getStage().getStageId());

       responsePayLoad = apiCall.projectSubmitApproval(getApproverId(),getStageId(),"approved");
        Assert.assertEquals(responsePayLoad.getApproval().get_id(), getApproverId(), this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");
        Assert.assertEquals(responsePayLoad.getApproval().getStatus(), "Approved", this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");
    }

    @Test
    public void projectSubmitApproval_StatusRejected() throws IOException {
        responsePayLoad=null;
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

        responsePayLoad = apiCall.projectSubmitApproval(getApproverId(),getStageId(),"rejected");
        Assert.assertEquals(responsePayLoad.getApproval().get_id(), getApproverId(), this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");
        Assert.assertEquals(responsePayLoad.getApproval().getStatus(), "Rejected", this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");
    }
}