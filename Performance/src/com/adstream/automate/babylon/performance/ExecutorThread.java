package com.adstream.automate.babylon.performance;

import com.adstream.automate.babylon.performance.tests.AbstractPerformanceTest;
import com.adstream.automate.utils.Common;
import org.apache.log4j.Logger;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * User: ruslan.semerenko
 * Date: 12.07.12 18:25
 */
public class ExecutorThread extends Thread {
    private Logger log = Logger.getLogger(ExecutorThread.class);
    private boolean once = false;
    private boolean process = true;
    private AbstractPerformanceTest test;
    private int counter = 0, counterError = 0;
    private long timeSpent = 0;
    private List<Map<String, Long>> partialTimes = new ArrayList<>();

    public ExecutorThread(AbstractPerformanceTest test) {
        this.test = test;
    }

    public ExecutorThread(AbstractPerformanceTest test, boolean isOnce) {
        this.test = test;
        once = isOnce;
    }

    public void run() {
        while (process) {
            if (once) {
                process = false;
            }
            try {
                Common.sleep(test.getWaitBeforeIteration());
                test.resetPartialTimes();
                long start = System.currentTimeMillis();
                test.start();
                timeSpent += System.currentTimeMillis() - start;
                partialTimes.add(test.getPartialTimes());
                counter++;
            } catch (Exception e) {
                if (counterError == 0) {
                    log.error(e.getMessage(), e);
                } else {
                    log.error(e.getMessage());
                }
                counterError++;
            }
        }
        test.afterRun();
    }

    @Override
    public void interrupt() {
        process = false;
    }

    public void prepareOnce() {
        test.runOnce();
    }

    public void prepare() {
        test.beforeStart();
    }

    public int getCounter() {
        return counter;
    }

    public int getCounterError() {
        return counterError;
    }

    public long getTimeSpent() {
        return timeSpent;
    }

    public List<Map<String, Long>> getPartialTimes() {
        return partialTimes;
    }

    public boolean isOnce() {
        return once;
    }

    public void setOnce(boolean once) {
        this.once = once;
    }
}
