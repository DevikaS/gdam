package com.adstream.automate.babylon.tests.steps.utils;

import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.babylon.tests.steps.domain.LoginSteps;
import com.adstream.automate.jbehave.StoryContext;
import org.jbehave.core.annotations.BeforeScenario;
import org.jbehave.core.annotations.ScenarioType;

/**
 * Created by IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 24.01.12
 * Time: 13:23
 * To change this template use File | Settings | File Templates.
 */
public class LoginBeforeEachScenario extends BaseStep {
    private ThreadLocal<StoryContext> storyContext;

    public LoginBeforeEachScenario(ThreadLocal<StoryContext> storyContext) {
        this.storyContext = storyContext;
    }

    @BeforeScenario(uponType = ScenarioType.ANY)
    public void loginBeforeNormalScenario() {
        String desiredUserType = storyContext.get().getCurrentNarrative().asA();
        log.debug("login before story: " + storyContext.get().getCurrentStory().getName());
        log.debug("login before scenario: " + storyContext.get().getCurrentScenario());
        try{
            if(!desiredUserType.isEmpty())
            LoginSteps.loginAs(desiredUserType);
        } catch (Exception e){
            log.info("Error during login to this story: " + storyContext.get().getCurrentStory().getName() + " and Scenario: " + storyContext.get().getCurrentScenario());
            log.error("Error during login before scenario",e);
        }
    }
}
