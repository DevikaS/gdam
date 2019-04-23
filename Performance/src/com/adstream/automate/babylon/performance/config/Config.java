package com.adstream.automate.babylon.performance.config;

import java.util.Map;

/**
 * User: ruslan.semerenko
 * Date: 12.07.12 11:08
 */
public class Config {
    private int threadingTestTimeSeconds;
    private int degradationTestTimeMinutes;
    private int complexIterationTimeSeconds;
    private int responseTimeLimitSeconds;
    private int maxThread;
    private int startWithIteration;
    private String mongoDbHost;
    private int mongoDbPort;
    private String elasticSearchHost;
    private int elasticSearchPort;
    private Map<String, String> globalParams;
    private Map<String, Destination> destinations;
    private Map<String, Test> tests;
    private String snapshotPath;

    public int getThreadingTestTime() {
        return threadingTestTimeSeconds * 1000;
    }

    public void setThreadingTestTime(int threadingTestTime) {
        this.threadingTestTimeSeconds = threadingTestTime / 1000;
    }

    public int getDegradationTestTime() {
        return degradationTestTimeMinutes * 60000;
    }

    public void setDegradationTestTime(int degradationTestTime) {
        this.degradationTestTimeMinutes = degradationTestTime / 60000;
    }

    public int getComplexIterationTime() {
        return complexIterationTimeSeconds * 1000;
    }

    public void setComplexIterationTime(int complexIterationTime) {
        this.complexIterationTimeSeconds = complexIterationTime / 1000;
    }

    public int getResponseTimeLimitSeconds() {
        return responseTimeLimitSeconds;
    }

    public void setResponseTimeLimitSeconds(int responseTimeSeconds) {
        this.responseTimeLimitSeconds = responseTimeSeconds;
    }

    public int getMaxThread() {
        return maxThread;
    }

    public void setMaxThread(int maxThread) {
        this.maxThread = maxThread;
    }

    public int getStartWithIteration() {
        return startWithIteration;
    }

    public void setStartWithIteration(int startWithIteration) {
        this.startWithIteration = startWithIteration;
    }

    public String getMongoDbHost() {
        return mongoDbHost;
    }

    public void setMongoDbHost(String mongoDbHost) {
        this.mongoDbHost = mongoDbHost;
    }

    public int getMongoDbPort() {
        return mongoDbPort;
    }

    public void setMongoDbPort(int mongoDbPort) {
        this.mongoDbPort = mongoDbPort;
    }

    public String getElasticSearchHost() {
        return elasticSearchHost;
    }

    public void setElasticSearchHost(String elasticSearchHost) {
        this.elasticSearchHost = elasticSearchHost;
    }

    public int getElasticSearchPort() {
        return elasticSearchPort;
    }

    public void setElasticSearchPort(int elasticSearchPort) {
        this.elasticSearchPort = elasticSearchPort;
    }

    public Map<String, String> getGlobalParams() {
        return globalParams;
    }

    public void setGlobalParams(Map<String, String> globalParams) {
        this.globalParams = globalParams;
    }

    public Map<String, Destination> getDestinations() {
        return destinations;
    }

    public void setDestinations(Map<String, Destination> destinations) {
        this.destinations = destinations;
    }

    public Map<String, Test> getTests() {
        return tests;
    }

    public void setTests(Map<String, Test> tests) {
        this.tests = tests;
    }

    public String getSnapshotPath() {
        return snapshotPath;
    }

    public void setSnapshotPath(String snapshotPath) {
        this.snapshotPath = snapshotPath;
    }
}
