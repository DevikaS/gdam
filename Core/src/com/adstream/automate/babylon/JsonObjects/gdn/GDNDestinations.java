package com.adstream.automate.babylon.JsonObjects.gdn;

import org.joda.time.DateTime;

/**
 * Created by Ramababu.Bendalam on 09/05/2016.
 */
public class GDNDestinations {

    String slaMinutes;
    String externalId;
    String a5Status;
    String id;
    String gdnWorkflowId;
    String gdnStatus;
    String _version;
    DateTime _modified;

    public String getSlaMinutes() {
        return slaMinutes;
    }

    public void setSlaMinutes(String slaMinutes) {
        this.slaMinutes = slaMinutes;
    }

    public String getExternalId() {
        return externalId;
    }

    public void setExternalId(String externalId) {
        this.externalId = externalId;
    }

    public String getA5Status() {
        return a5Status;
    }

    public void setA5Status(String a5Status) {
        this.a5Status = a5Status;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getGdnWorkflowId() {
        return gdnWorkflowId;
    }

    public void setGdnWorkflowId(String gdnWorkflowId) {
        this.gdnWorkflowId = gdnWorkflowId;
    }

    public String getGdnStatus() {
        return gdnStatus;
    }

    public void setGdnStatus(String gdnStatus) {
        this.gdnStatus = gdnStatus;
    }

    public String get_version() {
        return _version;
    }

    public void set_version(String _version) {
        this._version = _version;
    }

    public DateTime get_modified() {
        return _modified;
    }

    public void set_modified(DateTime _modified) {
        this._modified = _modified;
    }
}
