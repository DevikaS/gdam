package com.adstream.automate.babylon.JsonObjects.mediamanager;

/**
 * Created by Saritha.Dhanala on 19/02/2018.
 */
public class JobInfo {
    private String duration;

    private String totalWarnings;

    private String start;

    private String status;

    private String totalErrors;

    private String end;

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public String getTotalWarnings() {
        return totalWarnings;
    }

    public void setTotalWarnings(String totalWarnings) {
        this.totalWarnings = totalWarnings;
    }

    public String getStart() {
        return start;
    }

    public void setStart(String start) {
        this.start = start;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getTotalErrors() {
        return totalErrors;
    }

    public void setTotalErrors(String totalErrors) {
        this.totalErrors = totalErrors;
    }

    public String getEnd() {
        return end;
    }

    public void setEnd(String end) {
        this.end = end;
    }
}
