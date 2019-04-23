package com.adstream.automate.babylon.migration.objects;

import javax.xml.bind.annotation.XmlElement;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 5/28/15
 * Time: 12:23 PM
 */
public class ProductOrder {

    private String productOrderGUID;
    private ProductOrderItems productOrderItems;

    @XmlElement(name = "ProductOrderGUID")
    public String getProductOrderGUID() {
        return productOrderGUID;
    }

    public void setProductOrderGUID(String productOrderGUID) {
        this.productOrderGUID = productOrderGUID;
    }

    @XmlElement(name = "ProductOrderItems")
    public ProductOrderItems getProductOrderItems() {
        return productOrderItems;
    }

    public void setProductOrderItems(ProductOrderItems productOrderItems) {
        this.productOrderItems = productOrderItems;
    }
}
