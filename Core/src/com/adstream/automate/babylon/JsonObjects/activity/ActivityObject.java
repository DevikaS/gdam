package com.adstream.automate.babylon.JsonObjects.activity;

import com.adstream.automate.babylon.JsonObjects.Identity;

import java.util.List;

public class ActivityObject {
    private String id;
    private String name;
    private String type;
    private Identity agency;
    private List<String> parents;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Identity getAgency() {
        return agency;
    }

    public void setAgency(Identity agency) {
        this.agency = agency;
    }

    public List<String> getParents() {
        return parents;
    }

    public void setParents(List<String> parents) {
        this.parents = parents;
    }
}
