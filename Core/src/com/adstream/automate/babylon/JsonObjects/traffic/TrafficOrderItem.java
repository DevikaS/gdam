package com.adstream.automate.babylon.JsonObjects.traffic;

import com.adstream.automate.babylon.JsonObjects.CustomMetadata;
import com.adstream.automate.babylon.JsonObjects.TrafficBaseObject;

import java.util.List;

/**
 * Created by denysb on 27/06/2016.
 */
public class TrafficOrderItem extends TrafficBaseObject {

    private OrderItemMetadata metadata;
    private Boolean onHold;
    private String orderId;
    private String orderItemId;
    private String qcAssetId;
    private String created;
    private String duration;
    private List<DeliveryItem> deliveryItems;
    private String clockNumber;
    private TrafficOrderItemDetails orderItemDetails;
    private String modified;
    private Asset asset;
    private String status;

    public class Asset {
        private String adDurationInTime;
        private String formatGeneral;
        private String adDurationInFrames;
        private String aspectRatio;
        private String ingestedDateTime;

        public String getAdDurationInTime() {
            return adDurationInTime;
        }

        public void setAdDurationInTime(String adDurationInTime) {
            this.adDurationInTime = adDurationInTime;
        }

        public String getFormatGeneral() {
            return formatGeneral;
        }

        public void setFormatGeneral(String formatGeneral) {
            this.formatGeneral = formatGeneral;
        }

        public String getAdDurationInFrames() {
            return adDurationInFrames;
        }

        public void setAdDurationInFrames(String adDurationInFrames) {
            this.adDurationInFrames = adDurationInFrames;
        }

        public String getAspectRatio() {
            return aspectRatio;
        }

        public void setAspectRatio(String aspectRatio) {
            this.aspectRatio = aspectRatio;
        }

        public String getIngestedDateTime() {
            return ingestedDateTime;
        }

        public void setIngestedDateTime(String ingestedDateTime) {
            this.ingestedDateTime = ingestedDateTime;
        }
    }

    public OrderItemMetadata getMetadata() {
        return metadata;
    }

    public void setMetadata(OrderItemMetadata metadata) {
        this.metadata = metadata;
    }

    public Boolean getOnHold() {
        return onHold;
    }

    public void setOnHold(Boolean onHold) {
        this.onHold = onHold;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getOrderItemId() {
        return orderItemId;
    }

    public void setOrderItemId(String orderItemId) {
        this.orderItemId = orderItemId;
    }

    public String getQcAssetId() {
        return qcAssetId;
    }

    public void setQcAssetId(String qcAssetId) {
        this.qcAssetId = qcAssetId;
    }

    public String getCreated() {
        return created;
    }

    public void setCreated(String created) {
        this.created = created;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public TrafficOrderItemDetails getOrderItemDetails() {
        return orderItemDetails;
    }

    public void setOrderItemDetails(TrafficOrderItemDetails orderItemDetails) {
        this.orderItemDetails = orderItemDetails;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List <DeliveryItem> getDeliveryItem() {
        return deliveryItems;
    }

    public void setDeliveryItem(List <DeliveryItem> deliveryItem) {
        this.deliveryItems = deliveryItem;
    }

    public String getClockNumber() {
        return clockNumber;
    }

    public void setClockNumber(String clockNumber) {
        this.clockNumber = clockNumber;
    }

    public String getModified() {
        return modified;
    }

    public void setModified(String modified) {
        this.modified = modified;
    }

    public Asset getAsset() {
        return asset;
    }

    public void setAsset(Asset asset) {
        this.asset = asset;
    }
}
