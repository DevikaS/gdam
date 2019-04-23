package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 18/02/2016.
 */
public class Orders_GetOrderReport extends OrdersBaseTest {

    @Test
    public void getOrderReportTest() {
        apiCall = new HeadlessAPICalls();

        responsePayLoad=apiCall.createOrder();
        setOrderId(responsePayLoad.getId());

        responsePayLoad=apiCall.createItem(getOrderId());
        setItemId(responsePayLoad.getId());

        apiCall.addDestinationItems(getOrderId(),getItemId());

        responsePayLoad=apiCall.processDraftorders(getOrderId(),getItemId(),"Library");

        boolean actualState = apiCall.getOrderReport(getOrderId());
        Assert.assertTrue(actualState,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
 }