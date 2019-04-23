package com.adstream.automate.babylon.tests.performance;

/**
 * User: ruslan.semerenko
 * Date: 16.07.13 21:18
 */
public class WorkflowActionPageStats {
    private String page;
    private long requestsCount;
    private long loadTime;

    public String getPage() {
        return page;
    }

    public void setPage(String page) {
        this.page = page;
    }

    public long getRequestsCount() {
        return requestsCount;
    }

    public void setRequestsCount(long requestsCount) {
        this.requestsCount = requestsCount;
    }

    public long getLoadTime() {
        return loadTime;
    }

    public void setLoadTime(long loadTime) {
        this.loadTime = loadTime;
    }
}
