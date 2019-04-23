package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;


/**
 * Created by Nirmala.Sankaran on 19/02/2016.
 */
public class OrderMarkets_ListMarkets extends OrdersBaseTest{

    @Test
    public void listOrderMarketsTest(){
        apiCall = new HeadlessAPICalls();

        Assert.assertTrue(apiCall.listOrderMarkets(),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");

    }
}
