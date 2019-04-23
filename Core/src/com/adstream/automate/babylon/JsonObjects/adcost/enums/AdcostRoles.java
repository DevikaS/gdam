package com.adstream.automate.babylon.JsonObjects.adcost.enums;

/*
 * Created by Arti Sharma on 23.01.18.
 */
public enum AdcostRoles {
    AGENCYOWNER("Agency Owner"),
    REGIONALAGENCYUSER("Regional Agency User"),
    AGENCYADMIN("Agency Admin"),
    CENTRALADAPTATIONSUPPLIER("Central Adaptation Supplier"),
    AGENCYFINANCEMANAGER("Agency Finance Manager"),
    COSTCONSULTANT("Cost Consultant"),
    ADSTREAMADMIN("Adstream Admin"),
    FINANCEMANAGER("Finance Manager"),
    INTEGRATEDPRODUCTIONMANAGER("Integrated Production Manager"),
    BRANDMANAGEMENTAPPROVER("Brand Management Approver"),
    INSURANCEUSER("Insurance User"),
    PURCHASINGSUPPORT("Purchasing Support"),
    REGIONSUPPORT("Region Support"),
    GOVERNANCEMANAGER("Governance Manager");



    private String adcostRoles;

    private AdcostRoles(String adcostRole) {
        this.adcostRoles = adcostRole;
    }

    @Override
    public String toString() {
        return adcostRoles;
    }

    public static AdcostRoles findByName(String role) {
        for (AdcostRoles roles: values())
            if (role.toString().equals(role))
                return roles;
        throw new IllegalArgumentException("Unknown role type in Adcost : " + role);
    }
}