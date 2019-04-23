package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.jsonPayLoads.GsonClasses.BaseOfBase;
import com.publicApi.jsonPayLoads.GsonClasses.traffic.OrderItems;
import com.publicApi.jsonPayLoads.GsonClasses.traffic.Traffic;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import com.publicApi.utilities.ResponseParser;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

/**
 * Created by Nirmala.Sankaran on 27/10/2015.
 */
public class Traffic_ListOrderItems extends OrdersBaseTest {


    @Test
    public void Traffic_ListOrderItemsTest() {
        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createOrder();
        setOrderId(responsePayLoad.getId());

        responsePayLoad = apiCall.createItem(getOrderId());
        setItemId(responsePayLoad.getId());

        String responseStr= apiCall.addDestinationItems(getOrderId(), getItemId());
        setDestinationId(ResponseParser.getDestinationId(responseStr));

        //process the draft order
        responsePayLoad = apiCall.processDraftorders(getOrderId(), getItemId(),"Library");
        waitFor(60000); // Wait for order to replicate to A4

        String response = apiCall.traffic_ListOrderItems();

        Assert.assertTrue(response.contains(getOrderId()),
                this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");
    }

    @Test
    public void Traffic_ListOrderItemsTest_CreatedDateSearch() throws UnsupportedEncodingException {
        apiCall = new HeadlessAPICalls();
        Traffic traffic = new Traffic();

        responsePayLoad = apiCall.createOrder();
        setOrderId(responsePayLoad.getId());

        responsePayLoad = apiCall.createItem(getOrderId());
        setItemId(responsePayLoad.getId());

        String responseStr= apiCall.addDestinationItems(getOrderId(), getItemId());
        setDestinationId(ResponseParser.getDestinationId(responseStr));

        //process the draft order
        responsePayLoad = apiCall.processDraftorders(getOrderId(), getItemId(),"Library");
        waitFor(60000); // Wait for order to replicate to A4

        OrderItems[] orderItems = apiCall.trafficGetOrderItem(getItemId());

        String modifiedTimeStampEncoded = null;
        String createdTimeStampEncoded = null;
        String modifiedTimeStamp = orderItems[0].getDestinations()[0].getModifiedTimestamp();
        String createdTimeStamp = orderItems[0].getDestinations()[0].getCreatedTimestamp();

        if (orderItems != null && orderItems.length > 0) {
            if (orderItems[0].getDestinations() != null) {
                modifiedTimeStampEncoded = URLEncoder.encode(modifiedTimeStamp);
                createdTimeStampEncoded = URLEncoder.encode(createdTimeStamp);

            }

            String[] timestamp = {modifiedTimeStampEncoded, modifiedTimeStampEncoded, createdTimeStampEncoded, createdTimeStampEncoded};
            OrderItems[] response = apiCall.traffic_ListOrderItems_DateSearch(timestamp);

            Assert.assertNotNull(response);
            Assert.assertEquals(response[0].getDestinations()[0].getModifiedTimestamp(), modifiedTimeStamp);
            Assert.assertEquals(response[0].getDestinations()[0].getCreatedTimestamp(), createdTimeStamp);

        }
    }

    @Test
    public void Traffic_ListOrderItemsTest_ModifiedDateSearch() throws UnsupportedEncodingException {
        apiCall = new HeadlessAPICalls();
        Traffic traffic = new Traffic();

        responsePayLoad = apiCall.createOrder();
        setOrderId(responsePayLoad.getId());

        responsePayLoad = apiCall.createItem(getOrderId());
        setItemId(responsePayLoad.getId());

        String responseStr=apiCall.addDestinationItems(getOrderId(), getItemId());
        setDestinationId(ResponseParser.getDestinationId(responseStr));

        //process the draft order
        responsePayLoad = apiCall.processDraftorders(getOrderId(), getItemId(),"Library");
        waitFor(80000); // Wait for order to replicate to A4*//**//**//**//*

        String expectedHN = ExpectedData.generate_UniqueHN();
        apiCall.traffic_SetDestinationHouseNumber(getItemId(),getDestinationId(), expectedHN);
        waitFor(20000); // Wait for to get the houseNumber to replicate in orderItem response *//**//**//**//**//**//**//**//*

        traffic = apiCall.traffic_GetOrderItemHN(getItemId());

        String modifiedTimeStamp = traffic.getDestinations()[0].getModifiedTimestamp();
        String createdTimeStamp = traffic.getDestinations()[0].getCreatedTimestamp();
        String modifiedTimeStampEncoded = null;
        String createdTimeStampEncoded = null;
        if (traffic.getId() != null) {
            if (traffic.getDestinations() != null) {
                modifiedTimeStampEncoded = URLEncoder.encode(modifiedTimeStamp);
                createdTimeStampEncoded = URLEncoder.encode(createdTimeStamp);

            }

            String[] timestamp = {modifiedTimeStampEncoded, modifiedTimeStampEncoded, createdTimeStampEncoded, createdTimeStampEncoded};
            OrderItems[] response = apiCall.traffic_ListOrderItems_DateSearch(timestamp);

            Assert.assertNotNull(response);
            Assert.assertEquals(response[0].getDestinations()[0].getModifiedTimestamp(),modifiedTimeStamp);
            Assert.assertEquals(response[0].getDestinations()[0].getCreatedTimestamp(),createdTimeStamp);


        }
    }


    @Test
    public void Traffic_ListOrderItemsTest_PaginationWithSize() {
        apiCall = new HeadlessAPICalls();

        String firstOrder = completeOrder(apiCall);
        String secondOrder = completeOrder(apiCall);
        String thirdOrder = completeOrder(apiCall);

        waitFor(80000); // Wait for orders to be available in Traffic

        OrderItems[] response = apiCall.traffic_ListOrderItems("1","3");

        actual_list.add(response[0].getId());
        actual_list.add(response[1].getId());
        actual_list.add(response[2].getId());

        expected_list.add(thirdOrder);
        expected_list.add(secondOrder);
        expected_list.add(firstOrder);

        Assert.assertEquals(actual_list,expected_list);
    }



    @Test
    public void Traffic_ListOrderItemsTest_DefaultPagination() {
        apiCall = new HeadlessAPICalls();

        OrderItems[] response = apiCall.traffic_ListOrderItems("1"); // Get all orders from first page. Check that count doesn't exceed 20 orders per page

        int i;
        int counter=0;
        for(OrderItems ordersCount:response)
        {
            i=ordersCount.getId().length();
            if(i>0)
                counter++;
        }
        if(counter>20)
            Assert.fail("Check default Page size of Order items. Should return 20 order items per page, but got more orders: "+counter);
    }


    private String completeOrder(HeadlessAPICalls apiCall){
        responsePayLoad = apiCall.createOrder();
        setOrderId(responsePayLoad.getId());

        responsePayLoad = apiCall.createItem(getOrderId());
        setItemId(responsePayLoad.getId());

        String responseStr = apiCall.addDestinationItems(getOrderId(), getItemId());
        setDestinationId(ResponseParser.getDestinationId(responseStr));

        //process the draft order
        apiCall.processDraftorders(getOrderId(), getItemId(),"Library");

        return getItemId(); // Return order Item ID
    }
}
