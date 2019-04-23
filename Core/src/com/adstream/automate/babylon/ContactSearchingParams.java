package com.adstream.automate.babylon;

/**
 * User: ruslan.semerenko
 * Date: 06.07.12 14:16
 */
public class ContactSearchingParams extends SearchingParams {
    private Boolean group = null;
    private String firstName = null;
    private String lastName = null;
    private String email = null;
    private String groupName = null;

    public Boolean getGroup() {
        return group;
    }

    public ContactSearchingParams setGroup(Boolean group) {
        this.group = group;
        return this;
    }

    public String getFirstName() {
        return firstName;
    }

    public ContactSearchingParams setFirstName(String firstName) {
        this.firstName = firstName;
        return this;
    }

    public String getLastName() {
        return lastName;
    }

    public ContactSearchingParams setLastName(String lastName) {
        this.lastName = lastName;
        return this;
    }

    public String getEmail() {
        return email;
    }

    public ContactSearchingParams setEmail(String email) {
        this.email = email;
        return this;
    }

    public String getGroupName() {
        return groupName;
    }

    public ContactSearchingParams setGroupName(String groupName) {
        this.groupName = groupName;
        return this;
    }
}
