package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.jsonPayLoads.GsonClasses.traffic.Traffic;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import com.publicApi.utilities.ResponseParser;
import org.testng.Assert;
import org.testng.annotations.Test;
import org.testng.internal.junit.ExactComparisonCriteria;

/*= * Created by Nirmala.Sankaran on 27/10/2015.
 */
public class Traffic_GetOrder extends OrdersBaseTest{

    @Test
    public void trafficOrderTest() {

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

        Traffic response=apiCall.traffic_GetOrder(getOrderId());

        // Verify fields in response
        actual_list.clear();
        actual_list.add(response.getId());
        actual_list.add(response.getOrderId());
        actual_list.add("onhold:".concat(response.getOnHold()));
        actual_list.add("Status:".concat(response.getStatus()));

        actual_list.add(response.getOrderDetails().getSubtitlesRequired());
        actual_list.add(response.getOrderDetails().getServiceLevel());
        actual_list.add(response.getOrderDetails().getMarketId());
        actual_list.add(response.getOrderDetails().getMarket());
        actual_list.add(response.getOrderDetails().getHasAdditionalServices());

        actual_list.add(response.getOrderItems()[0].getId());
        actual_list.add(response.getOrderItems()[0].getStatus());
        actual_list.add(response.getOrderItems()[0].getClockNumber());
        actual_list.add(response.getOrderItems()[0].getDuration());
        actual_list.add(response.getOrderItems()[0].getOrderId());
        actual_list.add(response.getOrderItems()[0].getOnHold());

        actual_list.add(response.getOrderItems()[0].getDestinations()[0].getId());
        actual_list.add(response.getOrderItems()[0].getDestinations()[0].getBroadcasterStatus());
        actual_list.add(response.getOrderItems()[0].getDestinations()[0].getOnHold());
        actual_list.add(response.getOrderItems()[0].getDestinations()[0].getOrderId());
        actual_list.add(response.getOrderItems()[0].getDestinations()[0].getOrderItemId());
        actual_list.add(response.getOrderItems()[0].getDestinations()[0].getServiceLevel().getName());
        actual_list.add(response.getOrderItems()[0].getDestinations()[0].getServiceLevel().getId()[0]);
        actual_list.add(response.getOrderItems()[0].getDestinations()[0].getDestinationId());
        actual_list.add(response.getOrderItems()[0].getDestinations()[0].getDestinationStatus());
        actual_list.add(response.getOrderItems()[0].getDestinations()[0].getDeliveryItemStatus());
        actual_list.add(response.getOrderItems()[0].getDestinations()[0].getName());
        actual_list.add(response.getOrderItems()[0].getDestinations()[0].getA5ViewStatus());

        actual_list.add(response.getOrderItems()[0].getOrderItemDetails().getDuration());
        actual_list.add(response.getOrderItems()[0].getOrderItemDetails().getAdditionalInformation());
        actual_list.add(response.getOrderItems()[0].getOrderItemDetails().getSubtitles());
        actual_list.add(response.getOrderItems()[0].getOrderItemDetails().getItemType());
        actual_list.add(response.getOrderItems()[0].getOrderItemDetails().getSubtitlesRequired());
        actual_list.add(response.getOrderItems()[0].getOrderItemDetails().getServiceLevel());


        actual_list.add(response.getOrderItems()[0].getMetadata().getFirstAirDate());
        actual_list.add(response.getOrderItems()[0].getMetadata().getDuration());
        actual_list.add(response.getOrderItems()[0].getMetadata().getMarket());
        actual_list.add(response.getOrderItems()[0].getMetadata().getAdvertiser());
        actual_list.add(response.getOrderItems()[0].getMetadata().getAdditionalInformation());
        actual_list.add(response.getOrderItems()[0].getMetadata().getClockNumber());
        actual_list.add(response.getOrderItems()[0].getMetadata().getItem_type());
        actual_list.add(response.getOrderItems()[0].getMetadata().getSubtitlesRequired());
        actual_list.add(response.getOrderItems()[0].getMetadata().getTitle());
        actual_list.add(response.getOrderItems()[0].getMetadata().getStatus());

        actual_list.add(response.getAssets()[0].getName());

        expected_list.clear();
        expected_list.add(getOrderId());
        expected_list.add(getOrderId());
        expected_list.add("onhold:false");
        expected_list.add("Status:In Progress");

        expected_list.add("false");
        expected_list.add(ExpectedData.DESTINATION_SERVICELEVEL_NAME);
        expected_list.add(ExpectedData.MARKETID);
        expected_list.add(ExpectedData.MARKET);
        expected_list.add("false");

        expected_list.add(getItemId());
        expected_list.add("New");
        expected_list.add(ExpectedData.CLOCKNUMBER);
        expected_list.add(ExpectedData.DURATION);
        expected_list.add(getOrderId());
        expected_list.add("false");

        expected_list.add(ExpectedData.DESTINATION_ID);
        expected_list.add("File Not Supplied");
        expected_list.add("false");
        expected_list.add(getOrderId());
        expected_list.add(getItemId());
        expected_list.add(ExpectedData.DESTINATION_SERVICELEVEL_NAME);
        expected_list.add(ExpectedData.DESTINATION_SERVICELEVEL_ID);
        expected_list.add(ExpectedData.DESTINATION_ID);
        expected_list.add("Online");
        expected_list.add("New");
        expected_list.add(ExpectedData.DESTINATION_NAME);
        expected_list.add("Order Placed");

        expected_list.add(ExpectedData.DURATION);
        expected_list.add(ExpectedData.ADDITIONALINFORMATION);
        expected_list.add(ExpectedData.SUBTITLESREQUIRED);
        expected_list.add("delivery");
        expected_list.add("false");
        expected_list.add(ExpectedData.DESTINATION_SERVICELEVEL_NAME);

        expected_list.add(ExpectedData.FIRSTAIRDATE);
        expected_list.add(ExpectedData.DURATION);
        expected_list.add(ExpectedData.MARKET);
        expected_list.add(ExpectedData.ADVERTISER);
        expected_list.add(ExpectedData.ADDITIONALINFORMATION);
        expected_list.add(ExpectedData.CLOCKNUMBER);
        expected_list.add("delivery");
        expected_list.add(ExpectedData.SUBTITLESREQUIRED);
        expected_list.add(ExpectedData.TITLE);
        expected_list.add("awaiting_media");
        expected_list.add(ExpectedData.TITLE);

        Assert.assertEquals(actual_list,expected_list,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");

    }
}