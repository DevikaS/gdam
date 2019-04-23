package com.adstream.automate.babylon.JsonObjects.adcost;

/**
 * Created by Arti.Sharma on 13/02/2018.
 */
public class VendorsCount {

    private String count;

    private Vendors[] vendors;

    public String getCount ()
    {
        return count;
    }

    public void setCount (String count)
    {
        this.count = count;
    }

    public Vendors[] getVendors ()
    {
        return vendors;
    }

    public void setVendors (Vendors[] vendors)
    {
        this.vendors = vendors;
    }
}