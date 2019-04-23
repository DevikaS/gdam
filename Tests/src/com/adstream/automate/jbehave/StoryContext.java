package com.adstream.automate.jbehave;

import org.jbehave.core.model.Narrative;
import org.jbehave.core.model.Story;

/**
 * Created with IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 03.05.12
 * Time: 20:10
 * To change this template use File | Settings | File Templates.
 */
public class StoryContext {
    private Story currentStory;
    private String currentScenario;
    private boolean given;
    private String currentStep;
    private Narrative currentNarrative;

    public void setCurrentStory(Story currentStory) {
        this.currentStory = currentStory;
    }

    public void setCurrentScenario(String currentScenario) {
        this.currentScenario = currentScenario;
    }

    public void setIsGiven(boolean given) {
        this.given = given;
    }

    public void setCurrentStep(String currentStep) {
        this.currentStep = currentStep;
    }

    public Story getCurrentStory() {
        return currentStory;
    }

    public String getCurrentScenario() {
        return currentScenario;
    }

    public boolean isGiven() {
        return given;
    }

    public String getCurrentStep() {
        return currentStep;
    }

    public void setCurrentNarrative(Narrative currentNarrative) {
        this.currentNarrative = currentNarrative;
    }
    public Narrative getCurrentNarrative() {
        return this.currentNarrative;
    }
}
