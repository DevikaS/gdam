package com.adstream.automate.babylon.JsonObjects.activity;

public class Action {
    private String type;
    private ActionShare share;
    private String personalMessage;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public ActionShare getShare() {
        return share;
    }

    public void setShare(ActionShare share) {
        this.share = share;
    }

    public String getPersonalMessage() {
        return personalMessage;
    }

    public void setPersonalMessage(String personalMessage) {
        this.personalMessage = personalMessage;
    }
}
