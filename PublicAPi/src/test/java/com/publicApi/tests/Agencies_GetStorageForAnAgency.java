package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.jsonPayLoads.GsonClasses.Storage;
import com.publicApi.tests.testsBase.BaseTests;
import org.testng.Assert;
import org.testng.annotations.Test;


public class Agencies_GetStorageForAnAgency extends BaseTests {

    @Test
    public void getStorageTypeTest(){
        apiCall = new HeadlessAPICalls();

        // Validate A5 storage type
        Storage storage = apiCall.getStorageForAnAgency(ExpectedData.PRIMARY_BU_ID);
        Assert.assertTrue(storage.getSubType().equalsIgnoreCase("DEFAULT FILE STORAGE"),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");

        // Validate S3 storage type
        storage = apiCall.getStorageForAnAgency(ExpectedData.S3_STORAGE_BU_ID);
        Assert.assertTrue(storage.getSubType().equalsIgnoreCase("S3"),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}