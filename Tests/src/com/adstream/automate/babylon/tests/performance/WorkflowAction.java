package com.adstream.automate.babylon.tests.performance;

/**
 * User: ruslan.semerenko
 * Date: 18.07.13 17:32
 */
public abstract class WorkflowAction {
    public void prepare(Workflow workflow) {
    }

    public abstract void perform(Workflow workflow);
}
