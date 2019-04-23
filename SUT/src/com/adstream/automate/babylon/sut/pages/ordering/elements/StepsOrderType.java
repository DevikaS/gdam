package com.adstream.automate.babylon.sut.pages.ordering.elements;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 25.12.13
 * Time: 02:14
 */
public enum StepsOrderType {
    TV("tv"),
    MUSIC("music"),
    PRINT("print");

    private String stepsOrderType;

    private StepsOrderType(String stepsOrderType) {
        this.stepsOrderType = stepsOrderType;
    }

    @Override
    public String toString() {
        return stepsOrderType;
    }

    public static StepsOrderType findByType(String type) {
        for (StepsOrderType stepsOrderType: values())
            if (stepsOrderType.toString().equals(type))
                return stepsOrderType;
        throw new IllegalArgumentException("Unknown steps order type: " + type);
    }
}