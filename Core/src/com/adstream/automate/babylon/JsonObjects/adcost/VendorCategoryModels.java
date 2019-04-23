package com.adstream.automate.babylon.JsonObjects.adcost;

import java.util.List;

/**
 * Created by Raja.Gone on 07/02/2018.
 */
public class VendorCategoryModels {

    private boolean hasDirectPayment;

    private String id;

    private List<PaymentRules> paymentRules;

    private boolean isPreferredSupplier;

    private String name;

    private String defaultCurrencyId;

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

    public List<PaymentRules> getPaymentRules() {
        return paymentRules;
    }

    public void setPaymentRules(List<PaymentRules> paymentRules) {
        this.paymentRules = paymentRules;
    }

    public boolean getIsPreferredSupplier ()
    {
        return isPreferredSupplier;
    }

    public void setIsPreferredSupplier (boolean isPreferredSupplier)
    {
        this.isPreferredSupplier = isPreferredSupplier;
    }

    public String getName ()
    {
        return name;
    }

    public void setName (String name)
    {
        this.name = name;
    }

    public String getDefaultCurrencyId ()
    {
        return defaultCurrencyId;
    }

    public void setDefaultCurrencyId (String defaultCurrencyId)
    {
        this.defaultCurrencyId = defaultCurrencyId;
    }
}
