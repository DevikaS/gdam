package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.GsonClasses.traffic.Traffic;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import com.publicApi.utilities.ResponseParser;
import org.testng.Assert;
import org.testng.annotations.BeforeTest;

import java.util.HashMap;

/**
 * Created by Nirmala.Sankaran on 15/10/2015.
 */
public class Traffic_CreateOrder extends OrdersBaseTest {

    static HashMap<String, String> TrafficTable = new HashMap<>();

    protected Traffic response;

    @BeforeTest
    public boolean TrafficOrder() throws InterruptedException{

        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createOrder();
        setOrderId(responsePayLoad.getId());

        TrafficTable.put("orderreferenceId", responsePayLoad.getOrderReference());
        TrafficTable.put("orderId", getOrderId());

        responsePayLoad = apiCall.createItem(TrafficTable.get("orderId"));

        setItemId(responsePayLoad.getId());
        TrafficTable.put("orderitemId", getItemId());

        setClockNumber(responsePayLoad.getMeta().getCommon().getClockNumber());
        TrafficTable.put("clock", getClockNumber());

        String responseStr=apiCall.addDestinationItems(TrafficTable.get("orderId"), TrafficTable.get("orderitemId"));
        setDestinationId(ResponseParser.getDestinationId(responseStr));


        //process the draft order
        responsePayLoad = apiCall.processDraftorders(TrafficTable.get("orderId"), TrafficTable.get("orderitemId"),"Library");
        String orderStatus = responsePayLoad.getStatus()[0].toString();

        Assert.assertTrue((orderStatus.contains("completing")) || (orderStatus.contains("inprogress")),
                "Order not completed, Check Draft process order");

        // Wait for order to replicate to A4 and available in TRAFFIC.
        // Current wait approach is very very bad, rather should pool A4 to check order replication is complete
        Thread.sleep(20000);

        return true;
    }
}