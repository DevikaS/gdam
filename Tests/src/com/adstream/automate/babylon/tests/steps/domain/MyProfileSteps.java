package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.data.Logo;
import com.adstream.automate.babylon.sut.pages.adbank.myprofile.MyAccountSettingPage;
import com.adstream.automate.babylon.sut.pages.adbank.myprofile.MyProfilePage;
import com.adstream.automate.babylon.sut.pages.admin.people.CreateUserPage;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.EmailMessage;
import com.adstream.automate.utils.IO;
import org.jbehave.core.annotations.Alias;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.junit.Assert;
import java.util.Map;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import static org.hamcrest.Matchers.containsString;
import static org.hamcrest.Matchers.not;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 05.07.12
 * Time: 11:36
 */
public class MyProfileSteps extends BabylonSteps {

    @Given("{I am |}on my profile page")
    @When("{I |}go on my profile page")
    public MyProfilePage openMyProfilePage() {
        return getSut().getPageNavigator().getMyProfilePage();
    }

    @When("{I |}upload logo '$logo' on user profile page")
    public void uploadLogoOnProfilePage(String logo) {
        if (logo != null && !logo.isEmpty()) {
            MyProfilePage myProfilePage = openMyProfilePage();
            myProfilePage.uploadLogo(Logo.valueOf(logo).getPath());
        }
    }

    @Then("{I |}should see logo '$logo' on user profile page and on a header")
    @Alias("{I |}should see logo '$logo' on user details page and on a header")
    public void checkUploadedLogoOnProfilePage(String logo) {
        MyProfilePage profilePage = getSut().getPageCreator().getMyProfilePage();
        byte[] realProfileLogo = profilePage.getProfileLogo();
        byte[] realHeaderLogo = profilePage.getHeaderLogo();
        byte[] emptyLogo = Logo.EMPTY.getBytes();
            if (!logo.equals("EMPTY")) {
                assertThat("Profile logo "+ logo + " is not loaded!",realProfileLogo.length, not(equalTo(emptyLogo.length)));
                assertThat("Header logo "+ logo + " is not loaded!",realHeaderLogo.length,not(equalTo(emptyLogo.length)));
            } else {
                assertThat("Profile logo is not empty!",realProfileLogo.length,equalTo(emptyLogo.length));
                assertThat("Header logo is not empty!",realHeaderLogo.length, equalTo(emptyLogo.length));
            }
    }

    @Then("agency name is '$enabledState' on my profile page")
    public void checkReadOnlyElement(String enabledState) {
        boolean isEnabled = enabledState.equalsIgnoreCase("enabled");
        MyProfilePage profilePage=getSut().getPageNavigator().getMyProfilePage();
        assertThat("Agency name editable", profilePage.isAgencyNameEditable(), equalTo(isEnabled));
    }

    @Then("Email is disabled on my profile page")
    public void checkReadOnlyEmail() {
        MyProfilePage profilePage=getSut().getPageNavigator().getMyProfilePage();
        assertThat("Email editable", profilePage.isEmailEditable(), equalTo(false));
    }

    @Then("I should see current agency with valid text on my profile page")
    public void checkAgency() {
        MyProfilePage profilePage=getSut().getPageNavigator().getMyProfilePage();
        assertThat(profilePage.getAgencyName(),equalTo(getData().getAgencyByName("DefaultAgency").getName()));
    }

    @Then("I should see email '$email' on my profile page")
    public void checkEmail(String email) {
        MyProfilePage profilePage=getSut().getPageNavigator().getMyProfilePage();
        assertThat(profilePage.getEmail(), equalTo(wrapUserEmailWithTestSession(email)));
    }

    @Then("{I |}should see on my profile page fields with following values: $elementsTable")
    public void checkFields(ExamplesTable fieldsTable) {
        MyProfilePage profilePage=getSut().getPageNavigator().getMyProfilePage();
        //EditUserPage editUserPage=getSut().getPageNavigator().getEditUserPage();
        Common.sleep(1000);
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            String elementName = row.get("element");
            String elementValue = row.get("value");
            boolean should=elementValue.equals("should");
            if (elementName.equals("FirstName")) {
                assertThat(elementValue,equalTo(profilePage.getFirstName()));
            } else if (elementName.equals("LastName")) {
                assertThat(elementValue,equalTo(profilePage.getLastName()));
            } else if (elementName.equals("Email")) {
                elementValue = wrapUserEmailWithTestSession(elementValue);
                assertThat(elementValue,equalTo(profilePage.getEmail()));
            } else if (elementName.equals("Telephone")) {
                assertThat(elementValue,equalTo(profilePage.getPhoneNumber()));
            } else if (elementName.equalsIgnoreCase("MobileNumber")) {
                assertThat(elementValue, equalTo(profilePage.getMobileNumber()));
            } else if (elementName.equalsIgnoreCase("SkypeNumber")) {
                assertThat(elementValue, equalTo(profilePage.getSkypeNumber()));
            } else if (elementName.equalsIgnoreCase("GoogleTalkContact")) {
                assertThat(elementValue, equalTo(profilePage.getGoogleTalkContact()));
            }

            else if (elementName.equals("Agency")) {
                assertThat(profilePage.getAgency(),equalTo(getData().getAgencyByName("DefaultAgency").getName()));
            } else if (elementName.equals("Role")) {
                long wait  = System.currentTimeMillis() + 10 * 1000; //wait for 10 second , because value of Role combo box appears with some delay
                while (profilePage.getRole().isEmpty()){
                    if (wait < System.currentTimeMillis()) Assert.fail("Timeout while waiting appearing user role in combobox!!!");
                    Common.sleep(1000);
                }
                assertThat(profilePage.getRole(),equalTo(elementValue));
            } else if (elementName.equals("Folders")) {
                assertThat(should,equalTo(profilePage.isFoldersChecked()));
            } else if (elementName.equals("Ordering")) {
                assertThat(should,equalTo(profilePage.isOrderingChecked()));
            }  else if (elementName.equals("Library")) {
                assertThat(should,equalTo(profilePage.isLibraryChecked()));
            } else {
                throw new IllegalArgumentException("Unknown element name on user details page!");
            }
        }
    }

    @Then("{I |}'$condition' see checkbox 'Password never expires' on my profile page")
    public void checkPasswordNeverExpiresVisibility(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = openMyProfilePage().isPasswordNeverExpiresCheckboxVisible();

        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' see selected checkbox 'Password never expires' on my profile page")
    public void checkPasswordNeverExpiresState(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = openMyProfilePage().isPasswordNeverExpiresCheckboxSelected();

        assertThat(actualState, is(expectedState));
    }


    @Given("{I am |}on my Account Setting page")
    @When("{I |}go to my Account Setting page")
    public MyAccountSettingPage openMyAccountSettingPage() {
        return getSut().getPageNavigator().getMyAccountSettingPage();
    }

    @When("{I |}change current user's password '$currentPassword' to following new password '$password' and confirm password '$confirmPwd' on my Account Settings page")
    public void changeUsersPassword(String currentPassword, String password, String confirmPwd) {
        MyAccountSettingPage ownAccountSettingPage = getSut().getPageNavigator().getMyAccountSettingPage();
        Common.sleep(1000);
        ownAccountSettingPage.changeUsersPassword(currentPassword, password, confirmPwd);
    }

    @When("{I |}change current user '$userName' password generated automatically that was in email with subject '$subject' to following new password '$password' confirm password '$confirmPwd' on my Account Settings page")
    public void changeUsersPasswordGeneratedAutomatically(String userName, String subject, String password, String confirmPwd) {
        EmailSteps emailSteps = new EmailSteps();
        EmailMessage emailMessage = emailSteps.getLastEmailMessageByHeaderAndSubjectWithoutDelete(EmailSteps.Headers.TO, wrapUserEmailWithTestSession(userName), subject);
        assertThat("There is no last unread email with following subject: " + subject, emailMessage, notNullValue());
        assertThat("Check recipient to : ", emailMessage.getHeader().getRecipient_to(), equalTo(wrapUserEmailWithTestSession(userName)));
        String textMessage = emailSteps.parseEmailMessage(emailMessage);
        String generatedPassword = emailSteps.getPasswordFromEmailMessage(textMessage);
        MyAccountSettingPage ownAccountSettingPage = getSut().getPageNavigator().getMyAccountSettingPage();
        ownAccountSettingPage.changeUsersPassword(generatedPassword, password, confirmPwd);
    }

    @When("{I |}canceled changing current user's password '$currentPassword' to following new password '$password' and confirm password '$confirmPwd' on my Account Settings page")
    public void cancelChangingUsersPassword(String currentPassword, String password, String confirmPwd) {
        MyAccountSettingPage ownAccountSettingPage = getSut().getPageNavigator().getMyAccountSettingPage();
        Common.sleep(1000);
        ownAccountSettingPage.cancelChangingPassword(currentPassword, password, confirmPwd);
    }

    // | MinimumPasswordLength | UppercaseCharactersCount | LowercaseCharactersCount | NumbersCount |
    @Then("{I |}'$condition' see message about password rules on my Account Settings page with following attributes: $data")
    public void checkPasswordRulesAttributes(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        MyAccountSettingPage page = getSut().getPageNavigator().getMyAccountSettingPage();
        Map<String,String> params = parametrizeTabularRow(data);
        String expectedMessage = String.format("Your password must have a minimum of %s characters and include at least %s number(s), at least %s uppercase letter(s).",
                params.get("MinimumPasswordLength"), params.get("NumbersCount"), params.get("UppercaseCharactersCount"));

        String actualMessage = page.getPasswordQualityText();

        assertThat(actualMessage, shouldState ? containsString(expectedMessage) : not(containsString(expectedMessage)));
    }
}