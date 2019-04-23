package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import com.publicApi.jsonPayLoads.ExpectedData;
import org.testng.Assert;
import org.testng.annotations.Test;

public class Order_GETDestinationItems extends OrdersBaseTest{

    @Test
    public void getDestinationItemsTest() {

        apiCall = new HeadlessAPICalls();

        responsePayLoad= apiCall.createOrder();
        setOrderId(responsePayLoad.getId());

        responsePayLoad = apiCall.createItem(getOrderId());
        setItemId(responsePayLoad.getId());

        apiCall.addDestinationItems(getOrderId(), getItemId());

        responsePayLoad=apiCall.getDestinationItems(getOrderId(), getItemId());

        // Verify values on response

        actual_list.clear();
        /*actual_list.add(responsePayLoad.getCount().getAtDestination());
        actual_list.add(responsePayLoad.getCount().getCancelled());
        actual_list.add(responsePayLoad.getCount().getTotal());
        actual_list.add(responsePayLoad.getItems()[0].getCountryCode());
        actual_list.add(responsePayLoad.getItems()[0].getDestinationStatusId());*/
        actual_list.add(responsePayLoad.getItems()[0].getId()[0].toString());
        //actual_list.add(responsePayLoad.getItems()[0].getName());
        actual_list.add(responsePayLoad.getItems()[0].getServiceLevel().getId()[0].toString());
    //    actual_list.add(responsePayLoad.getItems()[0].getServiceLevel().getName());
        actual_list.add(responsePayLoad.getItems()[0].getStatus());
        actual_list.add(responsePayLoad.getItems()[0].getStatusId()[0].toString());
        actual_list.add(responsePayLoad.getItems()[0].getViewStatus()[0].toString());

        expected_list.clear();
        /*expected_list.add("0"); // atDestination
        expected_list.add("0"); // cancelled
        expected_list.add("1"); // total
        expected_list.add(ExpectedData.DESTINATION_COUNTRYCODE);
        expected_list.add(ExpectedData.DESTINATION_STATUSID);*/
        expected_list.add(ExpectedData.DESTINATION_ID);
        /*expected_list.add(ExpectedData.DESTINATION_NAME);*/
        expected_list.add(ExpectedData.DESTINATION_SERVICELEVEL_ID);
        /*expected_list.add(ExpectedData.DESTINATION_SERVICELEVEL_NAME);*/
        expected_list.add("New");
        expected_list.add("9");
        expected_list.add("Order Placed");

        Assert.assertEquals(actual_list, expected_list,
                this.getClass().getSimpleName().toUpperCase() + ": Check destinations, ");
    }
}