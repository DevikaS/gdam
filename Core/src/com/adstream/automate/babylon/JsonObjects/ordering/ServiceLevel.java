package com.adstream.automate.babylon.JsonObjects.ordering;

import com.adstream.automate.babylon.JsonObjects.CustomMetadata;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 04.09.13
 * Time: 14:33
 */
public class ServiceLevel {
    private String key;
    private String name;
    private ServiceLevel map;
    private String[] values;
    // this field only for destination in order item
    private String[] id;

    public ServiceLevel(CustomMetadata cm) {
        setId(cm.getStringArray("id"));
        setName(cm.getString("name"));
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String[] getValues() {
        return values;
    }

    public void setValues(String[] values) {
        this.values = values;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public ServiceLevel getMap() {
        return map;
    }

    public void setMap(ServiceLevel map) {
        this.map = map;
    }

    public String[] getId() {
        return id;
    }

    public void setId(String[] id) {
        this.id = id;
    }
}