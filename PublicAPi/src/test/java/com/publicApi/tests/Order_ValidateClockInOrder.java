package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedJsonSchema;
import com.publicApi.jsonPayLoads.RequestPayLoads;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import net.javacrumbs.jsonunit.JsonAssert;
import org.apache.http.entity.StringEntity;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.nio.charset.StandardCharsets;

import static net.javacrumbs.jsonunit.JsonAssert.when;
import static net.javacrumbs.jsonunit.core.Option.IGNORING_VALUES;

/**
 * Created by Nirmala.Sankaran on 17/02/2016.
 */
public class Order_ValidateClockInOrder extends OrdersBaseTest {

    RequestPayLoads payload;
    StringEntity entity;
    String actualResponse;

    @Test // Test for clock number not same/duplicate
    public void validateClockInOrder_Unique() {
        apiCall = new HeadlessAPICalls();

        responsePayLoad= apiCall.createOrder();
        setOrderId(responsePayLoad.getId());

        responsePayLoad = apiCall.createItem(getOrderId());
        responsePayLoad=apiCall.createItem(getOrderId());

        payload = new RequestPayLoads();
        entity = new StringEntity(payload.updateItemPayLoad(), StandardCharsets.UTF_8);
        apiCall.updateItem(getOrderId(),responsePayLoad.getId(),entity);

        actualResponse = apiCall.validateClocksInOrder(getOrderId());

        Assert.assertTrue(!actualResponse.contains("duplicate"),"VALIDATE CLOCK IN ORDER: End point - Failed");

        ExpectedJsonSchema expPayloadSchema= new ExpectedJsonSchema();
        JsonAssert.assertJsonEquals(expPayloadSchema.validateclocksinLibrary(), actualResponse, when(IGNORING_VALUES));
    }

    @Test      // Test for clock number are same/duplicate
    public void validateclockinOrder_NonUnique() {
        apiCall = new HeadlessAPICalls();

        responsePayLoad= apiCall.createOrder();
        setOrderId(responsePayLoad.getId());

        responsePayLoad = apiCall.createItem(getOrderId());

        setClockNumber(responsePayLoad.getMeta().getCommon().getClockNumber());
        responsePayLoad=apiCall.createItem(getOrderId());

        payload = new RequestPayLoads();
        entity = new StringEntity(payload.updateItemPayLoad_Clock(getClockNumber()),StandardCharsets.UTF_8);
        apiCall.updateItem(getOrderId(),responsePayLoad.getId(),entity);

        actualResponse = apiCall.validateClocksInOrder(getOrderId());
        Assert.assertTrue(actualResponse.contains("duplicate"),"VALIDATE CLOCK IN ORDER: End point - Failed");
    }
}