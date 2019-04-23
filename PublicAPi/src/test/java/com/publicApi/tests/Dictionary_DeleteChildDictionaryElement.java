package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.tests.testsBase.BaseTests;
import org.testng.Assert;
import org.testng.annotations.Test;


/**
 * Created by Devika on 13/11/2016.
 */
public class Dictionary_DeleteChildDictionaryElement extends BaseTests {

    @Test
    public void deleteChildDictionaryTest() {

        apiCall = new HeadlessAPICalls();

        String dictionary = apiCall.updateDictionary();
        //delete the child element
        Assert.assertTrue(apiCall.deleteChildDictionaryElement(ExpectedData.DICTIONARY_ID_UPDATE),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");

        dictionary = apiCall.getDictionary();

        Assert.assertTrue(!(dictionary.contains(ExpectedData.DICTIONARY_CHILD_ID_UPDATE)),
               this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}
