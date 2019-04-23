package com.adstream.automate.teamcity;


import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by alexeys on 4/24/14.
 */
public class TeamCityIntegration {
    private static RestApi restApi = new RestApi("http://10.0.24.34");
    private static Map<String, List<String>> mutedTests;

    public static boolean isTeamcityRun() {
        return System.getProperty("teamcity.version") != null;
    }

    public static void setBuildTag(String tag) {
        if (isTeamcityRun()) {
            restApi.setBuildTag(tag);
        }
    }

    public static String getBuildId() {
        return  System.getProperty("teamcity.buildType.id", "");
    }

    public boolean isStoryHaveMutesSenarios(String story) {
        return isTeamcityRun() && getMutedTests().containsKey(story);
    }

    public boolean isScenarioMuted(String story, String scenario) {
        return isTeamcityRun() && isStoryHaveMutesSenarios(story) && getMutedTests().get(story).contains(scenario);
    }

    private Map<String, List<String>> getMutedTests() {
        if (mutedTests == null) {
            mutedTests = restApi.getMutedTests();
        }
        return mutedTests;
    }

    private static String escape(String input) {
        if (input == null) return null;
        if (input.isEmpty()) return "";
        return input
                .replace("|", "||")
                .replace("'", "|'")
                .replace("]", "|]")
                .replace("[", "|[")
                .replace("\n", "|n")
                .replace("\r", "|r")
                .replaceAll("\\p{C}", "?");
    }

    private static String prepareMessage(String input, String... inserts) {
        List<String> escapedInserts = new ArrayList<>();
        if (input == null) return null;
        for (String insertion : inserts) {
            escapedInserts.add(escape(insertion));
        }
        String threadName = Thread.currentThread().getName();
        String message = MessageFormat.format(input, escapedInserts.toArray());
        return String.format("##teamcity[%s flowId='%s']", message, escape(threadName));
    }

    public static String testFailedMessage(String name, String message, String details) {
        return prepareMessage("testFailed name=''{0}'' message=''{1}'' details=''{2}''",
                name,
                message,
                details);
    }

    public static String testIgnoredMessage(String name, String message) {
        return prepareMessage("testIgnored name=''{0}'' message=''{1}''",
                name,
                message);
    }

    public static String testSuiteFinishedMessage(String name) {
        return prepareMessage("testSuiteFinished name=''{0}''", name);
    }

    public static String testFinishedMessage(String name, long duration) {
        return prepareMessage("testFinished name=''{0}'' duration=''{1}''",
                name,
                String.valueOf(duration));
    }

    public static String testStartedMessage(String name) {
        return prepareMessage("testStarted name=''{0}'' captureStandardOutput=''true''",
                name);
    }

    public static String testSuiteStartedMessage(String name) {
        return prepareMessage("testSuiteStarted name=''{0}''",
                name);
    }
}
