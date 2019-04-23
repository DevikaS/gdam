package com.adstream.automate.babylon.sut.pages.ordering.elements;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 13.09.13
 * Time: 19:48
 */
public enum ServiceLevelType {
    STANDARD("Standard", "2"),
    EXPRESS("Express", "3"),
    STANDARD_US("Standard (US)", "11"),
    EXPRESS_US("Express (US)", "12"),
    OVERNIGHT("Overnight", "4"),
    NEXT_DAY("Next Day", "5"),
    RED_HOT("Red Hot (US)", "13");

    private String serviceLevelType;
    private String key;

    private ServiceLevelType(String serviceLevelType, String key) {
        this.serviceLevelType = serviceLevelType;
        this.key = key;
    }

    @Override
    public String toString() {
        return serviceLevelType;
    }

    public String getKey() {
        return key;
    }

    public static ServiceLevelType findByName(String name) {
        for (ServiceLevelType serviceLevel: values())
            if (serviceLevel.toString().equals(name))
                return serviceLevel;
        throw new IllegalArgumentException("Unknown service level type: " + name);
    }
}