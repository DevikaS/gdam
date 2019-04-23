package com.adstream.automate.babylon.sut.pages.adcost.elements;

/**
 * Created by Raja.Gone on 01/09/2017.
 */
public enum UserRoleInCostModule {
    AGENCYADMIN("Agency Admin"),
    INTEGRATEDPRODUCTIONMANAGER("Integrated Production Manager"),
    BRANDMANAGEMENTAPPROVER("Brand Manager"),
    COSTCONSULTANT("Cost Consultant"),
    AGENCYOWNER("Agency Owner"),
    FINANCEMANAGER("Finance Manager"),
    ADSTREAMADMIN("Adstream Admin"),
    GOVERNANCEMANAGER("Governance Manager"),
    AGENCYFINANCEMANAGER("Agency Finance Manager"),
    CENTRALADAPTIONSUPPLIER("Central Adaptation Supplier"),
    REGIONALAGENCYUSER("Regional Agency User"),
    INSURANCEUSER("Insurance User"),
    PURCHASINGSUPPORT("Purchasing Support"),
    REGIONSUPPORT("Region Support");

    private String userRoleInCostModule;

    private UserRoleInCostModule(String userRoleInCostModule) {
        this.userRoleInCostModule = userRoleInCostModule;
    }

    @Override
    public String toString() {
        return userRoleInCostModule;
    }

    public static UserRoleInCostModule findByType(String type) {
        for (UserRoleInCostModule userRoleInCostModule: values())
            if (userRoleInCostModule.toString().equals(type))
                return userRoleInCostModule;
        throw new IllegalArgumentException("Unknown User Role: " + type);
    }
}
