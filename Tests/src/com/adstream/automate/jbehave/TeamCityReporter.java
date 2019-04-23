package com.adstream.automate.jbehave;

import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.tests.steps.utils.TimeTracker;
import com.adstream.automate.teamcity.TeamCityIntegration;
import org.jbehave.core.configuration.Keywords;
import org.jbehave.core.model.ExamplesTable;
import org.jbehave.core.model.Scenario;
import org.jbehave.core.model.Story;
import org.jbehave.core.reporters.*;

import java.io.*;
import java.text.MessageFormat;
import java.util.*;

/**
 * Created by IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 09.02.12
 * Time: 17:08
 * <p/>
 * http://confluence.jetbrains.net/display/TCD7/Build+Script+Interaction+with+TeamCity#BuildScriptInteractionwithTeamCity-ReportingTests
 */
public class TeamCityReporter extends TxtOutput {
    public static final org.jbehave.core.reporters.Format TEAMCITY = new TeamCityOutput();
    private PrintStream output;

    private String currentScenarioTitle;
    private String currentStoryTitle;

    int examplesCount;
    boolean isFirstExample = false;
    boolean scenarioFailed = false;
    HashSet<String> exampledScenarios;
    HashSet<String> reportedScenarios = new HashSet<>();
    private StringBuilder scenarioBuffer;
    private TeamCityIntegration teamCity = new TeamCityIntegration();

    public static String getStoryName(String fileName) {
        final String ext = ".story";
        if (fileName.endsWith(ext))
            return fileName.substring(0, fileName.length() - ext.length());
        return fileName;
    }

    public TeamCityReporter(PrintStream output, Keywords keywords) {
        super(output, keywords);
        this.output = output;
    }

    @Override
    public void beforeStory(Story story, boolean givenStory) {
        currentStoryTitle = getStoryName(story.getName());
        output.println(TeamCityIntegration.testSuiteStartedMessage(currentStoryTitle));
        super.beforeStory(story, givenStory);
        exampledScenarios = getExampledScenarios(story.getScenarios());
        reportedScenarios.clear();
    }

    @Override
    public void scenarioNotAllowed(Scenario scenario, String filter) {
        super.scenarioNotAllowed(scenario, filter);
        pending("Excluded by filter " + filter);
    }

    private HashSet<String> getExampledScenarios(List<Scenario> scenarioList) {
        HashSet<String> exampledScenarios = new HashSet<>();
        for (Scenario scenario : scenarioList) {
            boolean isExampled = scenario.getExamplesTable().getHeaders().size() > 0;
            if (isExampled) {
                exampledScenarios.add(scenario.getTitle());
            }
        }
        return exampledScenarios;
    }


    @Override
    public void beforeScenario(String title) {
        scenarioBuffer = new StringBuilder();
        currentScenarioTitle = title;
        examplesCount = -1;
        scenarioFailed = false;
        if (!exampledScenarios.contains(title)) {
            startTest(title);
        }
        super.beforeScenario(title);
    }

    @Override
    public void beforeExamples(List<String> steps, ExamplesTable table) {
        super.beforeExamples(steps, table);
        isFirstExample = true;
    }

    @Override
    //actually it before example
    public void example(Map<String, String> tableRow) {
        if (!isFirstExample) {
            finishTest(currentScenarioTitle + examplesCount);
        }
        isFirstExample = false;
        examplesCount++;
        startTest(currentScenarioTitle + examplesCount);
        super.example(tableRow);
    }

    @Override
    public void afterExamples() {
        super.afterExamples();
        finishTest(currentScenarioTitle + examplesCount);
    }

    @Override
    public void failed(String step, Throwable storyFailure) {
        super.failed(step, storyFailure);
        String scenario = examplesCount != -1 ? currentScenarioTitle + examplesCount : currentScenarioTitle;
        printMessage(TeamCityIntegration.testFailedMessage(
                scenario,
                step,
                storyFailure.getCause().toString()));
        reportedScenarios.add(scenario);
        scenarioFailed = true;
    }

    @Override
    public void pending(String step) {
        super.pending(step);
        String scenario = examplesCount != -1 ? currentScenarioTitle + examplesCount : currentScenarioTitle;
        if (!reportedScenarios.contains(scenario) ) {
            printMessage(TeamCityIntegration.testIgnoredMessage(scenario, step));
            reportedScenarios.add(scenario);
        }
    }

    @Override
    public void afterScenario() {
        super.afterScenario();
        if (!exampledScenarios.contains(currentScenarioTitle)) {
            finishTest(currentScenarioTitle);
        }
        //do not print scenario only if that is first run, scenario are failed and not muted in teamcity
        if (!(isSecondRunEnabled() && scenarioFailed && !isCurrentScenarioMuted())) {
            output.println(scenarioBuffer.toString());
        }
    }

    private boolean isCurrentScenarioMuted() {
        return teamCity.isScenarioMuted(currentStoryTitle, currentScenarioTitle);
    }

    private void startTest(String scenarioTitle) {
        printMessage(TeamCityIntegration.testStartedMessage(scenarioTitle));
    }

    private void finishTest(String scenarioTitle) {
        long time = 0;
        try {
            time = TimeTracker.getScenarioTime(currentStoryTitle, scenarioTitle, examplesCount);
        } catch (Exception e) {
            e.printStackTrace();
        }
        printMessage(TeamCityIntegration.testFinishedMessage(scenarioTitle, time));
    }

    @Override
    public void afterStory(boolean givenStory) {
        super.afterStory(givenStory);
        output.println(TeamCityIntegration.testSuiteFinishedMessage(currentStoryTitle));
    }

    private boolean isSecondRunEnabled() {
        return TestsContext.getInstance().isUnicDataSet
                && TestsContext.getInstance().testsRunAgainOnFail
                && !TestsContext.getInstance().isSecondRun;
    }

    private void printMessage(String message) {
        if (isSecondRunEnabled()) {
            scenarioBuffer.append(message).append(System.getProperty("line.separator"));
        } else {
            output.println(message);
        }
    }

    private static class TeamCityOutput extends org.jbehave.core.reporters.Format {
        private volatile StoryReporter reporter;

        public TeamCityOutput() {
            super("TEAMCITY");
        }

        @Override
        public StoryReporter createStoryReporter(FilePrintStreamFactory factory, StoryReporterBuilder storyReporterBuilder) {
            if (reporter == null) {
                synchronized (this) {
                    if (reporter == null) {
                        reporter = new TeamCityReporter(System.out, storyReporterBuilder.keywords()).doReportFailureTrace(true);
                    }
                }
            }
            return reporter;
        }
    }
}
