package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.BaseTests;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 05/02/2016.
 */
public class Dictionary_ListDictionaries extends BaseTests {

    @Test
    public void listDictionaryTest() {
        apiCall = new HeadlessAPICalls();

        String response = apiCall.listDictionaries();

        Assert.assertNotNull(response);
    }
}
