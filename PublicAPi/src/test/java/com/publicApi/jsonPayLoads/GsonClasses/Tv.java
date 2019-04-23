package com.publicApi.jsonPayLoads.GsonClasses;

/**
 * Created by Raja.Gone on 04/07/2016.
 */
public class Tv {

    private String[] marketId;

    private String market;

    private String orderReference;

    private String marketCountry;

    private String atDestination;

    private String cancelled;

    public String getCancelled ()
    {
        return cancelled;
    }

    public void setCancelled (String cancelled)
    {
        this.cancelled = cancelled;
    }

    public String getAtDestination ()
    {
        return atDestination;
    }

    public void setAtDestination (String atDestination)
    {
        this.atDestination = atDestination;
    }

    public String[] getMarketId ()
    {
        return marketId;
    }

    public void setMarketId (String[] marketId)
    {
        this.marketId = marketId;
    }

    public String getMarket ()
    {
        return market;
    }

    public void setMarket (String market)
    {
        this.market = market;
    }

    public String getOrderReference ()
    {
        return orderReference;
    }

    public void setOrderReference (String orderReference)
    {
        this.orderReference = orderReference;
    }

    public String getMarketCountry ()
    {
        return marketCountry;
    }

    public void setMarketCountry (String marketCountry)
    {
        this.marketCountry = marketCountry;
    }
}
