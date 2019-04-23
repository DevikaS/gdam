package com.publicApi.jsonPayLoads.GsonClasses;

/**
 * Created by Raja.Gone on 08/07/2016.
 */
public class Destinations {
    private DestinationsCount count;

    private DestinationItems[] items;

    public DestinationsCount getCount ()
    {
        return count;
    }

    public void setCount (DestinationsCount count)
    {
        this.count = count;
    }

    public DestinationItems[] getItems ()
    {
        return items;
    }

    public void setItems (DestinationItems[] items)
    {
        this.items = items;
    }

    private String broadcasterStatus;

    private String a4Id;

    private String orderItemId;

    private String qcAssetId;

    private String houseNumber;

    private String destinationStatus;

    private ServiceLevel serviceLevel;

    public String getModifiedTimestamp() {
        return modifiedTimestamp;
    }

    public void setModifiedTimestamp(String modifiedTimestamp) {
        this.modifiedTimestamp = modifiedTimestamp;
    }

    public String getCreatedTimestamp() {
        return createdTimestamp;
    }

    public void setCreatedTimestamp(String createdTimestamp) {
        this.createdTimestamp = createdTimestamp;
    }

    private String id;

    private String modifiedTimestamp;

    private String createdTimestamp;

    private String a5ViewStatus;

    private String destinationId;

    private String name;

    private String onHold;

    private String orderId;

    private String deliveryItemStatus;

    public String getBroadcasterStatus ()
    {
        return broadcasterStatus;
    }

    public void setBroadcasterStatus (String broadcasterStatus)
    {
        this.broadcasterStatus = broadcasterStatus;
    }

    public String getA4Id ()
    {
        return a4Id;
    }

    public void setA4Id (String a4Id)
    {
        this.a4Id = a4Id;
    }

    public String getOrderItemId ()
    {
        return orderItemId;
    }

    public void setOrderItemId (String orderItemId)
    {
        this.orderItemId = orderItemId;
    }

    public String getQcAssetId ()
    {
        return qcAssetId;
    }

    public void setQcAssetId (String qcAssetId)
    {
        this.qcAssetId = qcAssetId;
    }

    public String getDestinationStatus ()
    {
        return destinationStatus;
    }

    public void setDestinationStatus (String destinationStatus)
    {
        this.destinationStatus = destinationStatus;
    }

    public String getHouseNumber() {
        return houseNumber;
    }

    public void setHouseNumber(String houseNumber) {
        this.houseNumber = houseNumber;
    }

    public ServiceLevel getServiceLevel ()
    {
        return serviceLevel;
    }

    public void setServiceLevel (ServiceLevel serviceLevel)
    {
        this.serviceLevel = serviceLevel;
    }

    public String getId ()
    {
        return id;
    }

    public void setId (String id)
    {
        this.id = id;
    }

    public String getA5ViewStatus ()
    {
        return a5ViewStatus;
    }

    public void setA5ViewStatus (String a5ViewStatus)
    {
        this.a5ViewStatus = a5ViewStatus;
    }

    public String getDestinationId ()
    {
        return destinationId;
    }

    public void setDestinationId (String destinationId)
    {
        this.destinationId = destinationId;
    }

    public String getName ()
    {
        return name;
    }

    public void setName (String name)
    {
        this.name = name;
    }

    public String getOnHold ()
    {
        return onHold;
    }

    public void setOnHold (String onHold)
    {
        this.onHold = onHold;
    }

    public String getOrderId ()
    {
        return orderId;
    }

    public void setOrderId (String orderId)
    {
        this.orderId = orderId;
    }

    public String getDeliveryItemStatus ()
    {
        return deliveryItemStatus;
    }

    public void setDeliveryItemStatus (String deliveryItemStatus)
    {
        this.deliveryItemStatus = deliveryItemStatus;
    }


}
