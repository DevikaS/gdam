package com.publicApi.jsonPayLoads.GsonClasses.traffic;

import com.publicApi.jsonPayLoads.GsonClasses.Asset;
import com.publicApi.jsonPayLoads.GsonClasses.Destinations;

/**
 * Created by Raja.Gone on 05/08/2016.
 */
public class OrderItems {
    private String id;

    private Destinations[] destinations;

    public OrderItemDetails getOrderItemDetails() {
        return orderItemDetails;
    }

    public void setOrderItemDetails(OrderItemDetails orderItemDetails) {
        this.orderItemDetails = orderItemDetails;
    }

    private OrderItemDetails orderItemDetails;

    private String duration;

    private Asset asset;

    private String created;

    private String status;

    private String qcAssetId;

    private String clockNumber;

    private String onHold;

    private String orderId;

    private Metadata metadata;

    private String modified;

    public String getId ()
    {
        return id;
    }

    public void setId (String id)
    {
        this.id = id;
    }

    public Destinations[] getDestinations ()
    {
        return destinations;
    }

    public void setDestinations (Destinations[] destinations)
    {
        this.destinations = destinations;
    }

    public String getDuration ()
    {
        return duration;
    }

    public void setDuration (String duration)
    {
        this.duration = duration;
    }

    public Asset getAsset ()
    {
        return asset;
    }

    public void setAsset (Asset asset)
    {
        this.asset = asset;
    }

    public String getCreated ()
    {
        return created;
    }

    public void setCreated (String created)
    {
        this.created = created;
    }

    public String getStatus ()
    {
        return status;
    }

    public void setStatus (String status)
    {
        this.status = status;
    }

    public String getQcAssetId ()
    {
        return qcAssetId;
    }

    public void setQcAssetId (String qcAssetId)
    {
        this.qcAssetId = qcAssetId;
    }

    public String getClockNumber ()
    {
        return clockNumber;
    }

    public void setClockNumber (String clockNumber)
    {
        this.clockNumber = clockNumber;
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

    public Metadata getMetadata ()
    {
        return metadata;
    }

    public void setMetadata (Metadata metadata)
    {
        this.metadata = metadata;
    }

    public String getModified ()
    {
        return modified;
    }

    public void setModified (String modified)
    {
        this.modified = modified;
    }
}
