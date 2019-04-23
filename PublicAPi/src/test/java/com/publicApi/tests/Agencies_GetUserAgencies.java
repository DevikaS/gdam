package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.BaseTests;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 15/02/2016.
 */
public class Agencies_GetUserAgencies extends BaseTests {

    @Test
    public void getCurrentUserTest(){
        apiCall = new HeadlessAPICalls();

        Assert.assertTrue(apiCall.getUserAgencies(),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}