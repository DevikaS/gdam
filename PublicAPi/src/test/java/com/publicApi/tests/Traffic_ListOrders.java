package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import com.publicApi.utilities.ResponseParser;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 27/10/2015.
 */
public class Traffic_ListOrders extends OrdersBaseTest {

    @Test
    public void trafficListOrdersTest() {
        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createOrder();
        setOrderId(responsePayLoad.getId());

        responsePayLoad = apiCall.createItem(getOrderId());
        setItemId(responsePayLoad.getId());

        setClockNumber(responsePayLoad.getMeta().getCommon().getClockNumber());

        String response=apiCall.addDestinationItems(getOrderId(), getItemId());
        setDestinationId(ResponseParser.getDestinationId(response));

        //process the draft order
        responsePayLoad = apiCall.processDraftorders(getOrderId(), getItemId(),"Library");
        waitFor(60000); // Wait for order to replicate to A4

        response = apiCall.traffic_ListOrders();

        Assert.assertTrue(response.contains(getOrderId()),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}