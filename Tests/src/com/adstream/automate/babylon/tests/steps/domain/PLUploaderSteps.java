package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import org.jbehave.core.annotations.Then;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.is;

public class PLUploaderSteps extends BaseStep {
    @Then("{I |}'$condition' be on PlUploader page")
    public void checkThatPLUploaderPageOpened(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = true;
        try {
            getSut().getPageCreator().getPLUploaderPage();
        } catch (Exception e) {
            actualState = false;
        }

        assertThat(actualState, is(expectedState));
        getSut().getPageNavigator().getDashboardPage();
    }
}
