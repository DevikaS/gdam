package com.publicApi.tests.testsBase;


/**
 * Created by Raja.Gone on 27/07/2016.
 */
public abstract class OrdersBaseTest extends BaseTests{

    private String orderId;
    private String itemId;
    private String clockNumber ;
    private String assetId;
    private String destinationId;
    public  String expectedHouseNumber;


    public String getDestinationId() {
        return destinationId;
    }

    public void setDestinationId(String destinationId) {
        this.destinationId = destinationId;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    public String getClockNumber() {
        return clockNumber;
    }

    public void setClockNumber(String clockNumber) {
        this.clockNumber = clockNumber;
    }

    public String getAssetId() {
        return assetId;
    }

    public void setAssetId(String assetId) {
        this.assetId = assetId;
    }

    public String getExpectedHouseNumber() {
        return expectedHouseNumber;
    }

    public void setExpectedHouseNumber(String expectedHouseNumber) {
        this.expectedHouseNumber = expectedHouseNumber;
    }
}
