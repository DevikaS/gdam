package com.adstream.automate.babylon.sut.pages.ordering.elements;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 23.08.13
 * Time: 14:07
 */
public enum OrderStatus {
    VIEW_LIVE_ORDERS("View Live Orders", "in_progress", "completing", "failed"),
    VIEW_DRAFT_ORDERS("View Draft Orders", "draft"),
    VIEW_HELD_ORDERS("View Held Orders", "onHold"),
    VIEW_COMPLETED_ORDERS("View Completed Orders", "completed");

    private String title;
    private String[] orderStatus;

    private OrderStatus(String title, String... orderStatus) {
        this.title = title;
        this.orderStatus = orderStatus;
    }

    public String toString() {
        return orderStatus[0];
    }

    public String getTitle() {
        return title;
    }

    public String[] getOrderStatus() {
        return orderStatus;
    }

    public String convertStatusToString() {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < getOrderStatus().length; i++) {
            sb.append(getOrderStatus()[i]);
            if (i != getOrderStatus().length - 1) sb.append(",");
        }
        return sb.toString();
    }
}