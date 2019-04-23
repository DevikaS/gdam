package com.adstream.automate.babylon.sut.pages.ordering.elements;

/*
 * Created by demidovskiy-r on 13.03.14.
 */
public enum DestinationStatus {
    ORDER_PLACED("Order Placed"),
    RECEIVED_MEDIA("Received Media"),
    PASSED_QC("Passed QC"),
    TRANSFERRING("Transferring"),
    AT_DESTINATION("At Destination");

    private String status;

    private DestinationStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return status;
    }

    public static DestinationStatus findByStatus(String status) {
        for (DestinationStatus destinationStatus : values())
            if (destinationStatus.toString().equals(status))
                return destinationStatus;
        throw new IllegalArgumentException("Unknown destination status: " + status);
    }
}