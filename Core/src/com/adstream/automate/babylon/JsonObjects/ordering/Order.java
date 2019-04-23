package com.adstream.automate.babylon.JsonObjects.ordering;

import com.adstream.automate.babylon.JsonObjects.BaseObject;
import com.adstream.automate.babylon.JsonObjects.CustomMetadata;
import com.adstream.automate.babylon.JsonObjects.User;
import org.joda.time.DateTime;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 12.08.13
 * Time: 19:41
 */
public class Order extends BaseObject {
    private String assignee;
    private CustomMetadata _cm;
    private User submittedBy;
    private Boolean onHold;
    private CustomMetadata assetsSummary;
    private CustomMetadata lastError;
    private String[] status;
    private String submitter;
    private Deliverable deliverables;
    private Integer orderReference;
    private User assignedTo;
    // for confirmed order
    private DateTime submitted;

    public String getAssignee() {
        return assignee;
    }

    public void setAssignee(String assignee) {
        this.assignee = assignee;
    }

    public User getSubmittedBy() {
        return submittedBy;
    }

    public void setSubmittedBy(User submittedBy) {
        this.submittedBy = submittedBy;
    }

    public Boolean isOnHold() {
        return onHold;
    }

    public void setOnHold(Boolean onHold) {
        this.onHold = onHold;
    }

    public String[] getStatus() {
        return status;
    }

    public void setStatus(String[] status) {
        this.status = status;
    }

    public String getSubmitter() {
        return submitter;
    }

    public void setSubmitter(String submitter) {
        this.submitter = submitter;
    }

    public Deliverable getDeliverables() {
        return deliverables;
    }

    public void setDeliverables(Deliverable deliverables) {
        this.deliverables = deliverables;
    }

    public Integer getOrderReference() {
        return orderReference;
    }

    public void setOrderReference(Integer orderReference) {
        this.orderReference = orderReference;
    }

    public User getAssignedTo() {
        return assignedTo;
    }

    public void setAssignedTo(User assignedTo) {
        this.assignedTo = assignedTo;
    }

    public DateTime getSubmitted() {
        return submitted;
    }

    public void setSubmitted(DateTime submitted) {
        this.submitted = submitted;
    }

     /*
    * Custom metadata assetsSummary fields
    */

    public Integer getAssetsTotal() {
        return getAssetsSummary().getInteger("assetsTotal");
    }

    public void setAssetsSummary(Integer assetsTotal) {
        getAssetsSummary().put("assetsTotal", assetsTotal);
    }

    public NotIngestedAsset[] getNotIngestedAssets() {
        return getAssetsSummary().getArrayForClass("notIngestedAssets", NotIngestedAsset.class);
    }

    public void setNotIngestedAssets(NotIngestedAsset[] notIngestedAssets) {
        getAssetsSummary().put("notIngestedAssets", notIngestedAssets);
    }

    public Integer getNotIngestTotal() {
        return getAssetsSummary().getInteger("notIngestedTotal");
    }

    public void setNotIngestTotal(String notIngestedTotal) {
        getAssetsSummary().put("notIngestedTotal", notIngestedTotal);
    }

    /*
    * Custom metadata lastError fields
    */

    public Integer getStatusCodeError() {
        return getLastError().getInteger("statusCode");
    }

    public String getMessageError() {
        return getLastError().getString("message");
    }

    public String getStackTraceError() {
        return getLastError().getString("stackTrace");
    }

     /*
    * Custom metadata billing fields
    */

    public String[] getBillingBuId() {
        return getCmBillingBu().getStringArray("id");
    }

    public void setBillingBuId(String[] id) {
        getCmBillingBu().put("id", id);
    }

    public String getBillingBuName() {
        return getCmBillingBu().getString("name");
    }

    public void setBillingBuName(String name) {
        getCmBillingBu().put("name", name);
    }

    /*
    * Custom metadata Tv fields
    */

    public String getTvMarket() {
        return getCmTV().getString("market");
    }

    public void setTvMarket(String tvMarket) {
        getCmTV().put("market", tvMarket);
    }

    public String getTvMarketCountry() {
        return getCmTV().getString("marketCountry");
    }

    public void setTvMarketCountry(String marketCountry) {
        getCmTV().put("marketCountry", marketCountry);
    }

    public String[] getTVMarketId() {
        return getCmTV().getStringArray("marketId");
    }

    public void setTVMarketId(String[] marketId) {
        getCmTV().put("marketId", marketId);
    }

    public Integer getCountTvAtDestination() {
        return getCmTV().getInteger("atDestination");
    }

    public Integer getCountTvCanceled() {
        return getCmTV().getInteger("cancelled");
    }

    /*
    * Custom metadata common fields only for complete orders
    */
    public String getJobNumber() {
        return getCmCommon().getString("jobNumber");
    }

    public void setJobNumber(String jobNumber) {
        getCmCommon().put("jobNumber", jobNumber);
    }

    public String getPoNumber() {
        return getCmCommon().getString("poNumber");
    }

    public void setPoNumber(String poNumber) {
        getCmCommon().put("poNumber", poNumber);
    }

    public String getPin() {
        return getCmCommon().getString("pin");
    }

    public void setPin(String pin) {
        getCmCommon().put("pin", pin);
    }

    public Boolean getNotifyAboutDelivery() {
        return getCmCommon().getBoolean("notifyAboutDelivery");
    }

    public void setNotifyAboutDelivery(boolean notifyAboutDelivery) {
        getCmCommon().put("notifyAboutDelivery", notifyAboutDelivery);
    }

    public Boolean getNotifyAboutQc() {
        return getCmCommon().getBoolean("notifyAboutQc");
    }

    public void setNotifyAboutQc(boolean notifyAboutQc) {
        getCmCommon().put("notifyAboutQc", notifyAboutQc);
    }

    public Boolean getHandleStandardsConversions() {
        return getCmCommon().getBoolean("handleStandardsConversions");
    }

    public void setHandleStandardsConversions(boolean handleStandardsConversions) {
        getCmCommon().put("handleStandardsConversions", handleStandardsConversions);
    }

    public String[] getNotificationEmails() {
        return getCmCommon().getStringArray("notificationEmails");
    }

    public void setNotificationEmails(String[] emails) {
        getCmCommon().put("notificationEmails", emails);
    }

    public Integer getAdbankLevelKey() {
        return getCmCommon().getInteger("adbankLevel");
    }

    public Boolean isAdbankLevelRenewable() {
        return getCmCommon().getBoolean("adbankLevelRenewable");
    }

    public void setAdbankLevelRenewable(boolean adbankLevelRenewable) {
        getCmCommon().put("adbankLevelRenewable", adbankLevelRenewable);
    }

     /*
    * Private helpers
    */

    public CustomMetadata getCm() {
        if (_cm == null) _cm = new CustomMetadata();
        return _cm;
    }

    private CustomMetadata getAssetsSummary() {
        if (assetsSummary == null) assetsSummary = new CustomMetadata();
        return assetsSummary;
    }

    private CustomMetadata getLastError() {
        if (lastError == null) lastError = new CustomMetadata();
        return lastError;
    }

    private CustomMetadata getCmTV() {
        return getCm().getOrCreateNode("tv");
    }

    private CustomMetadata getCmCommon() {
        return getCm().getOrCreateNode("common");
    }

    private CustomMetadata getCmBilling() {
        return getCm().getOrCreateNode("billing");
    }

    private CustomMetadata getCmBillingBu() {
        return getCmBilling().getOrCreateNode("bu");
    }
}