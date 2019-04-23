package com.adstream.automate.babylon.JsonObjects.traffic;

import com.adstream.automate.babylon.JsonObjects.TrafficBaseObject;

/**
 * Created by denysb on 27/06/2016.
 */
public class Agency extends TrafficBaseObject{

    private String name;
    private String country;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }
}
