package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.ContactSearchingParams;
import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.data.Logo;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AdBankTeamsPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AddTeamTemplatePopUpWindow;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AddTeamUserPopUpWindow;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.TeamUserPermissionsPopUpWindow;
import com.adstream.automate.utils.Common;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;

import java.util.*;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 07.08.12
 * Time: 12:37
 */
public abstract class AbstractTeamsStep extends AbstractProjectTabsSteps {
    protected abstract AdBankTeamsPage getTeamsPage(String objectId);

    protected abstract AdBankTeamsPage getTeamsPage(String objectId, String agencyTeamId);

    protected abstract AdBankTeamsPage getTeamsPageByUser(String objectId, String userId);

    protected abstract AdBankTeamsPage getCurrentTeamsPage();

    protected AdBankTeamsPage openTeamsPage(String objectName) {
        objectName = wrapVariableWithTestSession(objectName);
        Project object = getObjectByName(objectName);
        return getTeamsPage(object.getId());
    }

    protected AdBankTeamsPage openTeamsPage(String objectName, User user) {
        objectName = wrapVariableWithTestSession(objectName);
        Project object = getObjectByName(objectName, user);
        return getTeamsPage(object.getId());
    }

    protected AdBankTeamsPage openTeamsPage(String objectName, String userName) {
        objectName = wrapVariableWithTestSession(objectName);
        Project object = getObjectByName(objectName);
        User user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userName));
        return getTeamsPageByUser(object.getId(), user.getId());
    }

    protected AdBankTeamsPage openTeamsPageAgencyTeam(String objectName, String agencyTeamId) {
        objectName = wrapVariableWithTestSession(objectName);
        Project object = getObjectByName(objectName);
        return getTeamsPage(object.getId(), agencyTeamId);
    }


    protected void fillAddUserPopUp(String userName, String objectName, String role, String expiredDate, ExamplesTable foldersTable) {
        AddTeamUserPopUpWindow popup = new AddTeamUserPopUpWindow(openTeamsPage(objectName));

        if (!userName.isEmpty()) {
            userName = wrapUserEmailWithTestSession(userName);
            popup.setName(userName);
        }

        for (Map<String, String> row : foldersTable.getRows()) {
            popup.toggleFolder(wrapPathWithTestSession(row.get("Folder")));

            if (!expiredDate.isEmpty()) {
                String expiredDateString = parseDateTime(expiredDate).toString(DateTimeFormat.forPattern(getContext().userDateTimeFormat));
                //popup.expirationDate.selectByVisibleText(expiredDateString);
               popup.expirationDate.type(expiredDateString);
            }

            if (!role.isEmpty()) {
                role = new RolesSteps().wrapRoleName(role);
               popup.role.selectByVisibleText(role);
               // popup.role.select(role);

                popup.clickAddRole();
                Common.sleep(1000);
            }
        }

        Common.sleep(1000);
    }

    protected void fillAddUserPopUpViaAddUser(String userName, String objectName, String role, String expiredDate, ExamplesTable foldersTable) {
        //AddTeamUserPopUpWindow popup = new AddTeamUserPopUpWindow(openTeamsPage(objectName));
        AddTeamTemplatePopUpWindow popup = new AddTeamTemplatePopUpWindow(openTeamsPage(objectName));

        if (!userName.isEmpty()) {
            userName = wrapUserEmailWithTestSession(userName);
            popup.setName(userName);
        }

        for (Map<String, String> row : foldersTable.getRows()) {
            popup.toggleFolder(wrapPathWithTestSession(row.get("Folder")));

            if (!expiredDate.isEmpty()) {
                String expiredDateString = parseDateTime(expiredDate).toString(DateTimeFormat.forPattern(getContext().userDateTimeFormat));
                //popup.expirationDate.selectByVisibleText(expiredDateString);
                popup.expirationDate.type(expiredDateString);
            }

            if (!role.isEmpty()) {
                role = new RolesSteps().wrapRoleName(role);
               // popup.role.selectByVisibleText(role);
                 popup.selectRole(role);

                popup.clickAddRole();
                Common.sleep(1000);
            }
        }

        Common.sleep(1000);
    }

    // NGN-18452 - Share Folder along with project
    protected void fillAddUserPopUpViaAddUserWithProject(String userName, String objectName, String role, String expiredDate, ExamplesTable foldersTable) {
        //AddTeamUserPopUpWindow popup = new AddTeamUserPopUpWindow(openTeamsPage(objectName));
        AddTeamTemplatePopUpWindow popup = new AddTeamTemplatePopUpWindow(openTeamsPage(objectName));

        if (!userName.isEmpty()) {
            userName = wrapUserEmailWithTestSession(userName);
            popup.setName(userName);
        }

        for (Map<String, String> row : foldersTable.getRows()) {
            popup.toggleFolder(wrapPathWithTestSession(row.get("Folder")));

           WebElement elementLocatot =  getSut().getWebDriver().findElement(By.xpath("//span[contains(.,'"+wrapVariableWithTestSession(objectName)+"')]"));
            getSut().getWebDriver().getActions().keyDown(Keys.CONTROL).moveToElement(elementLocatot).click().perform();
            getSut().getWebDriver().getActions().keyUp(Keys.CONTROL).perform();

            if (!expiredDate.isEmpty()) {
                String expiredDateString = parseDateTime(expiredDate).toString(DateTimeFormat.forPattern(getContext().userDateTimeFormat));
                //popup.expirationDate.selectByVisibleText(expiredDateString);
                popup.expirationDate.type(expiredDateString);
            }

            if (!role.isEmpty()) {
                role = new RolesSteps().wrapRoleName(role);
                // popup.role.selectByVisibleText(role);
                popup.selectRole(role);

                popup.clickAddRole();
                Common.sleep(1000);
            }
        }
        Common.sleep(1000);
    }




    protected void fillAddPrivateTemplate(String templateName, String objectName, String roles, String expiredDate, String folder) {
        AddTeamUserPopUpWindow popup = new AddTeamUserPopUpWindow(openTeamsPage(objectName));

        popup.toggleFolder(wrapPathWithTestSession(folder));

        if (!templateName.isEmpty()) {
            templateName = wrapVariableWithTestSession(templateName);
            popup.setName(templateName);
        }

        if (!expiredDate.isEmpty()) {
            String expiredDateString = parseDateTime(expiredDate).toString(DateTimeFormat.forPattern(getContext().userDateTimeFormat));
            popup.expirationDate.setValue(expiredDateString);
        }

        if (!roles.isEmpty()) {
            for (String role : roles.split(",")) {
                role = new RolesSteps().wrapRoleName(role);
                popup.role.selectByVisibleText(role);
                //popup.role.select(role);
                popup.clickAddRole();
            }
            Common.sleep(1000);
        }
        Common.sleep(1000);
    }

    protected void fillAddPrivateTemplateVisAdduser(String templateName, String objectName, String roles, String expiredDate, String folder) {
        //AddTeamUserPopUpWindow popup = new AddTeamUserPopUpWindow(openTeamsPage(objectName));
        AddTeamTemplatePopUpWindow popup = new AddTeamTemplatePopUpWindow(openTeamsPage(objectName));

        popup.toggleFolder(wrapPathWithTestSession(folder));

        if (!templateName.isEmpty()) {
            templateName = wrapVariableWithTestSession(templateName);
            popup.setName(templateName);
        }

        if (!expiredDate.isEmpty()) {
            String expiredDateString = parseDateTime(expiredDate).toString(DateTimeFormat.forPattern(getContext().userDateTimeFormat));
            popup.expirationDate.setValue(expiredDateString);
        }

        if (!roles.isEmpty()) {
            for (String role : roles.split(",")) {
                role = new RolesSteps().wrapRoleName(role);
               // popup.role.selectByVisibleText(role);
                //popup.role.select(role);
                popup.selectRole(role);
                popup.clickAddRole();
            }
            Common.sleep(1000);
        }
        Common.sleep(1000);
    }
    protected void checkUserSelected(String condition, String userName, String objectName) {
        openTeamsPage(objectName, userName);
        checkUserSelected(condition, userName);
    }

    protected void addUserIntoTeamPopUp(String userName, String objectName) {
        AddTeamUserPopUpWindow popup = new AddTeamUserPopUpWindow(openTeamsPage(objectName));
        userName = wrapUserEmailWithTestSession(userName);
        popup.setName(userName);
    }

    protected void checkUsersCountInTeamPopUp(int count, String objectName) {
        AddTeamUserPopUpWindow popup = new AddTeamUserPopUpWindow(openTeamsPage(objectName));
        assertThat(popup.getAutoCompleteItemsCount(), equalTo(count));
    }

    protected void checkUsersNameInTeams(String shouldState, String userName, String objectName, String agencyTeamName) {
//        Common.sleep(1000);
        boolean should = shouldState.equals("should");
        User userFromEnum = getData().getUserByType(userName);
        User user = userFromEnum == null? getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userName)): userFromEnum;
        getSut().getWebDriver().navigate().refresh();
        AdBankTeamsPage teamsPage;
        if (agencyTeamName.isEmpty()) {
            teamsPage = openTeamsPage(objectName); }
        else {
            AgencyProjectTeam agencyProjectTeam = getCoreApi().getAgencyProjectTeamByName(wrapPathWithTestSession(agencyTeamName));
            teamsPage = openTeamsPageAgencyTeam(objectName, "/" + agencyProjectTeam.getId());
        }
        assertThat("Is user present " + user.getFullName(), user.isEasyUser() ? teamsPage.isUserPresent(user.getEmail()) :
               teamsPage.isUserPresent(user.getFullName()), is(should));
    }

    protected void checkUsersNameInTeamsForClient(String shouldState, String userName, String objectName, String agencyTeamName) {
        Common.sleep(1000);
        boolean should = shouldState.equals("should");

        AdBankTeamsPage teamsPage;
        if (agencyTeamName.isEmpty()) {
            teamsPage = openTeamsPage(objectName); }
        else {
            AgencyProjectTeam agencyProjectTeam = getCoreApi().getAgencyProjectTeamByName(wrapPathWithTestSession(agencyTeamName));
            teamsPage = openTeamsPageAgencyTeam(objectName, "/" + agencyProjectTeam.getId());
        }
        assertThat("Is user present " + userName, teamsPage.isUserPresent(userName), is(should));
    }

    protected void checkUsersNameInTeamsWithInterval(String shouldState, String userName, String objectName, String agencyTeamName) {
        Common.sleep(1000);
        boolean should = shouldState.equals("should");
        User userFromEnum = getData().getUserByType(userName);
        User user = userFromEnum == null? getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userName)): userFromEnum;
        getSut().getWebDriver().navigate().refresh();
        AdBankTeamsPage teamsPage;
        if (agencyTeamName.isEmpty()) {
            teamsPage = openTeamsPage(objectName); }
        else {
            AgencyProjectTeam agencyProjectTeam = getCoreApi().getAgencyProjectTeamByName(wrapPathWithTestSession(agencyTeamName));
            teamsPage = openTeamsPageAgencyTeam(objectName, "/" + agencyProjectTeam.getId());
        }
        int i = 1;
        boolean user_exists = teamsPage.isUserPresent(user.getFullName());
        do {
            if (user_exists == false ) {
                Common.sleep(60000);
                getSut().getWebDriver().navigate().refresh();
            }
            user_exists = teamsPage.isUserPresent(user.getFullName());
            i++;
        } while (user_exists == false && i<=5);
        assertThat(true, should ? equalTo(user_exists) : not(user_exists));
    }


    protected void selectUserInLookUpInTeamPopUp(String firstName, String objectName) {
        AddTeamUserPopUpWindow popup = new AddTeamUserPopUpWindow(openTeamsPage(objectName));
        assertThat(popup.isUserAvailableForSelecting(firstName), equalTo(true));
    }

    protected void checkTextInUserLookUpInTeamPopUp(String shouldState, String userEmail) {
        AddTeamUserPopUpWindow popup = new AddTeamUserPopUpWindow(getCurrentTeamsPage());
        boolean should = shouldState.equals("should");
        boolean present = popup.isUserLookUpResultsContainsText(userEmail);
        assertThat("Is text in user lookup present", present, is(should));
    }

    protected void checkUsersLogoInLookUpInTeamPopUp(String firstName, String objectName) {
        AddTeamUserPopUpWindow popup = new AddTeamUserPopUpWindow(openTeamsPage(objectName));
        byte[] userLogo = popup.getUserLogoForSelecting(firstName);
        byte[] emptyLogo = Logo.EMPTY.getBytes();
        assertThat("User logo is not empty", userLogo.length, greaterThan(0));
        assertThat(userLogo.length, not(equalTo(emptyLogo.length)));
    }

    protected void checkRoleInLookUpInTeamPopUp(String shouldState, String roleName, String objectName) {
        RolesSteps rs = new RolesSteps();
        roleName = rs.wrapRoleName(roleName);
        AddTeamUserPopUpWindow popup = new AddTeamUserPopUpWindow(openTeamsPage(objectName));
        //List<String> roles = popup.getRolesList();
        List<String> roles = popup.getRolesListAddUserPopup();
        if (shouldState.equalsIgnoreCase("should"))
            assertThat("Check role present in list", roles, hasItem(roleName));
        else
            assertThat("Check role not present in list", roles, not(hasItem(roleName)));
    }

    protected void checkRolesInLookUpInTeamPopUp(String condition, List<String> expectedRolesList, String objectName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        RolesSteps rs = new RolesSteps();
        List<String> actualRolesList = new TeamUserPermissionsPopUpWindow(getSut().getPageCreator().getAdBankTeamsPage()).getRolesList();

        for (String rN : expectedRolesList) {
            assertThat(actualRolesList, shouldState ? hasItem(rs.wrapRoleName(rN)) : not(hasItem(rs.wrapRoleName(rN))));
        }
    }

    protected void checkProperDisplayName(String objectName) {
        String expectedObjectName = wrapVariableWithTestSession(objectName);
        AddTeamUserPopUpWindow popup = new AddTeamUserPopUpWindow(openTeamsPage(objectName));
        assertThat(popup.getNameInTree(), equalTo(expectedObjectName));
    }

    protected void checkFoldersInTeamPopUp(String objectName, ExamplesTable foldersTable) {
        AddTeamUserPopUpWindow popup = new AddTeamUserPopUpWindow(openTeamsPage(objectName));
        for (Map<String, String> row : foldersTable.getRows()) {
            assertThat("Is folder exists", popup.isFolderExists(wrapPathWithTestSession(row.get("folder"))), equalTo(true));
        }
    }

    //new method added for angular changes
    protected void checkFoldersInTeampermissionsPopUp(String objectName, ExamplesTable foldersTable) {
      AddTeamUserPopUpWindow popup = new AddTeamUserPopUpWindow(openTeamsPage(objectName));

        for (Map<String, String> row : foldersTable.getRows()) {
            assertThat("Is folder exists", popup.isFolderExistsonTeamUserPermissionPopup(wrapPathWithTestSession(row.get("folder"))), equalTo(true));
        }
    }

    protected void checkFoldersInTeamUsersPopUp(String userName ,String objectName, ExamplesTable foldersTable) {
        TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(openTeamsPage(objectName, userName));
        for (Map<String, String> row : foldersTable.getRows()) {
            boolean shouldSelected = row.get("Selected").equals("should");
            boolean shouldEditable = row.get("Editable").equals("should");
            String folder = wrapPathWithTestSession(row.get("folder"));
            assertThat("Is folder " + folder + " exists", popup.isFolderExists(folder), equalTo(true));
            assertThat("Is folder " + folder + " selected", popup.isFolderCheckBoxSelected(folder), equalTo(shouldSelected));
            assertThat("Is folder " + folder + " editable", popup.isFolderCheckBoxEditable(folder), equalTo(shouldEditable));
        }
    }

    protected void addUserToTeamOverCore(String users, String objectName, String folders, String roleName, String expired) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        RolesSteps rs = new RolesSteps();
        Role role = getCoreApi().getRoleByName(rs.wrapRoleName(roleName),false);
        Long expirationTime = parseDateTime(expired).getMillis();
        List<TeamPermission> permissions = new ArrayList<>();
        for (String userName : users.split(",")) {
            String email = wrapUserEmailWithTestSession(userName);
            for (String path : folders.split(",")) {
                if (path.matches(objectName + "|/|root|^$"))
                    path = "/";
                String folderId = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path)).getId();
                permissions.add(new TeamPermission(folderId, email, role.getId(), false, expirationTime));
            }
        }
        getCoreApi().addUserToProjectTeam(permissions.toArray(new TeamPermission[permissions.size()]));
    }

    protected void shareUsersForEachProjectFoldersOverCore(String objectName, User user, Role role, DateTime expired) {
        Project object = getObjectByName(wrapVariableWithTestSession(objectName));
        TeamPermission teamPermission = new TeamPermission(object.getId(), user.getEmail(), role.getId(), true, expired.getMillis());
        getCoreApi().addUserToProjectTeam(new TeamPermission[] {teamPermission});
    }

    protected void addUserToTeamOverCore(String users, String objectName, String roleName, String expired) {
        Project object = getObjectByName(wrapVariableWithTestSession(objectName));
        RolesSteps rs = new RolesSteps();
        Role role = getCoreApi().getRoleByName(rs.wrapRoleName(roleName),false);
        Long expirationTime = parseDateTime(expired).getMillis();
        List<TeamPermission> permissions = new ArrayList<>();
        for (String userName : users.split(",")) {
            String email = wrapUserEmailWithTestSession(userName);
            permissions.add(new TeamPermission(object.getId(), email, role.getId(), true, expirationTime));
        }
        getCoreApi().addUserToProjectTeam(permissions.toArray(new TeamPermission[permissions.size()]));
    }

    protected void shareUsersOverCore(String users, String objectName, String folders, String roleName, String expired, String accessToSubFolder) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Role role = getCoreApi().getRoleByName(new RolesSteps().wrapRoleName(roleName),false);
        Long expirationTime = parseDateTime(expired).getMillis();
        List<TeamPermission> permissions = new ArrayList<>();
        boolean should = accessToSubFolder.equalsIgnoreCase("should");
        for (String userName : users.split(",")) {
            for (String path : folders.split(",")) {
                Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
                permissions.add(new TeamPermission(folder.getId(), wrapUserEmailWithTestSession(userName), role.getId(), should, expirationTime));
            }
        }
        getCoreApi().addUserToProjectTeam(permissions.toArray(new TeamPermission[permissions.size()]));
    }

    protected AdBankTeamsPage openUserDetails(String userName, String objectName) {
        String userEmail = wrapUserEmailWithTestSession(userName);
        User user = getCoreApi().getUserByEmail(userEmail);
        if (user == null)
            throw new IllegalStateException(String.format("Could not find user '%s'", userEmail));
        AdBankTeamsPage page = openTeamsPage(objectName);
        Common.sleep(3000);
        return page.openUserDetails(user);
    }

    protected AdBankTeamsPage openUserDetails(String userName) {
        String userEmail = wrapUserEmailWithTestSession(userName);
        User user = getCoreApi().getUserByEmail(userEmail);
        if (user == null)
            throw new IllegalStateException(String.format("Could not find user '%s'", userEmail));
        AdBankTeamsPage adBankTeamsPage = getSut().getPageCreator().getAdBankTeamsPage();
        return adBankTeamsPage.openUserDetails(user);
    }

    protected AdBankTeamsPage selectUserFormRecentActivities(String userName, String objectName) {
        String userEmail = wrapUserEmailWithTestSession(userName);
        User user = getCoreApi().getUserByEmail(userEmail);
        if (user == null)
            throw new IllegalStateException(String.format("Could not find activities for user '%s'", userEmail));
        AdBankTeamsPage page = openTeamsPage(objectName);
        return page.selectUserFormRecentActivities(user);
    }

    protected AdBankTeamsPage clickFileLinkFromRecentActivities(String filename, String userName, String objectName) {
        String userEmail = wrapUserEmailWithTestSession(userName);
        User user = getCoreApi().getUserByEmail(userEmail);
        if (user == null)
            throw new IllegalStateException(String.format("Could not find activities for user '%s'", userEmail));
        AdBankTeamsPage page = openTeamsPage(objectName);
        return page.clickFileLinkFromRecentActivities(filename, user);
    }

    protected void openUserPermissionsPopUp(String userName, String objectName) {
//        openUserDetails(userName, objectName).clickManagePermissions(); // For NGN-14650
//        getSut().getPageCreator().getAdBankTeamsPage().clickCancelButton(); // For NGN-14650
        openUserDetails(userName, objectName).clickManagePermissions();
    }

    protected void openUserPermissionsPopUp(String userName) {
        openUserDetails(userName).clickManagePermissions();
    }

    protected void selectFolderInTeamPopUp(String path, String objectName, String userName) {
        //TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(openTeamsPage(objectName, userName));
        TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(getCurrentTeamsPage());
        popup.selectFolder(wrapPathWithTestSession(path));
    }

    protected void selectRootFolderInTeamPopUp(String objectName, String userName) {
     //   TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(openTeamsPage(objectName, userName));
        TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(getCurrentTeamsPage());
        popup.selectRootFolder(wrapVariableWithTestSession(objectName));
    }

    protected void checkRolePermission(String roleName, String objectName, String userName) {
        //TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(openTeamsPage(objectName, userName));
        TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(getCurrentTeamsPage());
        if (roleName.equals("project.admin")) {
            assertThat(popup.getSelectedRole(), equalTo(roleName));
        } else {
            assertThat(popup.getSelectedRole(), equalTo(wrapVariableWithTestSession(roleName)));
        }
    }

    protected void checkRolePermissionPAR(String roleName, String objectName, String userName) {
        TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(getCurrentTeamsPage());
        selectRootFolderInTeamPopUp(objectName, userName);
        if (roleName.equals("project.admin")) {
            assertThat(popup.getSelectedRole(), equalTo(roleName));
        } else {
            assertThat(popup.getSelectedRole(), equalTo(roleName));
        }
    }

    protected void checkUserPermissionsOnManagePermissionsTab(String roleName, String objectName, String userName) {
       // TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(openTeamsPage(objectName, userName));
        Common.sleep(1000);
        TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(getCurrentTeamsPage());
        String [] rolesArray = roleName.split(",");
        for (int i = 0; i <rolesArray.length ; i++) {
            rolesArray[i] = wrapVariableWithTestSession(rolesArray[i]);
        }
        if(roleName.isEmpty()){
            assertThat(popup.getAvailableRolesOfuserInFolder(), empty());
        }else if (roleName.equals("project.admin")) {
            String translatedRole = "Project Admin";
            assertThat(popup.getAvailableRolesOfuserInFolder(), hasItem(translatedRole));
        }else{
            assertThat(popup.getAvailableRolesOfuserInFolder(),hasItems(rolesArray));
        }
    }

    protected void checkRolesPermissionsGetByEnableState(String roleName, String objectName, String userName, boolean isCheckBoxSelected, boolean isEditable) {
        TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(openTeamsPage(objectName, userName));
        assertThat(popup.getSelectedRoleByEnableState(isCheckBoxSelected).isEnabled(), equalTo(isEditable));
        //assertThat(popup.isRoleCheckBoxEditable(isCheckBoxSelected), equalTo(isEditable));
        assertThat(popup.getSelectedRoleByEnableState(isCheckBoxSelected).getDisplayedValue(), equalTo(wrapVariableWithTestSession(roleName)));
    }

    protected void checkIsRoleEditable (String objectName, String userName, boolean isEditable) {
        TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(openTeamsPage(objectName, userName));
        assertThat(popup.getSelectedRoleByEnableState(isEditable).isEnabled(), equalTo(isEditable));
        assertThat(popup.isRoleCheckBoxEditable(isEditable), equalTo(isEditable));
    }

    protected void checkExpiredTime(String expirationDate, String objectName, String userName) {
        User user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userName));
       // TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(openTeamsPage(objectName, userName));
        TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(getCurrentTeamsPage());
        DateTime actualDateTime = DateTimeFormat.forPattern(UserDateFormat.getForLanguage(user.getLanguage()).getDateFormat()).parseDateTime(popup.getExpirationDate());
        DateTime expectedDateTime = parseDateTime(expirationDate);
        assertThat(actualDateTime, equalTo(expectedDateTime));
    }
    protected void checkExpiredTimeForUserOnTeamTab(String expirationDate, String objectName, String userName, String role, String roleName) {
        //TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(openTeamsPage(objectName, userName));
        TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(getCurrentTeamsPage());
        AddTeamTemplatePopUpWindow.RoleItem roleItem = popup.getRoleItemByIdOrName(role,roleName);
        DateTime actualDateTime;
        if(roleItem != null && roleItem.getDate() != null && expirationDate != null && !expirationDate.isEmpty()) {
            actualDateTime = popup.getExpirationDateByRoleIdOrRoleName(role, roleName);
            DateTime expectedDateTime = parseDateTime(expirationDate);
            assertThat(actualDateTime, equalTo(expectedDateTime));
        } else {
            assertThat("",equalTo(expirationDate));
        }
    }


    protected void checkExpiredTimeGetByEnableState(String expirationDate, String objectName, String userName, boolean isCheckBoxSelected, boolean isEditable) {
        TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(openTeamsPage(objectName, userName));
        DateTime actualDateTime = DateTimeFormat.forPattern(getContext().userDateTimeFormat).parseDateTime(popup.getExpirationDateByEnableState(isCheckBoxSelected).getDisplayedValue());
        DateTime expectedDateTime = parseDateTime(expirationDate);
        assertThat(popup.getExpirationDateByEnableState(isCheckBoxSelected).isEnabled(), equalTo(isEditable));
        assertThat(actualDateTime, equalTo(expectedDateTime));
    }

    protected void checkExpiredTimeEditableGetByEnableState(String objectName, String userName, boolean isCheckBoxSelected, boolean isEditable) {
        TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(openTeamsPage(objectName, userName));
        assertThat(popup.getExpirationDateByEnableState(isCheckBoxSelected).isEnabled(), equalTo(isEditable));
    }

    protected void checkUsersPermissions(String objectName, String userName, ExamplesTable settingsTable){
        Common.sleep(1000);
        for (Map<String, String> row : settingsTable.getRows()) {
            selectFolderInTeamPopUp(row.get("Folder"), objectName, userName);
            checkRolePermission(row.get("Role"), objectName, userName);
            if (!row.get("Expiration").isEmpty()) {
                checkExpiredTime(row.get("Expiration"), objectName, userName);
            } else {
                checkExpiredTimeEmpty(row.get("Expiration"), objectName, userName);
            }
        }
    }

    protected void checkUsersPermissionsOnManagePermissionsTab(String objectName, String userName, ExamplesTable settingsTable){
        Common.sleep(1000);
        for (Map<String, String> row : settingsTable.getRows()) {
            String  roleId = "";
            selectFolderInTeamPopUp(row.get("Folder"), objectName, userName);
            checkUserPermissionsOnManagePermissionsTab(row.get("Role"), objectName, userName);
            if(!row.get("Role").isEmpty()&&!row.get("Role").equals("project.admin")){
                roleId = getCoreApi().getRoleByName(wrapVariableWithTestSession(row.get("Role")),false).getId();
            }
            if(row.get("Role").equals("project.admin")){
                roleId = getCoreApi().getRoleByName(row.get("Role"),false).getId();
            }
            checkExpiredTimeForUserOnTeamTab(row.get("Expiration"), objectName, userName, roleId,wrapVariableWithTestSession(row.get("Role")));
        }
    }

    protected void checkOwnersPermissions(String objectName, String userName, ExamplesTable settingsTable) {
        for (Map<String, String> row : settingsTable.getRows()) {
            String  roleId = "";
            selectRootFolderInTeamPopUp(objectName, userName);
            checkUserPermissionsOnManagePermissionsTab(row.get("Role"), objectName, userName);
            if(!row.get("Role").isEmpty()&&!row.get("Role").equals("project.admin")){
                roleId = getCoreApi().getRoleByName(wrapVariableWithTestSession(row.get("Role")),false).getId();
            }
            if(row.get("Role").equals("project.admin")){
                roleId = getCoreApi().getRoleByName(row.get("Role"),false).getId();
            }
            checkExpiredTimeForUserOnTeamTab(row.get("Expiration"), objectName, userName, roleId,wrapVariableWithTestSession(row.get("Role")));
        }
    }

    protected void checkExpiredTimeEmpty(String expirationDate, String objectName, String userName) {
       // TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(openTeamsPage(objectName, userName));
        TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(getCurrentTeamsPage());
        assertThat(popup.getExpirationDate(), equalTo(expirationDate));
    }

    protected void checkIsRoleChecked(String objectName, String userName , boolean shouldState) {
        TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(openTeamsPage(objectName, userName));
        assertThat(popup.isRoleCheckBoxChecked(),equalTo(shouldState));
    }

    protected void checkIsRootFolderIsSelected(String objectName, String userName, boolean shouldState) {
        TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(openTeamsPage(objectName, userName));
        assertThat(popup.isRootFolderSelected(),equalTo(shouldState));
    }

    protected void checkIsRoleSelected(String objectName, String userName , boolean isRoleCheckBoxSelected) {
        TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(openTeamsPage(objectName, userName));
        assertThat(popup.isRoleCheckBoxSelected(true),equalTo(isRoleCheckBoxSelected));
    }

    protected void checkExpiredTimeEmptyGetByEnabledState(String expirationDate, String objectName, String userName, boolean isCheckBoxSelected) {
        TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(openTeamsPage(objectName, userName));
        assertThat(popup.getExpirationDateByEnableState(isCheckBoxSelected).getDisplayedValue(), equalTo(expirationDate));
    }

    // | Folder  | Role | Expiration | RoleCheckBoxState | EnableState |
    protected void checkInheritedUsersPermissions(String objectName, String userName, ExamplesTable settingsTable) {
        for (int i=0; i< settingsTable.getRowCount(); i++) {
            boolean shouldRoleCheckBoxChecked = settingsTable.getRow(i).get("RoleCheckBoxState").equals("should");
            boolean shouldBoxEnabled = settingsTable.getRow(i).get("EnableState").equals("should");
            selectFolderInTeamPopUp(settingsTable.getRow(i).get("Folder"), objectName, userName);
            checkRolesPermissionsGetByEnableState(settingsTable.getRow(i).get("Role"), objectName, userName , shouldRoleCheckBoxChecked, shouldBoxEnabled);
            if (!settingsTable.getRow(i).get("Expiration").isEmpty()) {
                checkExpiredTimeGetByEnableState(settingsTable.getRow(i).get("Expiration"), objectName, userName, shouldRoleCheckBoxChecked, shouldBoxEnabled);
            } else {
                checkExpiredTimeEmptyGetByEnabledState(settingsTable.getRow(i).get("Expiration"), objectName, userName, shouldRoleCheckBoxChecked);
                checkExpiredTimeEditableGetByEnableState(objectName, userName, shouldRoleCheckBoxChecked,  shouldBoxEnabled);
            }
        }
    }

    protected void checkUsersCounterOnTeamPage(int count, String objectName) {
        getSut().getWebDriver().navigate().refresh();
        AdBankTeamsPage page = openTeamsPage(objectName);
        assertThat(page.getValueOfUsersOnThisTeamPageCounter(), equalTo(count));
    }

    protected void checkUserDisplayedOnTeamPage(String userName, String objectName) {
        AdBankTeamsPage page = openTeamsPage(objectName);
        assertThat(page.isUserDisplayed(userName), is(true));
    }


    protected void selectUserOnTeamPage(String userName, String objectName) {
        User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userName));
        AdBankTeamsPage page = openTeamsPage(objectName);
        page.selectUser(user);
    }

    protected void selectUserOnCurrentTeamPage(String userName, String objectName) {
        User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userName));
        AdBankTeamsPage page = getCurrentTeamsPage();
        page.selectUser(user);
    }

    protected void selectEasyshareUserOnTeamPage(String userEmail, String objectName) {
        openTeamsPage(objectName).getUserItemElement(wrapUserEmailWithTestSession(userEmail)).click();
    }

    protected void checkUserLogoOnTeamPage(String logo, String userName, String objectName) {
        AdBankTeamsPage page = openTeamsPage(objectName);
        User user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userName));
        byte[] actualLogo = page.getUserLogo(user);
        byte[] expectedLogo = Logo.valueOf(logo).getBytes();
        assertThat("User logo length", actualLogo.length, equalTo(expectedLogo.length));
    }

    protected void checkCountSelectedUsersOnTeamPage(int count, String objectName) {
        AdBankTeamsPage page = openTeamsPage(objectName);
        assertThat(page.getSelectedUsersCount(), equalTo(count));
    }

    protected void fillClientAddTeamTemplatePopUp(String teamName, String objectName, String expiredDate, ExamplesTable foldersTable) {
        AddTeamTemplatePopUpWindow popup = new AddTeamTemplatePopUpWindow(openTeamsPage(objectName));
        if (!teamName.isEmpty()) {
            for (String team : teamName.split(",")) {
                popup.setName(team);
            }
        }
        if (!expiredDate.isEmpty()) {
            DateTime expiredDateTime = parseDateTime(expiredDate);
            popup.expirationDate.setValue(expiredDateTime.toString(DateTimeFormat.forPattern(getContext().userDateTimeFormat)));
        }
        for (Map<String, String> row : foldersTable.getRows()) {
            popup.toggleFolder(wrapPathWithTestSession(row.get("Folder")));
        }

        // If we send data with an ExampleTable, we do two cycles:
        //  - In first 'for' we count rows, and it's will be number of iterations
        //  - In second 'for' if we have several roles, they will be seperate and
        // applied for current folder
        if (foldersTable.getHeaders().contains("Role")) {
            for (Map<String, String> row : foldersTable.getRows()) {
                for (String role : row.get("Role").split(",")) {
                    popup.selectFolder(wrapVariableWithTestSession(role));
                }
            }
        }
        // If we do not using ExampleTable, we set default role 'project.user'
        else {
            popup.selectRole("Project User");
        }
        Common.sleep(1000);
    }
    protected void fillAddTeamTemplatePopUpwithoutAddrole(String teamName, String objectName, String expiredDate, ExamplesTable foldersTable) {
        AddTeamTemplatePopUpWindow popup = new AddTeamTemplatePopUpWindow(openTeamsPage(objectName));
        if (!teamName.isEmpty()) {
            for (String team : teamName.split(",")) {
                team = wrapVariableWithTestSession(team);
                popup.setName(team);
            }
        }
        if (!expiredDate.isEmpty()) {
            DateTime expiredDateTime = parseDateTime(expiredDate);
            popup.expirationDate.setValue(expiredDateTime.toString(DateTimeFormat.forPattern(getContext().userDateTimeFormat)));
        }
        for (Map<String, String> row : foldersTable.getRows()) {
            popup.toggleFolder(wrapPathWithTestSession(row.get("Folder")));
        }

        // If we send data with an ExampleTable, we do two cycles:
        //  - In first 'for' we count rows, and it's will be number of iterations
        //  - In second 'for' if we have several roles, they will be seperate and
        // applied for current folder
        if (foldersTable.getHeaders().contains("Role")) {
            for (Map<String, String> row : foldersTable.getRows()) {
                for (String role : row.get("Role").split(",")) {
                    popup.selectFolder(wrapVariableWithTestSession(role));
                }
            }
        }
        // If we do not using ExampleTable, we set default role 'project.user'
        else {
            popup.selectRole("Project User");
        }
        Common.sleep(1000);
    }


    protected void fillAddTeamTemplatePopUp(String teamName, String objectName, String expiredDate, ExamplesTable foldersTable) {
        AddTeamTemplatePopUpWindow popup = new AddTeamTemplatePopUpWindow(openTeamsPage(objectName));
        if (!teamName.isEmpty()) {
            for (String team : teamName.split(",")) {
                team = wrapVariableWithTestSession(team);
                popup.setName(team);
            }
        }
        if (!expiredDate.isEmpty()) {
            DateTime expiredDateTime = parseDateTime(expiredDate);
            popup.expirationDate.setValue(expiredDateTime.toString(DateTimeFormat.forPattern(getContext().userDateTimeFormat)));
        }
        for (Map<String, String> row : foldersTable.getRows()) {
            popup.toggleFolder(wrapPathWithTestSession(row.get("Folder")));
            if (foldersTable.getHeaders().contains("Role"))
            {
                for (String role : row.get("Role").split(",")) {
                    role = new RolesSteps().wrapRoleName(role);
                    popup.selectRole(role);
                    popup.clickAddRole();
                }
            }else{
                popup.selectRole("Project User");
                popup.clickAddRole();
            }

        }
        Common.sleep(1000);
    }

    protected void fillAddTeamTemplatePopUpToProject(String teamName, String objectName, String roleName, String expiredDate) {
        AddTeamTemplatePopUpWindow popup = new AddTeamTemplatePopUpWindow(openTeamsPage(objectName));
        if (!teamName.isEmpty()) {
            for (String team : teamName.split(",")) {
                team = wrapVariableWithTestSession(team);
                popup.setName(team);

            }
        }
       if (!expiredDate.isEmpty()) {
            DateTime expiredDateTime = parseDateTime(expiredDate);
            popup.expirationDate.setValue(expiredDateTime.toString(DateTimeFormat.forPattern(getContext().userDateTimeFormat)));
        }

        if (!roleName.isEmpty()) {
            popup.selectRole(roleName);
            popup.clickAddRole();
            popup.clickOK();
        }
        Common.sleep(1000);
    }

    protected void fillAddTeamTemplatePopUpWithoutAddingRole(String teamName, String objectName, String expiredDate, ExamplesTable foldersTable) {
         AddTeamTemplatePopUpWindow popup = new AddTeamTemplatePopUpWindow(openTeamsPage(objectName));
        if (!teamName.isEmpty()) {
            for (String team : teamName.split(",")) {
                team = wrapVariableWithTestSession(team);
                popup.setName(team);
            }
        }
        if (!expiredDate.isEmpty()) {
            DateTime expiredDateTime = parseDateTime(expiredDate);
            popup.expirationDate.setValue(expiredDateTime.toString(DateTimeFormat.forPattern(getContext().userDateTimeFormat)));
        }
        for (Map<String, String> row : foldersTable.getRows()) {
            popup.toggleFolder(wrapPathWithTestSession(row.get("Folder")));
            if (foldersTable.getHeaders().contains("Role"))
            {
                for (String role : row.get("Role").split(",")) {
                    role = new RolesSteps().wrapRoleName(role);
                    popup.selectRole(role);
                }
            }else{
                popup.selectRole("Project User");
            }

        }
        Common.sleep(1000);
    }

    protected void addTeamTemplateIntoTeamPopUp(String teamName, String objectName) {
        AddTeamTemplatePopUpWindow popup = new AddTeamTemplatePopUpWindow(openTeamsPage(objectName));
        popup.setName(wrapVariableWithTestSession(teamName));
    }

    protected void checkCountTeamTemplatesIntoTeamPopUp(int count, String objectName) {
        AddTeamTemplatePopUpWindow popup = new AddTeamTemplatePopUpWindow(openTeamsPage(objectName));
        assertThat(popup.getAutoCompleteItemsCount(), equalTo(count));
    }

    protected void addTeamTemplateToTeamOverCoreApi(String teamName, String objectName, String folders, Role role, String expired) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        SearchResult<Contact> contacts = getCoreApi().getContacts(new ContactSearchingParams().setGroupName(wrapVariableWithTestSession(teamName)));
        Long expirationTime = parseDateTime(expired).getMillis();
        List<TeamPermission> permissions = new ArrayList<>();
        for (Contact contact : contacts.getResult()) {
            if (contact.getGroups() == null) continue;
            for (String path : folders.split(",")) {
                Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
                permissions.add(new TeamPermission(folder.getId(), contact.getContactUser(), role.getId(), false, expirationTime));
            }
        }
        getCoreApi().addUserToProjectTeam(permissions.toArray(new TeamPermission[permissions.size()]));
    }

    protected void shareTeamTemplateOverCore(String teamName, String objectName, String folders, Role role, String expired, String accessToSubFolder) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        SearchResult<Contact> contacts = getCoreApi().getContacts(new ContactSearchingParams().setGroupName(wrapVariableWithTestSession(teamName)));
        Long expirationTime = parseDateTime(expired).getMillis();
        boolean should = accessToSubFolder.equalsIgnoreCase("should");
        List<TeamPermission> permissions = new ArrayList<>();
        for (Contact contact : contacts.getResult()) {
            if (contact.getGroups() == null) continue;
            for (String path : folders.split(",")) {
                Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
                permissions.add(new TeamPermission(folder.getId(), contact.getContactUser(), role.getId(), should, expirationTime));
            }
        }
        getCoreApi().addUserToProjectTeam(permissions.toArray(new TeamPermission[permissions.size()]));
    }

    protected void selectRoleInTeamPopUp(String roleName, String userName, String objectName) {
        Common.sleep(1000);
        TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(getCurrentTeamsPage());
        popup.selectRole(new RolesSteps().wrapRoleName(roleName));
    }

    protected void selectExpireDateInTeamPopUp(String date, String userName, String objectName) {
        Common.sleep(1000);
        TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(getCurrentTeamsPage());
//        popup.setExpirationDate(date);
        popup.setExpirationDateInPopup(date);
    }

    protected void assignFolderRoleInTeamPopUp(String roleName, String userName, String path, String objectName) {
        Common.sleep(1000);
        TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(getCurrentTeamsPage());
        popup.selectFolder(wrapPathWithTestSession(path));
        popup.selectRole(new RolesSteps().wrapRoleName(roleName));
        popup.addrole.click();
        popup.save.click();
        Common.sleep(1000);
    }

    protected void toggleFolderInTeamPopUp(String path, String objectName, String userName) {
        TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(getCurrentTeamsPage());
        popup.toggleFolder(wrapPathWithTestSession(path));
    }

    protected void toggleFolderInManagePermissionsPopUp(String path, String objectName, String userName) {
        TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(getCurrentTeamsPage());
        popup.toggleFolder(wrapPathWithTestSession(path));
    }

    protected void checkUserRoleOnTeamPage(String userName, String roleName, String objectName) {
        User user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userName));
        List<String> actualRoles = openTeamsPage(objectName).getUserRoles(user.getFullName());
        List<String> expectedRoles = new ArrayList<>();

        for (String role : roleName.split(","))
            expectedRoles.add(new RolesSteps().wrapRoleName(role));
        //expectedRoles.add(new RolesSteps().wrapRoleName(role).replaceAll("_", ".").replaceAll(" ", "."));
        assertThat("Roles count", actualRoles.size(), equalTo(expectedRoles.size()));

        for (String expectedRole : expectedRoles)
            assertThat(actualRoles, hasItem(expectedRole.toLowerCase()));
    }

    protected void checkUserRoleOnTeamPageDisplayedOnce(String userName, String roleName, String objectName) {
        User user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userName));
        String expectedRoleName = new RolesSteps().wrapRoleName(roleName);
        List<String> actualRoles = openTeamsPage(objectName).
                getUserRolesFromDetails(user.getFullName() == null || user.getFullName().isEmpty() ? user.getEmail() : user.getFullName());

        assertThat(actualRoles.indexOf(expectedRoleName), not(equalTo(-1)));
        assertThat(actualRoles.indexOf(expectedRoleName), equalTo(actualRoles.lastIndexOf(expectedRoleName)));
    }

    protected void checkUserRolePresentOnTeamPage(boolean shouldState, String userName, String roleName, String objectName) {
        User user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userName));
        String expectedRoleName = new RolesSteps().wrapRoleName(roleName);
        List<String> actualRoles = openTeamsPage(objectName).
                getUserRolesFromDetails(user.getFullName() == null || user.getFullName().isEmpty() ? user.getEmail() : user.getFullName());

        assertThat(actualRoles, shouldState ? hasItem(expectedRoleName) : not(hasItem(expectedRoleName)));
    }

    protected void checkSortingUsers(String fieldName, String ordering, String objectName) {
        Project object = getObjectByName(wrapVariableWithTestSession(objectName));
        List<User> expectedUsers = getCoreApi().getTeamUsers(object.getId(), true).getResult();
        final int order = ordering.equals("descending") ? -1 : 1;
        if (fieldName.equals("name")) {
            Collections.sort(expectedUsers, new Comparator<User>() {
                public int compare(User u1, User u2) {
                    String fullName1 = u1.getFirstName() + " " + u1.getLastName();
                    String fullName2 = u2.getFirstName() + " " + u2.getLastName();
                    return order * fullName1.compareToIgnoreCase(fullName2);
                }
            });
        } else {
            Collections.sort(expectedUsers, new Comparator<User>() {
                public int compare(User u1, User u2) {
                    return order * u1.getAgency().getName().compareToIgnoreCase(u2.getAgency().getName());
                }
            });
        }
        AdBankTeamsPage teamsPage = openTeamsPage(objectName);
        List<String> users = teamsPage.getUserNames();
        assertThat("Users count", users.size(), equalTo(expectedUsers.size()));
        for (int i = 0; i < users.size(); i++) {
            String fullName = expectedUsers.get(i).getFirstName() + " " + expectedUsers.get(i).getLastName();
            assertThat(users.get(i), equalTo(fullName));
        }
    }

    protected void checkSelectingIncludeChildrenForFolder(String shouldState, String path,String objectName, Role role, String userName) {
        //TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(openTeamsPage(objectName, userName));
        TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(getCurrentTeamsPage());
        popup.selectFolder(wrapPathWithTestSession(path));
        boolean should = shouldState.equals("should");
        assertThat(popup.getRoleItemByIdOrName(role.getId(),role.getName()).isIncludeSubfolders(), equalTo(should));
    }

    protected void checkSelectingIncludeChildrenForRoot(String shouldState, String objectName, String userName,Role role) {
       // TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(openTeamsPage(objectName, userName));
        TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(getCurrentTeamsPage());
        String roleName = null;
        boolean should = shouldState.equals("should");
        if (role.getName().equalsIgnoreCase("project.admin")){
            roleName = "Project Admin";
        }
        assertThat(popup.getRoleItemByIdOrName(role.getId(),roleName).isIncludeSubfolders(), equalTo(should));
    }

    protected void selectIncludeChildrenForFolder(String path, String objectName, String userName) {
        TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(openTeamsPage(objectName, userName));
        popup.selectFolder(wrapPathWithTestSession(path));
        popup.selectIncludeChildrenCheckBoxForFolder();
    }

    @Deprecated
    protected void checkActivity(boolean should, String userName, String message, String value) {
        Common.sleep(1000);
        checkActivity(getCurrentTeamsPage(), should, userName, message, value);
    }

    protected void checkProjectShareActivity(String should, String userName, String message, String value) {
        Common.sleep(1000);
        checkProjectShareActivity(getCurrentTeamsPage(), should, userName, message, value);
    }

    protected void checkUploadFileActivity(String condition, String userEmail, String fileName) {
        Common.sleep(1000);
        checkUploadFileActivity(getCurrentTeamsPage(), condition, userEmail, fileName);
    }

    protected void checkCreateObjectActivity(String condition, String userEmail, String fileName) {
        Common.sleep(1000);
        checkCreateObject(getCurrentTeamsPage(), condition, userEmail, fileName);
    }

    @Deprecated
    protected void checkActivity(String objectName, ExamplesTable activitiesTable, boolean sorted) {
        Common.sleep(1000);
        AdBankTeamsPage page = openTeamsPage(objectName);
        checkActivities(page, activitiesTable, sorted);
    }

    protected void clickUserInActivities(String objectName, String userName) {
        AdBankTeamsPage page = getCurrentTeamsPage();
        User user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userName));
        page.clickUserInActivities(user);
    }

    protected void clickFileInActivities(String objectName, String fileName) {
        AdBankTeamsPage page = openTeamsPage(objectName);
        page.clickFileInActivities(fileName);
    }

    protected void checkUserSelected(String condition, String userName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualUserNames = getCurrentTeamsPage().getSelectedUserName();
        String expectedUserName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userName)).getFullName();
        assertThat(actualUserNames, shouldState ? hasItem(expectedUserName) : not(hasItem(expectedUserName)));
    }

    protected void checkUsersPerPage(String number){
        int usersPerPage = getCurrentTeamsPage().getUsersPerPage();
        assertThat(" Users per page does not match ", String.valueOf(usersPerPage), equalTo(number));
    }

    protected List<String> getProjectTeamPaginationSizes(){
        return getCurrentTeamsPage().getPaginationSizes();
    }

    protected void selectTeamUserPaginationNumber(String number){
          assertThat("Pagination size is not selected",getCurrentTeamsPage().selectPaginationSize(number));
    }

    protected void checkEasyShareUsers(String condition, String userName, String roleName, String objectName) {
        userName = wrapUserEmailWithTestSession(userName);
        boolean should = condition.equals("should");
        objectName = wrapVariableWithTestSession(objectName);
        roleName = wrapVariableWithTestSession(roleName);
        AdBankTeamsPage teamsPage = openTeamsPage(objectName);
        List<String> users = teamsPage.getUserNamesInLowerCase();
        assertThat("user name", userName.toLowerCase(), isIn(users));
        assertThat("user role", teamsPage.getUserRoles(userName), hasItem(roleName.toLowerCase()));
    }
}