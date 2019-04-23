package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import com.publicApi.jsonPayLoads.ExpectedData;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Swathi.Battula on 12/06/2016.
 */
public class Order_GetDeliveryListForSpecifiedClock extends OrdersBaseTest {

    @Test
    public void getDeliveryListForSpecifiedClockTest() {

        apiCall = new HeadlessAPICalls();

        responsePayLoad=apiCall.createOrder();
        setOrderId(responsePayLoad.getId());

        responsePayLoad=apiCall.createItem(getOrderId());
        setItemId(responsePayLoad.getId());
        setClockNumber(responsePayLoad.getMeta().getCommon().getClockNumber());

        apiCall.addDestinationItems(getOrderId(),getItemId());

        apiCall.processDraftorders(getOrderId(),getItemId(),"Library");

        waitFor(20000);

        responsePayLoad = apiCall.getDeliveryListForSpecifiedClock(getClockNumber());

        //Verify Traffic Order DeliveryListForSpecifiedClock
        actual_list.add(responsePayLoad.getDestinationName());
        actual_list.add(responsePayLoad.getDestinationId());
        actual_list.add(responsePayLoad.getA4Status());
        actual_list.add(responsePayLoad.getViewStatus());
        actual_list.add(responsePayLoad.getOrderAccessible());
        actual_list.add(responsePayLoad.getMarketId());

        expected_list.add(ExpectedData.DESTINATION_NAME);
        expected_list.add(ExpectedData.DESTINATION_ID);
        expected_list.add("New");
        expected_list.add("Order Placed");
        expected_list.add("true");
        expected_list.add(ExpectedData.MARKETID);

        Assert.assertEquals(actual_list, expected_list,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}
