package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Tests https://a5.adstream.com/api/v2/orders/assets endpoint
 */
public class Order_SearchAssets extends OrdersBaseTest{

    @Test
    public void searchOrderAssetsTest(){
        apiCall = new HeadlessAPICalls();

        responsePayLoad=apiCall.createOrder();
        setOrderId(responsePayLoad.getId());

        responsePayLoad=apiCall.createItem(getOrderId());
        setItemId(responsePayLoad.getId());

        apiCall.addDestinationItems(getOrderId(), getItemId());

        responsePayLoad= apiCall.processDraftorders(getOrderId(),getItemId(),"None");

        waitFor(10000);
        //the asset search endpoint should not return the asset as its not saved in library
        String query = "meta.video.clockNumber:\""+ExpectedData.CLOCKNUMBER+"\"";
        Assert.assertFalse(apiCall.searchAssets(query),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");

        //the search order assets endpoint should return the details even though its not saved in library
        query = "{\"terms\":{\"_cm.video.clockNumber\":[\""+ ExpectedData.CLOCKNUMBER+"\"]}}";

        Assert.assertTrue(apiCall.searchOrderAssets(query),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");

    }
}
