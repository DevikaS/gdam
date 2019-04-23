package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.io.IOException;


/**
 * Created by Nirmala.Sankaran on 05/02/2016.
 */
public class ProjectApprovals_ListApprovals extends ProjectsBaseTest {

    public ProjectApprovals_ListApprovals() {
        apiCall = new HeadlessAPICalls();
    }

    @Test
    public void projectApprovals_ListApprovalsTest_typeNotStarted() throws IOException{

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

        String response = apiCall.projectsApprovals_ListApprovals("notstarted");

        Assert.assertTrue(response.contains("Hidden"),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, Check ProjectApprovals_ListApprovals endpoint with type=notstarted");
    }

    @Test
    public void projectApprovals_ListApprovalsTest_typeSubmitted() throws IOException{

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

        responsePayLoad = apiCall.projectStartApproval(getMediaId(), getFileId(), getApproverId());

        String response = apiCall.projectsApprovals_ListApprovals("submitted");

        if(response.contains("hidden"))
            Assert.fail("Check ProjectApprovals_ListApprovals endpoint with type=submitted");
    }
}
