package com.adstream.automate.babylon.tests.steps.utils;

import com.adstream.automate.jbehave.StoryContext;
import com.adstream.automate.jbehave.TeamCityReporter;
import org.jbehave.core.annotations.AfterScenario;
import org.jbehave.core.annotations.BeforeScenario;
import org.jbehave.core.annotations.ScenarioType;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * User: ruslan.semerenko
 * Date: 10.01.13 10:36
 */
public class TimeTracker {
    private static volatile Map<String, Map<String, List<Long>>> timeMap =
            new ConcurrentHashMap<String, Map<String, List<Long>>>();

    private ThreadLocal<StoryContext> storyContext;
    private ThreadLocal<Long> scenarioStartTime = new ThreadLocal<Long>();

    public TimeTracker(ThreadLocal<StoryContext> storyContext) {
        this.storyContext = storyContext;
    }

    @BeforeScenario(uponType = ScenarioType.ANY)
    public void startScenario() {
        scenarioStartTime.set(System.currentTimeMillis());
    }

    @AfterScenario(uponType = ScenarioType.ANY)
    public void endScenario() {
        long time = System.currentTimeMillis() - scenarioStartTime.get();
        addScenarioTime(getCurrentStoryName(), getCurrentScenarioName(), time);
    }

    private String getCurrentStoryName() {
        return TeamCityReporter.getStoryName(storyContext.get().getCurrentStory().getName());
    }

    private String getCurrentScenarioName() {
        return storyContext.get().getCurrentScenario();
    }

    private static void addScenarioTime(String storyName, String scenarioName, Long time) {
        Map<String, List<Long>> storyMap = timeMap.get(storyName);
        if (storyMap == null) {
            storyMap = new ConcurrentHashMap<String, List<Long>>();
            timeMap.put(storyName, storyMap);
        }
        List<Long> times = storyMap.get(scenarioName);
        if (times == null) {
            times = new ArrayList<Long>();
            storyMap.put(scenarioName, times);
        }
        times.add(time);
    }

    public static long getScenarioTime(String storyName, String scenarioName, int exampleNumber) {
        String exampleNumberStr = String.valueOf(exampleNumber);
        if (scenarioName.endsWith(exampleNumberStr)) {
            scenarioName = scenarioName.substring(0, scenarioName.length() - exampleNumberStr.length());
        } else {
            exampleNumber = 0;
        }
        Map<String, List<Long>> storyMap = timeMap.get(storyName);
        if (storyMap != null) {
            List<Long> scenarioList = storyMap.get(scenarioName);
            if (scenarioList != null && scenarioList.size() > exampleNumber) {
                return scenarioList.get(exampleNumber);
            }
        }
        return 0;
    }
}
