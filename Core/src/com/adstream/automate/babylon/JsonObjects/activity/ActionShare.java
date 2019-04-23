package com.adstream.automate.babylon.JsonObjects.activity;

import java.util.List;

public class ActionShare {
    private String type;
    private List<Subject> to;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public List<Subject> getTo() {
        return to;
    }

    public void setTo(List<Subject> to) {
        this.to = to;
    }
}
