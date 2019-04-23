package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.hamcrest.StringByRegExpCheck;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Alias;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.openqa.selenium.By;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created with IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 04.05.12
 * Time: 12:50
 */
public class BabylonSteps extends BaseStep {
    private String currentScrollPosition;

    @Given("{I |}saved current scroll position")
    @When("{I |}save current scroll position")
    public void saveCurrentPosition() {
        this.currentScrollPosition = getSut().getPageCreator().getBasePage().getCurrentScrollPosition();
    }

    @Then("{I should see |}page '$page'")
    public static void checkCurrentHashPage(String page) {
        String currentPage = getCurrentPageName();
        if (currentPage.startsWith("/") && currentPage.length() > 1) {
            currentPage = currentPage.substring(1);
        }
        if (page.startsWith("/") && page.length() > 1) {
            page = page.substring(1);
        }
        assertThat(currentPage, equalToIgnoringCase(page));
    }

    @Then("{I should see |}interface '$product'")
    public static void checkCurrentProduct(String product) {
        assertThat(getCurrentInterfaceName(), equalToIgnoringCase(product));
    }

    public static String getCurrentInterfaceName() {
        // http://10.0.25.57:3000/adbank#projects/projects:create
        // matches group(1) - host:port
        // group(2) - interface
        // group(3) - page
        //String fullPattern = Pattern.compile("^https?://([a-zA-Z\\.:\\d]+)/?([a-zA-Z]+)?#?([a-zA-Z/:]*)?");
        Pattern pattern = Pattern.compile("^https?://[a-zA-Z\\.:\\d\\-]+/?([a-zA-Z]+)?");
        Matcher matcher = pattern.matcher(getSut().getWebDriver().getCurrentUrl());
        if (matcher.find()) {
            return matcher.group(1);
        }
        return "";
    }

    public static String getCurrentPageName() {
        String[] url = getSut().getWebDriver().getCurrentUrl().split("#");
        return url.length > 1 ? url[1] : "";
    }

    @Given("I logout from account")
    @When("{I |}logout from account")
    @Then("{I |}logout from account")
    public void logout() {
        getData().setCurrentUser(null);
        getSut().getPageNavigator().getLoginPage();
    }

    @Then("I should see that user '$userName' is logged now")
    public void checkLoggedUser(String userName) {
        String fullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userName)).getFullName();
        By elementLocator = getSut().getUIMap().getByPageUrl(getSut().getPageUrl(), "MainMenu");
        assertThat(getSut().getWebDriver().findElement(elementLocator).getText(), equalTo(fullName));
    }

    @Then(value = "{I should see |}message warning '$message' for project '$project'", priority = 1)
    public static void checkMessage(String message, String projectName) {
        String val1 = "";
        if(message.contains(projectName))
            val1 = projectName;

        message = message.replace(val1, wrapVariableWithTestSession(val1));
        checkWarningMessage("should", message);
    }

    @Then("{I should see |}message {warning|success} '$message'")
    @Alias("{I should see |}message error '$message'")
    public static void checkWarningMessage(String message) {
        String actualMessage = getSut().getPageCreator().getBasePage().getPopUpNotificationMessage();
        if (!message.trim().isEmpty()) {
            assertThat(actualMessage, StringByRegExpCheck.matches(message));
        }
    }

    // For 14650
    @Then("{I should see |}message {warning|success} '$message' on global roles page")
    @Alias("{I should see |}message error '$message' on global roles page")
    public static void checkWarningMessageonGlobalRolesPage(String message) {
        if (!message.trim().isEmpty()) {
            String actualMessage = getSut().getPageCreator().getBasePage().getPopUpNotificationMessage_GlobalRolesPage();
            assertThat(actualMessage, StringByRegExpCheck.matches(message));
        }
    }

    @Then("{I should see |}message without delay {warning|success} '$message'")
    @Alias("{I should see |}message error without delay '$message'")
    public static void checkWarningMessage_withoutDelay(String message) {
        if (!message.trim().isEmpty()) {
            String actualMessage = getSut().getPageCreator().getBasePage().getPopUpNotificationMessage_withoutWait();
            assertThat(actualMessage, StringByRegExpCheck.matches(message));
        }
    }

    @Then("{I should see |} error message '$message'")
    public static void checkErrorMessage(String message) {
        if (!message.trim().isEmpty()) {
            String actualMessage = getSut().getPageCreator().getBasePage().getErrorMessage();
            assertThat(actualMessage, StringByRegExpCheck.matches(message));
        }
    }


    @Then("{I should see |}message {warning|success} '$message'on same page")
    @Alias("{I should see |}message error '$message' on same page")
    public static void checkWarningMessageWithoutReload(String message) {
        if (!message.trim().isEmpty())
        {
            String actualMessage = getSut().getPageCreator().getBaseAdminPage().getStandardPopUpMessage();
            assertThat(actualMessage, StringByRegExpCheck.matches(message));
        }
    }

    // | action: OK | Cancel
    @When("{I |}click '$action' on the alert")
    public void actionOnPopUp(String action){
        getSut().getPageCreator().getBasePage().actionOnAlert(action);
    }

    @Then("{I |}'$shouldState' see error message '$message' on the page")
    public void checkErrorMessageOnPage(String shouldState, String message) {
       if (!message.trim().isEmpty()) {
            String actualMessage = getSut().getPageCreator().getBasePage().getErrorMessageOnThePage();
            assertThat("Check error messages on the page: ", actualMessage, shouldState.equals("should") ? equalTo(message) : equalTo(""));
        }
    }

    @Then("{I |}'$condition' see warning message '$message' on page")
    public static void checkWarningMessage(String condition, String message) {
        if (!message.trim().isEmpty()) {
            boolean shouldState = condition.equalsIgnoreCase("should");
            List<String> actualMessages = getSut().getPageCreator().getBasePage().getPopUpNotificationMessages();
            assertThat(actualMessages, shouldState ? hasItem(message) : not(hasItem(message)));
        }
    }


    @Then("{I should see |}message warning about duplicate '$projectName' project's name with job number '$jobNumber'")
    public static void checkWarningMessageAboutDuplicateProjectsName(String projectName, String jobNumber) {
        if (!projectName.trim().isEmpty()) {
            String actualMessage = getSut().getPageCreator().getBasePage().getPopUpNotificationMessage();
            projectName = wrapVariableWithTestSession(projectName);
            String expectedResult = projectName + " with job id Some(" + jobNumber + ") Already exists." ;
            assertThat(actualMessage, equalToIgnoringWhiteSpace(expectedResult));
        }
    }

    @Then("{I should see |}message exclamation '$message'")
    public static void checkExclamationMessage(String expectedMessage) {
        String actualMessage = getSut().getPageCreator().getBasePage().getPopUpExclamationMessage();
        assertThat(actualMessage, equalToIgnoringWhiteSpace(expectedMessage));
    }

    @Then ("I should see message notification '$message'")
    public void checkNotificationMessage(String message){
        String actualMessage = getSut().getPageCreator().getBasePage().getNotificationMessage();
        assertThat(actualMessage, equalToIgnoringWhiteSpace(message));
    }

    @Then("{I |}'$condition' see alert message '$message'")
    public void checkAlertMessage(String condition, String message) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        BasePage basePage = getSut().getPageCreator().getBasePage();
        if (shouldState) {
            assertThat(basePage.getAlertMessage(), equalToIgnoringCase(message));
        } else {
            assertThat(basePage.isAlertMessageVisible(), is(false));
        }
    }

    @Then("{I |}'$condition' see error message '$message'")
    public void checkErrorMessage(String condition, String message) {
        BasePage basePage = getSut().getPageCreator().getBasePage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        if (shouldState) {
            assertThat(basePage.getErrorMessage(), equalToIgnoringCase(message));
        } else {
            assertThat(basePage.isErrorMessageVisible(), is(false));
        }
    }

    @Then("I '$should' see red inputs on page")
    public static void checkPageErrors(String message) {
        boolean should = message.equals("should");
        boolean pageOnErrors = getSut().getPageCreator().getBasePage().isAnyErrorsOnPage();
        assertThat(pageOnErrors, is(should));
    }

    @Then("I '$should' see active Save button")
    public static void checkSaveButton(String message) {
        boolean should = message.equals("should");
        boolean isSaveButtonActive = getSut().getPageCreator().getBasePage().isSaveButtonActive();
        assertThat(isSaveButtonActive, is(should));
    }

    @Then("{I |}'$condition' see empty page")
    public static void checkThatPageEmpty(String condition) {
        boolean shouldState = condition.equals("should");
        assertThat(getSut().getPageCreator().getBasePage().isEmpty(), is(shouldState));
    }

    @Then("{I |}should see be on current scroll position")
    public void checkScrollPosition() {
        Common.sleep(2000);
        //FAB-201 -- Tolerance scroll position difference of 3 pixels is added
        assertThat(Integer.parseInt(this.currentScrollPosition)-Integer.parseInt(getSut().getPageCreator().getBasePage().getCurrentScrollPosition()), lessThan(3));
    }
}
