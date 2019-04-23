package com.publicApi.jsonPayLoads.GsonClasses.traffic;

/**
 * Created by Raja.Gone on 05/08/2016.
 */
public class OrderDetails {
    private String marketId;

    private String hasAdditionalServices;

    private String market;

    private String subtitlesRequired;

    private String serviceLevelMinutes;

    private String poNumber;

    private String ingestLocation;

    private String serviceLevel;

    private String marketCountry;

    private String jobNumber;

    public String getMarketId ()
    {
        return marketId;
    }

    public void setMarketId (String marketId)
    {
        this.marketId = marketId;
    }

    public String getHasAdditionalServices ()
    {
        return hasAdditionalServices;
    }

    public void setHasAdditionalServices (String hasAdditionalServices)
    {
        this.hasAdditionalServices = hasAdditionalServices;
    }

    public String getMarket ()
    {
        return market;
    }

    public void setMarket (String market)
    {
        this.market = market;
    }

    public String getSubtitlesRequired ()
    {
        return subtitlesRequired;
    }

    public void setSubtitlesRequired (String subtitlesRequired)
    {
        this.subtitlesRequired = subtitlesRequired;
    }

    public String getServiceLevelMinutes ()
    {
        return serviceLevelMinutes;
    }

    public void setServiceLevelMinutes (String serviceLevelMinutes)
    {
        this.serviceLevelMinutes = serviceLevelMinutes;
    }

    public String getPoNumber ()
    {
        return poNumber;
    }

    public void setPoNumber (String poNumber)
    {
        this.poNumber = poNumber;
    }

    public String getIngestLocation ()
    {
        return ingestLocation;
    }

    public void setIngestLocation (String ingestLocation)
    {
        this.ingestLocation = ingestLocation;
    }

    public String getServiceLevel ()
    {
        return serviceLevel;
    }

    public void setServiceLevel (String serviceLevel)
    {
        this.serviceLevel = serviceLevel;
    }

    public String getMarketCountry ()
    {
        return marketCountry;
    }

    public void setMarketCountry (String marketCountry)
    {
        this.marketCountry = marketCountry;
    }

    public String getJobNumber ()
    {
        return jobNumber;
    }

    public void setJobNumber (String jobNumber)
    {
        this.jobNumber = jobNumber;
    }

}
