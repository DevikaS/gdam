package com.adstream.automate.jbehave;

import org.jbehave.core.steps.*;

/**
 * Created by IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 09.02.12
 * Time: 14:31
 */
public class StoryContextMonitor extends DelegatingStepMonitor {
    private final ThreadLocal<StoryContext> storyContext;
    public StoryContextMonitor(StepMonitor delegate, ThreadLocal<StoryContext> storyContext) {
        super(delegate);
        this.storyContext = storyContext;
    }

    @Override
    public void performing(String step, boolean dryRun) {
        super.performing(step, dryRun);
        storyContext.get().setCurrentStep(step);
    }
}
