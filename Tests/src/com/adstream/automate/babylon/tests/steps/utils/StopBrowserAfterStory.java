package com.adstream.automate.babylon.tests.steps.utils;

import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.jbehave.StoryContext;
import org.jbehave.core.annotations.*;

/**
 * Created by IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 24.01.12
 * Time: 13:23
 * To change this template use File | Settings | File Templates.
 */
public class StopBrowserAfterStory extends BaseStep{
    private ThreadLocal<StoryContext> storyContext;

    public StopBrowserAfterStory(ThreadLocal<StoryContext> storyContext) {
        this.storyContext = storyContext;
    }

    @AfterStory()
    public void stopBrowserAfterStory() {
        log.info("Stop browser after story " + storyContext.get().getCurrentStory().getName());
        try{
            stopSut();
        } catch (Exception e){
            log.error("Error during stopping browser after story",e);
        }
    }
}
