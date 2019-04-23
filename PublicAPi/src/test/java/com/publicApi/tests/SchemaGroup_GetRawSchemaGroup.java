package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.BaseTests;
import org.testng.Assert;
import org.testng.annotations.Test;


public class SchemaGroup_GetRawSchemaGroup extends BaseTests {

    @Test
    public void validateSchemaForAdkitGroupAndTypeAgency() {
        try {
            apiCall = new HeadlessAPICalls();
            Assert.assertTrue(apiCall.getRawSchemaForGroupAdkitAndTypeAgency(),
                    "validateSchemaForAdkitGroupAndTypeAgency - End point validation failed");
        } catch (Exception e) {
            e.printStackTrace();
            Assert.fail("validateSchemaForAdkitGroupAndTypeAgency - End point validation failed");
        }
    }

    @Test
    public void validateSchemaForAssetElementProjectCommonGroupAndTypeAgency() {
        try {
            apiCall = new HeadlessAPICalls();
            Assert.assertTrue(apiCall.getRawSchemaForGroupAssetElementProjectCommonAndTypeAgency(),
                    "validateSchemaForAssetElementProjectCommonGroupAndTypeAgency - End point validation failed");
        } catch (Exception e) {
            e.printStackTrace();
            Assert.fail("validateSchemaForAssetElementProjectCommonGroupAndTypeAgency - End point validation failed");
        }
    }
}