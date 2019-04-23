package com.adstream.automate.babylon.JsonObjects;

public class PublicShare extends BaseObject {
    private String objectRef;
    private String[] permissions;
    private Recipient[] recipients;
    private String token;

    public String getObjectRef() {
        return objectRef;
    }

    public void setObjectRef(String objectRef) {
        this.objectRef = objectRef;
    }

    public String[] getPermissions() {
        return permissions;
    }

    public void setPermissions(String[] permissions) {
        this.permissions = permissions;
    }

    public Recipient[] getRecipients() {
        return recipients;
    }

    public void setRecipients(Recipient[] recipients) {
        this.recipients = recipients;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }
}
