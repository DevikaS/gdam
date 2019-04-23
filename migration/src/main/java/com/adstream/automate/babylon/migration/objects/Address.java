package com.adstream.automate.babylon.migration.objects;

import javax.xml.bind.annotation.XmlElement;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/7/13
 * Time: 7:37 PM

 */
public class Address {
    private String addressGUID;
    private String contactName;
    private String streetAddress1;
    private String suburb;
    private String state;
    private String postcode;
    private String country;
    private String sapModificationDate;

    @XmlElement(name = "AddressGUID")
    public String getAddressGUID() {
        return addressGUID;
    }

    public void setAddressGUID(String addressGUID) {
        this.addressGUID = addressGUID;
    }

    @XmlElement(name = "ContactName")
    public String getContactName() {
        return contactName;
    }

    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    @XmlElement(name = "StreetAddress1")
    public String getStreetAddress1() {
        return streetAddress1;
    }

    public void setStreetAddress1(String streetAddress1) {
        this.streetAddress1 = streetAddress1;
    }

    @XmlElement(name = "Suburb")
    public String getSuburb() {
        return suburb;
    }

    public void setSuburb(String suburb) {
        this.suburb = suburb;
    }

    @XmlElement(name = "State")
    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    @XmlElement(name = "Postcode")
    public String getPostcode() {
        return postcode;
    }

    public void setPostcode(String postcode) {
        this.postcode = postcode;
    }

    @XmlElement(name = "Country")
    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    @XmlElement(name = "SAPModificationDate")
    public String getSapModificationDate() {
        return sapModificationDate;
    }

    public void setSapModificationDate(String sapModificationDate) {
        this.sapModificationDate = sapModificationDate;
    }
}
