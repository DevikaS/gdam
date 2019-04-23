package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;


/**
 * Created by Nirmala.Sankaran on 08/02/2016.
 */
public class Relations_GetRelated extends ProjectsBaseTest {

    @Test
    public void getRelationTest() {

        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createProject();
        setProjectId(responsePayLoad.getId());
        setProjectName(responsePayLoad.getMeta().getCommon().getName());

        //create parent file
        responsePayLoad = apiCall.createProjectFile(getProjectId());
        setParentFileId(responsePayLoad.getId());

        //create child file
        responsePayLoad = apiCall.createProjectFile(getProjectId());
        setChildFileId(responsePayLoad.getId());

        //create Relations
        responsePayLoad = apiCall.createRelation(getParentFileId(), getChildFileId());

        //get relation
        responsePayLoad = apiCall.getRelated(getParentFileId());

        Assert.assertEquals(responsePayLoad.getDocumentId(),getParentFileId(),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}