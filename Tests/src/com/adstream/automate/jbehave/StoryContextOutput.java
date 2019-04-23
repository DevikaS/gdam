package com.adstream.automate.jbehave;

import org.jbehave.core.reporters.FilePrintStreamFactory;
import org.jbehave.core.reporters.StoryReporter;
import org.jbehave.core.reporters.StoryReporterBuilder;

/**
 * Created with IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 03.05.12
 * Time: 20:10
 * To change this template use File | Settings | File Templates.
 */
public class StoryContextOutput extends org.jbehave.core.reporters.Format{

    private final ThreadLocal<StoryContext> storyContext;


    public StoryContextOutput(ThreadLocal<StoryContext> storyContext) {
        super("STORY_CONTEXT");
        this.storyContext = storyContext;
    }

    @Override
    public StoryReporter createStoryReporter(FilePrintStreamFactory filePrintStreamFactory, StoryReporterBuilder storyReporterBuilder) {
        return new StoryContextReporter(storyContext);
    }
}
