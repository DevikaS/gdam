package com.adstream.automate.babylon.performance.config;

import java.util.HashMap;
import java.util.Map;

/**
 * User: ruslan.semerenko
 * Date: 22.06.12 18:19
 */
public class TestThreadGroup {
    private String destination;
    private String testClass;
    private Integer weight;
    private Map<String, String> params;

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public String getTestClass() {
        return testClass;
    }

    public void setTestClass(String testClass) {
        this.testClass = testClass;
    }

    public int getWeight() {
        if (weight == null) {
            weight = 1;
        }
        return weight;
    }

    public void setWeight(int weight) {
        this.weight = weight;
    }

    public Map<String, String> getParams() {
        if (params == null) {
            params = new HashMap<String, String>();
        }
        return params;
    }

    public void setParams(Map<String, String> params) {
        this.params = params;
    }
}
