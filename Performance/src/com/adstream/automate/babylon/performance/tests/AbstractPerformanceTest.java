package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.BabylonService;
import com.adstream.automate.babylon.PaperPusherService;
import com.adstream.automate.babylon.core.BabylonCoreService;
import com.adstream.automate.babylon.middleware.BabylonMiddlewareService;
import com.adstream.automate.utils.Gen;
import org.apache.log4j.Logger;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * User: ruslan.semerenko
 * Date: 15.06.12 18:14
 */
public abstract class AbstractPerformanceTest {
    protected final Logger log = Logger.getLogger(this.getClass());
    private Map<String, String> params = new HashMap<>();
    private BabylonService service;
    private PaperPusherService paperPusherService;
    private Boolean isCoreService;
    private int waitBeforeIterationMin = 0;
    private int waitBeforeIterationMax = 0;
    protected Map<String, Long> partialTimes = new LinkedHashMap<>();

    public abstract void runOnce();
    public abstract void beforeStart();
    public abstract void start();
    public abstract void afterRun();

    public final String getParam(String param) {
        return params.get(param);
    }

    public final int getParamInt(String param) {
        try {
            return Integer.parseInt(getParam(param));
        } catch (Exception e) {
            return 0;
        }
    }

    public final boolean getParamBoolean(String param) {
        try {
            return Boolean.parseBoolean(getParam(param));
        } catch (Exception e) {
            return false;
        }
    }

    public final void addParams(Map<String, String> params) {
        this.params.putAll(params);
    }

    public BabylonService getService() {
        return service;
    }

    public void setService(BabylonService service) {
        this.service = service;
    }

    public PaperPusherService getPaperPusherService() {
        return paperPusherService;
    }

    public void setPaperPusherService(PaperPusherService paperPusherService) {
        this.paperPusherService = paperPusherService;
    }

    public BabylonMiddlewareService getBabylonMiddlewareService() {
        return (BabylonMiddlewareService) getService();
    }

    public Boolean isCoreService() {
        if (isCoreService == null) {
            isCoreService = service instanceof BabylonCoreService;
        }
        return isCoreService;
    }

    public final void fail(String message) {
        throw new RuntimeException(message);
    }

    public void resetPartialTimes() {
        partialTimes = new LinkedHashMap<>();
    }

    public Map<String, Long> getPartialTimes() {
        return partialTimes;
    }

    protected void setPartialTimes(Map<String, Long> partialTimes) {
        this.partialTimes = partialTimes;
    }

    protected void addPartialTime(String name, long time) {
        partialTimes.put(name, time);
    }

    public int getWaitBeforeIteration() {
        if (waitBeforeIterationMin >= 0 && waitBeforeIterationMin < waitBeforeIterationMax) {
            return Gen.getInt(waitBeforeIterationMin, waitBeforeIterationMax);
        }
        return 0;
    }
}