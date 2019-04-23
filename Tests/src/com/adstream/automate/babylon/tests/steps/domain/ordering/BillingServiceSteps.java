package com.adstream.automate.babylon.tests.steps.domain.ordering;

import org.jbehave.core.annotations.Given;

/*
 * Created by demidovskiy-r on 02.04.14.
 */
public class BillingServiceSteps extends OrderingHelperSteps {

    private enum BillingStatus {
        ON("on"),
        OFF("off");

        private String name;

        private BillingStatus(String name) {
            this.name = name;
        }

        @Override
        public String toString() {
            return name;
        }

        public static BillingStatus findByName(String name) {
            for (BillingStatus billingStatus: values())
                if (billingStatus.toString().equals(name))
                    return billingStatus;
            throw new IllegalArgumentException("Unknown billing status: " + name);
        }
    }

    private BillingStatus getBillingStatus() {
        return BillingStatus.findByName(getCoreApi().getBillingStatus());
    }

    // action: enable, disable
    @Given("{I |}'$action' Billing Service")
    public void actionWithBillingService(String action) {
        BillingStatus billingStatus = getBillingStatus();
        if (billingStatus.equals(BillingStatus.ON) && action.equals("disable")) {
            getCoreApi().disableBilling();
            if (getBillingStatus().equals(BillingStatus.ON))
                throw new IllegalStateException("Billing Service still is working now!");
        } else if (billingStatus.equals(BillingStatus.OFF) && action.equals("enable")) {
            getCoreApi().enableBilling();
            if (getBillingStatus().equals(BillingStatus.OFF))
                throw new IllegalArgumentException("Billing Service is not starting now!");
        }
    }
}