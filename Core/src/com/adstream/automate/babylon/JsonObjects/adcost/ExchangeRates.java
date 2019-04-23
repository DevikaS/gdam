package com.adstream.automate.babylon.JsonObjects.adcost;

/**
 * Created by Raja.Gone on 09/06/2017.
 */
public class ExchangeRates {
    private String id;

    private String rateType;

    private Double oldRate;

    private String fromCurrency;

    private String effectiveFrom;

    private Double rate;

    private String abstractTypeId;

    private String toCurrency;

    private String rateName;

    public String getId ()
    {
        return id;
    }

    public void setId (String id)
    {
        this.id = id;
    }

    public String getRateType ()
    {
        return rateType;
    }

    public void setRateType (String rateType)
    {
        this.rateType = rateType;
    }

    public Double getOldRate ()
    {
        return oldRate;
    }

    public void setOldRate (Double oldRate)
    {
        this.oldRate = oldRate;
    }

    public String getFromCurrency ()
    {
        return fromCurrency;
    }

    public void setFromCurrency (String fromCurrency)
    {
        this.fromCurrency = fromCurrency;
    }

    public String getEffectiveFrom ()
    {
        return effectiveFrom;
    }

    public void setEffectiveFrom (String effectiveFrom)
    {
        this.effectiveFrom = effectiveFrom;
    }

    public Double getRate ()
    {
        return rate;
    }

    public void setRate (Double rate)
    {
        this.rate = rate;
    }

    public String getAbstractTypeId ()
    {
        return abstractTypeId;
    }

    public void setAbstractTypeId (String abstractTypeId)
    {
        this.abstractTypeId = abstractTypeId;
    }

    public String getToCurrency ()
    {
        return toCurrency;
    }

    public void setToCurrency (String toCurrency)
    {
        this.toCurrency = toCurrency;
    }

    public String getRateName ()
    {
        return rateName;
    }

    public void setRateName (String rateName)
    {
        this.rateName = rateName;
    }

}
