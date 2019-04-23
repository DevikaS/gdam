package com.adstream.automate.babylon.JsonObjects.ordering;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 16.08.13
 * Time: 12:23
 */
public class OrderCounter {
    private String name;
    private int count;

    public String getStatus() {
        return name;
    }

    public void setStatus(String name) {
        this.name = name;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }
}