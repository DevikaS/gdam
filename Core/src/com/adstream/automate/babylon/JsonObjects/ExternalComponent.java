package com.adstream.automate.babylon.JsonObjects;

/*
 * Created by demidovskiy-r on 03.10.2014.
 */
public class ExternalComponent {
    private String name;
    private Integer responseTimeInMillis;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getResponseTimeInMillis() {
        return responseTimeInMillis;
    }

    public void setResponseTimeInMillis(Integer responseTimeInMillis) {
        this.responseTimeInMillis = responseTimeInMillis;
    }
}