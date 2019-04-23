package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 10/11/2015.
 */
public class Schema_GetOrderItemDestinationSchema extends OrdersBaseTest {

    @Test
    public void itemDestinationSchema_CreateTest() {
            apiCall = new HeadlessAPICalls();

            responsePayLoad = apiCall.createOrder();
            setOrderId(responsePayLoad.getId());

            responsePayLoad = apiCall.createItem(getOrderId());
            setItemId(responsePayLoad.getId());

            apiCall.addDestinationItems(getOrderId(), getItemId());

            Assert.assertTrue(apiCall.get_OrderItemDestinationSchema(getOrderId(), "create"),
                    "Schema_GetOrderItemDestinationSchema - Endpoint failed, check 'create' method");
    }

    @Test
    public void itemDestinationSchema_UpdateTest() {
            apiCall = new HeadlessAPICalls();

            responsePayLoad = apiCall.createOrder();
            setOrderId(responsePayLoad.getId());

            responsePayLoad = apiCall.createItem(getOrderId());
            setItemId(responsePayLoad.getId());

            apiCall.addDestinationItems(getOrderId(), getItemId());

            Assert.assertTrue(apiCall.get_OrderItemDestinationSchema(getOrderId(), "update"),
                    "Schema_GetOrderItemDestinationSchema - Endpoint failed, check 'update' method");
    }
}
