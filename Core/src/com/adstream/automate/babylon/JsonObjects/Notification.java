package com.adstream.automate.babylon.JsonObjects;

import org.joda.time.DateTime;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 22.08.12
 * Time: 19:18
 */
public class Notification {
    private String _id;
    private DateTime _created;
    private boolean hasRead;
    private User createdBy;
    private String _documentType;
    private DateTime _modified;
    private String[] ids;
    private String type;
    private User user;
    private Parameters parameters;

    public DateTime getCreated() {
        return _created;
    }

    public void setCreated(DateTime created) {
        _created = created;
    }

    public String getNotificationsId() {
        return _id;
    }

    public void setNotificationsId(String _id) {
        this._id = _id;
    }

    public boolean getHasRead() {
        return hasRead;
    }

    public void setHasRead(boolean hasRead) {
        this.hasRead = hasRead;
    }

    public User getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(User createdBy) {
        this.createdBy = createdBy;
    }

    public String getDocumentType() {
        return _documentType;
    }

    public void setDocumentType(String documentType) {
        this._documentType = documentType;
    }

    public DateTime getModified() {
        return _modified;
    }

    public void setModified(DateTime modified) {
        _modified = modified;
    }

    public String[] getIds(){
        return ids;
    }

    public void setIds(String[] ids) {
        this.ids = ids;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Parameters getParameters() {
        return parameters;
    }

    public void setParameters(Parameters parameters) {
        this.parameters = parameters;
    }
}