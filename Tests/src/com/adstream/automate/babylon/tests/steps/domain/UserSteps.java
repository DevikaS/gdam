package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.JsonObjects.AgencyTeamMember;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.data.Logo;
import com.adstream.automate.babylon.sut.data.UserDecorator;
import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.NotificationsSettingPageForGA;
import com.adstream.automate.babylon.sut.pages.adbank.addressbook.AdbankAddressbookPage;
import com.adstream.automate.babylon.sut.pages.adbank.addressbook.InviteUserPopup;
import com.adstream.automate.babylon.sut.pages.adbank.myprofile.MyNotificationsSettingPage;
import com.adstream.automate.babylon.sut.pages.admin.agency.AgencyDeleteMarketPopUpWindow;
import com.adstream.automate.babylon.sut.pages.admin.agency.AgencyEditMarketPage;
import com.adstream.automate.babylon.sut.pages.admin.people.*;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.babylon.tests.steps.core.GenericSteps;
import com.adstream.automate.babylon.tests.steps.domain.adcost.AdCostsHelperSteps;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.EmailMessage;
import org.jbehave.core.annotations.*;
import org.jbehave.core.model.ExamplesTable;
import org.junit.Assert;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import java.util.*;
import static com.adstream.automate.hamcrest.SortingCheck.sortedAlphabetically;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created by IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 24.01.12
 * Time: 15:54
 */
public class UserSteps extends BaseStep {

    @Given("{I am |}on Users list page")
    @When("{I |}go to User list page")
    public UsersPage openUsersPage() {
        return getSut().getPageNavigator().getUsersPage();
    }
    @Then("{I |}should see following count '$count' of users on Users page")
    public void checkCountOfTotalUser(int count){
        int actualCount = getSut().getPageNavigator().getUsersPage().getUsersCount();
        assertThat(String.format("The number of users on user page is incorrect: %d, but should be %d", actualCount, count), count ==actualCount);
    }

    @Given("{I am |}on Users list page with selected user '$userName'")
    @When("{I |}go to Users list page with selected user '$userName'")
    public UsersPage openUsersPage(String userName) {
        return getSut().getPageNavigator().getUsersPageForUser(wrapNameAndGetUserId(userName));
    }

    @Given("{I am |}on user '$userName' projects page in administration area")
    @When("{I |}go to user '$userName' projects page in administration area")
    public UserProjectsPage openUserProjectsPage(String userName) {
        return getSut().getPageNavigator().getUserProjectsPage(wrapNameAndGetUserId(userName));
    }

    @Given("{I am |}on user '$userName' library page in administration area")
    @When("{I |}go to user '$userName' library page in administration area")
    public UserLibraryPage openUserLibraryPage(String userName) {
        return getSut().getPageNavigator().getUserLibraryPage(wrapNameAndGetUserId(userName));
    }

    @Given("{I am |}on user '$userName' applications page in administration area")
    @When("{I |}go to user '$userName' applications page in administration area")
    public UserApplicationsPage openUserApplicationsPage(String userName) {
        return getSut().getPageNavigator().getUserApplicationsPage(wrapNameAndGetUserId(userName));
    }

    @Given("{I am |}on page '$pageNumber' of Users list page")
    @When("{I |}go to page '$pageNumber' of User list page")
    public UsersPage openUsersPageByPageNumber(String pageNumber) {
        return getSut().getPageNavigator().getUsersPage(pageNumber);
    }

    @Given("{I am |}on Create New User page")
    @When("{I |}go to Create New User page")
    public CreateUserPage openNewUserPage() {
        return openUsersPage().clickNewUser();
    }

    @Given("{I am |}on user '$userName' details page")
    @When("{I |}go to user '$userName' details page")
    @Then("{I |}go to user '$userName' details page")
    public EditUserPage openEditUserPage(String userName) {
        User user = wrapNameAndGetUser(userName);
        if (user == null)
            throw new IllegalStateException(String.format("Could not found user '%s'", userName));
        Common.sleep(2000);
        return getSut().getPageNavigator().getEditUserPage(user.getId());
    }

    @Given("{I am |}on user '$userName' Account Settings page")
    @When("{I |}go to user '$userName' Account Settings page")
    public AccountSettingPage openAccountSettingPage(String userName) {
        User user = wrapNameAndGetUser(userName);
        return getSut().getPageNavigator().getAccountSettingPage(user.getId());
    }

    @Given("{I am |}on user '$userName' Notifications Settings page")
    @When("{I |}go to user '$userName' Notifications Settings page")
    public NotificationsSettingPage openNotificationsSettingPage(String userName) {
        User user = wrapNameAndGetUser(userName);
        try {
            return getSut().getPageNavigator().getNotificationsSettingPage(user.getId());
        } catch (Exception e) {
            // If user doesn't exist in mail service, exception can be thrown. Try again.
            GenericSteps.refreshPageWithoutDelay();
            return getSut().getPageNavigator().getNotificationsSettingPage(user.getId());
        }
    }

    @Given("{I am |}on user '$userName' Notifications Settings page of agency '$agencyName'")
    @When("{I |}go to user '$userName' Notifications Settings page of agency '$agencyName'")
    public NotificationsSettingPageForGA openNotificationsSettingPageForGA(String userName, Agency agencyName) {
        User user = wrapNameAndGetUser(userName);
        try {
            return getSut().getPageNavigator().getNotificationsSettingPageForGA(user.getId(), agencyName);
        } catch (Exception e) {
            // If user doesn't exist in mail service, exception can be thrown. Try again.
            GenericSteps.refreshPageWithoutDelay();
            return getSut().getPageNavigator().getNotificationsSettingPageForGA(user.getId(), agencyName);
        }
    }

    @Given("I clicked invite button on the {U|u}sers page")
    @When("I click invite button on the {U|u}sers page")
    public void clickInviteUser() {
        UsersPage usersPage = getSut().getPageCreator().getUsersPage();
        usersPage.clickInviteButton();
        Common.sleep(2000);
    }

    @Given("I typed '$email' user email on Invite user popup in {U|u}sers page")
    @When("I type '$email' user email on Invite user popup in {U|u}sers page")
    public void typeUserEmailInviteUser(String search) {
        InviteUserPopup inviteUserPopup = new InviteUserPopup(getSut().getPageCreator().getUsersPage());
        inviteUserPopup.startTypeUserEmail(wrapUserEmailWithTestSession(search) + Keys.RETURN, 2000);
        Common.sleep(2000);
    }

    @Given("I clicked '$action' invite user in {U|u}sers page")
    @When("I click '$action' invite user in {U|u}sers page")
    public void clickInviteUserOnPopup(String action) {
        InviteUserPopup inviteUserPopup = new InviteUserPopup(getSut().getPageCreator().getUsersPage());
        if (action.equalsIgnoreCase("invite")) inviteUserPopup.action.click();
        else if (action.equalsIgnoreCase("close")) inviteUserPopup.close.click();
        else if (action.equalsIgnoreCase("cancel")) inviteUserPopup.cancel.click();
        else inviteUserPopup.close.click();
        Common.sleep(2000);
    }


    @Given("{I am |}on my Notifications Settings page")
    @When("{I |}go to my Notifications Settings page")
    public NotificationsSettingPage openMyNotificationsSettingPage() {
        return getSut().getPageNavigator().getMyNotificationSettingPage();
    }

    private void checkNotificationCheckboxes(NotificationsSettingPage page, ExamplesTable data) {
        Map<String, Boolean> cBoxes = page.getNotificationStatus();
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            Boolean checked = cBoxes.get(row.get("Name"));
            if (checked != null)
                assertThat("Is '" + row.get("Name") + "' selected", checked, is(row.get("Checked").equals("on")));
        }
    }

    private void compareNotificationCheckboxes(NotificationsSettingPage page, ExamplesTable data) {
        Map<String, Boolean> cBoxes = page.getNotificationStatus();
        List<String> expectedList = new ArrayList<>();
        List<String> actualList = page.getAllNotifications();
        if (data.getRowCount() != cBoxes.size()) {
            for (int i = 0; i < data.getRowCount(); i++) {
                Map<String, String> map = parametrizeTabularRow(data, i);
                expectedList.add(map.get("Name"));
            }
            if(expectedList.size() > cBoxes.size()) {
                expectedList.removeAll(actualList);
                assertThat("Difference in Expected List  " + expectedList, cBoxes.size(), equalTo(data.getRowCount()));
            } else {
                actualList.removeAll(expectedList);
                assertThat("Difference in Actual List " + actualList, cBoxes.size(), equalTo(data.getRowCount()));
            }
        } else {
                for (int i = 0; i < cBoxes.size(); i++) {
                Map<String, String> map = parametrizeTabularRow(data, i);
                String expectedStatus = map.get("Checked");
                assertThat("Notification not found on settings page ",  page.isNotificationDisplayed(map.get("Name")));
                assertThat("Notification status expected " + expectedStatus + " for notification setting " + map.get("Name") , page.getStatusForNotification(map.get("Name")).equalsIgnoreCase(expectedStatus));
            }
        }
    }



    private void checkNotificationCheckboxesForGA(NotificationsSettingPageForGA page, ExamplesTable data) {
        Map<String, Boolean> cBoxes = page.getNotificationStatus();
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            Boolean checked = cBoxes.get(row.get("Name"));
            if (checked != null)
                assertThat("Is '" + row.get("Name") + "' selected", checked, is(row.get("Checked").equals("on")));
        }
    }

    // | UserEmail | SettingName | SettingState |
    @Given("{I |}set following notification settings for users: $data")
    @When("{I |}set following notification settings for users: $data")
    public void setNotificationIntoStateForUsers(ExamplesTable data) {
        for (Map<String,String> row : parametrizeTableRows(data)) {
            openNotificationsSettingPage(row.get("UserEmail"));
            setNotificationIntoState(row.get("SettingName"), row.get("SettingState"));
            saveCurrentUserNotification();
            getSut().getWebDriver().navigate().refresh();
        }
    }

    @Given("{I |}set following notification settings for user: $data")
    @When("{I |}set following notification settings for user: $data")
    public void setNotificationIntoStateForUserviaCore(ExamplesTable data) {
        for (Map<String,String> row : parametrizeTableRows(data)) {
            User user = wrapNameAndGetUser(row.get("UserEmail"));
            String notificationSetting = row.get("SettingName");
            String settingState = row.get("SettingState");
            getCoreApi().addNotificationSetting(user.getId(), notificationSetting, settingState);
        }
    }

    @Given("{I |}set notification '$name' into state '$state' for current user")
    @When("{I |}set notification '$name' into state '$state' for current user")
    public void setNotificationIntoState(String name, String state) {
        getSut().getPageCreator().getNotificationSettingPage().setNotificationState(name, state.equalsIgnoreCase("on"));
    }

    @Given("{I |}saved current user notifications setting")
    @When("{I |}save current user notifications setting")
    public void saveCurrentUserNotification() {
        getSut().getPageCreator().getNotificationSettingPage().clickSaveButton();
    }

    // | FirstName | LastName | Agency | Email | Telephone | Password | Notifications | Logo |
    // | Access | Role | MobileNumber | SkypeNumber | GoogleTalkContact | Disabled (values: true/false) | ViewPublicTemplate |
    @Given("{I |}created users with following fields: $fields")
    @When("{I |}create users with following fields: $fields")
    public void createUserViaCore(ExamplesTable fields) {
        for (int i = 0; i < fields.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fields, i);
            if (row.get("Email") != null)
                row.put("Email", wrapUserEmailWithTestSession(row.get("Email")));
            if (row.get("Role") != null)
                row.put("Role", new RolesSteps().wrapRoleName(row.get("Role")));
            if ((row.get("AgencyUnique") != null) && (!row.get("AgencyUnique").isEmpty()))
                row.put("Agency", wrapVariableWithTestSession(row.get("AgencyUnique")));
            if ((row.get("Agency")!= null) && (!row.get("Agency").isEmpty())) {
                if (getData().getAgencyByName(row.get("Agency"))!= null || row.get("Agency").equals("##"))
                    row.put("Agency", row.get("Agency"));
                else
                    row.put("Agency", wrapVariableWithTestSession(row.get("Agency")));
            }
            User user = getUserBuilder().getUser(row, getContext().isRealDb);
            boolean allowToViewPublicTemplates = !row.containsKey("ViewPublicTemplate") || Boolean.parseBoolean(row.get("ViewPublicTemplate"));
            createUserViaCore(user, allowToViewPublicTemplates);
            log.debug("Success. User: " + user.getEmail() + " " + user.getFirstName() + " " + user.getLastName());
        }
    }

    // | FirstName | LastName | Agency | Email | Telephone | Password | Notifications | Logo |
    // | Access | Role | MobileNumber | SkypeNumber | GoogleTalkContact | Disabled (values: true/false) | ViewPublicTemplate |
    @Given("{I |}created users with following fields and waited until replication to Cost Module: $fields")
    @When("{I |}create users with following fields and wait until replication to Cost Module: $fields")
    public void createUserViaCoreAndWaitedForCostModuleReplication(ExamplesTable fields) {
        AdCostsHelperSteps steps = new AdCostsHelperSteps();
        steps.waitUntilReplicationToCostModule("BusinessUnits",fields);
        createUserViaCore(fields);
        steps.waitUntilReplicationToCostModule("Users",fields);
    }

    // | FirstName | LastName | Agency | Email | Telephone | Password | Notifications | Logo |
    // | Access | Role | MobileNumber | SkypeNumber | GoogleTalkContact | Disabled (values: true/false) | ViewPublicTemplate |
    @Given("{I |}created users with following fields with no tests session: $fields")
    @When("{I |}create users with following fields with no tests session: $fields")
    public void createUserViaCoreWithnoTestsession(ExamplesTable fields) {
        for (int i = 0; i < fields.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fields, i);
            if (row.get("Email") != null)
                row.put("Email", row.get("Email"));
            if (row.get("Role") != null)
                row.put("Role", new RolesSteps().wrapRoleName(row.get("Role")));
            if ((row.get("AgencyUnique") != null) && (!row.get("AgencyUnique").isEmpty()))
                row.put("Agency", row.get("AgencyUnique"));
            if ((row.get("Agency")!= null) && (!row.get("Agency").isEmpty())) {
                row.put("Agency", row.get("Agency"));
            }
            User user = getUserBuilder().getUserForExistingBU(row, getContext().isRealDb);
            boolean allowToViewPublicTemplates = !row.containsKey("ViewPublicTemplate") || Boolean.parseBoolean(row.get("ViewPublicTemplate"));
            createUserViaCore(user, allowToViewPublicTemplates);
            log.debug("Success. User: " + user.getEmail() + " " + user.getFirstName() + " " + user.getLastName());
        }
    }

    @Given("{I |}created '$usersCount' users with email pattern '$emailPattern' for agency '$agencyName'")
    public void generateCommonUsersViaCore(String usersCount, String emailPattern, String agencyName) {
        Map<String, String> userFields = new HashMap<>();
        for (int i = 1; i <= Integer.parseInt(usersCount); i++) {
            userFields.clear();
            userFields.put("Email", wrapUserEmailWithTestSession(String.format("%s_%d", emailPattern, i)));
            userFields.put("FirstName", String.format("FirstName%d", i));
            userFields.put("LastName", String.format("LastName%d", i));
            userFields.put("Role", new RolesSteps().wrapRoleName("agency.user"));
            userFields.put("Agency", wrapVariableWithTestSession(agencyName));

            User user = getUserBuilder().getUser(userFields, false);
            createUserViaCore(user, true);
            log.debug("Success. User: " + user.getEmail() + " " + user.getFirstName() + " " + user.getLastName());
        }
    }

    @Given("{I |}created '$userName' User with '$fields'")
    public void createUserViaCore(String userName, String fields) {
        User user = prepareUser(userName, fields);
        createUserViaCore(user, true);
    }

    @Given("{I |}created '$userNumber' users with role '$role'")
    public void createUsersviaCore(String userNumber, String role){
        int numberOfUsers = Integer.parseInt(userNumber);
        Map<String,String> m = new HashMap<String,String>();

        for(int i=1; i<=numberOfUsers; i++){
            m.put("Email" , wrapUserEmailWithTestSession("UM"+i));
            m.put("Role" , new RolesSteps().wrapRoleName(role));
            User user = getUserBuilder().getUser(m, getContext().isRealDb);
            getCoreApiAdmin().createUser(user);
         }
    }

    @Given("{I |}created '$userName' User")
    public void createUserViaCore(String userName) {
        createUserViaCore(userName, "MandatoryFields");
    }

    // | User Name |
    @Given("{I |}created following users: $usersTable")
    public void createUsersViaCore(ExamplesTable usersTable) {
        for (Map<String, String> row : usersTable.getRows()) {
            createUserViaCore(row.get("User Name"));
        }
    }

    @Given("{I |}added existing user '$userName' to agency '$agencyName' with role '$roleName'")
    @When("{I |}add existing user '$userName' to agency '$agencyName' with role '$roleName'")
    public void addedExistingUserToAgency(String userName, String agencyName, String roleName) {
        User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userName));
        if (user != null) {
            String agencyId = getAgencyIdByName(agencyName);
            String roleId = getCoreApiAdmin().getRoleByName(roleName, false).getId();
            getCoreApiAdmin().addExistingUserToAgency(user.getId(), agencyId, roleId);
        } else
            throw new IllegalArgumentException("User has been not found by email: " + wrapUserEmailWithTestSession(userName));
    }

    @Given("{I |}added existing user '$userName' to agency '$agencyName' with custom role '$roleName'")
    public void addedExistingUserToAgencyWithCustomRole(String userName, String agencyName, String roleName) {
        User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userName));
        if (user != null) {
            String agencyId = getAgencyIdByName(agencyName);
            String roleId = getCoreApiAdmin().getRoleByName(wrapRoleName(roleName), false).getId();
            getCoreApiAdmin().addExistingUserToAgency(user.getId(), agencyId, roleId);
        } else
            throw new IllegalArgumentException("User has been not found by email: " + wrapUserEmailWithTestSession(userName));
    }

    @Given("{I |} filled following fields on user '$userName' with timezone details page: $fields")
    @When("{I |} fill following fields on user '$userName' with timezone details page: $fields")
    public EditUserPage fillFieldsForUserWthtimeZone(String userName, ExamplesTable fields) {
        Map<String, String> row = parametrizeTabularRow(fields, 0);
        if (row.get("Role") != null)
            row.put("Role", new RolesSteps().wrapRoleName(row.get("Role")));
        if (row.get("timeZone") != null)
            row.put("timeZone", row.get("timeZone"));
        User user = wrapNameAndGetUser(userName);
        // User newUser = getUserBuilder().getUser(row);
        return getSut().getPageNavigator().getEditUserPage(user.getId()).fillFieldsWthTimeZone(row.get("timeZone"));
    }


    // | FirstName | LastName | Agency | Email | Telephone | Password | Notifications | Logo | Access | Role | ViewPublicTemplates |
    @Given("{I |} filled following fields on user '$userName' details page: $fields")
    public CreateUserPage fillFieldsForUser(String userName, ExamplesTable fields) {
        Map<String, String> row = parametrizeTabularRow(fields, 0);
        if (row.get("Email") != null)
            row.put("Email", wrapUserEmailWithTestSession(row.get("Email")));
        if (row.get("Role") != null)
            row.put("Role", new RolesSteps().wrapRoleName(row.get("Role")));
        User user = wrapNameAndGetUser(userName);
        User newUser = getUserBuilder().getUser(row, false);
        return getSut().getPageNavigator().getEditUserPage(user.getId()).fillFields(new UserDecorator(newUser));
    }

    @Given("{I |} filled following fields on user '$userName' details page with specific Language: $fields")
    @When("{I |} filled following fields on user '$userName' details page with specific Language: $fields")
    public EditUserPage fillFieldsForOthrLocaleUser(String userName, ExamplesTable fields) {
        Map<String, String> row = parametrizeTabularRow(fields, 0);
        if (row.get("Language") != null)
            row.put("Language", row.get("Language"));
        User user = wrapNameAndGetUser(userName);
        User newUser = getUserBuilder().getUser(row, false);
        return getSut().getPageNavigator().getEditUserPage(user.getId()).fillFieldsWthLanguage(row.get("Language"));
    }
    // | FirstName | LastName | Agency | Email | Telephone | Password | Notifications | Logo | Access | Role |
    @Given("{I |}filled following fields on user opened details page: $fields")
    @When("{I |}fill following fields on user opened details page: $fields")
    public CreateUserPage fillFields(ExamplesTable fields) {
        Map<String, String> row = parametrizeTabularRow(fields, 0);
        if (row.get("Email") != null)
            row.put("Email", wrapUserEmailWithTestSession(row.get("Email")));
        if (row.get("Role") != null)
            row.put("Role", new RolesSteps().wrapRoleName(row.get("Role")));
        User newUser = getUserBuilder().getUser(row, false);
        return getSut().getPageNavigator().getCreateUserPage().fillFields(new UserDecorator(newUser));
    }

    @Given("{I |}searched user by text '$searchQuery'")
    @When("{I |}search user by text '$searchQuery'")
    public void searchUserByText(String searchQuery) {
        UsersPage usersPage = openUsersPage();
        usersPage.searchUser(searchQuery);
    }

    @When("{I |}search user by email '$userName'")
    public void searchUserByEmail(String userName) {
        UsersPage usersPage = openUsersPage();
        usersPage.searchUser(userName.isEmpty() ? userName : wrapUserEmailWithTestSession(userName));
    }

    @When("{I |}search for user '$userName' on Users page")
    public void searchUser(String userName) {
        openUsersPage();
        User user = wrapNameAndGetUser(userName);
        getSut().getPageCreator().getUsersPage().searchUser(user == null ? wrapUserEmailWithTestSession(userName) : user.getFullName());
    }
    @When("{I |}search for user '$userName' on Users page by First Name")
    public void searchUserByFirstNAme(String userName) {
        openUsersPage();
        User user = wrapNameAndGetUser(userName);
        getSut().getPageCreator().getUsersPage().searchUser(user == null ? wrapUserEmailWithTestSession(userName) : user.getFirstName());
    }

    @When("{I |}select 'Password never expires' option on user '$userEmail' settings page")
    public void selectPasswordNeverExpires(String userName) {
        EditUserPage page = openEditUserPage(userName);
        page.selectPasswordNeverExpires();
        page.clickSave();
    }

    @When("{I |}deselect 'Password never expires' option on user '$userEmail' settings page")
    public void deselectPasswordNeverExpires(String userName) {
        EditUserPage page = openEditUserPage(userName);
        page.deselectPasswordNeverExpires();
        page.clickSave();
    }

    @When("{I |}search for users '$userNames' in this {project|library} team")
    public void searchUsersInThisAgencyProjectTeam(String userNames){
        String usersSearchCriteria = "";
        for (String userName : userNames.split(",")) {
            User user = wrapNameAndGetUser(userName);
            usersSearchCriteria += user == null ? wrapUserEmailWithTestSession(userName) : user.getFullName() + " | ";
        }
        UsersPage usersPage = getSut().getPageCreator().getUsersPage();
        usersPage.searchUser(usersSearchCriteria.replaceFirst("\\s\\|\\s$", ""));
    }

    @When("{I |}search for users '$userNames' in library team")
    public void searchUsersInLibraryTeam(String userNames) {
        for (String userName : userNames.split(",")) {
            User user = wrapNameAndGetUser(userName);
            String name;
            if (user != null && user.isEasyUser())
                name = user.getEmail();
            else if (user == null) name = userName;
            else name = user.getFullName();
            UsersPage usersPage = getSut().getPageCreator().getUsersPage();
            usersPage.searchUser(name.replaceFirst("\\s\\|\\s$", ""));
        }
    }

    @Given("I clicked save on users details page")
    @When("{I |}click save on users details page")
    @Alias("I click save on Create new user page")
    public void saveUserDetailsPage() {
        getSut().getPageCreator().getEditUserPage().clickSave();
        Common.sleep(1000);
    }

    @Given("I clicked save on users details page with no Timezone")
    @When("{I |}click save on users details page with no Timezone")
    @Alias("I click save on Create new user page with no Timezone")
    public void saveEditUserDetailsPage() {
        getSut().getPageCreator().getCreateUserPage().clickSave();
        Common.sleep(1000);
    }

    @Given("{I |}saved user details on users page")
    @When("{I |}save user details on users page")
    public void saveUserDetails() {
        getSut().getPageCreator().getUsersPage().saveUserDetails();
        Common.sleep(1000);
    }

    @Given("{I |}clicked Reset password on user profile popup")
    @When("{I |}click Reset password on user profile popup")
    public void resetPassword() {
        new UserProfilePopup(getSut().getPageCreator().getUsersPage()).resetPassword.click();
        Common.sleep(1000);
    }

    // checkState: 'check', 'uncheck'
    @When("I '$checkOrUncheck' 'Generate password automatically' checkbox")
    public void clickGeneratePassCheckbox(String checkOrUncheck) {
        CreateUserPage createUserPage = getSut().getPageCreator().getCreateUserPage();
        createUserPage.clickGeneratePasswordCheckbox(checkOrUncheck.equalsIgnoreCase("check"));

    }

    // checkState: 'check', 'uncheck'
    @When("I '$checkOrUncheck' 'Disable user' checkbox")
    public void clickDisableUserCheckbox(String checkOrUncheck) {
        CreateUserPage createUserPage = getSut().getPageCreator().getCreateUserPage();
        createUserPage.clickDisableUserCheckbox(checkOrUncheck.equalsIgnoreCase("check"));

    }

    @When("I edit user '$userName' with following fields: $fields")
    public void editUser(String userName, ExamplesTable fields) {
        fillFieldsForUser(userName, fields).clickSave();
    }

    @Given("{I |} edited user '$userName' with following fields: $fields")
    public void editUserThroughApi(String userName, ExamplesTable fields) {
        Map<String, String> row = parametrizeTabularRow(fields, 0);
        if (row.get("Email") != null)
            row.put("Email", wrapUserEmailWithTestSession(row.get("Email")));
        if (row.get("Role") != null)
            row.put("Role", new RolesSteps().wrapRoleName(row.get("Role")));

        User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userName));
        Common.sleep(3000);
        User newUser = getUserBuilder().getUser(row, false);
        User updatedUser = getCoreApiAdmin().updateUser(user.getId(), newUser);
    }

    @Given("{I |}edited for user '$email' agency role '$userRole'")
    @When("{I |}edit for user '$email' agency role '$userRole'")
    public CreateUserPage editUserRole(String email, String userRole) {
        User user = wrapNameAndGetUser(email);
        return getSut().getPageNavigator().getEditUserPage(user.getId()).changeUserRole(userRole);
    }

    @Given("{I |}edited for user '$email' agency with custom role '$userRole'")
    public CreateUserPage editUserwithCustomRole(String email, String userRole) {
        User user = wrapNameAndGetUser(email);
        return getSut().getPageNavigator().getEditUserPage(user.getId()).changeUserRole(wrapVariableWithTestSession(userRole));
    }

    @When("I fill '$fields' for '$userName' user")
    public CreateUserPage fillFields(String fields, String userName) {
        User user = prepareUser(userName, fields);
        return getSut().getPageCreator().getCreateUserPage().fillFields(new UserDecorator(user));
    }

    @When("{I |}change current user's password '$currentPassword' to following new password '$password' and confirm password '$confirmPwd' on user '$userName' Account Settings page")
    public void changeUsersPassword(String currentPassword, String password, String confirmPwd, String userName) {
        User user = wrapNameAndGetUser(userName);
        AccountSettingPage accountSettingPage = getSut().getPageNavigator().getAccountSettingPage(user.getId());
        Common.sleep(1000);
        accountSettingPage.waitUntilPopUpNotificationMessageDisappeared();
        accountSettingPage.changeUsersPassword(currentPassword, password, confirmPwd);
    }

    @When("{I |}change current user's password generated automatically that was in email with subject '$subject' to following new password '$password' confirm password '$confirmPwd' on user '$userName' Account Settings page")
    public void changeUsersPasswordGeneratedAutomatically(String subject, String password, String confirmPwd, String userName) {
        EmailSteps emailSteps = new EmailSteps();
        EmailMessage emailMessage = emailSteps.getLastEmailMessageByHeaderAndSubjectWithoutDelete(EmailSteps.Headers.TO, wrapUserEmailWithTestSession(userName), subject);
        assertThat("There is no last unread email with following subject: " + subject, emailMessage, notNullValue());
        assertThat("Check recipient to : ", emailMessage.getHeader().getRecipient_to(), equalTo(wrapUserEmailWithTestSession(userName)));
        String textMessage = emailSteps.parseEmailMessage(emailMessage);
        String generatedPassword = emailSteps.getPasswordFromEmailMessage(textMessage);
        User user = wrapNameAndGetUser(userName);
        AccountSettingPage accountSettingPage = getSut().getPageNavigator().getAccountSettingPage(user.getId());
        accountSettingPage.changeUsersPassword(generatedPassword, password, confirmPwd);
    }

    @When("{I |}canceled changing current user's password '$currentPassword' to following new password '$password' and confirm password '$confirmPwd' on user '$userName' Account Settings page")
    public void cancelChangingUsersPassword(String currentPassword, String password, String confirmPwd, String userName) {
        User user = wrapNameAndGetUser(userName);
        AccountSettingPage accountSettingPage = getSut().getPageNavigator().getAccountSettingPage(user.getId());
        Common.sleep(1000);
        accountSettingPage.waitUntilPopUpNotificationMessageDisappeared();
        accountSettingPage.cancelChangingPassword(currentPassword, password, confirmPwd);
    }

    @When("{I |}typed following current password '$currentPassword' new password '$password' and confirm password '$confirmPwd' on user '$userName' Account Settings page")
    public void typeUsersPassword(String currentPassword, String password, String confirmPwd, String userName) {
        User user = wrapNameAndGetUser(userName);
        AccountSettingPage accountSettingPage = getSut().getPageNavigator().getAccountSettingPage(user.getId());
        Common.sleep(1000);
        accountSettingPage.setCurrentPassword(currentPassword);
        accountSettingPage.setNewPassword(password);
        accountSettingPage.setConfirmNewPassword(confirmPwd);
    }

    // | FirstName | LastName | Agency | Email | Telephone | Password | Notifications | Logo | Access | Role |
    @When("{I |}create{d|} user with following fields: $fields")
    public void createNewUser(ExamplesTable fields) {
        CreateUserPage page = getSut().getPageCreator().getCreateUserPage();
        for (int i = 0; i < fields.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fields, i);
            if (row.get("Email") != null) {
                String email = wrapUserEmailWithTestSession(row.get("Email"));
                row.put("Email", email);
            }
            if (row.get("Role") != null && !new RolesSteps().isDefaultRole(row.get("Role"))) {
                row.put("Role", wrapVariableWithTestSession(row.get("Role")));
            }
            User user = getUserBuilder().getUser(row, false);
            page = page.fillFields(new UserDecorator(user));
            page.clickSave();
        }
    }

    @When("I fill '$fields' and '$logo' logo for '$userName' user")
    public CreateUserPage fillFields(String fields, String logo, String userName) {
        User user = prepareUser(userName, fields, logo);
        return getSut().getPageCreator().getCreateUserPage().fillFields(new UserDecorator(user));
    }

    @When("{I |}open user profile popup for selected user")
    public void openUserProfilePopup() {
        getSut().getPageCreator().getUsersPage().openProfilePopup();
        Common.sleep(2000);
    }

    @When("{I |}close user profile popup")
    public void closeUserProfilePopup() {
        new UserProfilePopup(getSut().getPageCreator().getUsersPage()).close.click();
    }

    @When("{I |}open '$userName' user menu")
    public void expandUserMenu(String userName) {
        User user = wrapNameAndGetUser(userName);
        searchUser(user.getEmail());
        getSut().getPageCreator().getUsersPage().selectUserById(user.getId());
        Common.sleep(2000);
    }

    @When("{I |}open '$userName' user menu and search by First Name")
    public void expandUserMenuAndSearchByFirstName(String userName) {
        User user = wrapNameAndGetUser(userName);
        searchUserByFirstNAme(user.getEmail());
        Common.sleep(2000);
        getSut().getPageCreator().getUsersPage().selectUserById(user.getId());
        Common.sleep(2000);
    }

    @Given("{I |}selected user '$userName' for current search result on Users Page")
    @When("{I |}select user '$userName' for current search result on Users Page")
    public void selectUserForCurrentSearchResult(String userName) {
        UsersPage page = getSut().getPageCreator().getUsersPage();
        page.selectUserByIdForCurrentSearchResult(wrapNameAndGetUser(userName).getId());
        Common.sleep(2000);
    }


    @Given("{I |}created project access rule: $rule")
    @When("{I |}create project access rule: $rule")
    public void createProjectAccessRule(ExamplesTable rule) {

        UsersPage page = getSut().getPageCreator().getUsersPage();
        for (int i = 1; i <= rule.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(rule);
            Common.sleep(2000);
            ProjectAccessRulePopUp projectAccessRulesPopup = page.clickManageAccessRules();
            Common.sleep(2000);
            projectAccessRulesPopup.selectProjectRuleMetaData(row.get("MetaData"),row.get("MetaValue"));
            projectAccessRulesPopup.selectProjectRole(row.get("Role"));
            projectAccessRulesPopup.clickSave();

        }
    }

    @When("{I |}select user '$userNames' on Users page")
    public UsersPage selectUser(String userName) {
        UsersPage usersPage = getSut().getPageCreator().getUsersPage();
        User user = getCoreApi().getUserByEmail(prepareUser(userName).getEmail());
        String userFullName = user == null ? wrapUserEmailWithTestSession(userName) : user.getFullName();
        if (!usersPage.isUserItemSelected(userFullName)) usersPage.clickUserItem(userFullName);

        return usersPage;
    }

    @When("{I |}deselect user '$userNames' on Users page")
    public UsersPage deselectUsers(String userName) {
        UsersPage usersPage = getSut().getPageCreator().getUsersPage();
        User user = getCoreApi().getUserByEmail(prepareUser(userName).getEmail());
        String userFullName = user == null ? wrapUserEmailWithTestSession(userName) : user.getFullName();
        if (usersPage.isUserItemSelected(userFullName)) usersPage.clickUserItem(userFullName);

        return usersPage;
    }

    @When("{I |}sort users by field '$sortField' in order '$order'")
    public void sortUsersInUserListPage(String sortField, String order) {
        if (sortField.equalsIgnoreCase("User")) {
            sortField = "_cm.common.firstName";
        } else if (sortField.equalsIgnoreCase("Unit")) {
            sortField = "agency.name";
        }
        UsersPage usersPage = getSut().getPageCreator().getUsersPage();
        if (!usersPage.getClassOfSortField(sortField).contains(order.toLowerCase())) {
            usersPage.clickSortField(sortField);
            if (!usersPage.getClassOfSortField(sortField).contains(order.toLowerCase())) {
                usersPage.clickSortField(sortField);
            }
        }
    }

    @When("{I |}type in field '$fieldName' on user details page empty value '$text'")
    public void typeEmptyValue(String fieldName, String text) {
        EditUserPage editUserPage=getSut().getPageNavigator().getEditUserPage();
        long wait  = System.currentTimeMillis() + 10 * 1000; //wait for 10 second , because value of Role combo box appears with some delay
        while (editUserPage.getRole().isEmpty()){
            if (wait < System.currentTimeMillis()) Assert.fail("Timeout while waiting appearing user role in combobox!!!");
            Common.sleep(1000);
        }
        if (fieldName.equalsIgnoreCase("UserRoleList")) {
            editUserPage.roleBox.selectByVisibleText(text);
        } else if (fieldName.equalsIgnoreCase("AgencyList")) {
            editUserPage.fillAgencyList(text + Keys.BACK_SPACE);
        } else if (fieldName.equalsIgnoreCase("FirstName")) {
            editUserPage.fillFirstName(text);
        } else if (fieldName.equalsIgnoreCase("LastName")) {
            editUserPage.fillLastName(text);
        } else if (fieldName.equalsIgnoreCase("Email")) {
            if (editUserPage.isEmailFieldEnabled())editUserPage.fillEmail(text);
        }
        Common.sleep(1500);
    }

    @When("I click cancel on users details page")
    public void clickCancelUserDetailsPage() {
        EditUserPage editUserPage=getSut().getPageNavigator().getEditUserPage();
        editUserPage.clickCancel();
        Common.sleep(1000);
    }

    @When("I change fields on page user details on following values: $fieldsTable")
    public void changeUserFieldsValue(ExamplesTable fieldsTable) {
        EditUserPage editUserPage =getSut().getPageNavigator().getEditUserPage();
        Common.sleep(1000);
        for (Map<String, String> row : parametrizeTableRows(fieldsTable)) {
            if (row.get("Email")!=null) {
                row.put("Email", wrapUserEmailWithTestSession(row.get("Email")));
            }
            User user = getUserBuilder().getUser(row, false);
            if (!user.getEmail().isEmpty()) user.setEmail(""); // due to NGN-5918 Could not edit email
            editUserPage.fillFields(new UserDecorator(user)).clickSave();
        }
    }

    @When("I fill fields on page user details on following values: $fieldsTable")
    public void fillUserFieldsValue(ExamplesTable fieldsTable) {
        EditUserPage editUserPage=getSut().getPageNavigator().getEditUserPage();
        Common.sleep(1000);
        for (Map<String, String> row : fieldsTable.getRows()) {
            if (row.get("Email")!=null) {
                row.put("Email", wrapUserEmailWithTestSession(row.get("Email")));
            }
            User user = getUserBuilder().getUser(row, false);
            editUserPage.fillFields(new UserDecorator(user));
        }
    }

    @When("{I |}upload logo '$logo' on user details page")
    public void uploadLogoOnProfilePage(String logo) {
        if (logo != null && !logo.isEmpty()) {
            EditUserPage editUserPage = getSut().getPageNavigator().getEditUserPage();
            editUserPage.uploadLogo(Logo.valueOf(logo).getPath());

        }
    }

    @When("{I |}select some user on Users page")
    public void selectSomeUser() {
        UsersPage usersPage = getSut().getPageCreator().getUsersPage();
        List<String> visibleUsersFullName = usersPage.getVisibleUsersFieldsByName("FullName");
        String randomUserFullName = visibleUsersFullName.get(new Random().nextInt(visibleUsersFullName.size()));
        usersPage.clickUserItem(randomUserFullName);
    }

    @When("{I |}click '$button' button on projects tab for opened user details on users page")
    public void clickNavigationButtonOnUserDetails(String button) {
        UsersPage page = getSut().getPageCreator().getUsersPage();

        if (button.equalsIgnoreCase("next")) {
            page.clickNavigationButtonOnUserDetails("next");
        } else if (button.equalsIgnoreCase("previous")) {
            page.clickNavigationButtonOnUserDetails("prev");
        } else {
            throw new IllegalArgumentException(String.format("There are not any button with name %s", button));
        }

        Common.sleep(1000);
    }

    @When("{I |}navigate to last page on projects tab for opened user details on users page")
    public void navigateToLastPageOnUserDetails() {
        UsersPage usersPage = getSut().getPageCreator().getUsersPage();

        while (usersPage.isNavigationButtonActiveOnUserDetails("next")) {
            usersPage.clickNavigationButtonOnUserDetails("next");
        }
    }

    @When("{I |}check applications '$applications' on user '$userName' applications page in administration area")
    public void checkApplicationsOnUserDetails(String applications, String userName) {
        UserApplicationsPage page = openUserApplicationsPage(userName);

        for (String application : applications.split(",")) {
            page.checkApplication(ApplicationAccess.getByValue(application.trim().toLowerCase()));
        }
    }

    @When("{I |}select role '$role' for opened user details on users page")
    public void selectRoleForSelectedUser(String role) {
        getSut().getPageCreator().getUserLibraryPage().selectRole(wrapRoleName(role));
        Common.sleep(500);
    }

    @When("{I |}select category '$category' for opened user details on users page")
    public void selectCategoryForSelectedUser(String category) {
        getSut().getPageCreator().getUserLibraryPage().selectCategory(wrapCollectionName(category));
        Common.sleep(500);
    }

    @When("{I |}assign role '$roleName' for category '$categoryName' on library tab for opened user details on users page")
    public void assignRoleForCategoryForSelectedUser(String role, String category) {
        UserLibraryPage page = getSut().getPageCreator().getUserLibraryPage();
        String categoryName = wrapCollectionName(category);
        String roleName = new RolesSteps().isDefaultRole(role) ? role : wrapVariableWithTestSession(role);
        page.assignRoleForCategory(categoryName, roleName);
        Common.sleep(500);
        page.saveUserDetails();
    }

    // | CategoryName | RoleName |
    @When("{I |}assign the following categories for opened user details on users page: $data")
    public void assignCategoriesForSelectedUser(ExamplesTable data) {
        UserLibraryPage page = getSut().getPageCreator().getUserLibraryPage();

        for (Map<String, String> row : parametrizeTableRows(data)) {
            page.selectCategory(wrapCollectionName(row.get("CategoryName")));
            Common.sleep(500);
            page.selectRole(wrapRoleName(row.get("RoleName")));
            Common.sleep(500);
            page.clickAddMoreButtonForUserDetails();
            Common.sleep(500);
        }
    }

    // | CategoryName | RoleName |
    @When("{I |}remove the following categories from opened user details on users page: $data")
    public void removeCategoriesForSelectedUser(ExamplesTable data) {
        UserLibraryPage usersPage = getSut().getPageCreator().getUserLibraryPage();
        for (Map<String, String> row : parametrizeTableRows(data)) {
            usersPage.removeCategory(wrapCollectionName(row.get("CategoryName")),
                    new RolesSteps().isDefaultRole(row.get("RoleName")) ? row.get("RoleName") : wrapVariableWithTestSession(row.get("RoleName")));
        }
    }

    @When("{I |}click remove button next to category '$categoryName' with role '$roleName' for opened user details on users page")
    public void clickRemoveCategoryForSelectedUser(String categoryName, String roleName) {
        categoryName = wrapCollectionName(categoryName);
        roleName = new RolesSteps().isDefaultRole(roleName) ? roleName : wrapVariableWithTestSession(roleName);
        getSut().getPageCreator().getUserLibraryPage().clickRemoveCategory(categoryName, roleName);
    }

    @When("{I |}click '$element' element on Confirm removing popup")
    public void clickElementOnConfirmPopup(String element) {
        PopUpWindow popup = new PopUpWindow(getSut().getPageCreator().getUsersPage());

        if (element.equalsIgnoreCase("ok")) {
            popup.action.click();
        } else if (element.equalsIgnoreCase("close")) {
            popup.close.click();
        } else if (element.equalsIgnoreCase("cancel")) {
            popup.cancel.click();
        } else {
            throw new IllegalArgumentException(String.format("Unknown element name '%s' for confirm popup", element));
        }
        Common.sleep(1000);
    }

    @When("I check 'Select All' checkbox on Users List page")
    public void checkSelectAllCheckbox(){
        UsersPage usersPage = getSut().getPageCreator().getUsersPage();
        usersPage.checkSelectAllCheckBox();
    }

    @Then("{I |}'$condition' see following enabled fields '$fields' on user '$userEmail' edit page")
    public void checkDisabledFields(String condition, String fields, String userEmail) {
        User user = wrapNameAndGetUser(userEmail);
        boolean shouldState = condition.equalsIgnoreCase("should");
        EditUserPage editUserPage = getSut().getPageNavigator().getEditUserPage(user.getId());

        for (String field : fields.split(",")) {

            if (field.equalsIgnoreCase("email")) {
                assertThat("Wrong condition of user email: ", shouldState == editUserPage.isEmailFieldEnabled());
            } else if (field.equalsIgnoreCase("language")) {
                assertThat("Wrong condition of user language: ", shouldState == editUserPage.getLanguageBoxLocator().isEnabled());
            } else {
                assertThat(String.format("Wrong condition of user %s on edit form page", field), shouldState == editUserPage.isFieldEnabled(editUserPage.getLocatorsOfUserForm().get(field)));
            }
        }
    }


    @Then("{I |}'$condition' see checkbox 'Password never expires' on user '$userEmail' settings page")
    public void checkPasswordNeverExpiresVisibility(String condition, String userName) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = openEditUserPage(userName).isPasswordNeverExpiresCheckboxVisible();

        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' see selected checkbox 'Password never expires' on user '$userEmail' settings page")
    public void checkPasswordNeverExpiresState(String condition, String userName) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = openEditUserPage(userName).isPasswordNeverExpiresCheckboxSelected();

        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}should see that I have the following notifications: $data")
    public void checkNotificationCheckboxes(ExamplesTable data){
        checkNotificationCheckboxes(openMyNotificationsSettingPage(), data);
    }

    @Then("{I |}should see the complete list of following notifications: $data")
    public void checkAllNotificationCheckboxes(ExamplesTable data){
        compareNotificationCheckboxes(openMyNotificationsSettingPage(), data);
    }

    // | Name | Checked |
    @Then("{I |}should see that user '$userName' has the following notifications: $data")
    public void checkCustomUserNotificationsCheckboxes(String userName, ExamplesTable data){
        checkNotificationCheckboxes(openNotificationsSettingPage(userName), data);
    }

    @Then("{I |}should see that user '$userName' has the complete list of following notifications: $data")
    public void checkAllCustomUserNotificationsCheckboxes(String userName, ExamplesTable data){
        compareNotificationCheckboxes(openNotificationsSettingPage(userName), data);
    }

    @Then("{I |}should see that the user '$userName' of agency '$agencyName' has the following notifications: $data")
    public void checkCustomUserNotificationsCheckboxesForGA(String userName, Agency agencyName, ExamplesTable data){
        checkNotificationCheckboxesForGA(openNotificationsSettingPageForGA(userName,agencyName), data);
    }

    @Then("I should see all visible users are selected")
    public void checkAllUsersAreSelected(){
        UsersPage usersPage = getSut().getPageCreator().getUsersPage();
        assertThat(usersPage.areAllUsersSelected(), equalTo(true));
    }

    // | Name | Agency | Logo | Role |
    @Then("I '$condition' see following data for selected user: $data")
    public void checkThatSelectedUserHasData(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        UsersPage page = getSut().getPageCreator().getUsersPage();
        Map<String, String> expectedUserData = new HashMap<>();
        Map<String, String> actualUserData = new HashMap<>();
        Map<String, String> userData = parametrizeTabularRow(data);
        if (userData.containsKey("Name")) {
            expectedUserData.put("Name", userData.get("Name"));
            actualUserData.put("Name", page.getSelectedUserName());
        }

        if (userData.containsKey("Agency")) {
            expectedUserData.put("Agency", getData().getAgencyByName(userData.get("Agency")).getName());
            actualUserData.put("Agency", page.getSelectedUserAgency());
        }
        if (userData.containsKey("Role")) {
            expectedUserData.put("Role", wrapRoleName(userData.get("Role")));
            actualUserData.put("Role", page.getSelectedUserRole().toLowerCase());
        }
        if (userData.containsKey("Logo")) {
            expectedUserData.put("Logo", String.valueOf(Logo.valueOf(userData.get("Logo")).getBytes().length));
            actualUserData.put("Logo", String.valueOf(page.getDataByUrl(page.getSelectedUserLogoSrc()).length));
        }
        assertThat(actualUserData, shouldState ? equalTo(expectedUserData) : not(equalTo(expectedUserData)));
    }

    // | Logo | Name | Agency | Email | Telephone | MobileNumber | SkypeNumber | GoogleTalkContact |
    @Then("{I |}'$condition' see following data on User Profile popup: $data")
    public void checkThatProfilePopupHasData(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        UsersPage usersPage = getSut().getPageCreator().getUsersPage();
        UserProfilePopup userProfilePopup = new UserProfilePopup(usersPage);
        Map<String, String> expectedUserData = new HashMap<>();
        Map<String, String> actualUserData = new HashMap<>();
        Map<String, String> userData = parametrizeTabularRow(data);

        if (userData.containsKey("Name")) {
            expectedUserData.put("Name", userData.get("Name"));
            actualUserData.put("Name", userProfilePopup.getUsername());
        }

        if (userData.containsKey("Logo")) {
            expectedUserData.put("LogoSize", Integer.toString(Logo.valueOf(userData.get("Logo")).getBytes().length));
            actualUserData.put("LogoSize", Integer.toString(usersPage.getDataByUrl(userProfilePopup.getLogoSrc()).length));
        }

        if (userData.containsKey("Agency")) {
            expectedUserData.put("Agency", getData().getAgencyByName(userData.get("Agency")).getName());
            actualUserData.put("Agency", userProfilePopup.getAgency());
        }

        if (userData.containsKey("JobTitle")) {
            expectedUserData.put("JobTitle", userData.get("JobTitle"));
            actualUserData.put("JobTitle", userProfilePopup.getJobTitle());
        }

        if (userData.containsKey("Email")) {
            expectedUserData.put("Email", wrapUserEmailWithTestSession(userData.get("Email")));
            actualUserData.put("Email", userProfilePopup.getEmailAddress());
        }

        if (userData.containsKey("Telephone")) {
            expectedUserData.put("Telephone", userData.get("Telephone"));
            actualUserData.put("Telephone", userProfilePopup.getOfficeNumber());
        }

        if (userData.containsKey("MobileNumber")) {
            expectedUserData.put("MobileNumber", userData.get("MobileNumber"));
            actualUserData.put("MobileNumber", userProfilePopup.getMobileNumber());
        }

        if (userData.containsKey("SkypeNumber")) {
            expectedUserData.put("SkypeNumber", userData.get("SkypeNumber"));
            actualUserData.put("SkypeNumber", userProfilePopup.getSkype());
        }

        if (userData.containsKey("GoogleTalkContact")) {
            expectedUserData.put("GoogleTalkContact", userData.get("GoogleTalkContact"));
            actualUserData.put("GoogleTalkContact", userProfilePopup.getGoogleTalk());
        }

        assertThat(actualUserData, shouldState ? equalTo(expectedUserData) : not(equalTo(expectedUserData)));
    }

    @Then("{I |}'$condition' see opened user profile popup")
    public void checkThatUserProfilePopupOpened(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getUsersPage().isUserProfilePopupPresent();

        assertThat(String.format("Check that User Profile popup %s be opened", condition), actualState, is(expectedState));
    }

    // | ProjectName | JobNumber | Logo | Condition |
    @Then("{I |}should see the following projects on Projects tab for opened user details on Users list page: $data")
    public void checkThatProjectsPresentOnUserDetails(ExamplesTable data) {
        UserProjectsPage page = getSut().getPageCreator().getUserProjectsPage();
        List<Map<String,String>> actualFieldsList = page.getFullMapOfVisibleProjectFields(data.getHeaders());

        for(Map<String,String> row : parametrizeTableRows(data)) {
            boolean shouldState = row.get("Condition") == null || row.get("Condition").equalsIgnoreCase("should");
            Map<String,String> expectedFields = new HashMap<>();

            if (row.get("ProjectName") != null) {
                expectedFields.put("ProjectName", wrapVariableWithTestSession(row.get("ProjectName")));
            }
            if (row.get("JobNumber") != null) {
                expectedFields.put("JobNumber", row.get("JobNumber"));
            }
            if (row.get("Logo") != null) {
                expectedFields.put("LogoSize", Integer.toString(Logo.valueOf(row.get("Logo")).getBytes().length));
            }
            assertThat(actualFieldsList, shouldState ? hasItem(expectedFields) : not(hasItem(expectedFields)));
        }
    }

    @Then("{I |}'$condition' see active '$button' button in user details block of users list page")
    public void checkThatNavigationButtonActiveOnUserDetails(String condition, String button) {
        boolean expectedResult = condition.equalsIgnoreCase("should");
        boolean actualResult;
        UsersPage usersPage = getSut().getPageCreator().getUsersPage();

        if (button.equalsIgnoreCase("next")) {
            actualResult = usersPage.isNavigationButtonActiveOnUserDetails("next");
        } else if (button.equalsIgnoreCase("previous")) {
            actualResult = usersPage.isNavigationButtonActiveOnUserDetails("prev");
        } else {
            throw new IllegalArgumentException(String.format("There are not any button with name %s", button));
        }

        assertThat(String.format("Button '%s' %s be active", button, condition), actualResult, is(expectedResult));
    }

    @Then("{I |}should see '$expectedCount' projects for opened user details on users page")
    public void checkDisplayedProjectsCountOnUserDetails(int expectedCount) {
        int actualCount = getSut().getPageCreator().getUserProjectsPage().getVisibleProjectsCount();

        assertThat(actualCount, equalTo(expectedCount));
    }

    @Then("{I |}'$condition' see page '$expectedPageNumber' on projects tab for opened user details on users page")
    public void checkDisplayedProjectsPageNumberOnUserDetails(String condition, int expectedPageNumber) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        int actualPageNumber = getSut().getPageCreator().getUserProjectsPage().getVisibleProjectsPageNumber();

        assertThat(actualPageNumber, shouldState ? equalTo(expectedPageNumber) : not(equalTo(expectedPageNumber)));
    }

    @Then("{I |}'$condition' see checked applications '$apps' for opened user details on users page")
    public void checkThatApplicationsCheckedCorrectly(String condition, String apps) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualAppList = getSut().getPageCreator().getUserApplicationsPage().getCheckedApplications();
        for (String expectedApp : apps.split(",")) {
            assertThat(actualAppList, shouldState ? hasItem(expectedApp) : not(hasItem(expectedApp)));
        }
    }

    // | CategoryName | Condition |
    @Then("{I |}should see the following categories on category drop down on library tab for opened user details on users page: $data")
    public void checkCategoriesAvailableOnUserDetails(ExamplesTable data) {
        List<String> actualCategoriesList = getSut().getPageCreator().getUserLibraryPage().getAvailableCategories();

        for (Map<String, String> row : parametrizeTableRows(data)) {
            boolean shouldState = row.get("Condition").equalsIgnoreCase("should");
            String categoryName = wrapCollectionName(row.get("CategoryName"));

            assertThat(actualCategoriesList, shouldState ? hasItem(categoryName) : not(hasItem(categoryName)));
        }
    }

    // | CategoryName | Condition |
    @Then("{I |}should see the following categories on category list on library tab for opened user details on users page: $data")
    public void checkCategoriesListAvailableOnUserDetails(ExamplesTable data) {
        List<String> actualCategoriesList = getSut().getPageCreator().getUserLibraryPage().getAssignedCategoriesList();

        for (Map<String, String> row : parametrizeTableRows(data)) {
            boolean shouldState = row.get("Condition").equalsIgnoreCase("should");
            String categoryName = wrapCollectionName(row.get("CategoryName"));

            assertThat(actualCategoriesList, shouldState ? hasItem(categoryName) : not(hasItem(categoryName)));
        }
    }


    @Then("{I |}'$condition' be able to change role for category '$categoryName' on library tab for opened user details on users page")
    public void checkThatRoleSelectBoxIsActiveForCategory(String condition, String categoryName) {
        categoryName = wrapVariableWithTestSession(categoryName);
        boolean actualState = getSut().getPageCreator().getUserLibraryPage().isRoleSelectBoxActiveForCategory(categoryName);
        boolean expectedState = condition.equalsIgnoreCase("should");

        assertThat(actualState, is(expectedState));
    }

    // | RoleName | Condition |
    @Then("{I |}should see the following roles on role drop down on library tab for opened user details on users page: $data")
    public void checkRolesAvailableOnUserDetails(ExamplesTable data) {
        List<String> actualCategoriesList = getSut().getPageCreator().getUserLibraryPage().getAvailableRoles();

        for (Map<String, String> row : parametrizeTableRows(data)) {
            boolean shouldState = row.get("Condition").equalsIgnoreCase("should");
            String roleName = new RolesSteps().isDefaultRole(row.get("RoleName")) ? row.get("RoleName") : wrapVariableWithTestSession(row.get("RoleName"));

            assertThat(actualCategoriesList, shouldState ? hasItem(roleName) : not(hasItem(roleName)));
        }
    }

    @Then("{I |}'$condition' see selected role '$role' on role drop down on library tab for opened user details on users page")
    public void checkRoleSelectedOnUserDetails(String condition, String role) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String expectedRoleName = wrapRoleName(role);
        String actualRoleName = getSut().getPageCreator().getUserLibraryPage().getSelectedRole();

        assertThat(actualRoleName, shouldState ? equalTo(expectedRoleName) : not(equalTo(expectedRoleName)));
    }

    @Then("{I |}'$condition' see selected category '$category' on category drop down on library tab for opened user details on users page")
    public void checkCategorySelectedOnUserDetails(String condition, String category) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String expectedCategoryName = wrapRoleName(category);
        String actualCategoryName = getSut().getPageCreator().getUserLibraryPage().getSelectedCategory();

        assertThat(actualCategoryName, shouldState ? equalTo(expectedCategoryName) : not(equalTo(expectedCategoryName)));
    }

    // | CategoryName | RoleName | Condition |
    @Then("{I |}should see assigned to selected user following categories on library tab on users page: $data")
    public void checkCategoriesSelectedOnUserDetails(ExamplesTable data) {
        UserLibraryPage page = getSut().getPageCreator().getUserLibraryPage();
        List<String> actualCategoriesList = page.getAssignedCategoriesList();
        List<String> actualRolesList = page.getAssignedRolesList();

        assertThat(actualCategoriesList.size(), equalTo(actualRolesList.size()));

        List<Map<String, String>> actualResult = new LinkedList<>();
        for (int i = 0; i < actualCategoriesList.size(); i++) {
            Map<String, String> row = new HashMap<>();
            row.put(actualCategoriesList.get(i), actualRolesList.get(i));
            actualResult.add(row);
        }


        for (Map<String, String> row : parametrizeTableRows(data)) {
            boolean shouldState = row.get("Condition").equalsIgnoreCase("should");
            Map<String, String> expectedItem = new HashMap<>();
            String roleName = new RolesSteps().isDefaultRole(row.get("RoleName")) ? row.get("RoleName") : wrapVariableWithTestSession(row.get("RoleName"));
            expectedItem.put(wrapCollectionName(row.get("CategoryName")), roleName);

            assertThat(actualResult, shouldState ? hasItem(expectedItem) : not(hasItem(expectedItem)));
        }
    }

    @Then("{I should see |}'$userName' in User list with logo '$logo'")
    public void checkUserWithLogo(String userName, String logo) {
        UsersPage usersPage = openUsersPage();
        User user = wrapNameAndGetUser(userName);
        Map<String, List<String>> usersFields = usersPage.getFullMapOfVisibleUsersFields("Id", "Logo");
        assertThat(usersFields.get("Id"), hasItem(user.getId()));
        byte[] realLogo = Logo.valueOf(logo).getBytes();
        String logoSrc = null;
        for (String src : usersFields.get("Logo")) if (src.contains(user.getId())) logoSrc = src;
        byte[] userLogo = usersPage.getDataByUrl(logoSrc);

        if (logo.equals("EMPTY")) {
            assertThat("Logo size", userLogo.length, equalTo(realLogo.length));
            for (int i = 0; i < realLogo.length; i++) {
                assertThat("Byte " + i + " equals", userLogo[i], equalTo(realLogo[i]));
            }
        } else {
            assertThat("Logo size", userLogo.length, not(equalTo(realLogo.length)));
        }
    }

    @Then("I see user in the user list with the following data: $data")
    public void checkVisibilityOfNewUser(ExamplesTable data) {
        for (Map<String, String> row : data.getRows()) {
            String email = row.get("Email");
            User user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(email));
            boolean check = row.get("Result").equals("should");
            if (check) {
                //String successResult = user.getFirstName() + " " + user.getLastName();
                String successResult = row.get("Name");
                assertThat("Check that user " + successResult + "is present on the contacts list",
                        getSut().getWebDriver().getPageText().contains(successResult), equalTo(check));
            }
            else {
                String unSuccessResult = wrapUserEmailWithTestSession(row.get("Email"));
                assertThat("Check that email " + wrapUserEmailWithTestSession(row.get("Email")) + " is not present on the contacts list",
                        getSut().getWebDriver().getPageText().contains(unSuccessResult), equalTo(check));
            }
            if (row.get("Logo") != null) {
                AdbankAddressbookPage adbankAddressbookPage = getSut().getPageCreator().getAdbankAddressbookPage();
                byte[] emptyLogo = Logo.EMPTY.getBytes();
                byte[] projectLogo = adbankAddressbookPage.getLogo(user.getId());
                if (row.get("Logo").equals("EMPTY")) {
                    assertThat("Logo length", projectLogo.length, equalTo(emptyLogo.length));
                    for (int i = 0; i < emptyLogo.length; i++) {
                        assertThat(projectLogo[i], equalTo(emptyLogo[i]));
                    }
                } else {
                    assertThat("Logo length", projectLogo.length, not(equalTo(emptyLogo.length)));
                }
            }
            if ((row.get("Agency")!=null) && (row.get("Agency").equals("is not ready"))) {
                assertThat("Functionality isn't ready. Always bug", 1, equalTo(0));
            }
        }
    }

    @Then("{I |}'$shouldState' see '$userName' in User list")
    public void checkUserAbsent(String shouldState, String userName) {
        boolean should = shouldState.equalsIgnoreCase("should");
        User user = wrapNameAndGetUser(userName);
        if(user != null) {
            getSut().getPageNavigator().getUsersPageForUser(user.getId());
        }
        assertThat("I should see user in User list", user, should ? notNullValue() : nullValue());
    }

    @Then("{I |}'$condition' see user '$userName' with filled '$fields' on edit user page")
    public void checkUserFields(String condition, String userName, String fields) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        UserDecorator coreUser = new UserDecorator(wrapNameAndGetUser(userName));
        UserDecorator predefinedUser = new UserDecorator(prepareUser(userName, fields));
        EditUserPage editPage = getSut().getPageCreator().getEditUserPage();
        checkUserFields(editPage, coreUser, predefinedUser, shouldState);
    }

    @Then("'$userName' user should contains '$fields'")
    public void checkUserFields(String userName, String fields) {
        UserDecorator coreUser = new UserDecorator(wrapNameAndGetUser(userName));
        UserDecorator predefinedUser = new UserDecorator(prepareUser(userName, fields));
        EditUserPage editPage = getSut().getPageNavigator().getEditUserPage(coreUser.getId());
        checkUserFields(editPage, coreUser, predefinedUser, true);
    }

    @Then("I '$condition' see sorting type '$fieldName' '$order'")
    public void checkSortingType(String condition, String fieldName, String order) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String classOfSortField = getSut().getPageCreator().getUsersPage().getClassOfSortField(fieldName);
        assertThat(classOfSortField, shouldState ? containsString(order.toLowerCase()) : not(containsString(order.toLowerCase())));
    }

    @Then("I '$condition' see users sorted by field '$fieldName' in order '$order'")
    public void checkThatUsersSorted(String condition, String fieldName, String order) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        Map<String, List<String>> usersFields;
        List<String> allUsers = new ArrayList<>();
        List<String> expectedList = new ArrayList<>();
        UsersPage usersPage = getSut().getPageCreator().getUsersPage();
        if (fieldName.equalsIgnoreCase("user")) {
            List<String> prepareEL1 = new ArrayList<>();
            List<String> prepareEL2 = new ArrayList<>();
            usersFields = usersPage.getFullMapOfVisibleUsersFields("FullNameOnly", "EmailOnly");
            prepareEL1.addAll(usersFields.get("EmailOnly"));  // emails
            prepareEL2.addAll(usersFields.get("FullNameOnly")); // first and second name
            Collections.sort(prepareEL1, String.CASE_INSENSITIVE_ORDER);
            Collections.sort(prepareEL2, String.CASE_INSENSITIVE_ORDER);
            if (order.equalsIgnoreCase("desc")) {
                allUsers.addAll(usersFields.get("FullNameOnly"));
                allUsers.addAll(usersFields.get("EmailOnly"));
                Collections.reverse(prepareEL1);
                Collections.reverse(prepareEL2);
                expectedList.addAll(prepareEL2);
                expectedList.addAll(prepareEL1);
            } else {
                allUsers.addAll(usersFields.get("EmailOnly"));
                allUsers.addAll(usersFields.get("FullNameOnly"));
                expectedList.addAll(prepareEL1);
                expectedList.addAll(prepareEL2);
            }
        } else {
            usersFields = usersPage.getFullMapOfVisibleUsersFields("Unit");
            allUsers.addAll(usersFields.get("Unit"));
            expectedList.addAll(usersFields.get("Unit"));
            Collections.sort(expectedList,String.CASE_INSENSITIVE_ORDER);
            if (order.equalsIgnoreCase("desc"))
                Collections.reverse(expectedList);
        }
        assertThat(allUsers, shouldState ? equalTo(expectedList) : not(equalTo(expectedList)));
    }

    @Then("I '$condition' see users '$userName' according to search text '$text' sorted by field '$fieldName' in order '$order'")
    public void checkUsersAfterSearchAndSorting(String condition, String userName, String text, String fieldName, String order) {
        checkUsersAfterSearchGen(condition.equals("should"), userName, text, fieldName, order);
    }

    @Then("{I |}'$condition' see user '$userName' on users list page in according to search text '$text'")
    public void checkUsersAfterSearch(String condition, String userName, String text) {
        log.debug("checkUsersAfterSearch default was executed");
        checkUsersAfterSearchGen(condition.equalsIgnoreCase("should"), userName, text, "User", "asc");
    }

    @Then("{I |}should see user list sorted by '$sortingType'")
    public void checkUsersSorting(String sortingType) {
        Common.sleep(5000);
        UsersPage usersPage = openUsersPage();
        List<String> usersName =
                sortingType.equals("By first name") ?
                        usersPage.getVisibleUsersFirstName() :
                        usersPage.getVisibleUsersLastName();
        assertThat(usersName, sortedAlphabetically());
    }

    @Then("{I |}should see on user details page fields with following values: $elementsTable")
    public void checkFields(ExamplesTable fieldsTable) {
        EditUserPage editUserPage=getSut().getPageNavigator().getEditUserPage();
        Common.sleep(1000);
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            String elementName = row.get("element");
            String elementValue = row.get("value");
            boolean should=elementValue.equals("should");
            if (elementName.equals("FirstName")) {
                assertThat(elementValue,equalTo(editUserPage.getFirstName()));
            } else if (elementName.equals("LastName")) {
                assertThat(elementValue,equalTo(editUserPage.getLastName()));
            } else if (elementName.equals("Email")) {
                elementValue = wrapUserEmailWithTestSession(elementValue);
                assertThat(elementValue,equalTo(editUserPage.getEmail()));
            } else if (elementName.equals("Telephone")) {
                assertThat(elementValue,equalTo(editUserPage.getPhoneNumber()));
            } else if (elementName.equals("Role")) {
                //wait for 10 second , because value of Role combo box appears with some delay
                long wait  = System.currentTimeMillis() + 10 * 1000;
                while (editUserPage.getRole().isEmpty()) {
                    if (wait < System.currentTimeMillis())
                        Assert.fail("Timeout while waiting appearing user role in combobox!!!");
                    Common.sleep(1000);
                }

                List<String> elementValues = new ArrayList<>();
                elementValues.add(elementValue);
                if (elementValue.equals("guest.user")) elementValues.add("Guest User");
                if (elementValue.equals("agency.admin")) elementValues.add("Business Unit Admin");
                assertThat(editUserPage.getRole(), isIn(elementValues));
            } else if (elementName.equals("Folders")) {
                assertThat(should,equalTo(editUserPage.isFoldersChecked()));
            } else if (elementName.equals("Ordering")) {
                assertThat(should,equalTo(editUserPage.isOrderingChecked()));
            }  else if (elementName.equals("Library")) {
                assertThat(should,equalTo(editUserPage.isLibraryChecked()));
            }  else if (elementName.equals("Streamlined Library")) {
                assertThat(should,equalTo(editUserPage.isStreamlinedLibraryChecked()));
            } else {
                throw new IllegalArgumentException("Unknown element name " + elementName +" on user details page!");
            }
        }
    }

    @Then("I should see user '$userName' details page")
    public void checkUserDetailsPage(String userName) {
        User user = wrapNameAndGetUser(userName);
        String expectedPage = String.format("/people/users/%s:edit", user.getId());
        assertThat(BabylonSteps.getCurrentPageName(), equalTo(expectedPage));
    }

    @Then("{I |}'$condition' see user count '$expectedUserCount' on Users page")
    public void checkUserCounter(String condition, String expectedUserCount) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String actualUserCount = getSut().getPageCreator().getUsersPage().getUserCount();

        assertThat(actualUserCount, shouldState ? equalTo(expectedUserCount) : not(equalTo(expectedUserCount)));
    }

    @Then("{I |}'$condition' see item '$expectedAgencyName' in agencies list on Users page")
    public void checkThatAgencyNamePresents(String condition, String agencyName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        Agency agency = getData().getAgencyByName(agencyName);
        String expectedAgencyName = agency == null ? wrapVariableWithTestSession(agencyName) : agency.getName();
        List<String> actualAgencyNamesList = getSut().getPageCreator().getUsersPage().getAgencyNamesList();

        assertThat(actualAgencyNamesList, shouldState ? hasItem(expectedAgencyName) : not(hasItem(expectedAgencyName)));
    }

    @Then("{I |}'$condition' see active '$buttonName' button on Users page")
    public void checkThatButtonActive(String condition, String buttonName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        UsersPage usersPage = getSut().getPageCreator().getUsersPage();
        String assertionMessage = String.format("Button '%s' %s be active", buttonName, condition);

        if (buttonName.equalsIgnoreCase("next page")) {
            assertThat(assertionMessage, usersPage.isNextPageButtonActive(), is(shouldState));
        } else if (buttonName.equalsIgnoreCase("previous page")) {
            assertThat(assertionMessage, usersPage.isPreviousPageButtonActive(), is(shouldState));
        } else if (buttonName.equalsIgnoreCase("add to team")) {
            assertThat(assertionMessage, usersPage.isAddToTeamButtonActive(), is(shouldState));
        } else {
            throw new IllegalArgumentException(String.format("Unknown button name: '%s'", buttonName));
        }
    }

    @Then("{I |}'$condition' see user '$userNames' on opened users list")
    public void checkThatUserPresentOnOpenedList(String condition, String userNames){
        boolean shouldState = condition.equalsIgnoreCase("should");
        Map<String, List<String>> visibleUsersFields = getSut().getPageCreator().getUsersPage().getVisibleUsersFields("Id", "FullName");
        List<Map<String, String>> actualUsersFieldsList = new ArrayList<>();

        for (int i = 0; i < visibleUsersFields.get("Id").size(); i++) {
            Map<String, String> actualUserFields = new HashMap<>();
            actualUserFields.put("Id", visibleUsersFields.get("Id").get(i));
            actualUserFields.put("FullName", visibleUsersFields.get("FullName").get(i));
            actualUsersFieldsList.add(actualUserFields);
        }

        for (String userName : userNames.split(",")) {
            User user = wrapNameAndGetUser(userName);
            Map<String, String> expectedUserFields = new HashMap<>();
            expectedUserFields.put("Id", user.getId());
            expectedUserFields.put("FullName", user.getFullName() == null ? user.getEmail() : user.getFullName());

            assertThat(actualUsersFieldsList, shouldState ? hasItem(expectedUserFields) : not(hasItem(expectedUserFields)));
        }
    }

    @Then("{I |}'$condition' see opened page '$expectedPageNumber' of Users list page")
    public void checkOpenedUsersListPageNumber(String condition, String expectedPageNumber){
        boolean shouldState = condition.equalsIgnoreCase("should");
        String actualPageNumber = getSut().getPageCreator().getUsersPage().getPageNumber();

        assertThat(actualPageNumber, shouldState ? equalTo(expectedPageNumber) : not(equalTo(expectedPageNumber)));
    }

    @Then("{I |}'$condition' see all users are selected on Users list page")
    public void checkThatAllUsersSelected(String condition) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        UsersPage usersPage = getSut().getPageCreator().getUsersPage();
        int expectedUsersCount = 7;
        int actualUsersCount = usersPage.getSelectedUsersFullName().size();
        String assertionMessage = String.format("All users %s be selected on Users list page", condition);
        assertThat(assertionMessage, actualUsersCount, shouldState ? equalTo(expectedUsersCount) : not(equalTo(expectedUsersCount)));
    }

    @Then("{I |}'$condition' see '$count' users are selected on Users list page")
    public void checkCountSelectedUsers(String condition, int count) {
        UsersPage usersPage = getSut().getPageCreator().getUsersPage();
        int actualUsersCount = usersPage.getSelectedUsersFullName().size();
        assertThat(actualUsersCount, condition.equalsIgnoreCase("should") ? equalTo(count) : not(equalTo(count)));
    }

    @Then("{I |}should be on create user page")
    public void checkThatCurrentPageIsCreateUserPage() {
        getSut().getPageCreator().getCreateUserPage();
    }

    @Then("{I |}'$condition' see user with email '$userEmail' on Users list page")
    public void checkThatUserPresentsOnPageWithEmail(String condition, String userEmail) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String expectedUserEmail = wrapUserEmailWithTestSession(userEmail);
        UsersPage usersPage = getSut().getPageCreator().getUsersPage();
        Map<String, List<String>> actualUsersFields = usersPage.getFullMapOfVisibleUsersFields("Id");
        List<String> actualUsersEmailList = new ArrayList<>();

        for (String userId : actualUsersFields.get("Id")) {
            actualUsersEmailList.add(getCoreApiAdmin().getUser(userId).getEmail());
        }

        assertThat(actualUsersEmailList, shouldState ? hasItem(expectedUserEmail) : not(hasItem(expectedUserEmail)));
    }

    // | FullName | Role | Unit |
    @Then("I '$condition' see users with following fields on users list page: $usersFields")
    public void checkThatUsersFieldsDisplayedCorrectly(String condition, ExamplesTable usersFields) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<Map<String,String>> actualUsersFields = new ArrayList<>();
        List<Map<String,String>> expectedUsersFields = new ArrayList<>();

        Map<String,List<String>> usersDetails = getSut().getPageCreator().getUsersPage().getFullMapOfVisibleUsersFields("FullName", "Role", "Unit");

        for (int i = 0; i < usersDetails.get("FullName").size(); i++) {
            Map<String,String> fields = new HashMap<>();
            for (String key : usersDetails.keySet())
                fields.put(key, usersDetails.get(key).get(i));
            actualUsersFields.add(fields);
        }

        for (Map<String,String> row : parametrizeTableRows(usersFields)) {
            Map<String,String> fields = new HashMap<>();
            fields.put("FullName", row.get("FullName"));
            String expectedRoleName = wrapRoleName(row.get("Role")).replaceAll("[\\._]", " ");
            expectedRoleName = Character.toUpperCase(expectedRoleName.charAt(0)) + expectedRoleName.substring(1);
            fields.put("Role", expectedRoleName);
            Agency agency = getData().getAgencyByName(row.get("Unit"));
            fields.put("Unit", agency == null ? wrapVariableWithTestSession(row.get("Unit")) : agency.getName());
            expectedUsersFields.add(fields);
        }

        for (Map<String, String> expectedUserFields : expectedUsersFields) {
            assertThat(actualUsersFields, shouldState ? hasItem(expectedUserFields) : not(hasItem(expectedUserFields)));
        }
    }

    @Then("I should see that users list is empty on the library tab for selected user")
    public void checkThatUsersListIsEmpty() {
        assertThat(getSut().getPageCreator().getUserLibraryPage().getListOfCategoryRoles().size(), equalTo(0));
    }

    @Then("I should see Agency Project Teams list is displayed")
    public void checkAgencyProjectTeamsListPresent(){
        UsersPage usersPage = getSut().getPageCreator().getUsersPage();
        assertThat(usersPage.isAgencyProjectTeamsListPresent(),equalTo(true));
    }

    // | UserName | Role |
    @Given("{I |} created agency project team '$teamName' with following data: $aptData")
    public void createAgencyProjectTeam(String teamName, ExamplesTable aptData) {
        AgencyProjectTeam agencyProjectTeam = new AgencyProjectTeam();
        agencyProjectTeam.setName(wrapVariableWithTestSession(teamName));
        List<AgencyTeamMember> listOfMembers = new ArrayList<>();
        for (int i = 0; i < aptData.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(aptData, i);
            AgencyTeamMember membersAgencyProjectTeam = new AgencyTeamMember();
            String userId = "";
            String roleId = "";
            if (row.get("UserName")!= null && !row.get("UserName").isEmpty()) {
                userId = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(row.get("UserName"))).getId();
            }
            if (row.get("Role")!= null && !row.get("Role").isEmpty()) {
                roleId = getCoreApi().getRoleByName(wrapRoleName(row.get("Role")), false).getId();
            }
            membersAgencyProjectTeam.setUserId(userId);
            membersAgencyProjectTeam.setRoleId(roleId);
            listOfMembers.add(membersAgencyProjectTeam);
        }
        agencyProjectTeam.setMembers(listOfMembers.toArray(new AgencyTeamMember[listOfMembers.size()]));
        getCoreApi().createAgencyTeam(agencyProjectTeam);
    }

    // | MinimumPasswordLength | UppercaseCharactersCount | LowercaseCharactersCount | NumbersCount |
    @Then("{I |}'$condition' see message about password rules on create user page with following attributes: $data")
    public void checkPasswordRulesAttributes(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        Map<String,String> params = parametrizeTabularRow(data);
        String expectedMessage = String.format("Your password must have a minimum of %s characters and include at least %s number(s), at least %s uppercase letter(s)",
                params.get("MinimumPasswordLength"), params.get("NumbersCount"), params.get("UppercaseCharactersCount"));

        String actualMessage = getSut().getPageCreator().getCreateUserPage().getPasswordQualityText();

        assertThat(actualMessage, shouldState ? containsString(expectedMessage) : not(containsString(expectedMessage)));
    }

    // | MinimumPasswordLength | UppercaseCharactersCount | LowercaseCharactersCount | NumbersCount |
    @Then("{I |}'$condition' see message about password rules on user '$userName' settings page with following attributes: $data")
    public void checkPasswordRulesAttributes(String condition, String userName, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        Map<String,String> params = parametrizeTabularRow(data);
        String expectedMessage = String.format("Your password must have a minimum of %s characters and include at least %s number(s), at least %s uppercase letter(s).",
                params.get("MinimumPasswordLength"), params.get("NumbersCount"), params.get("UppercaseCharactersCount"));

        String actualMessage = openAccountSettingPage(userName).getPasswordQualityText();

        assertThat(actualMessage, shouldState ? containsString(expectedMessage) : not(containsString(expectedMessage)));
    }

    @Then("{I |}'$should' see 'View Public Templates' option on user details page")
    public void checkViewPublicTemplates(String condition) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getEditUserPage().isViewPublicTemplate();
        assertThat(actualState, is(shouldState));
    }

    @Then("{I |}'$condition' see selected Password field on create user page")
    public void checkPasswordFieldVisibilityState(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getCreateUserPage().isPasswordTextboxVisible();

        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' see '$application' application access checkbox on user '$userName' details page")
    public void checkFoldersApplicationFieldVisibilityState(String condition, String application, String userName) {
        User user = wrapNameAndGetUser(userName);
        if (user == null)
            throw new IllegalStateException(String.format("Could not found user '%s'", userName));
        Common.sleep(3000);
        EditUserPage page = getSut().getPageNavigator().getEditUserPage(user.getId());
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = page.isApplicationCheckboxVisible(application);

        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' be able to see a value selected on all user notification settings dropdown")
    public void checkForDefaultDropdownValues(String condition) {

        NotificationsSettingPageForGA settingsPageForGA = getSut().getPageCreator().getNotificationSettingPageForGA();
        List<String> notifications =  settingsPageForGA.getAllNotifications();
        for(String notification: notifications) {
            boolean expectedState = condition.equalsIgnoreCase("should");
            boolean actualState = !settingsPageForGA.getNotificationStatus(notification).isEmpty();
            assertThat("Notification-" + notification + "has no default value selected", actualState, is(expectedState));
        }
    }

    @Then("{I |}'$condition' be able to see a value selected on all user notification settings on My Notification settings page")
    public void checkForDefaultDropdownValuesAsAgencyAdmin(String condition) {
        MyNotificationsSettingPage settingsPage = getSut().getPageCreator().getMyNotificationSettingPage();
        List<String> notifications =  settingsPage.getAllNotifications();
        for(String notification: notifications) {
            boolean expectedState = condition.equalsIgnoreCase("should");
            boolean actualState = !settingsPage.getNotificationStatus(notification).isEmpty();
            assertThat("Notification-" + notification + "has no default value selected", actualState, is(expectedState));
        }
    }
    // state - on, off
    @Given("{I |}set '$state' '$application' application checkbox on user '$userName' details page")
    @When("{I |}set '$state' '$application' application checkbox on user '$userName' details page")
    public void setApplicationCheckbox(String state, String application, String userName ){
        User user = wrapNameAndGetUser(userName);
        if (user==null)
            throw new IllegalStateException(String.format("Could not found user '%s'", userName));
        Common.sleep(3000);
        EditUserPage page = getSut().getPageNavigator().getEditUserPage(user.getId());
        page.setApplicationAccessCheckboxState(application, state.equalsIgnoreCase("on"));
    }

    public String wrapRoleName(String roleName) {
        if (!(new RolesSteps().isDefaultRole(roleName))) {
            roleName = wrapVariableWithTestSession(roleName);
        } else if (!roleName.contains("project")) {
            roleName = roleName.replaceAll("(\\.|_)", " ");
        }
        return roleName;
    }

    private void createUserViaCore(User user, boolean allowToViewPublicTemplates) {
        if (getCoreApiAdmin().getUserByEmail(user.getEmail(), 0) == null) {
            if (user.getLogo().isEmpty()) {
                user.setLogo(Logo.EMPTY.getBase64());
            }
            User result = getCoreApiAdmin().createUser(user);
            getCoreApiAdmin().allowUserToViewPublicTemplates(result.getAgency().getId(), result.getId(), allowToViewPublicTemplates);
            getCoreApiAdmin().getUserByEmail(user.getEmail());// wait until user appear in search
        }
    }

    private void checkUserFields(EditUserPage editPage, UserDecorator coreUser, UserDecorator predefinedUser, boolean shouldState) {
        assertThat("First Name", editPage.getFirstName(), shouldState ? equalTo(coreUser.getFirstName()) : not(equalTo(coreUser.getFirstName())));
        assertThat("Last Name", editPage.getLastName(), shouldState ? equalTo(coreUser.getLastName()) : equalTo(coreUser.getLastName()));
        //assertThat("Agency", editPage.getAgency(), shouldState ? equalTo(coreUser.getAgencyName()) : not(equalTo(coreUser.getAgencyName())));  due to remove advertisers, and NGN-6231
        assertThat("Email", editPage.getEmail(), shouldState ? equalTo(coreUser.getEmail()) : not(equalTo(coreUser.getEmail())));
        assertThat("Phone", editPage.getPhoneNumber(), shouldState ? equalTo(coreUser.getPhoneNumber() == null ? "" : coreUser.getPhoneNumber()) : not(equalTo(coreUser.getPhoneNumber())));
        //TODO Add logo comparison, editPage.getLogoSrc() was base64 logo, but now it path to document
        if (!predefinedUser.getLogo().isEmpty()) {
            //    assertThat("Logo", editPage.getLogoSrc(), shouldState ? equalTo(coreUser.getLogo()) : not(equalTo(coreUser.getLogo())));
            throw new Error("Add logo comparison");
        }
        assertThat("Access to folders", editPage.isFoldersChecked(), shouldState ? equalTo(coreUser.isFoldersAccess()) : not(equalTo(coreUser.isFoldersAccess())));
        assertThat("Access to library", editPage.isLibraryChecked(), shouldState ? equalTo(coreUser.isLibraryAccess()) : not(equalTo(coreUser.isLibraryAccess())));
        assertThat("Access to ordering", editPage.isOrderingChecked(), shouldState ? equalTo(coreUser.isOrderingAccess()) : not(equalTo(coreUser.isOrderingAccess())));
        assertThat("Role", editPage.getRole(), shouldState ? equalTo(predefinedUser.getRoleName()) : not(equalTo(predefinedUser.getRoleName())));

    }

    protected void checkUsersAfterSearchGen(boolean shouldState, String userName, String text, String sortingField, String sortingOrder) {
        String[] usersEmail;
        UsersPage usersPage;
        usersPage = getSut().getPageCreator().getUsersPage();
        List<User> allUsers = getCoreApi().findUsers(new LuceneSearchingParams()).getResult();
        Map<String, List<String>> usersFields = usersPage.getFullMapOfVisibleUsersFields("Id", "FullName");
        List<String> allUsersId = usersFields.get("Id");
        List<String> allUsersFullName = usersFields.get("FullName");

        if (shouldState) {
            if (!userName.isEmpty()) {
                usersEmail = userName.split(",");
            } else {
                assertThat("I check that find nothing", allUsersId.size(), equalTo(0));
                return;
            }

            assertThat("I check that users in UI result after search not less than I have to find", allUsersId.size(), greaterThanOrEqualTo(usersEmail.length));
            assertThat("I check that users in UI result after search less than API return",
                    allUsersId.size(),
                    text.isEmpty() ? equalTo(allUsers.size()) : lessThanOrEqualTo(allUsers.size()));

            if (text.isEmpty()) return;

            for (String email: usersEmail) {
                email = wrapUserEmailWithTestSession(email);
                User user = getCoreApi().getUserByEmail(email);
                assertThat("I check that list of users in UI result contains user from scenario", allUsersId, hasItem(user.getId()));
                assertThat(allUsersFullName.get(allUsersId.indexOf(user.getId())), equalTo(user.getFullName()));
            }

            if (!sortingOrder.isEmpty()) {
                if (sortingField.equalsIgnoreCase("user")) {
                    List<String> beforeMySorting = new ArrayList<>();
                    beforeMySorting.addAll(allUsersFullName);
                    Collections.sort(beforeMySorting, String.CASE_INSENSITIVE_ORDER);

                    if (sortingOrder.equalsIgnoreCase("desc")) {
                        Collections.reverse(beforeMySorting);
                    }

                    assertThat(allUsersFullName, equalTo(beforeMySorting));
                } else if (sortingField.equalsIgnoreCase("unit")) {
                    Assert.fail("Assertion to check users ordering by Unit isn't implemented yet");
                }
            }
        } else {
            if (!userName.isEmpty()) {
                usersEmail = userName.split(",");
                for (String email: usersEmail) {
                    email = wrapUserEmailWithTestSession(email);
                    User user = getCoreApi().getUserByEmail(email);

                    if (user != null) {
                        assertThat("I check that list of users in UI result doesn't contains user from scenario ", allUsersId, not(hasItem(user.getId())));
                        assertThat(allUsersFullName, not(hasItem(String.format("%s %s", user.getFirstName(), user.getLastName()))));
                        log.debug("check InappropriateEmail " + user.getEmail());
                    }
                }
            } else {
                assertThat("I check that don't find anything", allUsersId.size(), equalTo(allUsers.size()));
            }
        }
    }

    protected static User prepareUser(String userName) {
        return prepareUser(userName, "MandatoryFields");
    }

    private static User prepareUser(String userName, String fields) {
        return prepareUser(userName, fields, "");
    }

    private static User prepareUser(String userName, String fields, String logo) {
        return getUserBuilder().getUser(fields, logo, wrapUserEmailWithTestSession(userName));
    }

    protected static User wrapNameAndGetUser(String userName) {
        return getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userName));
    }

    protected static String wrapNameAndGetUserId(String userName) {
        User user = wrapNameAndGetUser(userName);
        if (user == null) throw new IllegalArgumentException(String.format("Could not find user '%s'", userName));

        return user.getId();
    }
}