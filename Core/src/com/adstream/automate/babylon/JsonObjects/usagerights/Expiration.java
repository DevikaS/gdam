package com.adstream.automate.babylon.JsonObjects.usagerights;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/23/13
 * Time: 6:00 PM

 */
public class Expiration {
    private boolean useAirDate;
    private Integer expireInDays = null;
    private long startDate;
    private long expireDate;
    private String expireType;
    private ExpirationNotification[] notifications;

    public boolean isUseAirDate() {
        return useAirDate;
    }

    public void setUseAirDate(boolean useAirDate) {
        this.useAirDate = useAirDate;
    }

    public int getExpireInDays() {
        return expireInDays;
    }

    public void setExpireInDays(int expireInDays) {
        this.expireInDays = expireInDays;
    }

    public long getStartDate() {
        return startDate;
    }

    public void setStartDate(long startDate) {
        this.startDate = startDate;
    }

    public long getExpireDate() {
        return expireDate;
    }

    public void setExpireDate(long expireDate) {
        this.expireDate = expireDate;
    }

    public String getExpireType() {
        return expireType;
    }

    public void setExpireType(String expireType) {
        this.expireType = expireType;
    }

    public ExpirationNotification[] getNotifications() {
        return notifications;
    }

    public void setNotifications(ExpirationNotification[] notifications) {
        this.notifications = notifications;
    }
}
