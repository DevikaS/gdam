package com.adstream.automate.babylon.JsonObjects.ordering;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 02.09.13
 * Time: 18:20
 */
public class Deliverable {
    private Integer total;
    private OrderItem[] items;

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    public OrderItem[] getOrderItems() {
        return items;
    }

    public void setOrderItems(OrderItem[] items) {
        this.items = items;
    }
}