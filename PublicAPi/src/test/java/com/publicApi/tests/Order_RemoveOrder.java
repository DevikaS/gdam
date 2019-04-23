package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;

public class Order_RemoveOrder extends OrdersBaseTest{

    @Test
    public void removeOrderTest(){
        apiCall = new HeadlessAPICalls();

        responsePayLoad= apiCall.createOrder();
        setOrderId(responsePayLoad.getId());

        Assert.assertTrue(apiCall.removeOrder(getOrderId()),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed");
    }
}
