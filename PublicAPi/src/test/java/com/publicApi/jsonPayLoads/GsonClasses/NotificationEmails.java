package com.publicApi.jsonPayLoads.GsonClasses;

/**
 * Created by Ramababu.Bendalam on 10/12/2016.
 */
public class NotificationEmails {

    private String[] confirmed;
    private String[] ingested;
    private String[] completed;

    public String[] getConfirmed() {
        return confirmed;
    }

    public void setConfirmed(String[] confirmed) {
        this.confirmed = confirmed;
    }

    public String[] getIngested() {
        return ingested;
    }

    public void setIngested(String[] ingested) {
        this.ingested = ingested;
    }

    public String[] getCompleted() {
        return completed;
    }

    public void setCompleted(String[] completed) {
        this.completed = completed;
    }
}