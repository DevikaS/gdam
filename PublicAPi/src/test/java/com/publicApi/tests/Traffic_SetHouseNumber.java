package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.jsonPayLoads.GsonClasses.traffic.Traffic;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import com.publicApi.utilities.ResponseParser;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Saritha.Dhanala on 20/10/2016.
 */
public class Traffic_SetHouseNumber extends OrdersBaseTest {

    @Test()
    public void Traffic_SetDestinationHouseNumber() {
        apiCall = new HeadlessAPICalls();
        Traffic traffic = new Traffic();

        responsePayLoad = apiCall.createOrder();
        setOrderId(responsePayLoad.getId());

        responsePayLoad = apiCall.createItem(getOrderId());
        setItemId(responsePayLoad.getId());

        String response=apiCall.addDestinationItems(getOrderId(), getItemId());
        setDestinationId(ResponseParser.getDestinationId(response));

        //process the draft order
        responsePayLoad = apiCall.processDraftorders(getOrderId(), getItemId(),"Library");
        waitFor(60000); // Wait for order to replicate to A4*/

        String expectedHN = ExpectedData.generate_UniqueHN();
        setExpectedHouseNumber(expectedHN);
        apiCall.traffic_SetDestinationHouseNumber(getItemId(),getDestinationId(), getExpectedHouseNumber());
        waitFor(10000); // Wait for to get the houseNumber to replicate in orderItem response */

        traffic = apiCall.traffic_GetOrderItemHN(getItemId());

        String actualHN = traffic.getDestinations()[0].getHouseNumber();
        Assert.assertEquals(actualHN, expectedHN,"The House Numbers does not match");





       }
}
