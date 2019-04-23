package com.adstream.automate.babylon.migration.tests.data;

import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/6/14
 * Time: 12:15 PM

 */
public class TestBugInfo {
    private String a4Id;
    private String a5Id;
    private String uniqueName;
    private String status;
    private boolean isBug;
    private List<String> reasons;
    private long logTime;

    public String getA4Id() {
        return a4Id;
    }

    public void setA4Id(String a4Id) {
        this.a4Id = a4Id;
    }

    public String getA5Id() {
        return a5Id;
    }

    public void setA5Id(String a5Id) {
        this.a5Id = a5Id;
    }

    public String getUniqueName() {
        return uniqueName;
    }

    public void setUniqueName(String uniqueName) {
        this.uniqueName = uniqueName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List<String> getReasons() {
        return reasons;
    }

    public void setReasons(List<String> reasons) {
        this.reasons = reasons;
    }

    public boolean isBug() {
        return isBug;
    }

    public void setBug(boolean bug) {
        isBug = bug;
    }

    public void addReason(String value) {
        if (reasons == null)
            reasons = new ArrayList<>();
        reasons.add(value);
    }

    public long getLogTime() {
        return logTime;
    }

    public void setLogTime(long logTime) {
        this.logTime = logTime;
    }
}
