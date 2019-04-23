package com.adstream.automate.babylon.JsonObjects.activity;

import org.joda.time.DateTime;

import java.util.List;

public class Activity {
    private int version;
    private DateTime timestamp;
    private Subject subject;
    private Action action;
    private ActivityObject object;
    private List<String> recipients;
    private List<String> viewers;
    private String id;

    public int getVersion() {
        return version;
    }

    public void setVersion(int version) {
        this.version = version;
    }

    public DateTime getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(DateTime timestamp) {
        this.timestamp = timestamp;
    }

    public Subject getSubject() {
        return subject;
    }

    public void setSubject(Subject subject) {
        this.subject = subject;
    }

    public Action getAction() {
        return action;
    }

    public void setAction(Action action) {
        this.action = action;
    }

    public ActivityObject getObject() {
        return object;
    }

    public void setObject(ActivityObject object) {
        this.object = object;
    }

    public List<String> getRecipients() {
        return recipients;
    }

    public void setRecipients(List<String> recipients) {
        this.recipients = recipients;
    }

    public List<String> getViewers() {
        return viewers;
    }

    public void setViewers(List<String> viewers) {
        this.viewers = viewers;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String toString() {
        String user = subject != null ? subject.getEmail() : "";
        String type = action != null ? action.getType() : "";
        String objectName = object != null ? object.getName() : "";
        return timestamp + " " + user + " " + type + " " + objectName;
    }
}
