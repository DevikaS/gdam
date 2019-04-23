package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import com.publicApi.jsonPayLoads.ExpectedData;
import org.testng.Assert;
import org.testng.annotations.Test;


/**
 * Created by Nirmala.Sankaran on 08/02/2016.
 */
public class Relations_CreateRelation extends ProjectsBaseTest {

    @Test
    public void createRelation() {

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

        Assert.assertEquals(responsePayLoad.getRelationTypeId(), ExpectedData.RELATION_TYPE_ID,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}