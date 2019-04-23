package com.adstream.automate.babylon.JsonObjects.ordering;

import com.adstream.automate.babylon.JsonObjects.CustomMetadata;

/*
 * Created by demidovskiy-r on 09.01.14.
 */
public class NonBroadcastDestinationItem {
    private String notesAndLabels;
    private String[] format;
    private String[] method;
    private String noOfCopies;
    private String[] mediaCompile;
    private String[] specification;
    private ServiceLevel serviceLevel;
    private String destination;
    private String deliveryDetails;

    public NonBroadcastDestinationItem(CustomMetadata cm) {
        setNotesAndLabels(cm.getString("notesAndLabels"));
        setFormat(cm.getStringArray("format"));
        setMethod(cm.getStringArray("method"));
        setNoOfCopies(cm.getString("noOfCopies"));
        setMediaCompile(cm.getStringArray("mediaCompile"));
        setSpecification(cm.getStringArray("specification"));
        setServiceLevel(cm.getForClass("serviceLevel", ServiceLevel.class));
        setDestination(cm.getString("destination"));
        setDeliveryDetails(cm.getString("deliveryDetails"));
    }

    public String getNotesAndLabels() {
        return notesAndLabels;
    }

    public void setNotesAndLabels(String notesAndLabels) {
        this.notesAndLabels = notesAndLabels;
    }

    public String[] getFormat() {
        return format;
    }

    public void setFormat(String[] format) {
        this.format = format;
    }

    public String[] getMethod() {
        return method;
    }

    public void setMethod(String[] method) {
        this.method = method;
    }

    public String getNoOfCopies() {
        return noOfCopies;
    }

    public void setNoOfCopies(String noOfCopies) {
        this.noOfCopies = noOfCopies;
    }

    public String[] getMediaCompile() {
        return mediaCompile;
    }

    public void setMediaCompile(String[] mediaCompile) {
        this.mediaCompile = mediaCompile;
    }

    public String[] getSpecification() {
        return specification;
    }

    public void setSpecification(String[] specification) {
        this.specification = specification;
    }

    public ServiceLevel getServiceLevel() {
        return serviceLevel;
    }

    public void setServiceLevel(ServiceLevel serviceLevel) {
        this.serviceLevel = serviceLevel;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public String getDeliveryDetails() {
        return deliveryDetails;
    }

    public void setDeliveryDetails(String deliveryDetails) {
        this.deliveryDetails = deliveryDetails;
    }
}