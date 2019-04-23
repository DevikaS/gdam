package com.adstream.automate.babylon.JsonObjects.ordering.enums;

/*
 * Created by demidovskiy-r on 15.01.14.
 */
public enum OrderReportType {
    DELIVERY("delivery"),
    CONFIRMATION("confirmation"),
    DRAFT("draft"),
    BILLING("billing");

    private String type;

    private OrderReportType(String type) {
        this.type = type;
    }

    @Override
    public String toString() {
        return type;
    }

    public static OrderReportType findByType(String type) {
        for (OrderReportType orderReportType : values())
            if (orderReportType.toString().equalsIgnoreCase(type))
                return orderReportType;
        throw new IllegalArgumentException("Unknown order report type: " + type);
    }
}