package com.adstream.automate.babylon.JsonObjects.traffic;

/**
 * Created by denysb on 27/06/2016.
 */
public class TrafficOrderItemDetails {
    private String duration;
    private String serviceLevelMinutes;
    private String additionalInformation;
    private String itemType;
    private Boolean subtitlesRequired;
    private String campaign;
    private String [] uploadRequestAssignees;
    private String serviceLevel;
    private String agencyCountry;

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public String getServiceLevelMinutes() {
        return serviceLevelMinutes;
    }

    public void setServiceLevelMinutes(String serviceLevelMinutes) {
        this.serviceLevelMinutes = serviceLevelMinutes;
    }

    public String getAdditionalInformation() {
        return additionalInformation;
    }

    public void setAdditionalInformation(String additionalInformation) {
        this.additionalInformation = additionalInformation;
    }

    public String getItemType() {
        return itemType;
    }

    public void setItemType(String itemType) {
        this.itemType = itemType;
    }

    public Boolean getSubtitlesRequired() {
        return subtitlesRequired;
    }

    public void setSubtitlesRequired(Boolean subtitlesRequired) {
        this.subtitlesRequired = subtitlesRequired;
    }

    public String getCampaign() {
        return campaign;
    }

    public void setCampaign(String campaign) {
        this.campaign = campaign;
    }

    public String[] getUploadRequestAssignees() {
        return uploadRequestAssignees;
    }

    public void setUploadRequestAssignees(String[] uploadRequestAssignees) {
        this.uploadRequestAssignees = uploadRequestAssignees;
    }

    public String getServiceLevel() {
        return serviceLevel;
    }

    public void setServiceLevel(String serviceLevel) {
        this.serviceLevel = serviceLevel;
    }

    public String getAgencyCountry() {
        return agencyCountry;
    }

    public void setAgencyCountry(String agencyCountry) {
        this.agencyCountry = agencyCountry;
    }
}
