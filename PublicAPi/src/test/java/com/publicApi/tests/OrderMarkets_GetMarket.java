package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 18/02/2016.
 */
public class OrderMarkets_GetMarket extends OrdersBaseTest {

    @Test
    public void getOrderMarketTest() {

        apiCall = new HeadlessAPICalls();

        Assert.assertTrue(apiCall.getOrderMarkets(),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}
