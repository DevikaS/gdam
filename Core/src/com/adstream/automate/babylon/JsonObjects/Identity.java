package com.adstream.automate.babylon.JsonObjects;

import java.util.Map;

/**
 * User: ruslan.semerenko
 * Date: 11.03.13 17:29
 */
public class Identity {
    private String id;
    private String name;

    public Identity() {}

    public Identity(String id, String name) {
        this.id = id;
        this.name = name;
    }

    public Identity(Map<String, String> map) {
        this(map.get("id"), map.get("name"));
    }

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
}
