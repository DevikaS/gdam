package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;


public class OrderItems_GenerateSpotgateCode extends OrdersBaseTest {

    @Test
    public void generateSpotgateCodeTest(){
        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createOrder(ExpectedData.MARKET_FINLAND, ExpectedData.MARKET_COUNTRY_FINLAND, ExpectedData.MARKET_ID_FINLAND, ExpectedData.BEAM_ADMIN_USER);
        setOrderId(responsePayLoad.getId());

        responsePayLoad = apiCall.createItem(getOrderId(), ExpectedData.MARKET_FINLAND, ExpectedData.MARKET_COUNTRY_FINLAND, ExpectedData.MARKET_ID_FINLAND, "30", ExpectedData.BEAM_ADMIN_USER);
        setItemId(responsePayLoad.getId());

        // Request valid as createItem has been provided with valid duration
        String response = apiCall.generateSpotId(getOrderId(),getItemId(), true, ExpectedData.BEAM_ADMIN_USER);

        Assert.assertTrue(response.contains("spotId"),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }

    @Test
    public void generateSpotgateCodeTest_DurationNotSet(){
        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createOrder(ExpectedData.MARKET_FINLAND, ExpectedData.MARKET_COUNTRY_FINLAND, ExpectedData.MARKET_ID_FINLAND, ExpectedData.BEAM_ADMIN_USER);
        setOrderId(responsePayLoad.getId());

        responsePayLoad = apiCall.createItem(getOrderId(), ExpectedData.MARKET_FINLAND, ExpectedData.MARKET_COUNTRY_FINLAND, ExpectedData.MARKET_ID_FINLAND, "", ExpectedData.BEAM_ADMIN_USER);
        setItemId(responsePayLoad.getId());

        // Request invalid as createItem has not been provided with duration
        String response = apiCall.generateSpotId(getOrderId(),getItemId(), false, ExpectedData.BEAM_ADMIN_USER);

        Assert.assertTrue(response.contains("At least one mandatory field is missing. Please make sure Advertiser, Product, Title, and Duration are populated"),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}
