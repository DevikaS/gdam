package com.adstream.automate.babylon.JsonObjects.ordering.billing;

/*
 * Created by demidovskiy-r on 27.11.2014.
 */
public class BillingService {
    private String status;
    private BillingStepsMonitoring stepsEnabled;

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public BillingStepsMonitoring getStepsEnabled() {
        return stepsEnabled;
    }

    public void setStepsEnabled(BillingStepsMonitoring stepsEnabled) {
        this.stepsEnabled = stepsEnabled;
    }
}