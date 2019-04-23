package com.adstream.automate.babylon.monitoring;

/**
 * User: ruslan.semerenko
 * Date: 24.07.13 19:07
 */
public class Assertion {
    private Integer size;
    private Integer sizeMin;
    private Integer sizeMax;
    private String name;

    public Integer getSize() {
        return size;
    }

    public void setSize(Integer size) {
        this.size = size;
    }

    public Integer getSizeMin() {
        return sizeMin;
    }

    public void setSizeMin(Integer sizeMin) {
        this.sizeMin = sizeMin;
    }

    public Integer getSizeMax() {
        return sizeMax;
    }

    public void setSizeMax(Integer sizeMax) {
        this.sizeMax = sizeMax;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
