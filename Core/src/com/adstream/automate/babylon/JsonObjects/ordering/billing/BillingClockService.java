package com.adstream.automate.babylon.JsonObjects.ordering.billing;

/*
 * Created by demidovskiy-r on 04.07.2014.
 */
public class BillingClockService {
    private String SapServiceID;
    private Integer Quantity;
    private Integer Type;

    public String getSapServiceID() {
        return SapServiceID;
    }

    public void setSapServiceID(String sapServiceID) {
        SapServiceID = sapServiceID;
    }

    public Integer getQuantity() {
        return Quantity;
    }

    public void setQuantity(Integer quantity) {
        Quantity = quantity;
    }

    public Integer getType() {
        return Type;
    }

    public void setType(Integer type) {
        Type = type;
    }
}