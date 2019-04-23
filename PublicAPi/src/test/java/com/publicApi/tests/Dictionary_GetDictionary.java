package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.BaseTests;
import org.testng.Assert;
import org.testng.annotations.Test;


/**
 * Created by Nirmala.Sankaran on 05/02/2016.
 */
public class Dictionary_GetDictionary extends BaseTests {

    @Test
    public void getDictionary_ForAdvertiserAsKeyTest() {
        apiCall = new HeadlessAPICalls();

        String dictionary=apiCall.getDictionary();

        Assert.assertNotNull(dictionary, this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");

        Assert.assertTrue(dictionary.contains("Advertiser"),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
        Assert.assertTrue(dictionary.contains("Brand"),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
        Assert.assertTrue(dictionary.contains("SubBrand"),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
        Assert.assertTrue(dictionary.contains("Product"),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}
