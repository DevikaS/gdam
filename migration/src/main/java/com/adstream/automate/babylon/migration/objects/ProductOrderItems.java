package com.adstream.automate.babylon.migration.objects;

import javax.xml.bind.annotation.XmlElement;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 5/28/15
 * Time: 12:39 PM

 */
public class ProductOrderItems {
    private String[] orderItemsGUID;

    @XmlElement(name = "OrderItemGUID")
    public String[] getOrderItemsGUID() {
        return orderItemsGUID;
    }

    public void setOrderItemsGUID(String[] orderItemsGUID) {
        this.orderItemsGUID = orderItemsGUID;
    }
}
