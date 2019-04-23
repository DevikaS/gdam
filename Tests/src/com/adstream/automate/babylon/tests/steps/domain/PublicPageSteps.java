package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.tests.steps.core.BaseStep;

import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;

import java.util.List;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * User: lynda-k
 * Date: 16.12.13
 * Time: 12:00
 */
public class PublicPageSteps extends BaseStep {


    @When("{I |}click download button on public file preview page")
    public void clickDownloadButtonOnFilePreviewPage(){
        getSut().getPageCreator().getPublicFileViewPage().clickDownloadButton();
    }

    @Then("{I |}'$condition' be on public file preview page")
    public void checkThatPublicFilePreviewPageOpened(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = true;

        try {
            getSut().getPageCreator().getPublicFileViewPage();
        } catch (Exception e) {
            actualState = false;
        } finally {
            assertThat(actualState, is(expectedState));
        }
    }

    @Then("{I |}'$condition' see '$tabNames' tab on opened public file preview page")
    public void checkTabPresence(String condition, String tabNames) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualTabNames = getSut().getPageCreator().getPublicFileViewPage().getTabNames();

        for (String expectedTabName : tabNames.split(","))
            assertThat(actualTabNames, shouldState ? hasItem(expectedTabName) : not(hasItem(expectedTabName)));
    }
}