package com.publicApi.tests;

import com.google.gson.Gson;
import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import org.apache.commons.lang3.StringUtils;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Ramababu.Bendalam on 10/12/2016.
 */
public class Orders_ProcessADraftOrder extends OrdersBaseTest {


    public Orders_ProcessADraftOrder(){
        apiCall = new HeadlessAPICalls();
    }

    @Test
    public void processADraftOrder_Po_And_JobNumberTest(){
        orderPlace(apiCall);

        responsePayLoad= apiCall.processDraftorders(getOrderId(),getItemId(),"Pojobnumber");

        Assert.assertEquals(responsePayLoad.getMeta().getCommon().getPoNumber(), ExpectedData.poNumber,
                this.getClass().getSimpleName().toUpperCase() + ": End Point Failed poNumber not set, ");
        Assert.assertEquals(responsePayLoad.getMeta().getCommon().getJobNumber(), ExpectedData.jobNumber,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed jobNumber not set, ");
    }

    @Test
    public void processADraftOrder_NoMeta(){
        orderPlace(apiCall);

        responsePayLoad= apiCall.processDraftorders(getOrderId(),getItemId(),"None");

        Assert.assertFalse(responsePayLoad.getMeta().getCommon().getNotifyAboutDelivery(),this.getClass().getSimpleName().
                toUpperCase()+": End Point Failed due to, ");
        Assert.assertFalse(responsePayLoad.getMeta().getCommon().getHandleStandardsConversions(), this.getClass().getSimpleName().
                toUpperCase() + ": End Point Failed due to, ");
        Assert.assertFalse(responsePayLoad.getMeta().getCommon().getNotifyAboutQc(), this.getClass().getSimpleName().
                toUpperCase() + ": End Point Failed due to, ");
        StringUtils.isEmpty(responsePayLoad.getMeta().getCommon().getPoNumber());
        StringUtils.isEmpty(responsePayLoad.getMeta().getCommon().getJobNumber());
    }

    @Test
    public void processADraftOrder_NotificationsTest(){
        orderPlace(apiCall);

        responsePayLoad= apiCall.processDraftorders(getOrderId(),getItemId(),"Notifications");

        Assert.assertEquals(responsePayLoad.getMeta().getCommon().getNotificationEmails().getCompleted()[0],ExpectedData.email1,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
        Assert.assertEquals(responsePayLoad.getMeta().getCommon().getNotificationEmails().getCompleted()[1],ExpectedData.email2,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
        Assert.assertEquals(responsePayLoad.getMeta().getCommon().getNotificationEmails().getIngested()[0], ExpectedData.email1,
                this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");
        Assert.assertEquals(responsePayLoad.getMeta().getCommon().getNotificationEmails().getIngested()[1], ExpectedData.email2,
                this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");
        Assert.assertEquals(responsePayLoad.getMeta().getCommon().getNotificationEmails().getConfirmed()[0], ExpectedData.email1,
                this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");
        Assert.assertEquals(responsePayLoad.getMeta().getCommon().getNotificationEmails().getConfirmed()[1], ExpectedData.email2,
                this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");

    }

    @Test
    public void processADraftOrder_AllMetaTest(){
        orderPlace(apiCall);

        responsePayLoad= apiCall.processDraftorders(getOrderId(),getItemId(),"All");

        Assert.assertEquals(responsePayLoad.getMeta().getCommon().getPoNumber(), ExpectedData.poNumber,
                this.getClass().getSimpleName().toUpperCase() + ": End Point Failed poNumber not set, ");
        Assert.assertEquals(responsePayLoad.getMeta().getCommon().getJobNumber(), ExpectedData.jobNumber,
                this.getClass().getSimpleName().toUpperCase() + ": End Point Failed jobNumber not set, ");
        Assert.assertTrue(responsePayLoad.getMeta().getCommon().getNotifyAboutDelivery(), this.getClass().getSimpleName().
                toUpperCase() + ": End Point Failed due to, ");
        Assert.assertFalse(responsePayLoad.getMeta().getCommon().getHandleStandardsConversions(), this.getClass().getSimpleName().
                toUpperCase() + ": End Point Failed due to, ");
        Assert.assertTrue(responsePayLoad.getMeta().getCommon().getNotifyAboutQc(), this.getClass().getSimpleName().
                toUpperCase() + ": End Point Failed due to, ");
        Assert.assertEquals(responsePayLoad.getMeta().getCommon().getNotificationEmails().getCompleted()[0], ExpectedData.email1,
                this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");
        Assert.assertEquals(responsePayLoad.getMeta().getCommon().getNotificationEmails().getCompleted()[1], ExpectedData.email2,
                this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");
        Assert.assertEquals(responsePayLoad.getMeta().getCommon().getNotificationEmails().getIngested()[0], ExpectedData.email1,
                this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");
        Assert.assertEquals(responsePayLoad.getMeta().getCommon().getNotificationEmails().getIngested()[1], ExpectedData.email2,
                this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");
        Assert.assertEquals(responsePayLoad.getMeta().getCommon().getNotificationEmails().getConfirmed()[0], ExpectedData.email1,
                this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");
        Assert.assertEquals(responsePayLoad.getMeta().getCommon().getNotificationEmails().getConfirmed()[1], ExpectedData.email2,
                this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");


    }


    private void orderPlace(HeadlessAPICalls apiCalls)
    {
        responsePayLoad=apiCall.createOrder();
        setOrderId(responsePayLoad.getId());

        responsePayLoad=apiCall.createItem(getOrderId());
        setItemId(responsePayLoad.getId());

        apiCall.addDestinationItems(getOrderId(), getItemId());
    }
}
