package com.adstream.automate.babylon.performance.config;

import java.util.Map;

/**
 * User: ruslan.semerenko
 * Date: 22.06.12 18:18
 */
public class Test {
    private boolean enabled;
    private Boolean clearDatabase;
    private Boolean degradation;
    private Boolean complex;
    private boolean volume;
    private int desiredNumOfIterations;
    private Integer threadingDelay = 3000;
    private Integer threadingTestTimeSeconds = 0;
    private Integer responseTimeLimitSeconds = 0;
    private Map<String, TestThreadGroup> threadGroups;

    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    public Boolean isClearDatabase() {
        if (clearDatabase == null) {
            clearDatabase = false;
        }
        return clearDatabase;
    }

    public void setClearDatabase(Boolean clearDatabase) {
        this.clearDatabase = clearDatabase;
    }

    public Boolean isDegradation() {
        if (degradation == null) {
            degradation = false;
        }
        return degradation;
    }

    public void setDegradation(Boolean degradation) {
        this.degradation = degradation;
    }

    public boolean isComplex() {
        if (complex == null) {
            complex = false;
        }
        return complex;
    }

    public void setComplex(boolean complex) {
        this.complex = complex;
    }

    public Map<String, TestThreadGroup> getThreadGroups() {
        return threadGroups;
    }

    public void setThreadGroups(Map<String, TestThreadGroup> threadGroups) {
        this.threadGroups = threadGroups;
    }

    public boolean isVolume() {
        return volume;
    }

    public int getDesiredNumOfIterations() {
        return desiredNumOfIterations;
    }

    public Integer getThreadingDelay() {
        return threadingDelay;
    }

    public void setThreadingDelay(Integer threadingDelay) {
        this.threadingDelay = threadingDelay;
    }

    public Integer getThreadingTestTime() {
        return threadingTestTimeSeconds * 1000;
    }

    public void setThreadingTestTime(Integer threadingTestTimeSeconds) {
        this.threadingTestTimeSeconds = threadingTestTimeSeconds;
    }

    public Integer getResponseTimeLimitSeconds() {
        return responseTimeLimitSeconds;
    }

    public void setResponseTimeLimitSeconds(Integer responseTimeLimitSeconds) {
        this.responseTimeLimitSeconds = responseTimeLimitSeconds;
    }
}