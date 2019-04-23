package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.tests.testsBase.BaseTests;
import org.testng.Assert;
import org.testng.annotations.Test;


/**
 * Created by Nirmala.Sankaran on 05/02/2016.
 */
public class Dictionary_UpdateDictionary extends BaseTests {

    @Test
    public void updateDictionaryTest() {

        apiCall = new HeadlessAPICalls();

        String dictionary = apiCall.updateDictionary();

        Assert.assertNotNull(dictionary,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");

        Assert.assertTrue(dictionary.contains(ExpectedData.DICTIONARY_ID_UPDATE),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");

        Assert.assertTrue(dictionary.contains(ExpectedData.DICTIONARY_ID_ADDITIONALPARAM),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");

    }
}