package com.adstream.automate.babylon.JsonObjects.gdn;

import org.joda.time.DateTime;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Ramababu.Bendalam on 27/04/2016.
 */
public class IngestAsset {

    int duration;
    String advertiser;
    Boolean watermarkingInitialised;
    DateTime created;
    String unique;
    String closedCaptionStatus;
    String _id;
    String title;
    String tapeNumber;
    String masterArrivedComment;
    DateTime masterArrivedDate;
    DateTime firstAirDate;

    public DateTime getFirstAirDate() {
        return firstAirDate;
    }

    public void setFirstAirDate(DateTime firstAirDate) {
        this.firstAirDate = firstAirDate;
    }

    public String getTapeNumber() {
        return tapeNumber;
    }

    public void setTapeNumber(String tapeNumber) {
        this.tapeNumber = tapeNumber;
    }

    public String getMasterArrivedComment() {
        return masterArrivedComment;
    }

    public void setMasterArrivedComment(String masterArrivedComment) {
        this.masterArrivedComment = masterArrivedComment;
    }

    public DateTime getMasterArrivedDate() {
        return masterArrivedDate;
    }

    public void setMasterArrivedDate(DateTime masterArrivedDate) {
        this.masterArrivedDate = masterArrivedDate;
    }

    IngestRevision revision;
    //


    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public String getAdvertiser() {
        return advertiser;
    }

    public void setAdvertiser(String advertiser) {
        this.advertiser = advertiser;
    }

    public Boolean getWatermarkingInitialised() {
        return watermarkingInitialised;
    }

    public void setWatermarkingInitialised(Boolean watermarkingInitialised) {
        this.watermarkingInitialised = watermarkingInitialised;
    }

    public DateTime getCreated() {
        return created;
    }

    public void setCreated(DateTime created) {
        this.created = created;
    }

    public String getUnique() {
        return unique;
    }

    public void setUnique(String unique) {
        this.unique = unique;
    }

    public String getClosedCaptionStatus() {
        return closedCaptionStatus;
    }

    public void setClosedCaptionStatus(String closedCaptionStatus) {
        this.closedCaptionStatus = closedCaptionStatus;
    }

    public String get_id() {
        return _id;
    }

    public void set_id(String _id) {
        this._id = _id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public IngestRevision getRevision() {
        return revision;
    }

    public void setRevision(IngestRevision revision) {
        this.revision = revision;
    }
}
