package com.adstream.automate.babylon.migration.objects;

import javax.xml.bind.annotation.XmlElement;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 5/28/15
 * Time: 12:25 PM

 */
public class ProductOrderItem {

    private String orderItemGUID;
    private String assetGUID;

    @XmlElement(name = "OrderItemGUID")
    public String getOrderItemGUID() {
        return orderItemGUID;
    }

    public void setOrderItemGUID(String orderItemGUID) {
        this.orderItemGUID = orderItemGUID;
    }

    @XmlElement(name = "AssetGUID")
    public String getAssetGUID() {
        return assetGUID;
    }

    public void setAssetGUID(String assetGUID) {
        this.assetGUID = assetGUID;
    }
}
