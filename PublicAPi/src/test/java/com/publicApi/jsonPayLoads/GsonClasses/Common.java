package com.publicApi.jsonPayLoads.GsonClasses;

/**
 * Created by Raja.Gone on 05/07/2016.
 */
public class Common {

    private String title;

    private String duration;

    private String firstAirDate;

    private String additionalInformation;

    private String[] format;

    private String clockNumber;

    private String item_type;
    private String Campaign;
    private String email;

    private String[] advertiser;

    public NotificationEmails getNotificationEmails() {
        return notificationEmails;
    }

    public void setNotificationEmails(NotificationEmails notificationEmails) {
        this.notificationEmails = notificationEmails;
    }

    public String[] getAdvertiser() {
        return advertiser;
    }

    public Boolean getNotifyAboutDelivery() {
        return notifyAboutDelivery;
    }

    public void setNotifyAboutDelivery(Boolean notifyAboutDelivery) {
        this.notifyAboutDelivery = notifyAboutDelivery;
    }

    public Boolean getNotifyAboutQc() {
        return notifyAboutQc;
    }

    public void setNotifyAboutQc(Boolean notifyAboutQc) {
        this.notifyAboutQc = notifyAboutQc;
    }

    public String getPoNumber() {
        return poNumber;
    }

    public void setPoNumber(String poNumber) {
        this.poNumber = poNumber;
    }

    public String getJobNumber() {
        return jobNumber;
    }

    public void setJobNumber(String jobNumber) {
        this.jobNumber = jobNumber;
    }

    public Boolean getHandleStandardsConversions() {
        return handleStandardsConversions;
    }

    public void setHandleStandardsConversions(Boolean handleStandardsConversions) {
        this.handleStandardsConversions = handleStandardsConversions;
    }

    private String name;
    private String description;

    private String assetStatus;

    private String status;

    private Members[] members;

    private String[] projectMediaType;

    private String poNumber;
    private String jobNumber;
    private Boolean handleStandardsConversions;
    private Boolean notifyAboutQc;
    private Boolean notifyAboutDelivery;
    private NotificationEmails notificationEmails;

    public boolean isPublished() {
        return published;
    }

    public void setPublished(boolean published) {
        this.published = published;
    }

    public String[] getProjectMediaType() {
        return projectMediaType;
    }

    public void setProjectMediaType(String[] projectMediaType) {
        this.projectMediaType = projectMediaType;
    }

    private boolean published;

    public String getQuery() {
        return query;
    }

    public void setQuery(String query) {
        this.query = query;
    }

    private String query;

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCampaign() {
        return Campaign;
    }

    public void setCampaign(String campaign) {
        this.Campaign = campaign;
    }

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

    public void setAdditionalInformation (String additionalInformation)    {
        this.additionalInformation = additionalInformation;
    }

    public String[] getFormat ()
    {
        return format;
    }

    public void setFormat (String[] format)
    {
        this.format = format;
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

    public Members[] getMembers() {
        return members;
    }

    public void setMembers(Members[] members) {
        this.members = members;
    }

    public String getAssetStatus() {
        return assetStatus;

    }

    public String getStatus() {
        return status;

    }

    public void setAssetStatus(String assetStatus) {
        this.assetStatus = assetStatus;
    }



}
