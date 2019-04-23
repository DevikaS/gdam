package com.adstream.automate.babylon.JsonObjects;

import org.joda.time.DateTime;

public class Recipient {
    private String email;
    private DateTime sent;

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public DateTime getSent() {
        return sent;
    }

    public void setSent(DateTime sent) {
        this.sent = sent;
    }
}
