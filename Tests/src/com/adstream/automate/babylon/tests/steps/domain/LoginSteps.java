package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.ResetPasswordPopUpWindow;
import com.adstream.automate.babylon.sut.pages.login.LoginPage;
import com.adstream.automate.babylon.sut.pages.registration.RegistrationWindow;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.junit.Assert;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import static org.hamcrest.Matchers.is;

/**
 * Created by IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 24.01.12
 * Time: 15:54
 */
public class LoginSteps extends BaseStep {

    @Given("I {am |}logged in as '$userType'")
    @When("I {am |}login as '$userType'")
    public static void loginAs(String userType) {
        User user = getData().getUserByType(userType);
        if (user != null) {
            doLogin(user.getEmail(), user.getPassword());
        }
        else
            doLogin(userType, getContext().defaultUserPassword);
    }

    @Given("I am on babylon Login page")
    @When("I go to babylon Login page")
    public static LoginPage openLoginPage() {
        getData().setCurrentUser(null);
        return getSut().getPageNavigator().getLoginPage();
    }

    @When("I login as user with login '$login' and password '$password'")
    @Given("I login as user with login '$login' and password '$password'")
    public static void doLogin(String login, String password) {
        if (!isLogged(login)) {
            User currentUser = getCoreApiAdmin().getUserByEmail(login);
            currentUser = currentUser != null ? currentUser.setPassword(password) : new User(); // fix user password
            try {
                openLoginPage().login(login, password);
            } finally {
                getData().setCurrentUser(currentUser);
            }
            if(!currentUser.isDisabled()) {
                //wait for base page
                getSut().getPageCreator().getBasePage();
            }
        } else {
            getSut().getPageNavigator().navigateTo(); //flush current site state;
            //wait for base page
            getSut().getPageCreator().getBasePage();
        }
    }

    @When("I trying to login as user with login '$login' and password '$password'")
    public static void tryToLogin(String login, String password) {
        openLoginPage().login(wrapUserEmailWithTestSession(login), password);
    }

    @When ("I fill fields login '$login' and password '$password'")
    public void fillLoginPageFields(String login, String password){
        getSut().getPageCreator().getLoginPage().fill(login,password);
    }

    @When("{I |}login to system as user with name '$login' and password '$password'")
    public void loginToSystem(String login, String password) {
        loginToApp(login, password);
    }

    @Given("I filled login '$login' and password '$password' and then login to system")
    @When("{I |}fill fields login '$login' and password '$password' and then login to system")
    public BasePage fillLoginPageFieldsThenLogin(String login, String password) {
        loginToApp(login, password);
        return new BasePage(getSut().getWebDriver());
    }

    private void loginToApp(String login, String password) {
        login = wrapUserEmailWithTestSession(login);
        User currentUser = getCoreApiAdmin().getUserByEmail(login);
        if (currentUser == null) {
            throw new IllegalStateException("There is no user with following email: " + login);
        } else {
            currentUser.setPassword(password);
        }
        LoginPage loginPage = getSut().getPageCreator().getLoginPage();
        try {
            loginPage.login(login, password);
        } finally {
            getData().setCurrentUser(currentUser);
        }
    }

    @Given("{I |}logged in as user with name '$userName' and password '$password'")
    @When("{I |}login as user with name '$userName' and password '$password'")
    public static void wrapNameAndLogin(String userName, String password) {
        userName = wrapUserEmailWithTestSession(userName);
        doLogin(userName, password);
    }

    private static boolean isLogged(String login) {
        log.debug("Is logged: " + login);
        log.debug("Current user is: " + getData().getCurrentUser());
        return login.equalsIgnoreCase(getData().getCurrentUser().getEmail());
    }

    @Given("{I |}logged in with details of '$userName'")
    @When("{I |}login with details of '$userName'")
    @Then("{I |}login with details of '$userName'")
    public void loginAsUser(String userName) {
       User user=getData().getUserByType(userName);
       if(user == null) {
          userName = wrapUserEmailWithTestSession(userName);
          doLogin(userName, getContext().defaultUserPassword);
        }
        else {
            doLogin(user.getEmail(), user.getPassword());
        }

    }

    @Given("{I |}login as '$userName' of Agency '$agency'")
    @When("{I |}login as '$userName' of Agency '$agency'")
    public void loginAsUserOfAgency(String userName,String agency) {
        User user=getData().getUserByType(userName);
        if(user == null) {
            userName = wrapUserEmailWithTestSession(userName);
            doLogin(userName, "abcdefghA1");
        }
        else {
            doLogin(user.getEmail(), user.getPassword());
        }
    }

    @When("{I |}login such as user '$user' and with updated password '$pass'")
    public void loginAsUserAndUpdatedPassword(String userName, String password) {
        userName = wrapUserEmailWithTestSession(userName);
        doLogin(userName, password);
    }

    @When("{I |}close by Cancel link Reset Password popup")
    public void clickCancelLink() {
        LoginPage loginPage = getSut().getPageNavigator().getLoginPage();
        ResetPasswordPopUpWindow resetPasswordPopUpWindow = loginPage.clickForgotPasswordLink();
        resetPasswordPopUpWindow.cancel.click();
        Common.sleep(1000);
    }

    @Then("{I |}'$condition' see element '$element' has value '$expectedValue' on login page")
    public void checkColour(String condition, String element, String expectedValue) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        LoginPage page = getSut().getPageCreator().getLoginPage();
        String actualValue;

        if (element.equalsIgnoreCase("ButtonColour")) {
            actualValue = page.getButtonColour();
        } else if (element.equalsIgnoreCase("LinkColour")){
            actualValue = page.getLinkColour();
        } else if (element.equalsIgnoreCase("FooterColour")){
            actualValue = page.getFooterColour();
        } else if (element.equalsIgnoreCase("TextColour")) {
            actualValue = page.getTextColour();
        } else if (element.equalsIgnoreCase("Logo")) {
            actualValue = page.getTextColour();
        } else if (element.equalsIgnoreCase("WelcomeMessage")) {
            actualValue = page.getWelcomeMessage();
        } else {
            throw new IllegalArgumentException(String.format("Unknown element: %s on ", element));
        }

        assertThat(actualValue, shouldState ? equalToIgnoringCase(expectedValue) : not(equalToIgnoringCase(expectedValue)));
    }

    @Then("{I |}'$should' see custom logo on login page")
    public void checkCustomLogo(String condition){
        LoginPage page = getSut().getPageCreator().getLoginPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean expectedState = page.isNewLogoExist();
        assertThat(expectedState, shouldState ? equalTo(expectedState) : not(expectedState));
    }

    @Then("{I |}'$should' see custom background on login page")
    public void checkCustomBg(String condition){
        LoginPage page = getSut().getPageCreator().getLoginPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean expectedState = page.isNewBackground();
        assertThat(expectedState, shouldState ? equalTo(expectedState) : not(expectedState));
    }

    @Then("{I |}'$condition' see default '$logo' on login page")
    public void checkOnDefaultPicturesOnLoginPage(String condition, String element) {
        LoginPage page = getSut().getPageCreator().getLoginPage();
        boolean shouldState = condition.equalsIgnoreCase("should");

        if (shouldState) {
            if(element.equalsIgnoreCase("logo"))
                assertThat(page.isDefaultLogo(), equalTo(shouldState));
            else if (element.equalsIgnoreCase("background"))
                assertThat(page.isDefaultBackground(), equalTo(shouldState));
            else
                throw new IllegalArgumentException(String.format("Incorrect element exception: %s\n Could be 'logo' or 'background'", element));
        }
    }

    @Then("{I |}'$condition' see login page")
    public void checkIsItLoginPage(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = true;
        try {
            getSut().getPageCreator().getLoginPage().isLoaded();
        } catch (Exception e) {
            actualState = false;
        }
        assertThat(actualState, is(expectedState));
    }
    @Given("{I |}clicked Reset Password button after typed in the field Email on Reset Password popup following email '$email'")
    @When("{I |}click Reset Password button after typed in the field Email on Reset Password popup following email '$email'")
    public void typeEmails(String email) {
        LoginPage loginPage = getSut().getPageNavigator().getLoginPage();
        ResetPasswordPopUpWindow resetPasswordPopUpWindow = loginPage.clickForgotPasswordLink();
        resetPasswordPopUpWindow.typeEmail(wrapUserEmailWithTestSession(email));
        Common.sleep(2000);
        resetPasswordPopUpWindow.clickAction();
    }

    @When("{I |}click Reset Password button after an following text '$text' typed in the field Email on Reset Password popup")
    public void typeText(String text) {
        LoginPage loginPage = getSut().getPageNavigator().getLoginPage();
        ResetPasswordPopUpWindow resetPasswordPopUpWindow = loginPage.clickForgotPasswordLink();
        resetPasswordPopUpWindow.typeEmail(text);
        resetPasswordPopUpWindow.action.click();
        Common.sleep(1000);
    }

    @Then("{I |}should see message '$message' on reset password popup")
    public void checkResetPasswordMessage(String message) {
    LoginPage loginPage = getSut().getPageCreator().getLoginPage();
        ResetPasswordPopUpWindow resetPasswordPopUpWindow = new ResetPasswordPopUpWindow(loginPage);
        String actualMessage = resetPasswordPopUpWindow.getNotificationErrorMessage();
        assertThat(actualMessage, equalToIgnoringCase(message));
    }

    @Then("{I |}should see alert message '$message' on Login page")
    public void checkAlertMessage(String message) {
        String actualMessage = getSut().getPageCreator().getLoginPage().getAlertMessage();
        assertThat(actualMessage, equalToIgnoringCase(message));
    }

    @Then("I '$should' see red inputs on Login page")
    public static void checkPageErrors(String message) {
        boolean should = message.equals("should");
        boolean pageOnErrors = getSut().getPageCreator().getLoginPage().isAnyErrorsOnPage();
        assertThat(pageOnErrors, is(should));
    }

    @Then ("{I |}'$condition' see '$notificationType' message notification '$message' on Login page")
    public void checkNotificationMessage(String condition, String notificationType, String message){
        String actualMessage;
        if (notificationType.equalsIgnoreCase("error")) {
            actualMessage = getSut().getPageCreator().getLoginPage().getNotificationErrorMessage();
        } else if (notificationType.equalsIgnoreCase("success")) {
            actualMessage = getSut().getPageCreator().getLoginPage().getNotificationSuccessMessage();
        } else {
            throw new IllegalArgumentException(String.format("Unknown notification type given '%s', expected 'error' or 'success'", notificationType));
        }

        assertThat(actualMessage, equalToIgnoringWhiteSpace(message));
    }

    @When("I type '$componentName' on the invite popup with value '$value'")
    public void typeUserName(String componentName, String value) {
        RegistrationWindow registrationWindow = getSut().getPageCreator().getRegistrationWindow();
        if (componentName.toLowerCase().contains("first")) registrationWindow.setFirstName(value);
        else if (componentName.toLowerCase().contains("last")) registrationWindow.setLastName(value);
        else Assert.fail("Parameter 'componentName' has incorrect value");
    }

    @When("{I |}accept new user with first name '$firstName' and last name '$lastName'")
    public void acceptNewUser(String firstName, String lastName) {
        RegistrationWindow registrationWindow = getSut().getPageCreator().getRegistrationWindow();
        registrationWindow.setFirstName(firstName);
        registrationWindow.setLastName(lastName);
        registrationWindow.setPassword(getContext().defaultUserPassword);
        registrationWindow.setPasswordConfirm(getContext().defaultUserPassword);
        String registreadEmail = registrationWindow.getEmail();
        registrationWindow.clickSignUpButton();
        Common.sleep(5000);
        //TODO refactor loginToApp method
        User currentUser = getCoreApiAdmin().getUserByEmail(registreadEmail);
        if (currentUser == null) {
            throw new IllegalStateException("There is no user with following email: " + registreadEmail);
        } else {
            currentUser.setPassword(getContext().defaultUserPassword);
        }
        getData().setCurrentUser(currentUser);
    }

    @When("I login to Adstream platform with '$userName' via Media manager")
    public void fillAdstreamLoginPageViaMM(String userName) {
        userName = wrapUserEmailWithTestSession(userName);
        getSut().getPageCreator().getLoginPage().login(userName, getContext().defaultUserPassword);
    }
}