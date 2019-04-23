package com.adstream.automate.babylon.JsonObjects.usagerights;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/23/13
 * Time: 6:12 PM

 */
public class ExpirationNotification {
    private String id;
    private boolean notify;
    private int daysBefore;
    private boolean notifyTeam;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public boolean isNotify() {
        return notify;
    }

    public void setNotify(boolean notify) {
        this.notify = notify;
    }

    public int getDaysBefore() {
        return daysBefore;
    }

    public void setDaysBefore(int daysBefore) {
        this.daysBefore = daysBefore;
    }

    public boolean isNotifyTeam() {
        return notifyTeam;
    }

    public void setNotifyTeam(boolean notifyTeam) {
        this.notifyTeam = notifyTeam;
    }
}
