package com.adstream.automate.babylon.JsonObjects.ordering.billing;

/*
 * Created by demidovskiy-r on 04.07.2014.
 */
public class BillingClockDestination {
    private String VideoFormat;
    private Integer SLA;
    private String OriginCountry;
    private String DestinationCountry;
    private Integer DestinationType;
    private String DestinationID;
    private Integer ProductType;

    public String getVideoFormat() {
        return VideoFormat;
    }

    public void setVideoFormat(String videoFormat) {
        VideoFormat = videoFormat;
    }

    public Integer getSLA() {
        return SLA;
    }

    public void setSLA(Integer SLA) {
        this.SLA = SLA;
    }

    public String getOriginCountry() {
        return OriginCountry;
    }

    public void setOriginCountry(String originCountry) {
        OriginCountry = originCountry;
    }

    public String getDestinationCountry() {
        return DestinationCountry;
    }

    public void setDestinationCountry(String destinationCountry) {
        DestinationCountry = destinationCountry;
    }

    public Integer getDestinationType() {
        return DestinationType;
    }

    public void setDestinationType(Integer destinationType) {
        DestinationType = destinationType;
    }

    public String getDestinationID() {
        return DestinationID;
    }

    public void setDestinationID(String destinationID) {
        DestinationID = destinationID;
    }

    public Integer getProductType() {
        return ProductType;
    }

    public void setProductType(Integer productType) {
        ProductType = productType;
    }
}