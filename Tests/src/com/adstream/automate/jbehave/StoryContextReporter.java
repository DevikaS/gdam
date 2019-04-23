package com.adstream.automate.jbehave;

import org.jbehave.core.model.ExamplesTable;
import org.jbehave.core.model.GivenStories;
import org.jbehave.core.model.Narrative;
import org.jbehave.core.model.Story;
import org.jbehave.core.reporters.*;

import java.util.*;

/**
 * Created by IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 09.02.12
 * Time: 17:08
 * To change this template use File | Settings | File Templates.
 */
public class StoryContextReporter extends NullStoryReporter {

    private final StoryContext storyContext;

    public StoryContextReporter(ThreadLocal<StoryContext> storyContext) {
        StoryContext currentStoryContext = storyContext.get();
        if (currentStoryContext == null) {
            currentStoryContext = new StoryContext();
            storyContext.set(currentStoryContext);
        }
        this.storyContext = currentStoryContext;
    }

    @Override
    public void narrative(Narrative narrative) {
        storyContext.setCurrentNarrative(narrative);
    }

    @Override
    public void beforeStory(Story story, boolean givenStory) {
        storyContext.setCurrentStory(story);
        storyContext.setIsGiven(givenStory);
    }

    @Override
    public void beforeScenario(String title) {
        storyContext.setCurrentScenario(title);
    }

    @Override
    public void beforeExamples(List<String> steps, ExamplesTable table) {

    }

    @Override
    public void example(Map<String, String> tableRow) {//actually it before example

    }

    @Override
    public void afterExamples() {

    }

    @Override
    public void failed(String step, Throwable storyFailure) {

    }

    @Override
    public void pending(String step) {

    }

    @Override
    public void afterScenario() {

    }

    @Override
    public void afterStory(boolean givenStory) {

    }


}
