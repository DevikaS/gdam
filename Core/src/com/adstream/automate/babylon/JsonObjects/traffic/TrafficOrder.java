package com.adstream.automate.babylon.JsonObjects.traffic;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.JsonObjects.ordering.*;
import org.joda.time.DateTime;

import java.util.Date;
import java.util.List;

/**
 * Created by denysb on 24/06/2016.
 */
public class TrafficOrder extends TrafficBaseObject {

    private CustomMetadata metadata;
    private String orderId;
    private String orderReference;
    private Boolean onHold;
    private String [] status;
    private Agency agency;
    private User assignedTo;
    private User submittedBy;
    private User createdBy;
    private CustomMetadata orderDetails;
    private String submitted;
    private List<TrafficOrderItem> orderItems;
    private Asset [] assets;

    public Asset[] getAssets() {
        return assets;
    }

    public void setAssets(Asset[] assets) {
        this.assets = assets;
    }

    public String getOrderReference() {
        return orderReference;
    }

    public void setOrderReference(String orderReference) {
        this.orderReference = orderReference;
    }

    public String [] getStatus() {
        return status;
    }

    public void setStatus(String [] status) {
        this.status = status;
    }

    public Boolean getOnHold() {
        return onHold;
    }

    public void setOnHold(Boolean onHold) {
        this.onHold = onHold;
    }


    public String getSubmitted() {
        return submitted;
    }

    public void setSubmitted(String submitted) {
        this.submitted = submitted;
    }

    public User getSubmittedBy() {
        return submittedBy;
    }

    public void setSubmittedBy(User submittedBy) {
        this.submittedBy = submittedBy;
    }

    public User getAssignedTo() {
        return assignedTo;
    }

    public void setAssignedTo(User assignedTo) {
        this.assignedTo = assignedTo;
    }

    public Agency getAgency() {
        return agency;
    }

    public void setAgency(Agency agency) {
        this.agency = agency;
    }

    public User getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(User createdBy) {
        this.createdBy = createdBy;
    }


    private CustomMetadata getOrderDetails() {
        if (orderDetails == null) orderDetails = new CustomMetadata();
        return orderDetails;
    }

    /*
    * Custom metadata orderDetails fields
    */
    public Boolean getSubtitlesRequired(){
        return getOrderDetails().getBoolean("subtitlesRequired");
    }

    public void setSubtitleRequired(Boolean subtitlesRequired){
        getOrderDetails().put("subtitlesRequired",subtitlesRequired);
    }

    public String getServiceLevel(){
        return getOrderDetails().getString("serviceLevel");
    }

    public void setServiceLevel(String serviceLevel){
        getOrderDetails().put("serviceLevel",serviceLevel);
    }

    public String getMarketId(){
        return getOrderDetails().getString("marketId");
    }

    public void setMarketId(String marketId){
        getOrderDetails().put("marketId",marketId);
    }

    public String getMarket(){
        return getOrderDetails().getString("market");
    }

    public void setMarket(String market){
        getOrderDetails().put("market",market);
    }

    public String getMarketCountry(){
        return getOrderDetails().getString("marketCountry");
    }

    public void setMarketCountry(String marketCountry){
        getOrderDetails().put("marketCountry",marketCountry);
    }

    public String getPoNumber(){
        return getOrderDetails().getString("poNumber");
    }

    public void setPoNumber(String poNumber){
        getOrderDetails().put("poNumber",poNumber);
    }

    public String getJobNumber(){
        return getOrderDetails().getString("jobNumber");
    }

    public void setJobNumber(String jobNumber){
        getOrderDetails().put("jobNumber",jobNumber);
    }

    public String getIngestLocation(){
        return getOrderDetails().getString("ingestLocation");
    }

    public void setIngestLocation(String ingestLocation){
        getOrderDetails().put("ingestLocation",ingestLocation);
    }

    public Integer getServiceLevelMinutes(){
        return getOrderDetails().getInteger("serviceLevelMinutes");
    }

    public void setServiceLevelMinutes(String serviceLevelMinutes){
        getOrderDetails().put("serviceLevelMinutes",serviceLevelMinutes);
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public CustomMetadata getMetadata() {
        if (metadata == null) metadata = new CustomMetadata();
        return metadata;
    }

    public List<TrafficOrderItem> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List <TrafficOrderItem> orderItems) {
        this.orderItems = orderItems;
    }
}
