package com.adstream.automate.babylon.JsonObjects.ordering;

import com.adstream.automate.babylon.JsonObjects.CustomMetadata;
import org.joda.time.DateTime;

/*
 * Created by demidovskiy-r on 16.01.14.
 */
public class UploadRequest {
    private String assignee;
    private String postHouse;
    private String message;
    private Boolean alreadySupplied;
    private DateTime deadlineDate;
    private String[] uploadType;

    public UploadRequest(CustomMetadata cm) {
        setAssignee(cm.getString("assignee"));
        setPostHouse(cm.getString("postHouse"));
        setMessage(cm.getString("message"));
        setAlreadySupplied(cm.getBoolean("alreadySupplied"));
        setDeadlineDate(cm.getDateTime("deadlineDate"));
        setUploadType(cm.getStringArray("uploadType"));
    }

    public String getAssignee() {
        return assignee;
    }

    public void setAssignee(String assignee) {
        this.assignee = assignee;
    }

    public String getPostHouse() {
        return postHouse;
    }

    public void setPostHouse(String postHouse) {
        this.postHouse = postHouse;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Boolean isAlreadySupplied() {
        return alreadySupplied;
    }

    public void setAlreadySupplied(Boolean alreadySupplied) {
        this.alreadySupplied = alreadySupplied;
    }

    public DateTime getDeadlineDate() {
        return deadlineDate;
    }

    public void setDeadlineDate(DateTime deadlineDate) {
        this.deadlineDate = deadlineDate;
    }

    public String[] getUploadType() {
        return uploadType;
    }

    public void setUploadType(String[] uploadType) {
        this.uploadType = uploadType;
    }
}