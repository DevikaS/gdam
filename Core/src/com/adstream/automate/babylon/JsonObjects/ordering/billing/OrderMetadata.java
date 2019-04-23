package com.adstream.automate.babylon.JsonObjects.ordering.billing;

/*
 * Created by demidovskiy-r on 07.07.2014.
 */
public class OrderMetadata {
    private String JobNumber;
    private String PONumber;

    public String getJobNumber() {
        return JobNumber;
    }

    public void setJobNumber(String jobNumber) {
        JobNumber = jobNumber;
    }

    public String getPONumber() {
        return PONumber;
    }

    public void setPONumber(String PONumber) {
        this.PONumber = PONumber;
    }
}