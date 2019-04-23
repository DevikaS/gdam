package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import com.publicApi.jsonPayLoads.ExpectedData;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 15/02/2016.
 */
public class Order_UpdateOrder extends OrdersBaseTest {

    @Test
    public void updateOrderTest(){
        apiCall = new HeadlessAPICalls();

        responsePayLoad= apiCall.createOrder();
        setOrderId(responsePayLoad.getId());

        responsePayLoad=apiCall.updateOrder(getOrderId());

        // VERIFY - Important fields in response payload

        actual_list.add(responsePayLoad.getStatus()[0]);
        actual_list.add(responsePayLoad.getMeta().getTv().getMarket());
        actual_list.add(responsePayLoad.getMeta().getTv().getMarketId()[0].toString());
        actual_list.add(responsePayLoad.getMeta().getTv().getAtDestination());
        actual_list.add(responsePayLoad.getMeta().getTv().getCancelled());
        actual_list.add(responsePayLoad.getDocumentType());
        actual_list.add(responsePayLoad.getType());

        expected_list.add("draft");
        expected_list.add(ExpectedData.MARKET_ForEdit);
        expected_list.add(ExpectedData.MARKETID_ForEdit);
        expected_list.add("0");
        expected_list.add("0");
        expected_list.add("order");
        expected_list.add("tv_order");

        Assert.assertEquals(actual_list, expected_list,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}