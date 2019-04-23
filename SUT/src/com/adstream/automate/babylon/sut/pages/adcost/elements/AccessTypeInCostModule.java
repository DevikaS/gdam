package com.adstream.automate.babylon.sut.pages.adcost.elements;

/**
 * Created by Raja.Gone on 01/09/2017.
 */
public enum AccessTypeInCostModule {
    AGENCY("Agency"),
    SMO("Smo"),
    REGION("Region"),
    Client("Client");

    private String accessTypeInCostModule;

    private AccessTypeInCostModule(String accessTypeInCostModule) {
        this.accessTypeInCostModule = accessTypeInCostModule;
    }

    @Override
    public String toString() {
        return accessTypeInCostModule;
    }

    public static AccessTypeInCostModule findByType(String type) {
        for (AccessTypeInCostModule accessTypeInCostModule: values())
            if (accessTypeInCostModule.toString().equals(type))
                return accessTypeInCostModule;
        throw new IllegalArgumentException("Unknown Access Type: " + type);
    }
}
