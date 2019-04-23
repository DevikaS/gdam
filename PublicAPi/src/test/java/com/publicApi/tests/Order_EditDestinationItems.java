package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.GsonClasses.DestinationItems;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.utilities.ResponseParser;
import org.testng.Assert;
import org.testng.annotations.Test;

public class Order_EditDestinationItems extends OrdersBaseTest {

    @Test
    public void editDestinationItemsTest(){

        // POST - Create Order - To get order ID
        apiCall = new HeadlessAPICalls();
        responsePayLoad = apiCall.createOrder();

        // Retrieve ORDER ID from response
        setOrderId(responsePayLoad.getId());

        // POST CALL - CREATE ORDER ITEM
        responsePayLoad = apiCall.createItem(getOrderId());
        setItemId(responsePayLoad.getId());

        // POST CALL - ADD DESTINATIONS
        apiCall.addDestinationItems(getOrderId(), getItemId());

        // PUT CALL - Edit destination service level
        String responseStr = apiCall.editDestinationItems(getOrderId(), getItemId());
        ResponseParser.updateDestinationAndServiceLevelIds(responseStr, actual_list);

        // Verify : Important Fields in response payload

        // Verify - Destination items
        /*DestinationItems[] destinations = responsePayLoad.getMeta().getDestinations().getItems();

        for (DestinationItems destinationDetails : destinations) {
            actual_list.add(destinationDetails.getId()[0]);
            actual_list.add(destinationDetails.getServiceLevel().getId()[0]);
        }*/

        expected_list.add(ExpectedData.DESTINATION_ID);
        expected_list.add(ExpectedData.DESTINATION_SERVICELEVEL_ID);


        Assert.assertEquals(actual_list, expected_list,
                this.getClass().getSimpleName().toUpperCase() + ": Check destinations, ");

/*      // Due to FAB-508
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