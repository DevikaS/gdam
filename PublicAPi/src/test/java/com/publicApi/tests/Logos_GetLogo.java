package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 15/02/2016.
 */
public class Logos_GetLogo extends ProjectsBaseTest {

    @Test
    public void getLogoTest(){
        apiCall = new HeadlessAPICalls();

        Assert.assertTrue(apiCall.getLogo(),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}
