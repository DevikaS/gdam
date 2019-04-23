package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.tests.testsBase.BaseTests;
import org.testng.Assert;
import org.testng.annotations.Test;


/**
 * Created by Nirmala.Sankaran on 05/02/2016.
 */
public class Dictionary_DeleteDictionaryElement extends BaseTests {

    @Test
    public void deleteDictionaryTest() {

        apiCall = new HeadlessAPICalls();

        String dictionary = apiCall.updateDictionary();

        //delete the element
        Assert.assertTrue(apiCall.deleteDictionaryElement(ExpectedData.DICTIONARY_ID_UPDATE),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");

        dictionary = apiCall.getDictionary();

        Assert.assertTrue(!(dictionary.contains(ExpectedData.DICTIONARY_ID_UPDATE)),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}
