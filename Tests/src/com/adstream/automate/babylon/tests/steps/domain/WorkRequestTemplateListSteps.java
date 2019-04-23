package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Agency;
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
public class WorkRequestTemplateListSteps extends AbstractProjectSteps {

    @Given("I am on work request template list page")
    @When("{I |}go to {W|w}ork {R|r}equest {T|t}emplate list page")
    public AdbankWorkRequestTemplatesListPage openObjectListPagetemplate() {
        return getSut().getPageNavigator().getWorkRequestTemplatesListPage();
    }
    //jbehave throws error for dupes hence rewriting this as new method
    public AdbankWorkRequestTemplatesListPage openObjectListPage() {
        return getSut().getPageNavigator().getWorkRequestTemplatesListPage();
    }

    public Project getObjectByName(String objectName) {
        return getCoreApi().getWorkRequestTemplateByName(objectName);
    }

    public AdbankWorkRequestTemplateOverviewPage openWorkRequestTemplateOverviewPage(String objectId) {
        return getSut().getPageNavigator().getWorkRequestTemplateOverviewPage(objectId);
    }

    public AdbankWorkRequestTemplateSettingsPage openObjectSettingsPage(String objectId) {
        return openWorkRequestTemplateOverviewPage(objectId).clickEdit();
    }

    public AdbankWorkRequestTemplatesListPage getCurrentObjectListPage() {
        return getSut().getPageCreator().getWorkRequestTemplatesListPage();
    }

    @When("{I |}click use template button next to work template '$templateName' on opened work templates list page")
    public void clickUseTemplateButton(String templateName) {
        getCurrentObjectListPage().clickUseTemplateButton(wrapVariableWithTestSession(templateName));
    }

    @When("{I |}select business unit '$businessUnit' on work requests template list page")
    public void selectBusinessUnitonWorkRequestTemplate(Agency businessUnit) {
        openObjectListPage().selectBusinessUnit(businessUnit.getName());
    }

    @Then("{I should see |}'$WorkRequestTemplateName' work request template in work request template{s|} list")
    public void checkPresenceInTemplateList(@Named("Template Name") String workRequestTemplateName) {
        GenericSteps.refreshPage();
        workRequestTemplateName = wrapVariableWithTestSession(workRequestTemplateName.replace("\\\\", "\\").replace("\\$", "$"));
        boolean existInList = openObjectListPage().isObjectExistInList(workRequestTemplateName);
        assertThat("exist work request template with name " + workRequestTemplateName, existInList, is(true));
    }

    @Then("{I |}'$shouldState' see following work request templates '$WorkRequestTemplateName' in work request template{s|} list")
    public void checkPresenceInTemplateList(String shouldState, String workRequestTemplateName) {
        GenericSteps.refreshPage();
        boolean state = shouldState.equalsIgnoreCase("should");
        for (String wrName: workRequestTemplateName.split(",")) {
            wrName = wrapVariableWithTestSession(wrName.replace("\\\\", "\\").replace("\\$", "$"));
            boolean existInList = openObjectListPage().isObjectExistInList(wrName);
            assertThat("exist work request template with name " + wrName, existInList, is(state));
        }
    }

}
