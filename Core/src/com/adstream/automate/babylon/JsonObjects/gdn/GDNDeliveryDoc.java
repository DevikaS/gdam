package com.adstream.automate.babylon.JsonObjects.gdn;

import org.joda.time.DateTime;
import java.util.*;

/**
 * Created by Ramababu.Bendalam on 09/05/2016.
 */
public class GDNDeliveryDoc  {

    String _type;
    String agencyID;
    String priority;
    String clockNumber;
    String assetId;
    String orderReference;
    String _id;
    Integer _version;
    DateTime _created;
    DateTime _modified;
    String fileId;
    String status;
    String orderId;
    List<GDNDestinations> destinations;

    public List<GDNDestinations> getDestinations() {
        return destinations;
    }

    public void setDestinations(List<GDNDestinations> destinations) {
        this.destinations = destinations;
    }

     public String get_type() {
        return _type;
    }

    public void set_type(String _type) {
        this._type = _type;
    }

    public String getAgencyID() {
        return agencyID;
    }

    public void setAgencyID(String agencyID) {
        this.agencyID = agencyID;
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

    public String getClockNumber() {
        return clockNumber;
    }

    public void setClockNumber(String clockNumber) {
        this.clockNumber = clockNumber;
    }

    public String getAssetId() {
        return assetId;
    }

    public void setAssetId(String assetId) {
        this.assetId = assetId;
    }

    public String getOrderReference() {
        return orderReference;
    }

    public void setOrderReference(String orderReference) {
        this.orderReference = orderReference;
    }

    public String get_id() {
        return _id;
    }

    public void set_id(String _id) {
        this._id = _id;
    }

    public Integer get_version() {
        return _version;
    }

    public void set_version(Integer _version) {
        this._version = _version;
    }

    public DateTime get_created() {
        return _created;
    }

    public void set_created(DateTime _created) {
        this._created = _created;
    }

    public DateTime get_modified() {
        return _modified;
    }

    public void set_modified(DateTime _modified) {
        this._modified = _modified;
    }

    public String getFileId() {
        return fileId;
    }

    public void setFileId(String fileId) {
        this.fileId = fileId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

}
