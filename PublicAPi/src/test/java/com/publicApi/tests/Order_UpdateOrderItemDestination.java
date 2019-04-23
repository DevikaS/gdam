package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.utilities.ResponseParser;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 18/02/2016.
 */
public class Order_UpdateOrderItemDestination extends OrdersBaseTest {

    @Test
    public void updateOrderItemDestinationTest(){
        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createOrder();
        setOrderId(responsePayLoad.getId());

        responsePayLoad = apiCall.createItem(getOrderId());
        setItemId(responsePayLoad.getId());

        apiCall.addDestinationItems(getOrderId(), getItemId());

        String responseStr = apiCall.updateOrderItemDestination(getOrderId(), getItemId());
        ResponseParser.addDestinationInfo(responseStr,actual_list);
        // Verify : Important Fields in response payload

        // Verify - Destination items
        /*DestinationItems[] destinations = responsePayLoad.getMeta().getDestinations().getItems();

        for (DestinationItems destinationDetails : destinations) {
            //actual_list.add(destinationDetails.getCountryCode()); // Due to FAB-508
            //actual_list.add(destinationDetails.getDestinationStatusId());
            actual_list.add(destinationDetails.getId()[0]);
            //actual_list.add(destinationDetails.getName());
          //  actual_list.add(destinationDetails.getServiceLevel().getName());
            actual_list.add(destinationDetails.getServiceLevel().getId()[0]);
            actual_list.add(destinationDetails.getStatus());
            actual_list.add(destinationDetails.getStatusId()[0]);
            actual_list.add(destinationDetails.getViewStatus()[0]);
        }*/

        //expected_list.add(ExpectedData.DESTINATION_COUNTRYCODE);
        //expected_list.add(ExpectedData.DESTINATION_STATUSID);
        expected_list.add(ExpectedData.DESTINATION_ID);
        //expected_list.add(ExpectedData.DESTINATION_NAME);
        //expected_list.add(ExpectedData.DESTINATION_SERVICELEVEL_NAME_EDIT);
        expected_list.add(ExpectedData.DESTINATION_SERVICELEVEL_ID_EDIT);
        expected_list.add("New");
        expected_list.add("9");
        expected_list.add("Order Placed");

        Assert.assertEquals(actual_list, expected_list,
                this.getClass().getSimpleName().toUpperCase() + ": Check destinations, ");

/*
        actual_list.add(responsePayLoad.getMeta().getDestinations().getCount().getAtDestination().toString());
        expected_list.add("0");

        actual_list.add(responsePayLoad.getMeta().getDestinations().getCount().getCancelled().toString());
        expected_list.add("0");

        actual_list.add(responsePayLoad.getMeta().getDestinations().getCount().getTotal().toString());
        expected_list.add("1");
*/

        ResponseParser.addAdditionalDestinationInfo(responseStr, actual_list);

        expected_list.add(ExpectedData.DURATION);
        expected_list.add(ExpectedData.ADDITIONALINFORMATION);
        expected_list.add(ExpectedData.TITLE);
        expected_list.add("delivery");
        expected_list.add("tv_order_item");
        expected_list.add(ExpectedData.SUBTITLESREQUIRED);
        expected_list.add("awaiting_media");

        Assert.assertEquals(actual_list, expected_list,
                this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");
    }
}