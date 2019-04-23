package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.data.Logo;
import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.ResetPasswordPopUpWindow;
import com.adstream.automate.babylon.sut.pages.login.LoginPage;
import com.adstream.automate.babylon.sut.pages.registration.RegistrationPage;
import com.adstream.automate.babylon.sut.pages.registration.RegistrationWindow;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;
import org.junit.Assert;

import java.util.HashMap;
import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created by IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 24.01.12
 * Time: 15:54
 */
public class RegistrationSteps extends BaseStep {
    // | FirstName | LastName | Email | Password | ConfirmPassword |
    @When("{I |}register user with following fields on opened registration page: $data")
    public void registerUser(ExamplesTable data) {
        getSut().getPageCreator().getRegistrationPage().register(parametrizeTabularRow(data));
    }

    // | FirstName | LastName | Email | Password | ConfirmPassword |
    @When("{I |}fill registration form with following fields: $data")
    public void fillRegistrationForm(ExamplesTable data) {
        getSut().getPageCreator().getRegistrationPage().fill(parametrizeTabularRow(data));
    }

    // | Logo | Background | TextColor | FooterTextColor | ButtonColor | LinkColor | FooterColor | BackgroundColor | FooterText | Message |
    @Then("{I |}'$condition' see following attributes on opened registration page: $data")
    public void checkRegistrationPageAttributes(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        RegistrationPage page = getSut().getPageCreator().getRegistrationPage();
        Map<String,String> expectedAttributes = parametrizeTabularRow(data);
        Map<String,String> actualAttributes = new HashMap<String,String>();

        for (String elementName : expectedAttributes.keySet()) {
            if (elementName.equalsIgnoreCase("TextColor")) {
                actualAttributes.put(elementName, page.getTextColor());
            } else if (elementName.equalsIgnoreCase("FooterTextColor")){
                actualAttributes.put(elementName, page.getFooterTextColor());
            } else if (elementName.equalsIgnoreCase("ButtonColor")){
                actualAttributes.put(elementName, page.getButtonColor());
            } else if (elementName.equalsIgnoreCase("LinkColor")) {
                actualAttributes.put(elementName, page.getLinkColor());
            } else if (elementName.equalsIgnoreCase("FooterColor")) {
                actualAttributes.put(elementName, page.getFooterColor());
            } else if (elementName.equalsIgnoreCase("BackgroundColor")) {
                actualAttributes.put(elementName, page.getBackgroundColor());
            } else if (elementName.equalsIgnoreCase("FooterText")) {
                actualAttributes.put(elementName, page.getFooterText());
            } else if (elementName.equalsIgnoreCase("Message")) {
                actualAttributes.put(elementName, page.getMessage());
            } else if (elementName.equalsIgnoreCase("BackgroundAlign")) {
                actualAttributes.put(elementName, page.getBackgroundAlign());
            } else if (elementName.equalsIgnoreCase("Logo")) {
                expectedAttributes.put(elementName, Integer.toString(Logo.valueOf(expectedAttributes.get(elementName)).getBase64String().length()));
                actualAttributes.put(elementName, Integer.toString(page.getLogoBase64String().length()));
            } else if (elementName.equalsIgnoreCase("Background")) {
                expectedAttributes.put(elementName, Integer.toString(Logo.valueOf(expectedAttributes.get(elementName)).getBase64String().length()));
                actualAttributes.put(elementName, Integer.toString(page.getBackgroundBase64String().length()));
            }
        }

        assertThat(actualAttributes, shouldState ? equalTo(expectedAttributes) : not(equalTo(expectedAttributes)));
    }

    // | MinimumPasswordLength | UppercaseCharactersCount | NumbersCount |
    @Then("{I |}'$condition' see message about password rules on registration page with following attributes: $data")
    public void checkPasswordRulesAttributes(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        RegistrationPage page = getSut().getPageCreator().getRegistrationPage();
        Map<String,String> params = parametrizeTabularRow(data);
        String expectedMessage = String.format("Your password must have a minimum of %s characters and include at least %s number(s), at least %s uppercase letter(s)",
                params.get("MinimumPasswordLength"), params.get("NumbersCount"), params.get("UppercaseCharactersCount"));

        String actualMessage = page.getRegistrationFormText();

        assertThat(actualMessage, shouldState ? containsString(expectedMessage) : not(containsString(expectedMessage)));
    }

    @Then("{I |}'$condition' be on the registration page")
    public void checkIsItRegistrationPage(String condition) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        assertThat(getSut().getWebDriver().getCurrentUrl(), shouldState ? containsString("/registration") : not(containsString("/registration")));
    }
}