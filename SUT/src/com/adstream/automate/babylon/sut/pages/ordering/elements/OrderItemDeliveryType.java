package com.adstream.automate.babylon.sut.pages.ordering.elements;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 05.12.13
 * Time: 15:01
 */
public enum OrderItemDeliveryType {
    DELIVERY("delivery"),
    INGEST("ingest");

    private String type;

    private OrderItemDeliveryType(String type) {
        this.type = type;
    }


    @Override
    public String toString() {
        return type;
    }
}