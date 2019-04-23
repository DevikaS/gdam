package com.adstream.automate.babylon.JsonObjects.ordering.billing;

/*
 * Created by demidovskiy-r on 07.07.2014.
 */
public class Bill {
    private String TimeStamp;
    private String Operation;
    private String QUOTID;
    private Integer RelatedDoc;
    private String SLD;
    private OrderMetadata OrderMetaData;
    private ClockMetadata[] ClocksMetaData;

    public String getTimeStamp() {
        return TimeStamp;
    }

    public void setTimeStamp(String timeStamp) {
        TimeStamp = timeStamp;
    }

    public String getOperation() {
        return Operation;
    }

    public void setOperation(String operation) {
        Operation = operation;
    }

    public String getQUOTID() {
        return QUOTID;
    }

    public void setQUOTID(String QUOTID) {
        this.QUOTID = QUOTID;
    }

    public Integer getRelatedDoc() {
        return RelatedDoc;
    }

    public void setRelatedDoc(Integer relatedDoc) {
        RelatedDoc = relatedDoc;
    }

    public String getSLD() {
        return SLD;
    }

    public void setSLD(String SLD) {
        this.SLD = SLD;
    }

    public OrderMetadata getOrderMetaData() {
        return OrderMetaData;
    }

    public void setOrderMetaData(OrderMetadata orderMetaData) {
        OrderMetaData = orderMetaData;
    }

    public ClockMetadata[] getClocksMetaData() {
        return ClocksMetaData;
    }

    public void setClocksMetaData(ClockMetadata[] clocksMetaData) {
        ClocksMetaData = clocksMetaData;
    }
}