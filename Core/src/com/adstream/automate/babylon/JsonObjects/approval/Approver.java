package com.adstream.automate.babylon.JsonObjects.approval;

/**
 * User: ruslan.semerenko
 * Date: 19.06.13 20:16
 */
public class Approver {
    private String _id;
    private String email;
    private String firstName;
    private String fullName;
    private String lastName;
    private String agencyName;


    public String getId() {
        return _id;
    }

    public void setId(String id) {
        this._id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getAgencyName() {
        return agencyName;
    }

    public void setAgencyName(String agencyName) {
        this.agencyName = agencyName;
    }
}
