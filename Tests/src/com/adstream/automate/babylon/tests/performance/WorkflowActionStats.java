package com.adstream.automate.babylon.tests.performance;

import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;

/**
 * User: ruslan.semerenko
 * Date: 17.07.13 13:16
 */
public class WorkflowActionStats {
    private Map<String, WorkflowActionPageStats> stats = new LinkedHashMap<String, WorkflowActionPageStats>();

    public void addStats(WorkflowActionPageStats pageStats) {
        stats.put(pageStats.getPage(), pageStats);
    }

    public Set<String> getPages() {
        return stats.keySet();
    }

    public WorkflowActionPageStats getForPage(String page) {
        return stats.get(page);
    }
}
