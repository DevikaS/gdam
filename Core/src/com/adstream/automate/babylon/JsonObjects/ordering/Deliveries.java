package com.adstream.automate.babylon.JsonObjects.ordering;

import org.joda.time.DateTime;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 28.10.13
 * Time: 14:38
 */
public class Deliveries {
    private String clockNumber;
    private Integer orderReference;
    private String destination;
    private DateTime submitted;
    private String orderedBy;
    private String status;
    private String _id;

    public String getClockNumber() {
        return clockNumber;
    }

    public void setClockNumber(String clockNumber) {
        this.clockNumber = clockNumber;
    }

    public Integer getOrderReference() {
        return orderReference;
    }

    public void setOrderReference(Integer orderReference) {
        this.orderReference = orderReference;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public DateTime getSubmitted() {
        return submitted;
    }

    public void setSubmitted(DateTime submitted) {
        this.submitted = submitted;
    }

    public String getOrderedBy() {
        return orderedBy;
    }

    public void setOrderedBy(String orderedBy) {
        this.orderedBy = orderedBy;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String get_id() {
        return _id;
    }

    public void set_id(String _id) {
        this._id = _id;
    }
}