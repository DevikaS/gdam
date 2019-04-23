package com.adstream.automate.babylon.JsonObjects.ordering.billing;

/*
 * Created by demidovskiy-r on 04.07.2014.
 */
public class BillingItem {
    private String Advertiser;
    private BillingClock[] Clocks;

    public String getAdvertiser() {
        return Advertiser;
    }

    public void setAdvertiser(String advertiser) {
        Advertiser = advertiser;
    }

    public BillingClock[] getClocks() {
        return Clocks;
    }

    public void setClocks(BillingClock[] clocks) {
        Clocks = clocks;
    }
}