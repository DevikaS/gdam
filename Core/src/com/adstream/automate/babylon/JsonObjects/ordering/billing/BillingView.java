package com.adstream.automate.babylon.JsonObjects.ordering.billing;

/*
 * Created by demidovskiy-r on 04.07.2014.
 */
public class BillingView {
    private String TimeStamp;
    private String Agency;
    private String AgencyCountry;
    private String BillToCustomer;
    private String BillToCountry;
    private String A5OrderRef;
    private BillingItem[] Items;

    public String getTimeStamp() {
        return TimeStamp;
    }

    public void setTimeStamp(String timeStamp) {
        TimeStamp = timeStamp;
    }

    public String getAgency() {
        return Agency;
    }

    public void setAgency(String agency) {
        Agency = agency;
    }

    public String getAgencyCountry() {
        return AgencyCountry;
    }

    public void setAgencyCountry(String agencyCountry) {
        AgencyCountry = agencyCountry;
    }

    public String getBillToCustomer() {
        return BillToCustomer;
    }

    public void setBillToCustomer(String billToCustomer) {
        BillToCustomer = billToCustomer;
    }

    public String getBillToCountry() {
        return BillToCountry;
    }

    public void setBillToCountry(String billToCountry) {
        BillToCountry = billToCountry;
    }

    public String getA5OrderRef() {
        return A5OrderRef;
    }

    public void setA5OrderRef(String a5OrderRef) {
        A5OrderRef = a5OrderRef;
    }

    public BillingItem[] getItems() {
        return Items;
    }

    public void setItems(BillingItem[] items) {
        Items = items;
    }
}