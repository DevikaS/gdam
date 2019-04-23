package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.GsonClasses.traffic.Traffic;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import com.publicApi.utilities.ResponseParser;
import org.testng.Assert;
import org.testng.annotations.*;

/**
 * Created by Nirmala.Sankaran on 13/10/2015.
 */
public class Traffic_GetOrderItem extends OrdersBaseTest{

    @Test
    public void GET_TrafficOrderItem() {
            apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createOrder();
        setOrderId(responsePayLoad.getId());

        responsePayLoad = apiCall.createItem(getOrderId());
        setItemId(responsePayLoad.getId());

        setClockNumber(responsePayLoad.getMeta().getCommon().getClockNumber());

        String responseStr = apiCall.addDestinationItems(getOrderId(), getItemId());
        setDestinationId(ResponseParser.getDestinationId(responseStr));

        //process the draft order
        responsePayLoad = apiCall.processDraftorders(getOrderId(), getItemId(),"Library");
        waitFor(60000); // Wait for order to replicate to A4

        Traffic response = apiCall.traffic_GetOrderItem(getItemId());
    }

}
