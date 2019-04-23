package com.adstream.automate.babylon.JsonObjects.ordering.enums;

/*
 * Created by demidovskiy-r on 07.04.14.
 */
public enum AccountType {
    ADSTREAM("adstream", "Adstream", "http://www.adstream.com/uk/contact-us", "helpcentre@adstream.com"),
   // ADSTREAM_NORDIC("nordic", "Adstream", "http://www.adstream.com/uk/contact-us", "helpcentre@adstream.com"),
   ADSTREAM_NORDIC("nordic", "Adstream", "http://upload.adstreamnordic.nu", "helpcentre@adstream.com"),
    BEAM("beam", "Beam", "http://beam.tv/support", "support@beam.tv"),
    BEAM_AMV("beam amv", "Beam AMV", "", "amvbeamsuite@beam.tv");

    private String key;
    private String type;
    private String contactUrl;
    private String email;

    private AccountType(String key, String type, String contactUrl, String email) {
        this.key = key;
        this.type = type;
        this.contactUrl = contactUrl;
        this.email = email;
    }

    public String getKey() {
        return key;
    }

    @Override
    public String toString() {
        return type;
    }

    public String getContactUrl() {
        return contactUrl;
    }

    public String getEmail() {
        return email;
    }

    public static AccountType findByName(String name) {
        for (AccountType accountType: values())
            if (accountType.getKey().equalsIgnoreCase(name))
                return accountType;
        throw new IllegalArgumentException("Unknown account type: " + name);
    }
}