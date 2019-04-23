package com.adstream.automate.babylon.JsonObjects.ordering;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 05.09.13
 * Time: 14:15
 */
public class BaseSearchResult<T> {
    private String name;
    private List<T> values;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<T> getValues() {
        return values;
    }

    public void setValues(List<T> values) {
        this.values = values;
    }
}