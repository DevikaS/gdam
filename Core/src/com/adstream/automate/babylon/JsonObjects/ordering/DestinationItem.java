package com.adstream.automate.babylon.JsonObjects.ordering;

import com.adstream.automate.babylon.JsonObjects.CustomMetadata;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 20.09.13
 * Time: 18:50
 */
public class DestinationItem {
    private String name;
    private String[] viewStatus;
    private Boolean isCommentMandatory;
    private String[] id;
    private ServiceLevel serviceLevel;
    private String[] statusId;
    private String countryCode;
    private String utcOffset;
    private String status;
    private String comment;
    private String destinationStatusId;
    private String commentStorageID;
    // for confirmed order
    private String qcAssetId;
    // after success replicate order in a4
    private String a4Id;
    private String approvalStatus;

    public DestinationItem(CustomMetadata cm) {
        setA4Id(cm.getString("a4Id"));
        setName(cm.getString("name"));
        setViewStatus(cm.getStringArray("viewStatus"));
        setIsCommentMandatory(cm.getBoolean("isCommentMandatory"));
        setId(cm.getStringArray("id"));
        setServiceLevel(cm.getForClass("serviceLevel", ServiceLevel.class));
        setStatusId(cm.getStringArray("statusId"));
        setCountryCode(cm.getString("countryCode"));
        setStatus(cm.getString("status"));
        setComment(cm.getString("comment"));
        setDestinationStatusId(cm.getString("destinationStatusId"));
        setCommentStorageID(cm.getString("commentStorageID"));
        setUtcOffset(cm.getString("utcOffset"));
        setQcAssetId(cm.getString("qcAssetId"));
        setApprovalStatus(cm.getString("approvalStatus"));
    }

    public String getA4Id() {
        return a4Id;
    }

    public void setA4Id(String a4Id) {
        this.a4Id = a4Id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String[] getViewStatus() {
        return viewStatus;
    }

    public void setViewStatus(String[] viewStatus) {
        this.viewStatus = viewStatus;
    }

    public Boolean isCommentMandatory() {
        return isCommentMandatory;
    }

    public void setIsCommentMandatory(Boolean isCommentMandatory) {
        this.isCommentMandatory = isCommentMandatory;
    }

    public String[] getId() {
        return id;
    }

    public void setId(String[] id) {
        this.id = id;
    }

    public ServiceLevel getServiceLevel() {
        return serviceLevel;
    }

    public void setServiceLevel(ServiceLevel serviceLevel) {
        this.serviceLevel = serviceLevel;
    }

    public String[] getStatusId() {
        return statusId;
    }

    public void setStatusId(String[] statusId) {
        this.statusId = statusId;
    }

    public String getCountryCode() {
        return countryCode;
    }

    public void setCountryCode(String countryCode) {
        this.countryCode = countryCode;
    }

    public String getUtcOffset() {
        return utcOffset;
    }

    public void setUtcOffset(String utcOffset) {
        this.utcOffset = utcOffset;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getDestinationStatusId() {
        return destinationStatusId;
    }

    public void setDestinationStatusId(String destinationStatusId) {
        this.destinationStatusId = destinationStatusId;
    }

    public String getCommentStorageID() {
        return commentStorageID;
    }

    public void setCommentStorageID(String commentStorageID) {
        this.commentStorageID = commentStorageID;
    }

    public String getQcAssetId() {
        return qcAssetId;
    }

    public void setQcAssetId(String qcAssetId) {
        this.qcAssetId = qcAssetId;
    }

    public String getApprovalStatus() {
        return approvalStatus;
    }

    public void setApprovalStatus(String approvalStatus) {
        this.approvalStatus = approvalStatus;
    }
}