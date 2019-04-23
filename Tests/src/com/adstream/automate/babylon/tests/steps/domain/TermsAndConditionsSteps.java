package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.sut.pages.admin.tnc.TermsAndConditionsPage;
import com.adstream.automate.babylon.sut.pages.admin.tnc.elements.TermsAndConditionsPopup;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.utils.Common;
import org.apache.commons.lang3.StringUtils;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * User: lynda-k
 * Date: 28.02.14
 * Time: 09:00
 */
public class TermsAndConditionsSteps extends BaseStep {
    private TermsAndConditionsPage getTermsAndConditionsPage() {
        return getSut().getPageCreator().getTermsAndConditionsPage();
    }

    @Given("{I am |}on the T&C page")
    @When("{I |}go to the T&C page")
    public TermsAndConditionsPage openTermsAndConditionsPage() {
        Common.sleep(2000);
        return getSut().getPageNavigator().getTermsAndConditionsPage();
    }

    @Given("{I |}filled terms and conditions textbox with text '$text' on T&C page")
    @When("{I |}fill terms and conditions textbox with text '$text' on T&C page")
    public void fillTnCEntry(String text) {
        openTermsAndConditionsPage().fillEntryTextBox(text);
    }

    @Given("{I |}filled terms and conditions textbox with '$copiesCount' copies of text '$text' on T&C page")
    @When("{I |}fill terms and conditions textbox with '$copiesCount' copies of text '$text' on T&C page")
    public void fillTnCEntry(int copiesCount, String text) {
        openTermsAndConditionsPage().fillEntryTextBox(StringUtils.repeat(text, copiesCount));
    }

    @Given("{I |}saved current terms and conditions on opened T&C page")
    @When("{I |}save current terms and conditions on opened T&C page")
    public void saveTnC() {
        getTermsAndConditionsPage().clickSaveButton();
    }

    @When("{I |}{edit|add} following Terms And Condition to '$terms' on project '$project'")
    public void saveProjectTnC(String terms, String project) {
        getSut().getPageNavigator().getProjectListPage().clickProjectName(wrapVariableWithTestSession(project));
        getSut().getPageCreator().getProjectOverviewPage().clickEdit();
        getSut().getPageCreator().getCreateProjectPage().fillFieldByName("Terms & Conditions", terms);
    }

    @Given("{I |}deleted current terms and conditions on opened T&C page")
    @When("{I |}delete current terms and conditions on opened T&C page")
    public void deleteTnCOnOpenedPage() {
        getTermsAndConditionsPage().clickDeleteButton();
    }

    @Given("{I |}deleted terms and conditions on T&C page")
    @When("{I |}delete terms and conditions on T&C page")
    public void deleteTnC() {
        openTermsAndConditionsPage().clickDeleteButton();
    }

    @Given("{I |}enabled current terms and conditions for projects on opened T&C page")
    @When("{I |}enable current terms and conditions for projects on opened T&C page")
    public void enableTnCForProjects() {
        getTermsAndConditionsPage().checkEnableForProjectsCheckbox();
        Common.sleep(4000);
    }

    @Given("{I |}disabled current terms and conditions for projects on opened T&C page")
    @When("{I |}disable current terms and conditions for projects on opened T&C page")
    public void disableTnCForProjects() {
        getTermsAndConditionsPage().uncheckEnableForProjectsCheckbox();
        Common.sleep(2000);
    }

    // state: on, off
    @Given("{I |}turned '$state' terms and conditions for projects")
    public void changeTnCStateForProjects(String state) {
        boolean enabled = state.equalsIgnoreCase("on");
        TermsAndConditionsPage page = openTermsAndConditionsPage();
        page.setEnableForProjects(enabled);
        page.clickSaveButton();
    }

    @Given("{I |}accepted agency Terms and Conditions")
    @When("{I |}accept agency Terms and Conditions")
    public void acceptTnCPopup() {
        new TermsAndConditionsPopup(getSut().getPageCreator().getBasePage()).clickAcceptButton();
    }

    @Given("{I |}declined agency Terms and Conditions")
    @When("{I |}decline agency Terms and Conditions")
    public void declineTnCPopup() {
        new TermsAndConditionsPopup(getSut().getPageCreator().getBasePage()).clickDeclineLink();
        getData().setCurrentUser(null);
    }

    @Then("{I |}'$condition' see terms and conditions text '$expectedText' on T&C page")
    public void checkTermsAndConditionsTextboxValue(String condition, String expectedText) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String actualText = openTermsAndConditionsPage().getEntryTextBoxValue();

        assertThat(actualText, shouldState ? equalTo(expectedText) : not(equalTo(expectedText)));
    }

    @Then("{I |}'$condition' see terms and conditions text '$expectedText' copied '$copiesCount' times on T&C page")
    public void checkTermsAndConditionsTextboxValue(String condition, String expectedText, int copiesCount) {
        checkTermsAndConditionsTextboxValue(condition, StringUtils.repeat(expectedText, copiesCount));
    }

    @Then("{I |}'$condition' see agency Terms and Conditions text '$expectedText' on opened Terms and Conditions popup")
    public void checkTermsAndConditionsPopupTextboxValue(String condition, String expectedText) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String actualText = new TermsAndConditionsPopup(getSut().getPageCreator().getBasePage()).getEntryTextBoxValue();

        assertThat(actualText, shouldState ? equalTo(expectedText) : not(equalTo(expectedText)));
    }

    @Then("{I |}'$condition' see Terms and Conditions popup")
    public void checkTermsAndConditionsPopupIsOpened(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = true;

        try {
            new TermsAndConditionsPopup(getSut().getPageCreator().getBasePage()).getEntryTextBoxValue();
        } catch (Exception e) {
            actualState = false;
        }

        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' see agency Terms and Conditions text '$expectedText' on opened Terms and Conditions popup and accept rules")
    public void checkTermsAndConditionsPopupTextboxValueAndClickSave(String condition, String expectedText) {
        checkTermsAndConditionsPopupTextboxValue(condition, expectedText);
        acceptTnCPopup();
    }

    @Then("{I |}'$condition' see agency Terms and Conditions popup")
    public void checkTermsAndConditionsPopupVisibility(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = true;

        try {
            new TermsAndConditionsPopup(getSut().getPageCreator().getBasePage());
        } catch (Exception e) {
            actualState = false;
        }

        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' see 'Terms and Conditions' link on project Overview page")
    public void checkTermsAndConditionsLink(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getProjectOverviewPage().isTermsAndConditionsLinkVisible();
        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' see selected 'Enable Terms & Conditions for project' checkbox")
    public void checkOnCheckboxState(String condition) {
        boolean expectedState = condition.equals("should");
        boolean actualState = openTermsAndConditionsPage().isEnabledForProjects();
        assertThat(actualState, is(expectedState));
    }
}