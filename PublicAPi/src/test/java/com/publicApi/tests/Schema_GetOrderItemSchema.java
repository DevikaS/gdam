package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;


/**
 * Created by Nirmala.Sankaran on 10/11/2015.
 */
public class Schema_GetOrderItemSchema extends OrdersBaseTest {

    @Test
    public void orderItemSchema_CreateTest(){
            apiCall = new HeadlessAPICalls();

            responsePayLoad = apiCall.createOrder();
            setOrderId(responsePayLoad.getId());

            Assert.assertTrue(apiCall.getOrderItemSchema(getOrderId(),"create"),
                    "Schema_GetOrderItemSchema - EndPoint failed for 'create' method");
    }

    @Test
    public void orderItemSchema_UpdateTest(){
            apiCall = new HeadlessAPICalls();

            responsePayLoad = apiCall.createOrder();
            setOrderId(responsePayLoad.getId());

            Assert.assertTrue(apiCall.getOrderItemSchema(getOrderId(),"update"),
                    "Schema_GetOrderItemSchema - EndPoint failed for 'update' method");
    }
}