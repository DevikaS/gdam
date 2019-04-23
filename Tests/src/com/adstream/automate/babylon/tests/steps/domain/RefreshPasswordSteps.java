package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.refreshpassword.RefreshPasswordwithoutResetPage;
import com.adstream.automate.babylon.sut.pages.refreshpassword.ResetPasswordPage;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.openqa.selenium.By;

import java.util.List;
import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created by IntelliJ IDEA.
 * User: lynda-k
 * Date: 03.03.14
 * Time: 15:54
 */
public class RefreshPasswordSteps extends BaseStep {
    // | NewPassword | ConfirmPassword |
    @Given("{I |}filled refresh password form for user '$userEmail' with following data: $data")
    @When("{I |}fill refresh password form for user '$userEmail' with following data: $data")
    public User fillRefreshPasswordForm(String userEmail, ExamplesTable data) {
        User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userEmail));
        Map<String,String> row = parametrizeTabularRow(data);
        ResetPasswordPage page = getSut().getPageCreator().getRefreshPasswordPage();
        if (row.get("NewPassword") != null) {
            user.setPassword(row.get("NewPassword"));
            page.fillNewPasswordField(row.get("NewPassword"));
        }
        if (row.get("ConfirmPassword") != null) page.fillConfirmPasswordField(row.get("ConfirmPassword"));
        return user;
    }


    @Given("{I |}filled and confirmed refresh password form after expiry for user '$userEmail' with following data: $data")
    @When("{I |}fill and confirm refresh password form after expiry for user '$userEmail' with following data: $data")
    public void fillRefreshPasswordFormAfterExpiry(String userEmail, ExamplesTable data) {
        User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userEmail));
        Map<String,String> row = parametrizeTabularRow(data);
        RefreshPasswordwithoutResetPage page = getSut().getPageCreator().getRefreshPasswordwithoutResetPage();
        if (row.get("OldPassword") != null) page.fillOldPasswordField(row.get("OldPassword"));
        if (row.get("NewPassword") != null) {
            user.setPassword(row.get("NewPassword"));
            page.fillNewPasswordField(row.get("NewPassword"));
        }
        if (row.get("ConfirmPassword") != null) page.fillConfirmPasswordField(row.get("ConfirmPassword"));
       // return user;
        getSut().getPageCreator().getRefreshPasswordwithoutResetPage().clickRefreshButton();
        getData().setCurrentUser(user);
    }

    // | NewPassword | ConfirmPassword |
    @Given("{I |}refreshed password for user '$userEmail'  with following data: $data")
    @When("{I |}refresh password for user '$userEmail' with following data: $data")
    public void refreshPasswordWithData(String userEmail, ExamplesTable data) {
        User user = fillRefreshPasswordForm(userEmail, data);
        getSut().getPageCreator().getRefreshPasswordPage().clickRefreshButton();
        getData().setCurrentUser(user);
    }


    @When("{I |}Click on Confirm on Reset password page")
    public void confirmPasswordWithData() {
        getSut().getPageCreator().getRefreshPasswordPage().clickRefreshButton();
           }

    // | MinimumPasswordLength | UppercaseCharactersCount | NumbersCount |
    @Then("{I |}'$condition' see message about password rules on refresh password page with following attributes: $data")
    public void checkPasswordRulesAttributes(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        ResetPasswordPage page = getSut().getPageCreator().getRefreshPasswordPage();
        Map<String,String> params = parametrizeTabularRow(data);
        String expectedMessage = String.format("Your password must have a minimum of %s characters and include at least %s number(s), at least %s uppercase letter(s)",
                params.get("MinimumPasswordLength"), params.get("NumbersCount"), params.get("UppercaseCharactersCount"));
        String actualMessage = page.getBodyText();

        assertThat(actualMessage, shouldState ? containsString(expectedMessage) : not(containsString(expectedMessage)));
    }

    @Then("{I |}'$condition' see active Refresh button in refresh password page")
    public void checkActivityOfRefreshButtonRefreshPasswordPage(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getRefreshPasswordPage().isRefreshButtonActive();

        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' see error message '$expectedMessage' on the refresh password page")
    public void checkThatErrorMessagePresent(String condition, String expectedMessage) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualErrorMessages = getSut().getPageCreator().getRefreshPasswordPage().getListOfErrorMessages();
        assertThat(actualErrorMessages, shouldState ? hasItem(expectedMessage) : not(hasItem(expectedMessage)));
    }

    @Then("{I |}'$condition' be on the refresh password page")
    public void checkIsItRefreshPasswordPage(String condition) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        assertThat(getSut().getWebDriver().getCurrentUrl(), shouldState ? containsString("/refreshPassword?returnPath=/#/") : not(containsString("/refreshPassword?returnPath=/#/")));
    }

    @Then("{I |}'$condition' be on the reset password page")
    public void checkIsItResetPasswordPage(String condition) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        assertThat(getSut().getWebDriver().getCurrentUrl(), shouldState ? containsString("/password/reset?token") : not(containsString("/password/reset?token")));
    }

    @Then("{I |}'$shouldState' see error message '$message' on the page on clicking refresh password")
    public void checkErrorMessageOnPageOnrefreshPassword(String shouldState, String message) {
        getSut().getPageCreator().getRefreshPasswordPage().clickRefreshButton();
        if (!message.trim().isEmpty()) {
            String actualMessage = getSut().getWebDriver().findElement(By.cssSelector("#app-view .error, #app-main .error, [ng-app='resetPassword'] .error")).getText();
            assertThat("Check error messages on the page: ", actualMessage, shouldState.equals("should") ? equalTo(message) : equalTo(""));
        }
    }
}