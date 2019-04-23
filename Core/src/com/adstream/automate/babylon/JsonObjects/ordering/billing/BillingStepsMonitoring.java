package com.adstream.automate.babylon.JsonObjects.ordering.billing;

/*
 * Created by demidovskiy-r on 27.11.2014.
 */
public class BillingStepsMonitoring {
    private Boolean getPrice;
    private Boolean placeOrder;
    private Boolean update;

    public Boolean getGetPrice() {
        return getPrice;
    }

    public void setGetPrice(Boolean getPrice) {
        this.getPrice = getPrice;
    }

    public Boolean getPlaceOrder() {
        return placeOrder;
    }

    public void setPlaceOrder(Boolean placeOrder) {
        this.placeOrder = placeOrder;
    }

    public Boolean getUpdate() {
        return update;
    }

    public void setUpdate(Boolean update) {
        this.update = update;
    }
}