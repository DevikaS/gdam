package com.publicApi.tests;


import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.jsonPayLoads.GsonClasses.traffic.Traffic;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import com.publicApi.utilities.ResponseParser;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 12/10/2015.
 */
public class Traffic_GetOrderItemDestination extends OrdersBaseTest {

    @Test
    public void traffic_GetOrderItemDestinationTest() {

        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createOrder();
        setOrderId(responsePayLoad.getId());

        responsePayLoad = apiCall.createItem(getOrderId());
        setItemId(responsePayLoad.getId());

        setClockNumber(responsePayLoad.getMeta().getCommon().getClockNumber());

        String responseStr=apiCall.addDestinationItems(getOrderId(), getItemId());
        setDestinationId(ResponseParser.getDestinationId(responseStr));

        //process the draft order
        responsePayLoad = apiCall.processDraftorders(getOrderId(), getItemId(),"Library");
        waitFor(60000); // Wait for order to replicate to A4


        Traffic response = apiCall.traffic_GetOrderItemDestination(getItemId(), getDestinationId());

        // Verify fields in response

        actual_list.clear();
        actual_list.add("Id:".concat(response.getId()));
        actual_list.add("onHold:".concat(response.getOnHold()));
        actual_list.add("orderId:".concat(response.getOrderId()));
        actual_list.add("orderItemId:".concat(response.getOrderItemId()));
        actual_list.add("ServiceLevelId:".concat(response.getServiceLevel().getId()[0]));
        actual_list.add("ServiceLevelName:".concat(response.getServiceLevel().getName()));
        actual_list.add("destinationId:".concat(response.getDestinationId()));
        actual_list.add("destinationStatus:".concat(response.getDestinationStatus()));
        actual_list.add("name:".concat(response.getName()));
        actual_list.add("a5ViewStatus:".concat(response.getA5ViewStatus()));


        expected_list.clear();
        expected_list.add("Id:".concat(ExpectedData.DESTINATION_ID));
        expected_list.add("onHold:false");
        expected_list.add("orderId:".concat(getOrderId()));
        expected_list.add("orderItemId:".concat(getItemId()));
        expected_list.add("ServiceLevelId:".concat(ExpectedData.DESTINATION_SERVICELEVEL_ID));
        expected_list.add("ServiceLevelName:".concat(ExpectedData.DESTINATION_SERVICELEVEL_NAME));
        expected_list.add("destinationId:".concat(ExpectedData.DESTINATION_ID));
        expected_list.add("destinationStatus:Online");
        expected_list.add("name:".concat(ExpectedData.DESTINATION_NAME));
        expected_list.add("a5ViewStatus:Order Placed");

        Assert.assertEquals(actual_list,expected_list,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}