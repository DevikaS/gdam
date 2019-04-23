package com.adstream.automate.babylon.JsonObjects.ordering;

/*
 * Created by demidovskiy-r on 28.02.14.
 */
public class QcAsset {
    private String id;
    private String advertiser;
    private String product;
    private String campaign;
    private String title;
    private String clockNumber;
    private String duration;
    private String spec;
    private QcDestination[] destinations;
    private Boolean adbanked;
    private Boolean default_adbanked;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getAdvertiser() {
        return advertiser;
    }

    public void setAdvertiser(String advertiser) {
        this.advertiser = advertiser;
    }

    public String getProduct() {
        return product;
    }

    public void setProduct(String product) {
        this.product = product;
    }

    public String getCampaign() {
        return campaign;
    }

    public void setCampaign(String campaign) {
        this.campaign = campaign;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getClockNumber() {
        return clockNumber;
    }

    public void setClockNumber(String clockNumber) {
        this.clockNumber = clockNumber;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public String getSpec() {
        return spec;
    }

    public void setSpec(String spec) {
        this.spec = spec;
    }

    public QcDestination[] getDestinations() {
        return destinations;
    }

    public void setDestinations(QcDestination[] destinations) {
        this.destinations = destinations;
    }

    public Boolean getAdbanked() {
        return adbanked;
    }

    public void setAdbanked(Boolean adbanked) {
        this.adbanked = adbanked;
    }

    public Boolean getDefaultAdbanked() {
        return default_adbanked;
    }

    public void setDefaultAdbanked(Boolean default_adbanked) {
        this.default_adbanked = default_adbanked;
    }
}