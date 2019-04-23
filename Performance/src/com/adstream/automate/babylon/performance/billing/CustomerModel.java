package com.adstream.automate.babylon.performance.billing;

import java.util.List;

/*
 * Created by demidovskiy-r on 29.07.2014.
 */
public class CustomerModel {
    private Customer item;
    private List<Customer> items;

    public Customer getItem() {
        return item;
    }

    public void setItem(Customer item) {
        this.item = item;
    }

    public List<Customer> getItems() {
        return items;
    }

    public void setItems(List<Customer> items) {
        this.items = items;
    }
}