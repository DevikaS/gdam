package com.adstream.automate.jbehave;

import org.jbehave.core.model.Scenario;
import org.jbehave.core.model.Story;
import org.jbehave.core.reporters.*;
import ru.yandex.qatools.allure.Allure;
import ru.yandex.qatools.allure.config.AllureModelUtils;
import ru.yandex.qatools.allure.events.*;

import java.util.*;


/**
 * Created by denysb on 29/02/2016.
 */
public class JenkinsAllureReporter extends NullStoryReporter {

    private Allure allure = Allure.LIFECYCLE;
    private String uid;
    private final Map<String, String> suites = new HashMap<>();

    public void beforeStory(Story story, boolean givenStory) {
        uid = generateSuiteUid(story);
        TestSuiteStartedEvent event = new TestSuiteStartedEvent(uid, story.getName());
        event.withLabels(AllureModelUtils.createTestFrameworkLabel("JBehave"));
        event.withTitle(story.getName());
        allure.fire(event);
    }

    public void afterStory(boolean givenStory) {
        allure.fire(new TestSuiteFinishedEvent(uid));
    }

    public void scenarioNotAllowed(Scenario scenario, String filter) {
        super.scenarioNotAllowed(scenario, filter);
        pending("Excluded by filter " + filter);
    }

    public void beforeScenario(String scenarioTitle) {
        allure.fire(new TestCaseStartedEvent(uid, scenarioTitle));
        allure.fire(new ClearStepStorageEvent());
    }

    public void beforeStep(String step) {
        allure.fire(new StepStartedEvent(step).withTitle(step));
    }

    public void successful(String step) {
        allure.fire(new StepFinishedEvent());
    }

    public void ignorable(String step) {
        allure.fire(new StepCanceledEvent());
    }

    public void notPerformed(String step) {
        allure.fire(new StepCanceledEvent());
    }

    public void failed(String step, Throwable cause) {
        allure.fire(new StepFinishedEvent());
        allure.fire(new StepFailureEvent().withThrowable(cause.getCause()));
        allure.fire(new TestCaseFailureEvent().withThrowable(cause.getCause()));
    }


    public void pending(String step) {
        allure.fire(new StepCanceledEvent());
        allure.fire(new TestCasePendingEvent().withMessage("PENDING"));
    }


    public void afterScenario() {
        allure.fire(new TestCaseFinishedEvent());
    }

    public String generateSuiteUid(Story story) {
        String uId = UUID.randomUUID().toString();
        synchronized (getSuites()) {
            getSuites().put(story.getPath(), uId);
        }
        return uId;
    }

    public Map<String, String> getSuites() {
        return suites;
    }


}
