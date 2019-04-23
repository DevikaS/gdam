package com.adstream.automate.babylon.JsonObjects.activity;

import com.adstream.automate.babylon.JsonObjects.Identity;

public class Subject {
    private String id;
    private String email;
    private String firstName;
    private String lastName;
    private String application;
    private Identity agency;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getApplication() {
        return application;
    }

    public void setApplication(String application) {
        this.application = application;
    }

    public Identity getAgency() {
        return agency;
    }

    public void setAgency(Identity agency) {
        this.agency = agency;
    }
}
