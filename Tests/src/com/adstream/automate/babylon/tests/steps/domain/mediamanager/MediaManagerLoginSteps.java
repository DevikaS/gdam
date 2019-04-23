package com.adstream.automate.babylon.tests.steps.domain.mediamanager;

import com.adstream.automate.babylon.sut.pages.mediamanager.MediaManagerLoginPage;
import com.adstream.automate.babylon.sut.pages.mediamanager.MediaManagerRegistrationForm;
import com.adstream.automate.babylon.sut.pages.mediamanager.MediaMangerBasePage;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.hamcrest.StringByRegExpCheck;
import com.adstream.automate.utils.Common;

import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import static org.hamcrest.MatcherAssert.assertThat;

/**
 * Created by Saritha.Dhanala on 24/01/2018.
 */
public class MediaManagerLoginSteps  extends BaseStep {
    static int userCount = 0;
    private MediaManagerLoginPage getCurrentMediaManagerLoginPage() {
        return getSut().getPageCreator().getMMLoginPage();
    }

    @Given("I am on Media Manager Login page")
    @When("{I |}go to Media Manager Login page")
    public void openMMLoginPage() {
        getSut().getPageNavigator().getMMLoginPage();
    }

    @Given("I enter username '$login' and password '$pass in media manager")
    @When("I entered username '$login' and password '$pass' in media manager")
    public  void doMMLogin(String login, String pass) {
        getCurrentMediaManagerLoginPage().enterUserName(login);
        getCurrentMediaManagerLoginPage().enterPassword(pass);

    }

    @Given("I login to media manager with username '$uName' and password '$pass'")
    @When("I go to media manager with username '$uName' and password '$pass'")
    public  void loginToMediaManager(String uName, String pass) {
        openMMLoginPage();
        Common.sleep(1000);
       if(getCurrentMediaManagerLoginPage().isLoginButtonVisible()) {
            doMMLogin(uName, pass);
            getCurrentMediaManagerLoginPage().clickLoginButton();
        if(userCount == 0 && getCurrentMediaManagerLoginPage().isErrorMessageExists()) {
                signUp(uName, pass);
                openMMLoginPage();
                doMMLogin(uName, pass);
                getCurrentMediaManagerLoginPage().clickLoginButton();
            userCount++;
            }
        }
    }

    @Given("I logged in to media manager as '$uName'")
    @When("I log in to media manager as '$uName'")
    public  void loginWithSessionUserToMM(String uname) {
        openMMLoginPage();
        if(getCurrentMediaManagerLoginPage().isLoginButtonVisible()) {
            String email =  wrapVariableWithTestSession(uname) + "@adstream.com";
            doMMLogin(email, "abcdefghA1");
            getCurrentMediaManagerLoginPage().clickLoginButton();

        }
    }


    @When("I logout from media manager")
    @Then("I logout from media manager")
    public void logoutFromMM(){
        getSut().getPageCreator().getMMBasePage().clickLogout();
        Common.sleep(1000);
    }


    @Then("{I should see |}warning message '$message'")
    public static void checkWarningMessage(String message) {
        if (!message.trim().isEmpty()) {
            String actualMessage = getSut().getPageCreator().getMMBasePage().getWarningMessage();
            assertThat(actualMessage, StringByRegExpCheck.matches(message));
        }
    }

    @Given("{I |}registered a new user with username '$uname' in media manager")
    @When("{I |}register a new user with username '$uname' in media manager")
    public void registerUSer(String uname){
      String email = wrapVariableWithTestSession(uname) + "@adstream.com";
      signUp(email,"abcdefghA1");

    }


    @When("{I |}fill following fields for registration in media manager: $fieldsTable")
    public void signUp(String email, String password) {
        MediaManagerRegistrationForm n = getSut().getPageNavigator().getMMLoginPage().clickRegisterLink();
        n.fillRegisterForm("First name", "Auto");
        n.fillRegisterForm("Last name", "Tester");
        n.fillRegisterForm("Email", email);
        n.fillRegisterForm("Password", password);
        n.fillRegisterForm("Confirm password", password);
        n.clickRegisterButton();
        if(!n.isErrorMessageExists()) {
            n.acceptPrivacyCondition();
            authenticateExternalUser(email);
        }
    }

    @When("{I |}authenticate '$email' vai mail hog")
    public void authenticateExternalUser(String newUSer){
       String userName =  wrapVariableWithTestSession(newUSer);
        new MediaMangerBasePage(getSut().getWebDriver()).authenticateNewExternalUSer(userName);
    }


}
