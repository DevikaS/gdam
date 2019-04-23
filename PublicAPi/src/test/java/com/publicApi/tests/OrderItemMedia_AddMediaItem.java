package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import com.publicApi.utilities.ResponseParser;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.io.IOException;

/**
 * Created by Nirmala.Sankaran on 04/03/2016.
 */
public class OrderItemMedia_AddMediaItem extends OrdersBaseTest {

    @Test
    public void addMediaItemTest() throws IOException {
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
        waitFor(30000); // Wait for order to completely save to Library so that 'qcAssetId' is generated

        String assetId=apiCall.getQcAssetIdForConfirmedOrders(getOrderId());

        // Create Order
        responsePayLoad = apiCall.createOrder();
        setOrderId(responsePayLoad.getId());

        // CREATE ORDER ITEM
        responsePayLoad = apiCall.createItem(getOrderId());
        setItemId(responsePayLoad.getId());

        apiCall.addDestinationItems(getOrderId(), getItemId());

        //Add Asset to Order Item
        responsePayLoad = apiCall.addMediaItem(getOrderId(), getItemId(), assetId);

        Assert.assertEquals(assetId,responsePayLoad.getAssetId(),
                this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");
    }
}