package com.adstream.automate.babylon.sut.pages.adcost.elements;

public enum StepsAdCostType {
    PRODUCTION("production"),
    BUYOUT("buyout"),
    TRAFFICKINGDISTRIBUTION("Trafficking");

    private String stepsOrderType;

    private StepsAdCostType(String stepsOrderType) {
        this.stepsOrderType = stepsOrderType;
    }

    @Override
    public String toString() {
        return stepsOrderType;
    }

    public static StepsAdCostType findByType(String type) {
        for (StepsAdCostType stepsOrderType: values())
            if (stepsOrderType.toString().equals(type))
                return stepsOrderType;
        throw new IllegalArgumentException("Unknown Adcost type: " + type);
    }
}