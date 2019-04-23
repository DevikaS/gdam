package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.jsonPayLoads.GsonClasses.traffic.Traffic;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import com.publicApi.utilities.ResponseParser;
import org.testng.annotations.Test;
import org.testng.Assert;


/**
 * Note: Below tests are for two stage approvals. Approver is same for both stages.
 */
public class Traffic_SetApprovalsForOrderItems extends OrdersBaseTest {

    private boolean result =false;

    public Traffic_SetApprovalsForOrderItems() {
        apiCall = new HeadlessAPICalls();
    }

    @Test
    public void traffic_SetApprovalsForOrderItemsTest_Proxy_Approve() {

        result= false;
        createOrder_ThenIngestIt();

        result = apiCall.traffic_SetApprovalsForOrderItems("proxy", "approve",getItemId(),getDestinationId(),"Approve the Proxy");

        Assert.assertTrue(result, this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");

        waitFor(6000);
        //Changed method to traffic_GetOrderItemWithProxy as per the regression on 3July2017
        Traffic response = apiCall.traffic_GetOrderItemWithProxy(getItemId());

        Assert.assertEquals(response.getDestinations()[0].getBroadcasterStatus(), "Master Ready For Approval",
                this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");
   }
    @Test
    public void traffic_SetApprovalsForOrderItemsTest_Proxy_Reject() {

        result= false;
        createOrder_ThenIngestIt();

        result = apiCall.traffic_SetApprovalsForOrderItems("proxy", "reject",getItemId(),getDestinationId(),"Reject the Proxy");

        Assert.assertTrue(result, this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");

        waitFor(6000);
        //Changed method to traffic_GetOrderItemWithProxy as per the regression on 3July2017
        Traffic response = apiCall.traffic_GetOrderItemWithProxy(getItemId());

        Assert.assertEquals(response.getDestinations()[0].getBroadcasterStatus(), "Proxy Rejected",
                this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");
    }

    @Test
    public void traffic_SetApprovalsForOrderItemsTest_Master_Release() {

        result= false;
        createOrder_ThenIngestIt();

        result = apiCall.traffic_SetApprovalsForOrderItems("proxy", "approve",getItemId(),getDestinationId(),"Approve the Proxy");

        waitFor(6000);
        result = apiCall.traffic_SetApprovalsForOrderItems("master", "release",getItemId(),getDestinationId(),"Release the Master");

        Assert.assertTrue(result, this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");

        waitFor(4000); //This delay is for broadcasterStatus to update to Master Released

        Traffic response = apiCall.traffic_GetOrderItem(getItemId());

        Assert.assertEquals(response.getDestinations()[0].getBroadcasterStatus(), "Master Released",
                this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");

    }

    //API-626 All the fields of the details in the response appear in this test
    @Test
    public void traffic_SetApprovalsForOrderItemsTest_Delivered() {

        result= false;
        createOrder_ThenIngestIt();

        waitFor(6000);
        result = apiCall.traffic_SetApprovalsForOrderItems("proxy", "approve",getItemId(),getDestinationId(),"Approve the Proxy");

        waitFor(6000);
        result = apiCall.traffic_SetApprovalsForOrderItems("master", "release",getItemId(),getDestinationId(),"Release the Master");

        Assert.assertTrue(result, this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");

        waitFor(90000); //This delay is for broadcasterStatus updated to delivered and deliveryItemStatus: Transfer Complete

        Traffic response = apiCall.traffic_GetOrderItemWithOrderDelivered(getItemId());

        Assert.assertEquals(response.getDestinations()[0].getBroadcasterStatus(), "Delivered",
                this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");

    }

    private Traffic createOrder_ThenIngestIt(){
        responsePayLoad=null;
        responsePayLoad = apiCall.createOrder();
        setOrderId(responsePayLoad.getId());

        responsePayLoad = apiCall.createItem(getOrderId());
        setItemId(responsePayLoad.getId());

        String responseStr=apiCall.addDestinationItems(getOrderId(), getItemId());
        setDestinationId(ResponseParser.getDestinationId(responseStr));

        //process the draft order
        responsePayLoad = apiCall.processDraftorders(getOrderId(), getItemId(),"Library");

        waitFor(60000); // Wait for order to available in Traffic

        Traffic response = null;
        response=apiCall.traffic_GetOrderItem(getItemId());
        String qcAssetId = response.getDestinations()[0].getQcAssetId();

        // Ingest Asset
        AssetsIngestGDN_RegisterAFileInGDN ingest = new AssetsIngestGDN_RegisterAFileInGDN();
        Traffic trafficRespone = ingest.ingestAsset(qcAssetId,ExpectedData.BU_STORAGE_ID,ExpectedData.PRIMARY_BU_ID);
        waitFor(60000); // Wait for ingest process to complete, else will fail with 428 status code
        return trafficRespone;
    }
}