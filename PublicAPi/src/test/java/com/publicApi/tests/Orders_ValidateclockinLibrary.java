package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;


/**
 * Created by Nirmala.Sankaran on 17/02/2016.
 */
public class Orders_ValidateclockinLibrary  extends OrdersBaseTest {

    String actualResponse;

    @Test
    public void validateclockInLibrary_Unique() {
        apiCall = new HeadlessAPICalls();

        responsePayLoad= apiCall.createOrder();
        setOrderId(responsePayLoad.getId());

        responsePayLoad=apiCall.createItem(getOrderId());
        setClockNumber(responsePayLoad.getMeta().getCommon().getClockNumber());

        actualResponse=apiCall.validateClocksInLibrary(getClockNumber());
        Assert.assertTrue(!actualResponse.contains("duplicate"),"VALIDATE CLOCK IN LIBRARY: End point - Failed");
    }

    @Test
    public void validateclockInLibrary_NonUnique() {
        apiCall = new HeadlessAPICalls();

        responsePayLoad= apiCall.createOrder();
        setOrderId(responsePayLoad.getId());

        responsePayLoad=apiCall.createItem(getOrderId());
        setItemId(responsePayLoad.getId());
        setClockNumber(responsePayLoad.getMeta().getCommon().getClockNumber());

        apiCall.addDestinationItems(getOrderId(),getItemId());

        apiCall.processDraftorders(getOrderId(),getItemId(),"Library"); // Complete the order, so that QC'ed asset saved in library (Assuming 'Save in Library' set to TRUE for BU)

        waitFor(3000); // Wait for 3 secs so that asset is saved in library, else response would be empty
        actualResponse= apiCall.validateClocksInLibrary(getClockNumber());

        Assert.assertTrue(actualResponse.contains("duplicate"),"VALIDATE CLOCK IN LIBRARY: End point - Failed");

        Assert.assertTrue(true);
    }
}