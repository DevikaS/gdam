package com.adstream.automate.babylon.JsonObjects.ordering.billing;

/*
 * Created by demidovskiy-r on 04.07.2014.
 */
public class PriceItem {
    private String ItemCode;
    private String Description;
    private String Price;
    private Integer Quantity;
    private String VatPrcnt;

    public String getItemCode() {
        return ItemCode;
    }

    public void setItemCode(String itemCode) {
        ItemCode = itemCode;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String description) {
        Description = description;
    }

    public String getPrice() {
        return Price;
    }

    public void setPrice(String price) {
        Price = price;
    }

    public Integer getQuantity() {
        return Quantity;
    }

    public void setQuantity(Integer quantity) {
        Quantity = quantity;
    }

    public String getVatPrcnt() {
        return VatPrcnt;
    }

    public void setVatPrcnt(String vatPrcnt) {
        VatPrcnt = vatPrcnt;
    }
}