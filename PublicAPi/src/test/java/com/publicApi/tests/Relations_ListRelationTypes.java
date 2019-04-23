package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;


/**
 * Created by Nirmala.Sankaran on 08/02/2016.
 */
public class Relations_ListRelationTypes extends ProjectsBaseTest {

    @Test
    public void listRelationTypes() {
        apiCall = new HeadlessAPICalls();

        Assert.assertTrue(apiCall.listRelationTypes(),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}
