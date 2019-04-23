package com.publicApi.jsonPayLoads.GsonClasses.traffic;

import com.publicApi.jsonPayLoads.GsonClasses.Asset;
import com.publicApi.jsonPayLoads.GsonClasses.Destinations;
import com.publicApi.jsonPayLoads.GsonClasses.ServiceLevel;

/**
 * Created by Raja.Gone on 05/08/2016.
 */
public class Traffic {
    private String id;

    public String get_id() {
        return _id;
    }

    public void set_id(String _id) {
        this._id = _id;
    }

    private String _id;

    private Assets[] assets;

    private OrderDetails orderDetails;

    private Destinations[] destinations;

    private String status;

    private String submitted;

    private String orderReference;

    private OrderItems[] orderItems;

    public ServiceLevel getServiceLevel() {
        return serviceLevel;
    }

    public void setServiceLevel(ServiceLevel serviceLevel) {
        this.serviceLevel = serviceLevel;
    }

    private ServiceLevel serviceLevel;

    private String onHold;

    private String orderId;

    private String name;

    public String getA5ViewStatus() {
        return a5ViewStatus;
    }

    public void setA5ViewStatus(String a5ViewStatus) {
        this.a5ViewStatus = a5ViewStatus;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    private String a5ViewStatus;

    public String getDestinationStatus() {
        return destinationStatus;
    }

    public void setDestinationStatus(String destinationStatus) {
        this.destinationStatus = destinationStatus;
    }

    private String destinationStatus;

    public String getDestinationId() {
        return destinationId;
    }

    public void setDestinationId(String destinationId) {
        this.destinationId = destinationId;
    }

    private String destinationId;

    public String getOrderItemId() {
        return orderItemId;
    }

    public void setOrderItemId(String orderItemId) {
        this.orderItemId = orderItemId;
    }

    private String orderItemId;

    public String getId ()
    {
        return id;
    }

    public void setId (String id)
    {
        this.id = id;
    }

    public Assets[] getAssets ()
    {
        return assets;
    }

    public void setAssets (Assets[] assets)
    {
        this.assets = assets;
    }

    public OrderDetails getOrderDetails ()
    {
        return orderDetails;
    }

    public void setOrderDetails (OrderDetails orderDetails)
    {
        this.orderDetails = orderDetails;
    }

    public String getStatus ()
    {
        return status;
    }

    public void setStatus (String status)
    {
        this.status = status;
    }

    public String getSubmitted ()
    {
        return submitted;
    }

    public void setSubmitted (String submitted)
    {
        this.submitted = submitted;
    }

    public String getOrderReference ()
    {
        return orderReference;
    }

    public void setOrderReference (String orderReference)
    {
        this.orderReference = orderReference;
    }

    public OrderItems[] getOrderItems ()
    {
        return orderItems;
    }

    public void setOrderItems (OrderItems[] orderItems)
    {
        this.orderItems = orderItems;
    }

    public Destinations[] getDestinations() {
        return destinations;
    }

    public void setDestinations(Destinations[] destinations) {
        this.destinations = destinations;
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

    private Asset asset;

    private Order order;

    private Agency agency;

    public Asset getAsset ()
    {
        return asset;
    }

    public void setAsset (Asset asset)
    {
        this.asset = asset;
    }


    public Order getOrder ()
    {
        return order;
    }

    public void setOrder (Order order)
    {
        this.order = order;
    }

    public Agency getAgency ()
    {
        return agency;
    }

    public void setAgency (Agency agency)
    {
        this.agency = agency;
    }
}
