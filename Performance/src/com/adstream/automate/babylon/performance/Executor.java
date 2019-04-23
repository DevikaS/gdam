package com.adstream.automate.babylon.performance;

import com.adstream.automate.babylon.*;
import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.core.BabylonCoreService;
import com.adstream.automate.babylon.performance.config.*;
import com.adstream.automate.babylon.performance.report.*;
import com.adstream.automate.babylon.performance.report.impl.CsvReporter;
import com.adstream.automate.babylon.performance.report.impl.XmlReporter;
import com.adstream.automate.babylon.performance.tests.AbstractPerformanceTest;
import com.adstream.automate.babylon.performance.utils.TeamcityUtils;
import com.adstream.automate.utils.Common;
import com.google.gson.Gson;
import org.apache.commons.lang.exception.ExceptionUtils;
import org.apache.http.client.methods.HttpDelete;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.joda.time.Duration;
import org.joda.time.format.PeriodFormatter;
import org.joda.time.format.PeriodFormatterBuilder;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.*;

/**
 * User: ruslan_semerenko
 * Date: 15.06.12 17:45
 */
public class Executor {
    private static int MAX_THREADS;
    private static Logger log;
    private static Config config;
    private static List<Reporter> reports;
    private static BabylonCoreService coreService;
    private static PeriodFormatter formatter = new PeriodFormatterBuilder()
            .appendDays()
            .appendSuffix("d ")
            .appendHours()
            .appendSuffix("h ")
            .appendMinutes()
            .appendSuffix("m ")
            .appendSecondsWithOptionalMillis()
            .appendSuffix("s")
            .toFormatter();

    public static void main(String[] args) {
        String configFileName = args.length > 0 ? args[0] : "config.json";
        if (!loadConfig(configFileName))
            System.exit(1);
        execute();
        for (Reporter report : reports) report.writeReport();
    }

    private static boolean loadConfig(String configFileName) {
        try {
            PropertyConfigurator.configure("log4j.properties");
            log = Logger.getLogger(Executor.class);
            config = new Gson().fromJson(new FileReader(configFileName), Config.class);
            reports = new ArrayList<>();
            reports.add(new CsvReporter());
            MAX_THREADS = config.getMaxThread();
            Destination coreDestination = getCoreDestination();
            coreService = new BabylonCoreService(coreDestination.getUrl());
            if (coreDestination.isA5()) coreService.auth("admin", "abcdefghA1"); //"K33pKa1m09"

            reports.add(new XmlReporter(coreService));
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    private static void log(String message, Object... params) {
        String msg = String.format(message, params);
        log.info(msg);
    }

    private static void execute() {
        for (Map.Entry<String, Test> testEntry : config.getTests().entrySet()) {
            String testName = testEntry.getKey();
            Test test = testEntry.getValue();
            ReportTest reportTest = new ReportTest(testName, test.isEnabled());
            long start = System.currentTimeMillis();

            String teamcityTestName = TeamcityUtils.teamcityEscape(testName);
            try {
                if (!test.isEnabled()) {
                    log("Test '%s' is disabled", testName);
                    TeamcityUtils.teamcityLog("testIgnored name='" + teamcityTestName + "' message='disabled'");
                } else if (test.isComplex()) {
                    log("Begin complex test for '%s'", testName);
                    TeamcityUtils.teamcityLog("testStarted name='" + teamcityTestName + "' captureStandardOutput='true'");
                    TeamcityUtils.teamcityLog("progressMessage '" + teamcityTestName + "'");
                    testComplex(test, reportTest);
                } else if (test.isVolume()) {
                    log("Begin volume test for '%s'", testName);
                    TeamcityUtils.teamcityLog("testStarted name='" + teamcityTestName + "' captureStandardOutput='true'");
                    testVolume(test, reportTest);
                } else {
                    log("Begin threading test for '%s'", testName);
                    TeamcityUtils.teamcityLog("testStarted name='" + teamcityTestName + "' captureStandardOutput='true'");
                    TeamcityUtils.teamcityLog("progressMessage '" + teamcityTestName + "'");
                    int threadsCount = testThreading(test, reportTest);
                    log("Finished threading test for '%s' with best %d threads", testName, threadsCount);
                    TeamcityUtils.teamcityLog("progressMessage 'Finished threading test for '" + teamcityTestName + "' with best " + threadsCount + " threads'");
                    if (test.isDegradation()) {
                        log("Begin degradation test for '%s'", testName);
                        TeamcityUtils.teamcityLog("progressMessage 'Begin degradation test for '" + teamcityTestName + "''");
                        testDegradation(test, threadsCount, reportTest);
                        log("Finished degradation test for '%s'", testName);
                        TeamcityUtils.teamcityLog("progressMessage 'Finished degradation test for '" + teamcityTestName + "''");
                    }
                }
            } catch (Throwable e) {
                log(Common.exceptionToString(e));
                TeamcityUtils.teamcityLog("testFailed name='" + teamcityTestName + "' message='" + TeamcityUtils.teamcityEscape(e.getMessage()) + "' details='" + TeamcityUtils.teamcityEscape(ExceptionUtils.getFullStackTrace(e)) + "'");
            } finally {
                long end = System.currentTimeMillis();
                TeamcityUtils.teamcityLog("testFinished name='" + teamcityTestName + "' duration='" + (end - start) + "'");
                for (Reporter report : reports) report.addTest(reportTest);
            }
        }
    }

    private static void clearDatabase() {
        log.info("Clear database start");
        TeamcityUtils.teamcityLog("progressMessage 'Clear database start'");
        try {
            File snapshot = new File(config.getSnapshotPath());
            dropMongo();
            dropIndex();
            restoreMongo(snapshot);
            coreService.rebuildIndex();

//            createDefaultObjects();
            Common.sleep(10000);
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }
        log.info("Clear database finish");
        TeamcityUtils.teamcityLog("progressMessage 'Clear database finish'");
    }

    private static Destination getCoreDestination() {
        for (Map.Entry<String, Destination> entry : config.getDestinations().entrySet()) {
            if (entry.getValue().getType() == DestinationType.CORE)
                return entry.getValue();
        }
        return null;
    }

    private static void dropMongo() throws IOException, InterruptedException {
        StringBuilder command = new StringBuilder("mongo");
        command.append(" --host ").append(config.getMongoDbHost());
        command.append(" --port ").append(config.getMongoDbPort());
        command.append(" gdam --eval \"db.dropDatabase();\"");
        Runtime.getRuntime().exec(command.toString()).waitFor();
    }

    private static void dropIndex() throws IOException {
        StringBuilder address = new StringBuilder("http://");
        address.append(config.getElasticSearchHost()).append(":").append(config.getElasticSearchPort());
        address.append("/_all");
        CloseableHttpClient client = HttpClients.createDefault();
        HttpDelete delete = new HttpDelete(address.toString());
        EntityUtils.consume(client.execute(delete).getEntity());
    }

    private static void restoreMongo(File snapshot) throws IOException, InterruptedException {
        StringBuilder command = new StringBuilder("mongorestore");
        command.append(" --host ").append(config.getMongoDbHost());
        command.append(" --port ").append(config.getMongoDbPort());
        command.append(" --db gdam \"").append(snapshot.getCanonicalPath()).append("\"");
        Process proc = Runtime.getRuntime().exec(command.toString());
        InputStream in = proc.getInputStream();
        byte[] buffer = new byte[4096];
        while (in.read(buffer) != -1) {
        }
        in.close();
    }

    private static int testThreading(Test test, ReportTest reportTest) {
        if (test.isClearDatabase()) clearDatabase();
        double rps = 0.0, currentRps;
        int iteration = config.getStartWithIteration(), bestThreadsCount = 0;
        Map<String, TestThreadGroup> threadGroups = test.getThreadGroups();
        for (ExecutorThread thread : prepareThreads(threadGroups, 1)) thread.prepareOnce();
        do {
            List<ExecutorThread> threads = prepareThreads(threadGroups, (int) Math.pow(2, iteration));
            log("Prepare threads");
            for (ExecutorThread thread : threads) {
                thread.prepare();
            }
            Common.sleep(test.getThreadingDelay());
            log("Start %d threads", threads.size());
            for (ExecutorThread thread : threads) {
                thread.start();
            }
            int threadingTestTime = test.getThreadingTestTime() > 0 ? test.getThreadingTestTime() : config.getThreadingTestTime();
            Common.sleep(threadingTestTime);
            int counter = 0, counterError = 0;
            long timeSpent = 0;
            List<Map<String, Long>> partialTimes = new ArrayList<>();
            for (ExecutorThread thread : threads) {
                counter += thread.getCounter();
                counterError += thread.getCounterError();
                timeSpent += thread.getTimeSpent();
                partialTimes.addAll(thread.getPartialTimes());
            }
            currentRps = 1000.0 * counter / threadingTestTime;
            double responseTime = timeSpent / (1000.0 * counter);
            log("Finished with %.2f t/s (hits: %d, errors: %d, time: %.3f s)", currentRps, counter, counterError, responseTime);
            reportTest.addThreading(
                    ReportThreadingTest$.MODULE$.apply(
                            threads.size(), currentRps,
                            counter, counterError, responseTime,
                            getPartialTimes(partialTimes)
                    )
            );
            int responseTimeLimitSeconds = test.getResponseTimeLimitSeconds() > 0 ? test.getResponseTimeLimitSeconds() : config.getResponseTimeLimitSeconds();
            stopThreads(threads);
            if (/*currentRps > rps && */responseTime < responseTimeLimitSeconds && threads.size() < MAX_THREADS) {
                rps = currentRps;
                iteration++;
                bestThreadsCount = threads.size();
            } else break;
        } while (true);
        return bestThreadsCount;
    }

    private static Map<String, Long> getPartialTimes(List<Map<String, Long>> partialTimes) {
        Map<String, Long> result = new LinkedHashMap<>();
        Map<String, Integer> counts = new HashMap<>();
        for (Map<String, Long> partialTime : partialTimes) {
            for (Map.Entry<String, Long> entry : partialTime.entrySet()) {
                String key = entry.getKey();
                Long value = entry.getValue();
                if (result.get(key) == null) {
                    result.put(key, value);
                    counts.put(key, 1);
                } else {
                    result.put(key, result.get(key) + value);
                    counts.put(key, counts.get(key) + 1);
                }
            }
        }
        for (Map.Entry<String, Long> entry : result.entrySet()) {
            result.put(entry.getKey(), entry.getValue() / counts.get(entry.getKey()));
        }
        return result;
    }

    private static void stopThreads(List<ExecutorThread> threads) {
        for (ExecutorThread thread : threads) thread.interrupt();
        for (ExecutorThread thread : threads)
            try {
                thread.join();
            } catch (InterruptedException e) {/**/}
    }

    private static void testDegradation(Test test, int threadsCount, ReportTest reportTest) {
        if (test.isClearDatabase()) clearDatabase();
        Map<String, TestThreadGroup> threadGroups = test.getThreadGroups();
        log("Prepare threads");
        for (ExecutorThread thread : prepareThreads(threadGroups, 1)) thread.prepareOnce();
        List<ExecutorThread> threads = prepareThreads(threadGroups, threadsCount / threadGroups.size());
        for (ExecutorThread thread : threads) thread.prepare();
        for (ExecutorThread thread : threads) thread.start();
        long start = System.currentTimeMillis();
        do {
            Common.sleep(1000);
            long time = (System.currentTimeMillis() - start) / 1000;
            if (time % 60 == 0) {
                int counter = 0;
                for (ExecutorThread thread : threads) counter += thread.getCounter();
                log("%d iterations for %d minutes", counter, time / 60);
                reportTest.addDegradation(time, counter);
            }
        } while (System.currentTimeMillis() - start < config.getDegradationTestTime());
        stopThreads(threads);
    }

    private static void testVolume(Test test, ReportTest reportTest) {
        double currentRps;
        if (test.isClearDatabase()) clearDatabase();

        Map<String, TestThreadGroup> threadGroups = test.getThreadGroups();
        for (ExecutorThread thread : prepareThreads(threadGroups, 1)) thread.prepareOnce();
        for (int iteration = 0; iteration < test.getDesiredNumOfIterations(); iteration++) {
            long iterationStart = System.currentTimeMillis();
            log("Starting iteration " + iteration);

            List<ExecutorThread> threads = prepareThreads(threadGroups, 1);
            for (ExecutorThread thread : threads) thread.prepare();
            for (ExecutorThread thread : threads) thread.start();
            long start = System.currentTimeMillis();
            int threadingTestTime = test.getThreadingTestTime() > 0 ? test.getThreadingTestTime() : config.getThreadingTestTime();
            do {
                Common.sleep(1000);
                long time = System.currentTimeMillis() - start;
                if ((time / 1000) % 60 == 0) {
                    int counter = 0, counterError = 0;
                    long timeSpent = 0;
                    List<Map<String, Long>> partialTimes = new ArrayList<>();
                    for (ExecutorThread thread : threads) {
                        counter += thread.getCounter();
                        counterError += thread.getCounterError();
                        timeSpent += thread.getTimeSpent();
                        partialTimes.addAll(thread.getPartialTimes());
                    }
                    log("%d cycles for %s", counter, ppMillis(time));
                    currentRps = 1000.0 * counter / threadingTestTime;
                    double responseTime = timeSpent / (1000.0 * counter);
                    reportTest.addVolume(
                            ReportVolumeTest$.MODULE$.apply(
                                    iteration + 1, currentRps,
                                    counter, counterError, responseTime,
                                    getPartialTimes(partialTimes)
                            )
                    );
                }
            } while (System.currentTimeMillis() - start < threadingTestTime);
            log("Iteration took " + ppMillis(System.currentTimeMillis() - iterationStart));
            stopThreads(threads);
        }
    }

    private static void testComplex(Test test, ReportTest reportTest) {
        if (test.isClearDatabase()) clearDatabase();
        Map<String, TestThreadGroup> threadGroups = test.getThreadGroups();
        List<AbstractPerformanceTest> tests = prepareWeightedTests(threadGroups);
        Collections.shuffle(tests);
        log("Prepare tests");
        for (ExecutorThread thread : prepareThreads(threadGroups, 1)) thread.prepareOnce();
        for (AbstractPerformanceTest performanceTest : tests) performanceTest.beforeStart();
        int iterationTime = config.getComplexIterationTime(), testIndex = 0;
        for (int i = 0; i < 10; i++) {
            Common.sleep(3000);
            int waitTime = (int) (iterationTime * Math.pow(0.75, i) / tests.size());
            log("Begin iteration with wait time %d ms", waitTime);
            long start = System.currentTimeMillis();
            List<ExecutorThread> threads = new ArrayList<>();
            do {
                ExecutorThread thread = new ExecutorThread(tests.get(testIndex), true);
                thread.start();
                threads.add(thread);
                Common.sleep(waitTime);
                testIndex++;
                if (testIndex >= tests.size()) testIndex = 0;
            } while (System.currentTimeMillis() - start < iterationTime);
            int counter = 0, counterError = 0;
            long timeSpent = 0;
            for (ExecutorThread thread : threads) {
                counter += thread.getCounter();
                counterError += thread.getCounterError();
                timeSpent += thread.getTimeSpent();
            }
            double responseTime = timeSpent / (1000.0 * counter);
            log("Finished with average time %.3f s (hits: %d, errors: %d)", responseTime, counter, counterError);
            reportTest.addComplex(new ReportComplexTest(60000 / waitTime, responseTime, counter, counterError));
            stopThreads(threads);
        }
    }

    private static List<ExecutorThread> prepareThreads(Map<String, TestThreadGroup> threadGroups, int threadsPerGroup) {
        List<ExecutorThread> threads = new ArrayList<>(threadGroups.size() * threadsPerGroup);
        for (Map.Entry<String, TestThreadGroup> threadGroupEntry : threadGroups.entrySet()) {
            for (AbstractPerformanceTest test : prepareTests(threadGroupEntry.getValue(), threadsPerGroup)) {
                threads.add(new ExecutorThread(test));
            }
        }
        return threads;
    }

    private static List<AbstractPerformanceTest> prepareTests(TestThreadGroup threadGroup, int testsCount) {
        List<AbstractPerformanceTest> tests = new ArrayList<>(testsCount);
        Destination destination = config.getDestinations().get(threadGroup.getDestination());
        for (int i = 0; i < testsCount; i++) {
            AbstractPerformanceTest performanceTest = getPerformanceTest(threadGroup);
            performanceTest.setService(getService(destination));
            performanceTest.setPaperPusherService(getPaperPusherService(destination));
            performanceTest.addParams(config.getGlobalParams());
            performanceTest.addParams(threadGroup.getParams());
            tests.add(performanceTest);
        }
        return tests;
    }

    private static List<AbstractPerformanceTest> prepareWeightedTests(Map<String, TestThreadGroup> threadGroups) {
        List<AbstractPerformanceTest> tests = new ArrayList<>();
        for (Map.Entry<String, TestThreadGroup> threadGroupEntry : threadGroups.entrySet()) {
            TestThreadGroup threadGroup = threadGroupEntry.getValue();
            tests.addAll(prepareTests(threadGroup, threadGroup.getWeight()));
        }
        return tests;
    }

    private static BabylonService getService(Destination destination) {
        Class serviceClass = destination.getType().getServiceClass();
        try {
            BabylonService service = (BabylonService) serviceClass.getConstructor(URL.class).newInstance(destination.getUrl());
            if (service instanceof BabylonMessageSender) {
                ((BabylonMessageSender) service).setForceHttp(false);
            }
            return service;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private static PaperPusherService getPaperPusherService(Destination destination) {
        try {
            return new PaperPusherCoreService(destination.getPaperPusherUrl());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private static AbstractPerformanceTest getPerformanceTest(TestThreadGroup threadGroup) {
        try {
            return (AbstractPerformanceTest) Class.forName(threadGroup.getTestClass()).newInstance();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private static void createDefaultObjects() {
        Common.sleep(5000);
        Agency agency = createAgency("A5TestAdvertiser");
        createUser(agency, "agencyadmin@test.com");
    }

    private static Agency createAgency(String agencyName) {
        Agency agency = getAgency(agencyName);
        if (agency == null) {
            agency = new Agency();
            agency.setName(agencyName);
            agency.setDescription(agencyName);
            agency.setSubtype("agency");
            agency.setPin("1");
            agency.setTimeZone("Europe-Andorra");
            agency.setCountry("AF");
            agency.setAgencyType("Advertiser");
            agency.setStorageId("5b1ad2af-3f8f-4557-9841-d6440df3648c");
            agency = coreService.createAgency(agency);
        }
        return agency;
    }

    private static User createUser(Agency agency, String email) {
        User user = getUser(email);
        if (user == null) {
            user = new User();
            user.setAgency(agency);
            user.setPhoneNumber("1234567890");
            user.setAdvertiser(agency.getId());
            user.setPassword("abcdefghA1");
            user.setFullAccess();
            user.setRoles(new BaseObject[]{getRole("agency.admin")});
            user.setFirstName("admin");
            user.setLastName("agency");
            user.setEmail(email);
            user = coreService.createUser(agency.getId(), user);
        }
        return user;
    }

    private static Agency getAgency(String agencyName) {
        List<Agency> agencies = coreService.getAgencies();
        for (Agency agency : agencies) {
            if (agency.getName().equals(agencyName)) return agency;
        }
        return null;
    }

    private static User getUser(String email) {
        LuceneSearchingParams query = new LuceneSearchingParams();
        query.setQuery("_cm.common.email.untouched:" + email);
        SearchResult<User> result = coreService.findUsers(query);
        if (result.getResult().size() > 0) return result.getResult().get(0);
        return null;
    }

    private static Role getRole(String roleName) {
        LuceneSearchingParams query = new LuceneSearchingParams();
        query.setQuery(String.format("_cm.common.name:\"%s\"", roleName));
        return coreService.findRoles(query).getResult().get(0);
    }

    public static String ppMillis(long millis) {
        return formatter.print((new Duration(millis)).toPeriod());
    }
}