package com.adstream.automate.babylon.JsonObjects.ordering.billing;

/*
 * Created by demidovskiy-r on 04.07.2014.
 */
public class BillingClock {
    private String ClockID;
    private Integer ClockDuration;
    private BillingClockDestination[] Destinations;
    private BillingClockService[] Services;

    public String getClockID() {
        return ClockID;
    }

    public void setClockID(String clockID) {
        ClockID = clockID;
    }

    public Integer getClockDuration() {
        return ClockDuration;
    }

    public void setClockDuration(Integer clockDuration) {
        ClockDuration = clockDuration;
    }

    public BillingClockDestination[] getDestinations() {
        return Destinations;
    }

    public void setDestinations(BillingClockDestination[] destinations) {
        Destinations = destinations;
    }

    public BillingClockService[] getServices() {
        return Services;
    }

    public void setServices(BillingClockService[] services) {
        Services = services;
    }
}