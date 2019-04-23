package com.adstream.automate.babylon.JsonObjects.ordering;

import com.adstream.automate.babylon.JsonObjects.CustomMetadata;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 04.09.13
 * Time: 14:24
 */
public class Destination {
    private String key;
    private String name;
    private String marketId;
    private String destinationName;
    private String subGroup;
    private Integer subGroupPriority;
    private CustomMetadata bcData;
    private Boolean holdForApproval;
    private Boolean visible;
    private Boolean allowChannelsDelivery;
    private Integer statusId;
    private String defaultSourceMediaFormat;
    private String targetSourceMediaFormat;
    private Boolean allowMultiSourceMediaFormat;
    private Integer commentStorageID;
    private Boolean isCommentMandatory;
    private Boolean isIPTV;
    private String countryCode;
    private CustomMetadata metadata;
    private Destination map;
    private List<ServiceLevel> values;

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMarketId() {
        return marketId;
    }

    public void setMarketId(String marketId) {
        this.marketId = marketId;
    }

    public String getDestinationName() {
        return destinationName;
    }

    public void setDestinationName(String destinationName) {
        this.destinationName = destinationName;
    }

    public String getSubGroup() {
        return subGroup;
    }

    public void setSubGroup(String subGroup) {
        this.subGroup = subGroup;
    }

    public Integer getSubGroupPriority() {
        return subGroupPriority;
    }

    public void setSubGroupPriority(Integer subGroupPriority) {
        this.subGroupPriority = subGroupPriority;
    }

    public Boolean getHoldForApproval() {
        return holdForApproval;
    }

    public void setHoldForApproval(Boolean holdForApproval) {
        this.holdForApproval = holdForApproval;
    }

    public Boolean getVisible() {
        return visible;
    }

    public void setVisible(Boolean visible) {
        this.visible = visible;
    }

    public Boolean getAllowChannelsDelivery() {
        return allowChannelsDelivery;
    }

    public void setAllowChannelsDelivery(Boolean allowChannelsDelivery) {
        this.allowChannelsDelivery = allowChannelsDelivery;
    }

    public Integer getStatusId() {
        return statusId;
    }

    public void setStatusId(Integer statusId) {
        this.statusId = statusId;
    }

    public String getDefaultSourceMediaFormat() {
        return defaultSourceMediaFormat;
    }

    public void setDefaultSourceMediaFormat(String defaultSourceMediaFormat) {
        this.defaultSourceMediaFormat = defaultSourceMediaFormat;
    }

    public String getTargetSourceMediaFormat() {
        return targetSourceMediaFormat;
    }

    public void setTargetSourceMediaFormat(String targetSourceMediaFormat) {
        this.targetSourceMediaFormat = targetSourceMediaFormat;
    }

    public Boolean getAllowMultiSourceMediaFormat() {
        return allowMultiSourceMediaFormat;
    }

    public void setAllowMultiSourceMediaFormat(Boolean allowMultiSourceMediaFormat) {
        this.allowMultiSourceMediaFormat = allowMultiSourceMediaFormat;
    }

    public Integer getCommentStorageID() {
        return commentStorageID;
    }

    public void setCommentStorageID(Integer commentStorageID) {
        this.commentStorageID = commentStorageID;
    }

    public Boolean isCommentMandatory() {
        return isCommentMandatory;
    }

    public void setIsCommentMandatory(Boolean isCommentMandatory) {
        this.isCommentMandatory = isCommentMandatory;
    }

    public Boolean isIPTV() {
        return isIPTV;
    }

    public void setIsIPTV(Boolean isIPTV) {
        this.isIPTV = isIPTV;
    }

    public String getCountryCode() {
        return countryCode;
    }

    public void setCountryCode(String countryCode) {
        this.countryCode = countryCode;
    }

    public Destination getMap() {
        return map;
    }

    public void setMap(Destination map) {
        this.map = map;
    }

    public List<ServiceLevel> getServiceLevelValues() {
        return values;
    }

    public void setServiceLevelValues(List<ServiceLevel> values) {
        this.values = values;
    }

    // destinations bcData
    public Boolean isBc() {
        return getBcData().getBoolean("isBc");
    }

    public void setIsBc(Boolean isBc) {
        getBcData().put("isBc", isBc);
    }

    // destinations metadata
    public String getMarket() {
        return getMetadata().getString("market");
    }

    public void setMarket(String market) {
        getMetadata().put("market", market);
    }

    public String getSystemCode() {
        return getMetadata().getString("systemCode");
    }

    public void setSystemCode(String systemCode) {
        getMetadata().put("systemCode", systemCode);
    }

    public String getDeliveryType() {
        return getMetadata().getString("deliveryType");
    }

    public void setDeliveryType(String deliveryType) {
        getMetadata().put("deliveryType", deliveryType);
    }

    public String getDestinationType() {
        return getMetadata().getString("destinationType");
    }

    public void setDestinationType(String destinationType) {
        getMetadata().put("destinationType", destinationType);
    }

     /*
    * Private helpers
    */

    private CustomMetadata getMetadata() {
        if (metadata == null) metadata = new CustomMetadata();
        return metadata;
    }

    private CustomMetadata getBcData() {
        if (bcData == null) bcData = new CustomMetadata();
        return bcData;
    }
}