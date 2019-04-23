package com.adstream.automate.babylon.migration.json;

import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 7/7/14
 * Time: 11:36 AM

 */
public class Condition {
    private List<Map<String, FinalCondition>> must;
    private List<Map<String, FinalCondition>> must_not;
    private List<Map<String, FinalCondition>> should;

    public List<Map<String, FinalCondition>> getMust() {
        return must;
    }

    public void setMust(List<Map<String, FinalCondition>> must) {
        this.must = must;
    }

    public List<Map<String, FinalCondition>> getMust_not() {
        return must_not;
    }

    public void setMust_not(List<Map<String, FinalCondition>> must_not) {
        this.must_not = must_not;
    }

    public List<Map<String, FinalCondition>> getShould() {
        return should;
    }

    public void setShould(List<Map<String, FinalCondition>> should) {
        this.should = should;
    }
}
