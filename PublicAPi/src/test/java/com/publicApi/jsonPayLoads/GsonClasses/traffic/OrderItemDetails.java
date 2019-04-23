package com.publicApi.jsonPayLoads.GsonClasses.traffic;

/**
 * Created by Raja.Gone on 05/08/2016.
 */
public class OrderItemDetails {
    private String[] uploadRequestAssignees;

    private String subtitles;

    private String duration;

    private String subtitlesRequired;

    private String serviceLevelMinutes;

    private String itemType;

    private String agencyCountry;

    private String serviceLevel;

    private String additionalInformation;

    public String[] getUploadRequestAssignees ()
    {
        return uploadRequestAssignees;
    }

    public void setUploadRequestAssignees (String[] uploadRequestAssignees)
    {
        this.uploadRequestAssignees = uploadRequestAssignees;
    }

    public String getSubtitles ()
    {
        return subtitles;
    }

    public void setSubtitles (String subtitles)
    {
        this.subtitles = subtitles;
    }

    public String getDuration ()
    {
        return duration;
    }

    public void setDuration (String duration)
    {
        this.duration = duration;
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

    public String getItemType ()
    {
        return itemType;
    }

    public void setItemType (String itemType)
    {
        this.itemType = itemType;
    }

    public String getAgencyCountry ()
    {
        return agencyCountry;
    }

    public void setAgencyCountry (String agencyCountry)
    {
        this.agencyCountry = agencyCountry;
    }

    public String getServiceLevel ()
    {
        return serviceLevel;
    }

    public void setServiceLevel (String serviceLevel)
    {
        this.serviceLevel = serviceLevel;
    }

    public String getAdditionalInformation ()
    {
        return additionalInformation;
    }

    public void setAdditionalInformation (String additionalInformation)
    {
        this.additionalInformation = additionalInformation;
    }
}
