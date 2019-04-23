package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import com.publicApi.jsonPayLoads.ExpectedData;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 18/02/2016.
 */
public class OrderItemRights_UpdateUsageRights extends OrdersBaseTest {

    @Test
    public void orderItemRights_updateUsageRightsTest() {

        apiCall = new HeadlessAPICalls();

        responsePayLoad=apiCall.createOrder();
        setOrderId(responsePayLoad.getId());

        responsePayLoad=apiCall.createItem(getOrderId());
        setItemId(responsePayLoad.getId());

        apiCall.addDestinationItems(getOrderId(),getItemId());

        responsePayLoad=apiCall.processDraftorders(getOrderId(),getItemId(),"Library");

        responsePayLoad = apiCall.orderItemUpdateUsageRights(getOrderId(), getItemId());

        Assert.assertEquals(responsePayLoad.getLastStartDate(), ExpectedData.USAGERIGHTSSTARTDATE,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}