package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.sut.pages.adbank.projects.*;
import com.adstream.automate.babylon.tests.steps.core.GenericSteps;
import org.jbehave.core.annotations.*;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.is;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 9/11/14
 * Time: 12:46 PM

 */
public class WorkRequestListSteps  extends AbstractProjectSteps {

    @Given("I am on work request list page")
    @When("{I |}go to work request list page")
    public AdbankWorkRequestListPage openObjectListPageworkrequestlist() {
        getSut().getWebDriver().findElement(getSut().getUIMap().getByPageName("BasePage", "Projects")).click();
        return getSut().getPageNavigator().getWorkRequestListPage();
    }
    //jbehave throws error for dupes hence rewriting this as new method
    public AdbankWorkRequestListPage openObjectListPage() {
        getSut().getWebDriver().findElement(getSut().getUIMap().getByPageName("BasePage", "Projects")).click();
        return getSut().getPageNavigator().getWorkRequestListPage();
    }

    public Project getObjectByName(String objectName) {
        return getCoreApi().getWorkRequestByName(objectName);
    }

    public AdbankWorkRequestOverviewPage openWorkRequestOverviewPage(String objectId) {
        return getSut().getPageNavigator().getWorkRequestOverviewPage(objectId);
    }

    public AdbankWorkRequestSettingsPage openObjectSettingsPage(String objectId) {
        return openWorkRequestOverviewPage(objectId).clickEdit();
    }

    public AdbankWorkRequestListPage getCurrentObjectListPage() {
        return getSut().getPageCreator().getWorkRequestListPage();
    }

    @Then("{I should see |}'$WorkRequestName' work request in work request list")
    public void checkPresenceInTemplateList(@Named("Template Name") String workRequestName) {
        GenericSteps.refreshPage();
        workRequestName = wrapVariableWithTestSession(workRequestName.replace("\\\\", "\\").replace("\\$", "$"));
        boolean existInList = openObjectListPage().isObjectExistInList(workRequestName);
        assertThat("exist work request template with name " + workRequestName, existInList, is(true));
    }

    @Then("I shouldn't see '$WorkRequestName' work request in work request list")
    public void checkPresenceInTemplateListNegative(@Named("Template Name") String workRequestName) {
        GenericSteps.refreshPage();
        workRequestName = wrapVariableWithTestSession(workRequestName.replace("\\\\", "\\").replace("\\$", "$"));
        boolean existInList = openObjectListPage().isObjectExistInList(workRequestName);
        assertThat("exist work request template with name " + workRequestName, existInList, is(false));
    }

        @Then("{I |}'$shouldState' see following work request '$WorkRequestName' in work request list")
    public void checkPresenceInTemplateList(String shouldState, String workRequestName) {
        GenericSteps.refreshPage();
        boolean state = shouldState.equalsIgnoreCase("should");
        for (String wrName: workRequestName.split(",")) {
            wrName = wrapVariableWithTestSession(wrName.replace("\\\\", "\\").replace("\\$", "$"));
            boolean existInList = openObjectListPage().isObjectExistInList(wrName);
            assertThat("exist work request template with name " + wrName, existInList, is(state));
        }
    }
}
