package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.BaseTests;
import org.testng.Assert;
import org.testng.annotations.Test;


/**
 * Created by Nirmala.Sankaran on 10/11/2015.
 */
public class Schema_GetMarketSchema extends BaseTests {

    @Test
    public void marketSchema_CreateTest() {
        try {
            apiCall = new HeadlessAPICalls();
            Assert.assertTrue(apiCall.get_MarketSchema("create"),
                    "Schema_GetMarketSchema - End point failed, Check 'Create' method");
        } catch (Exception e) {
            e.printStackTrace();
            Assert.fail("Schema_GetMarketSchema - End point failed, Check 'Create' method");
        }
    }

    @Test
    public void marketSchema_UpdateTest(){
        try {
            apiCall = new HeadlessAPICalls();
            Assert.assertTrue(apiCall.get_MarketSchema("update"),
                    "Schema_GetMarketSchema - End point failed, Check 'Update' method");
        } catch (Exception e) {
            e.printStackTrace();
            Assert.fail("Schema_GetMarketSchema - End point failed, Check 'Update' method");
        }
    }
}