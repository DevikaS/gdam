package com.adstream.automate.babylon.JsonObjects.ordering.enums;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 21.08.13
 * Time: 19:50
 */
public enum OrderType {
    TV("tv_order", "tv_order_item"),
    MUSIC("tv_order_music", "tv_order_item_music"),
    PRINT("tv_order_print", "tv_order_item_print");

    private String orderType;
    private String orderItemType;

    private OrderType(String orderType, String orderItemType) {
        this.orderType = orderType;
        this.orderItemType = orderItemType;
    }

    public String getOrderType() {
        return orderType;
    }

    public String getOrderItemType() {
        return orderItemType;
    }

    public static OrderType findByType(String type) {
        for (OrderType orderType: values())
            if (orderType.getOrderType().equals(type))
                return orderType;
        throw new IllegalArgumentException("Unknown order type: " + type);
    }
}