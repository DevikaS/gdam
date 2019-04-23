package com.adstream.automate.babylon.JsonObjects.adcost;

import java.util.List;

/**
 * Created by Raja.Gone on 19/06/2017.
 */
public class Vendors {

    private String id;

    private String sapVendorCode;

    private String name;

    private List<VendorCategoryModels> vendorCategoryModels;

    public String getId ()
    {
        return id;
    }

    public void setId (String id)
    {
        this.id = id;
    }

    public String getSapVendorCode ()
    {
        return sapVendorCode;
    }

    public void setSapVendorCode (String sapVendorCode)
    {
        this.sapVendorCode = sapVendorCode;
    }

    public String getName ()
    {
        return name;
    }

    public void setName (String name)
    {
        this.name = name;
    }

    public List<VendorCategoryModels> getVendorCategoryModels ()
    {
        return vendorCategoryModels;
    }

    public void setVendorCategoryModels (List<VendorCategoryModels> vendorCategoryModels)
    {
        this.vendorCategoryModels = vendorCategoryModels;
    }
}
