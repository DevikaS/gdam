package com.adstream.automate.babylon.tests.steps.utils.heartbeat;

import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.jbehave.StoryContext;
import org.apache.log4j.Logger;
import org.jbehave.core.annotations.AfterScenario;
import org.jbehave.core.annotations.BeforeScenario;

import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

public class HeartbeatListener {
    private static final int DELAY_BEFORE_RELEASE_SCENARIO = 15000;
    private static Logger log = Logger.getLogger(HeartbeatListener.class);
    private static volatile List<String> recentScenarios = new CopyOnWriteArrayList<>();
    private ThreadLocal<StoryContext> storyContext;

    public HeartbeatListener(ThreadLocal<StoryContext> storyContext) {
        this.storyContext = storyContext;
        new MiddleTierHeartbeatSource(this).start();
        new CoreHeartbeatSource(this).start();
        new PaperPusherHeartbeatSource(this).start();
        new MailServiceHeartbeatSource(this).start();
        if(TestsContext.getInstance().isAdcost.equalsIgnoreCase("true"))
            new AdcostHeartBeatSource(this).start();
        if(TestsContext.getInstance().isnewlibrary != null && TestsContext.getInstance().isnewlibrary.equalsIgnoreCase("true"))
            new NewLibraryHeartBeatSource(this).start();
        if(TestsContext.getInstance().isMediaManager.equalsIgnoreCase("true"))
            new MediaManagerHeartBeatSource(this).start();
    }

    @BeforeScenario
    public void registerScenario() {
        recentScenarios.add(getCurrentStoryScenario());
    }

    @AfterScenario
    public void releaseScenario() {
        // in case of fail we should see scenarios for last 15 seconds
        final String currentStoryScenario = getCurrentStoryScenario();
        new Thread() {
            { setDaemon(true); }

            public void run() {
                try {
                    sleep(DELAY_BEFORE_RELEASE_SCENARIO);
                } catch (InterruptedException e) { /**/ }
                recentScenarios.remove(currentStoryScenario);
            }
        }.start();
    }

    public void heartbeatStopped(Class clazz) {
        StringBuilder str = new StringBuilder(clazz.getSimpleName() + " has detected heartbeat stop. Recent scenarios:\r\n");
        for (String scenario : recentScenarios) {
            str.append(scenario).append("\r\n");
        }
        log.error(str);
    }

    private String getCurrentStoryScenario() {
        return storyContext.get().getCurrentStory().getName() + " / " + storyContext.get().getCurrentScenario();
    }
}
