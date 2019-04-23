package com.adstream.automate.jbehave;

import org.jbehave.core.model.*;
import org.jbehave.core.reporters.ConcurrentStoryReporter;
import org.jbehave.core.reporters.FilePrintStreamFactory;
import org.jbehave.core.reporters.StoryReporter;
import org.jbehave.core.reporters.StoryReporterBuilder;
import java.util.*;
/**
 * Created by IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 09.02.12
 * Time: 17:08
 * <p/>
 * http://confluence.jetbrains.net/display/TCD7/Build+Script+Interaction+with+TeamCity#BuildScriptInteractionwithTeamCity-ReportingTests
 */
public class FailedTestsReporter implements StoryReporter {
    public static final org.jbehave.core.reporters.Format FAILED_TEST_REPORTER = new FailedTestOutput();
    private static Map<String, List<String>> failedTests = new HashMap<String, List<String>>();
    private static Map<String, List<String>> executedTests = new HashMap<String, List<String>>();
    private static Map<String, List<String>> skippedScenarios = new HashMap<String, List<String>>();



    private String currentScenarioTitle;
    private String currentStoryTitle;
    private boolean scenarioNotAllowed ;
    boolean isFirstExample = false;

    public static Map<String, List<String>> getSkippedTests() {
        return skippedScenarios;
    }

    public static String getStoryName(String fileName) {
        final String ext = ".story";
        if (fileName.endsWith(ext))
            return fileName.substring(0, fileName.length() - ext.length());
        return fileName;
    }

    public void excutedScenarios() {
        if ((!executedTests.containsKey(currentStoryTitle))) {
            executedTests.put(currentStoryTitle, new ArrayList<String>());
        }
        executedTests.get(currentStoryTitle).add(currentScenarioTitle);
    }

    public static Map<String, List<String>> getFailedTests() {
        return failedTests;
    }
    public static Map<String, List<String>> getexecutedTests() {
        return executedTests;
    }

    @Override
    public void storyNotAllowed(Story story, String filter) {
    }

    @Override
    public void storyCancelled(Story story, StoryDuration storyDuration) {
    }

    @Override
    public void beforeStory(Story story, boolean givenStory) {
        currentStoryTitle = getStoryName(story.getName());
    }

    @Override
    public void scenarioNotAllowed(Scenario scenario, String filter) {
        scenarioNotAllowed=true;
    }

    @Override
    public void beforeScenario(String title) {
        currentScenarioTitle = title;
        scenarioNotAllowed =false;
    }

    @Override
    public void scenarioMeta(Meta meta) {
    }

    @Override
    public void beforeExamples(List<String> steps, ExamplesTable table) {
         isFirstExample = true;
    }

    @Override
    public void example(Map<String, String> tableRow) {//actually it before example
        if(!isFirstExample){
        excutedScenarios();
        }
        isFirstExample = false;
    }

    @Override
    public void afterExamples() {
    }

    @Override
    public void beforeStep(String step) {
    }

    @Override
    public void successful(String step) {
    }

    @Override
    public void ignorable(String step) {
    }

    @Override
    public void failed(String step, Throwable storyFailure) {
        if (!failedTests.containsKey(currentStoryTitle)) {
            failedTests.put(currentStoryTitle, new ArrayList<String>());
        }
            failedTests.get(currentStoryTitle).add(currentScenarioTitle);
    }

    @Override
    public void failedOutcomes(String step, OutcomesTable table) {
    }

    @Override
    public void restarted(String step, Throwable cause) {
    }

    @Override
    public void dryRun() {
    }

    @Override
    public void pendingMethods(List<String> methods) {
    }

    @Override
    public void pending(String step) {
        if (!skippedScenarios.containsKey(currentStoryTitle)) {
            skippedScenarios.put(currentStoryTitle, new ArrayList<String>());
        }
        skippedScenarios.get(currentStoryTitle).add(currentScenarioTitle);
    }

    @Override
    public void notPerformed(String step) {
    }

    @Override
    public void afterScenario() {
        if(!scenarioNotAllowed){
            excutedScenarios();
        }
    }

    @Override
    public void givenStories(GivenStories givenStories) {
    }

    @Override
    public void givenStories(List<String> storyPaths) {
    }


    @Override
    public void afterStory(boolean givenStory) {
    }

    @Override
    public void narrative(Narrative narrative) {

    }

    @Override
    public void lifecyle(Lifecycle lifecycle) {
    }


    private static class FailedTestOutput extends org.jbehave.core.reporters.Format {

        public FailedTestOutput() {
            super("FAILED_TEST_REPORTER");
        }

        @Override
        public StoryReporter createStoryReporter(FilePrintStreamFactory factory, StoryReporterBuilder storyReporterBuilder) {
            return new FailedTestsReporter();
        }
    }
}
