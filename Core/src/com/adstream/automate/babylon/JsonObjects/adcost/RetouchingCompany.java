package com.adstream.automate.babylon.JsonObjects.adcost;

/**
 * Created by Arti.Sharma on 30/10/2017.
 */
public class RetouchingCompany {
    private boolean hasDirectPayment;

    private String id;

    private String currencyId;

    private String sapVendorCode;

    private String productionCategory;

    private String name;

    private boolean isDirectPayment;

    private String defaultCurrencyId;

    private String productionType;

    public boolean getHasDirectPayment ()
    {
        return hasDirectPayment;
    }

    public void setHasDirectPayment (boolean hasDirectPayment)
    {
        this.hasDirectPayment = hasDirectPayment;
    }

    public String getId ()
    {
        return id;
    }

    public void setId (String id)
    {
        this.id = id;
    }

    public String getCurrencyId ()
    {
        return currencyId;
    }

    public void setCurrencyId (String currencyId)
    {
        this.currencyId = currencyId;
    }

    public String getSapVendorCode ()
    {
        return sapVendorCode;
    }

    public void setSapVendorCode (String sapVendorCode)
    {
        this.sapVendorCode = sapVendorCode;
    }

    public String getProductionCategory ()
    {
        return productionCategory;
    }

    public void setProductionCategory (String productionCategory)
    {
        this.productionCategory = productionCategory;
    }

    public String getName ()
    {
        return name;
    }

    public void setName (String name)
    {
        this.name = name;
    }

    public boolean getIsDirectPayment ()
    {
        return isDirectPayment;
    }

    public void setIsDirectPayment (boolean isDirectPayment)
    {
        this.isDirectPayment = isDirectPayment;
    }

    public String getDefaultCurrencyId ()
    {
        return defaultCurrencyId;
    }

    public void setDefaultCurrencyId (String defaultCurrencyId)
    {
        this.defaultCurrencyId = defaultCurrencyId;
    }

    public String getProductionType ()
    {
        return productionType;
    }

    public void setProductionType (String productionType)
    {
        this.productionType = productionType;
    }
}
