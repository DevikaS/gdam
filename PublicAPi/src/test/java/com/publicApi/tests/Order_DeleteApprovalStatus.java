package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 18/02/2016.
 */
public class Order_DeleteApprovalStatus extends OrdersBaseTest {

    @Test
    public void order_DeleteApprovalStatusTest() throws InterruptedException {
        apiCall = new HeadlessAPICalls();

        responsePayLoad= apiCall.createOrder();
        setOrderId(responsePayLoad.getId());

        responsePayLoad=apiCall.createItem(getOrderId());
        setItemId(responsePayLoad.getId());

        apiCall.addDestinationItems(getOrderId(),getItemId());

        apiCall.processDraftorders(getOrderId(),getItemId(),"Library");

        Thread.sleep(9000);

        responsePayLoad = apiCall.setOrderApprovalStatus(getOrderId(), getItemId());

        Boolean isDeleted= apiCall.deleteApprovalStatus(getOrderId(), getItemId());

        Assert.assertTrue(isDeleted,this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}