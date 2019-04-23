package com.publicApi.jsonPayLoads.GsonClasses;

import com.publicApi.jsonPayLoads.GsonClasses.traffic.SpecDb;

/**
 * Created by Raja.Gone on 05/07/2016.
 */
public class Metadata {

    private String[] subtitlesRequired;

    public String[] getSubtitlesRequired ()
    {
        return subtitlesRequired;
    }

    public void setSubtitlesRequired (String[] subtitlesRequired)
    {
        this.subtitlesRequired = subtitlesRequired;
    }

    private String title;

    private String duration;

    private String market;

    private String status;

    private String name;

    private String firstAirDate;

    private String additionalInformation;

    private String format;

    private String advertiser;

    private String clockNumber;

    private String item_type;

    public String getTitle ()
    {
        return title;
    }

    public void setTitle (String title)
    {
        this.title = title;
    }

    public String getDuration ()
    {
        return duration;
    }

    public void setDuration (String duration)
    {
        this.duration = duration;
    }

    public String getMarket ()
    {
        return market;
    }

    public void setMarket (String market)
    {
        this.market = market;
    }

    public String getStatus ()
    {
        return status;
    }

    public void setStatus (String status)
    {
        this.status = status;
    }


    public String getName ()
    {
        return name;
    }

    public void setName (String name)
    {
        this.name = name;
    }

    public String getFirstAirDate ()
    {
        return firstAirDate;
    }

    public void setFirstAirDate (String firstAirDate)
    {
        this.firstAirDate = firstAirDate;
    }

    public String getAdditionalInformation ()
    {
        return additionalInformation;
    }

    public void setAdditionalInformation (String additionalInformation)
    {
        this.additionalInformation = additionalInformation;
    }

    public String getFormat ()
    {
        return format;
    }

    public void setFormat (String format)
    {
        this.format = format;
    }

    public String getAdvertiser ()
    {
        return advertiser;
    }

    public void setAdvertiser (String advertiser)
    {
        this.advertiser = advertiser;
    }

    public String getClockNumber ()
    {
        return clockNumber;
    }

    public void setClockNumber (String clockNumber)
    {
        this.clockNumber = clockNumber;
    }

    public String getItem_type ()
    {
        return item_type;
    }

    public void setItem_type (String item_type)
    {
        this.item_type = item_type;
    }
    private SpecDb specDb;

    public SpecDb getSpecDb ()
    {
        return specDb;
    }

    public void setSpecDb (SpecDb specDb)
    {
        this.specDb = specDb;
    }
}
