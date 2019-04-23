package com.adstream.automate.babylon.JsonObjects.traffic;

import com.adstream.automate.babylon.JsonObjects.TrafficBaseObject;

import java.util.List;

/**
 * Created by denysb on 27/06/2016.
 */
public class DeliveryItem extends TrafficBaseObject{
    private String broadcasterStatus;
    private String a4Id;
    private String onHold;
    private String orderId;
    private String orderItemId;
    private String qcAssetId;
    private String createdTimestamp;
    private ServiceLevel serviceLevel;
    private String destinationId;
    private List<Approval> approvals;
    private String name;
    private Details details;
    private String modifiedTimestamp;

    public class Approval{
        private String date;
        private String toStatus;
        private String fromStatus;
        private String approvalId;
        private String userName;
        private String message;
        private String userId;

        public String getDate() {
            return date;
        }

        public void setDate(String date) {
            this.date = date;
        }

        public String getToStatus() {
            return toStatus;
        }

        public void setToStatus(String toStatus) {
            this.toStatus = toStatus;
        }

        public String getFromStatus() {
            return fromStatus;
        }

        public void setFromStatus(String fromStatus) {
            this.fromStatus = fromStatus;
        }

        public String getApprovalId() {
            return approvalId;
        }

        public void setApprovalId(String approvalId) {
            this.approvalId = approvalId;
        }

        public String getUserName() {
            return userName;
        }

        public void setUserName(String userName) {
            this.userName = userName;
        }

        public String getMessage() {
            return message;
        }

        public void setMessage(String message) {
            this.message = message;
        }

        public String getUserId() {
            return userId;
        }

        public void setUserId(String userId) {
            this.userId = userId;
        }
    }

    public class Details{
        private String deliveryItemStatus;
        private String format;
        private String delivered;
        private String destinationStatus;
        private String a5ViewStatus;
        private String arrivalDate;

        public String getDeliveryItemStatus() {
            return deliveryItemStatus;
        }

        public void setDeliveryItemStatus(String deliveryItemStatus) {
            this.deliveryItemStatus = deliveryItemStatus;
        }

        public String getFormat() {
            return format;
        }

        public void setFormat(String format) {
            this.format = format;
        }

        public String getDelivered() {
            return delivered;
        }

        public void setDelivered(String delivered) {
            this.delivered = delivered;
        }

        public String getDestinationStatus() {
            return destinationStatus;
        }

        public void setDestinationStatus(String destinationStatus) {
            this.destinationStatus = destinationStatus;
        }

        public String getA5ViewStatus() {
            return a5ViewStatus;
        }

        public void setA5ViewStatus(String a5ViewStatus) {
            this.a5ViewStatus = a5ViewStatus;
        }

        public String getArrivalDate() {
            return arrivalDate;
        }

        public void setArrivalDate(String arrivalDate) {
            this.arrivalDate = arrivalDate;
        }
    }

    public class ServiceLevel{
        private Integer minutes;
        private String name;
        private String [] id;

        public Integer getMinutes() {
            return minutes;
        }

        public void setMinutes(Integer minutes) {
            this.minutes = minutes;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String[] getId() {
            return id;
        }

        public void setId(String[] id) {
            this.id = id;
        }
    }

    public String getBroadcasterStatus() {
        return broadcasterStatus;
    }

    public void setBroadcasterStatus(String broadcasterStatus) {
        this.broadcasterStatus = broadcasterStatus;
    }

    public String getA4Id() {
        return a4Id;
    }

    public void setA4Id(String a4Id) {
        this.a4Id = a4Id;
    }

    public String getOnHold() {
        return onHold;
    }

    public void setOnHold(String onHold) {
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

    public String getCreatedTimestamp() {
        return createdTimestamp;
    }

    public void setCreatedTimestamp(String createdTimestamp) {
        this.createdTimestamp = createdTimestamp;
    }

    public ServiceLevel getServiceLevel() {
        return serviceLevel;
    }

    public void setServiceLevel(ServiceLevel serviceLevel) {
        this.serviceLevel = serviceLevel;
    }

    public String getDestinationId() {
        return destinationId;
    }

    public void setDestinationId(String destinationId) {
        this.destinationId = destinationId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Details getDetails() {
        return details;
    }

    public void setDetails(Details details) {
        this.details = details;
    }

    public String getModifiedTimestamp() {
        return modifiedTimestamp;
    }

    public void setModifiedTimestamp(String modifiedTimestamp) {
        this.modifiedTimestamp = modifiedTimestamp;
    }

    public List<Approval> getApprovals() {
        return approvals;
    }

    public void setApprovals(List<Approval> approvals) {
        this.approvals = approvals;
    }
}
