package com.adstream.automate.babylon.JsonObjects.ordering;

import com.adstream.automate.babylon.JsonObjects.CustomMetadata;

/*
 * Created by demidovskiy-r on 29.10.2014.
 */
public class NotIngestedAsset {
    private String _id;
    private String clockNumber;

    public NotIngestedAsset(CustomMetadata cm) {
        set_id(cm.getString("_id"));
        setClockNumber(cm.getString("clockNumber"));
    }

    public String get_id() {
        return _id;
    }

    public void set_id(String _id) {
        this._id = _id;
    }

    public String getClockNumber() {
        return clockNumber;
    }

    public void setClockNumber(String clockNumber) {
        this.clockNumber = clockNumber;
    }
}