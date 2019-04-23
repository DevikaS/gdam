package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.Role;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdBankTemplateTeamsPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AdBankTeamsPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AddAgencyProjectTeamPopUp;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AddShareFolderForUserPopUpWindow;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AddTeamTemplatePopUpWindow;
import com.adstream.automate.babylon.tests.steps.core.GenericSteps;
import org.jbehave.core.annotations.Alias;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;

import java.util.List;
import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.containsString;
import static org.hamcrest.Matchers.isIn;
import static org.hamcrest.Matchers.not;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 01.08.12
 * Time: 19:55
 */
public class TemplateTeamsSteps extends AbstractTeamsStep {

    @Override
    protected AdBankTeamsPage getTeamsPage(String templateId) {
        return getSut().getPageNavigator().getTemplateTeamsPage(templateId);
    }

    @Override
    protected AdBankTeamsPage getTeamsPage(String templateId, String agencyTeamId) {
        return getSut().getPageNavigator().getTemplateAgencyTeamsPage(templateId, agencyTeamId);
    }

    protected Project getObjectByName(String templateName) {
        return getCoreApi().getTemplateByName(templateName);
    }

    protected Project getObjectByName(String templateName, User user) {
        return getCoreApi(user).getTemplateByName(templateName);
    }

    protected AdBankTeamsPage getTeamsPageByUser(String templateId, String userId) {
        return getSut().getPageNavigator().getTemplateTeamsPage(templateId, userId);
    }

    protected AdBankTeamsPage getCurrentTeamsPage() {
        return getSut().getPageCreator().getTemplateTeamsPage();
    }

    @Then("{I |}should see template team page '$pageName'")
    public void checkTeamPage(String pageName) {
        assertThat(getSut().getWebDriver().getCurrentUrl(),containsString(pageName));
    }

    @Given("{I am |}on template '$templateName' teams page")
    @When("{I |}go to template '$templateName' teams page")
    public AdBankTeamsPage openTemplateTeamsPage(String templateName) {
        return openTeamsPage(templateName);
    }

    @Given("{I |}added user '$userName' into template '$templateName' team with role '$role' expired '$expiredDate' for folder '$path'")
    @When("{I |}add user '$userName' into template '$templateName' team with role '$role' expired '$expiredDate' for folder '$path'")
    public void addUserIntoTemplateTeam(String userName, String templateName, String role, String expiredDate, String path) {
        GenericSteps gs = new GenericSteps();
        gs.clickElement("AddMemberButton", "TeamsPage");
        gs.clickElement("AddMemberUserItem", "TeamsPage");
        fillAddUserPopUpInTemplateTeam(userName, templateName, role, expiredDate, path);
        gs.clickElement("AddButton", "AddTeamUserPopUp");
    }

//new step for angular changes
    @Given("{I |}added user '$userName' into template '$templateName' team with role '$role' expired '$expiredDate' for folder pop up'$path'")
    @When("{I |}add user '$userName' into template '$templateName' team with role '$role' expired '$expiredDate' for folder pop up '$path'")
    public void addUserIntoTemplateTeampopup(String userName, String templateName, String role, String expiredDate, String path) {
        String tableString = "|Folder|";
        for ( String pathItem : path.split(",") ) {
            tableString += String.format("\r\n|%s|", pathItem);
        }
        ExamplesTable table = new ExamplesTable(tableString);
        GenericSteps gs = new GenericSteps();
        gs.clickElement("AddMemberButton", "TeamsPage");
        gs.clickElement("AddMemberUserItem", "TeamsPage");
        //fillAddUserPopUpInTemplateTeam(userName, templateName, role, expiredDate, path);
        fillAddUserPopUpViaAddUser(userName, templateName, role, expiredDate, table);
        gs.clickElement("AddButton", "AddTeamUserPopUp");
    }

    @When("{I |}fill add user popup with user '$userName' into template '$templateName' team with role '$role' expired '$expiredDate' for folder '$path'")
    public void fillAddUserPopUpInTemplateTeam(String userName, String templateName, String role, String expiredDate, String path) {
        String tableString = "|Folder|";
        for ( String pathItem : path.split(",") ) {
            tableString += String.format("\r\n|%s|", pathItem);
        }
        ExamplesTable table = new ExamplesTable(tableString);
        fillAddUserPopUpInTemplateTeam(userName, templateName, role, expiredDate, table);
    }

    //New method to couter angular changes
    @When("{I |}fill add user popup with user '$userName' into template '$templateName' team with role '$role' expired '$expiredDate' for folder pop up '$path'")
    public void fillAddUserPopUpInTemplateTeampopup(String userName, String templateName, String role, String expiredDate, String path) {
        String tableString = "|Folder|";
        for ( String pathItem : path.split(",") ) {
            tableString += String.format("\r\n|%s|", pathItem);
        }
        ExamplesTable table = new ExamplesTable(tableString);
        fillAddUserPopUpViaAddUser(userName, templateName, role, expiredDate, table);
    }

    // | Folder |
    @When("{I |}fill add user popup with user '$userName' into template '$templateName' team with role '$role' expired '$expiredDate' for following folders: $foldersTable")
    public void fillAddUserPopUpInTemplateTeam(String userName, String templateName, String role, String expiredDate, ExamplesTable foldersTable) {
        fillAddUserPopUp(userName, templateName, role, expiredDate, foldersTable);
    }

    @Then("I should see users count '$count' in add template '$templateName' team user popup")
    public void checkUsersCountInPopup(int count, String templateName) {
        checkUsersCountInTeamPopUp(count, templateName);
    }

    @Then("{I |}'$shouldState' see user '$userName' name in teams of template '$templateName'")
    public void checkUserName(String shouldState, String userName, String templateName) {
        checkUsersNameInTeams(shouldState, userName, templateName, "");
    }

    @Then("I should see user by first name '$firstName' is available for selecting in add user to template '$templateName' team popup")
    @Alias("I should see team template '$templateName' is available for selecting in add team template to template '$templateName' team popup")
    public void checkUserAvailableForSelecting(String firstName, String templateName) {
        selectUserInLookUpInTeamPopUp(firstName, templateName);
    }

    @Then("{I should see |}logo is visible for user by first name '$firstName' in add user to template '$templateName' team popup")
    public void checkUserLogoAvailableForSelecting(String firstName, String templateName) {
        checkUsersLogoInLookUpInTeamPopUp(firstName, templateName);
    }

    @Then("{I |}'$shouldState' see role '$roleName' in roles list of add user to template '$templateName' team popup")
    public void checkRoleInRolesList(String shouldState, String roleName, String templateName) {
        checkRoleInLookUpInTeamPopUp(shouldState, roleName, templateName);
    }

    // | UserName |
    @Then("{I |}'$shouldState' see following users on template '$templateName' team page: $usersTable")
    public void checkUsersCount(String shouldState, String templateName, ExamplesTable usersTable) {
        for (Map<String, String> row : usersTable.getRows()) {
            checkUserName(shouldState, row.get("UserName"), templateName);
        }
    }

    @Then("I should see template name '$templateName' in add user to template team popup")
    public void checkTemplateNameInPopUp(String templateName) {
        checkProperDisplayName(templateName);
    }

    // | folder |
    //changes for angular changes
    @Then("I should see following folders in add user to template '$templateName' team popup: $foldersTable")
    public void checkFolders(String templateName, ExamplesTable foldersTable) {
       // checkFoldersInTeamPopUp(templateName, foldersTable);
        checkFoldersInTeampermissionsPopUp(templateName, foldersTable);
    }

    // | folder | Editable |
    @Then("{I |}should see following folders in following state in user '$userName' permissions template '$templateName' team popup: $foldersTable")
    public void checkFoldersForUser(String userName ,String templateName, ExamplesTable foldersTable) {
        checkFoldersInTeamUsersPopUp(userName, templateName, foldersTable);
    }

    // users and folders are comma-separated
    @Given("{I |}added users '$users' to template '$templateName' team folders '$folders' with role '$roleName' expired '$expired'")
    public void addUsersToTemplateTeamOverCore(String users, String templateName, String folders, String roleName, String expired) {
        addUserToTeamOverCore(users, templateName, folders, roleName, expired);
    }

    @Given("{I |}fill Share popup by users '$users' in template '$projectName' folders '$folders' with role '$roleName' expired '$expired' and '$shouldState' access to subfolders")
    public void shareUsersForProjectFoldersOverCore(String users, String projectName, String folders, String roleName, String expired, String shouldState) {
        shareUsersOverCore(users, projectName, folders, roleName, expired, shouldState);
    }

    @Given("{I |}fill Share popup by users '$users' in template '$templateName' for following folders '$folders' with role '$roleName' expired '$expired' and '$shouldState' access to subfolders")
    @Alias("{I |}added users '$users' to template '$templateName' team folders '$folders' with role '$roleName' expired '$expired' and '$shouldState' access to subfolders")
    @When("{I |}filling Share popup by users '$users' in template '$templateName' for following folders '$folders' with role '$roleName' expired '$expired' and '$shouldState' access to subfolders")
    public void shareUsersForEveryProjectsFoldersOverCoreApi(String users, String templateName, String folders, String roleName, String expired, String shouldState) {
        for (String folder : folders.split(",")) {
            shareUsersOverCore(users, templateName, folder, roleName, expired, shouldState);
        }
    }

    @When("{I |}open user '$userName' permissions on template '$templateName' team page")
    public void openUserPermissions(String userName, String templateName) {
        openUserPermissionsPopUp(userName, templateName);
    }

    @When("{I |}select folder '$path' in manage permissions popup of template '$templateName' team for user '$userName'")
    public void selectFolderInPopUp(String path, String templateName, String userName) {
        selectFolderInTeamPopUp(path, templateName, userName);
    }

    @Then("{I should see |}role '$roleName' is selected in manage permissions popup of template '$templateName' team for user '$userName'")
    public void checkPermissionByRole(String roleName, String templateName, String userName) {
        checkRolePermission(roleName, templateName, userName);
    }

    @Then("{I should see |}expiration time is equal to '$expirationDate' in manage permissions popup of template '$templateName' team for user '$userName'")
    public void checkExpirationTime(String expirationDate, String templateName, String userName) {
        checkExpiredTime(expirationDate, templateName, userName);
    }

    // | Folder | Role | Expiration |
    @Then("I should see following role settings for folders in manage permissions popup of template '$templateName' team for user '$userName': $settingsTable")
    public void checkPermissionSettings(String templateName, String userName, ExamplesTable settingsTable) {
        checkUsersPermissions(templateName, userName, settingsTable);
    }

    // | Role | Expiration |
    @Then("{I |}should see following role settings for whole template in manage permissions popup of template '$templateName' team for owner '$userName': $settingsTable")
    public void checkPermissionsSettingsForSelectedTemplate(String templateName, String userName, ExamplesTable settingsTable) {
        checkOwnersPermissions(templateName, userName, settingsTable);
    }

    // | Folder | Role | Expiration | Editable |
    @Then("I should see following inherited permissions settings for folders in manage permissions popup of template '$templateName' team for user '$userName': $settingsTable")
    public void checkInheritedPermissionSettings(String templateName, String userName, ExamplesTable settingsTable) {
        checkInheritedUsersPermissions(templateName, userName, settingsTable);
    }

    @Then("I should see users count '$count' on template '$templateName' team")
    public void checkUsersCounter(int count, String templateName) {
        checkUsersCounterOnTeamPage(count, templateName);
    }

    @When("{I |}select user '$userName' on template '$templateName' team page")
    public void selectUser(String userName, String templateName) {
        selectUserOnTeamPage(userName, templateName);
    }

    @When("{I |}open user '$userName' details on template '$templateName' team page")
    public void openUser(String userName, String templateName) {
        openUserDetails(userName, templateName);
    }

    @When("{I |}select '$userName' from Recent Activities on template '$templateName' team page")
    public void selectUserFormRecentActivitiesList(String userName, String templateName) {
        selectUserFormRecentActivities(userName, templateName);
    }

    @When("{I |}click file link '$fileName' which user '$userName' uploaded in Recent Activities on template '$templateName' team page")
    public void clickFileLinkFromRecentActivitiesList(String filename, String userName, String templateName) {
        clickFileLinkFromRecentActivities(filename, userName, templateName);
    }

    @When("{I |}select easyshare user '$userEmail' on template '$templateName' team page")
    public void selectEasyshareUser(String userEmail, String templateName) {
        selectEasyshareUserOnTeamPage(userEmail, templateName);
    }

    @When("{I |}remove user '$userName' from template '$templateName' team page")
    public void removeUser(String userName, String templateName) {
        selectUser(userName, templateName);
        new GenericSteps().clickElement("RemoveButton", "TeamsPage");
        new GenericSteps().clickElement("YesButton", "DeleteUserConfirmationPopUp");
    }

    @When("{I |}remove easyshare user '$userEmail' from template '$templateName' team page")
    public void removeEasyshareUser(String userEmail, String templateName) {
        selectEasyshareUser(userEmail, templateName);
        new GenericSteps().clickElement("RemoveButton", "TeamsPage");
        new GenericSteps().clickElement("YesButton", "DeleteUserConfirmationPopUp");
    }

    @Then("I should see logo '$logo' for user '$userName' on template '$templateName' team page")
    public void checkUserLogo(String logo, String userName, String templateName) {
        checkUserLogoOnTeamPage(logo, userName, templateName);
    }

    @Then("I should see users count '$count' selected on template '$templateName' team")
    public void checkNumOfSelectedUsers(int count, String templateName) {
        checkCountSelectedUsersOnTeamPage(count, templateName);
    }

    // | Folder |
    @When("{I |}fill add team template popup with team '$teamName' into template '$templateName' team expired '$expiredDate' for following folders: $foldersTable")
    public void fillAddTeamTemplatePopUpForTemplate(String teamName, String templateName, String expiredDate, ExamplesTable foldersTable) {
        fillAddTeamTemplatePopUp(teamName, templateName, expiredDate, foldersTable);
    }

    @When("{I |}fill add team template popup with team '$teamName' into template '$templateName' team expired '$expiredDate' for folder '$path'")
    public void fillAddTeamTemplatePopUpInTemplateTeam(String teamName, String templateName, String expiredDate, String path) {
        String tableString = "|Folder|";
        for (String pathItem : path.split(",")) tableString += String.format("\r\n|%s|", pathItem);
        fillAddTeamTemplatePopUpForTemplate(teamName, templateName, expiredDate, new ExamplesTable(tableString));

    }

    @When("{I |}fill add team template popup with team '$teamName' into template '$templateName' team expired '$expiredDate' for folder '$path' without Adding role")
    public void fillAddTeamTemplatePopUpInTemplateTeamWithoutAddingRole(String teamName, String templateName, String expiredDate, String path) {
        String tableString = "|Folder|";
        for (String pathItem : path.split(",")) tableString += String.format("\r\n|%s|", pathItem);
        fillAddTeamTemplatePopUpWithoutAddingRole(teamName, templateName, expiredDate, new ExamplesTable(tableString));

    }

    //|Fillclient'steamdataintemplatepopup|
    @When("{I |}fill client add team template popup with team '$teamName' into template '$templateName' team expired '$expiredDate' for folder '$path'")
    public void fillClientAddTeamTemplatePopUpInTemplateTeam(String teamName, String templateName, String expiredDate, String path) {
        String tableString = "|Folder|";
        for (String pathItem : path.split(",")) tableString += String.format("\r\n|%s|", pathItem);
        fillClientAddTeamTemplatePopUp(teamName, templateName, expiredDate, new ExamplesTable(tableString));
    }


    @When("{I |}add team template '$teamName' into template '$templateName' team expired '$expiredDate' for folder '$path'")
    public void addTeamTemplateIntoTemplateTeam(String teamName, String templateName, String expiredDate, String path) {
        GenericSteps gs = new GenericSteps();
        gs.clickElement("AddMemberButton", "TeamsPage");
        gs.clickElement("AddMemberTeamTemplateItem", "TeamsPage");
        fillAddTeamTemplatePopUpInTemplateTeam(teamName, templateName, expiredDate, path);
        //clickAddRoleButtonOnProjectTeamPermissionsPopUp();
        clickSaveButtonOnProjectTeamPermissionsPopUp();
       // gs.clickElement("AddButton", "AddTeamUserPopUp");
    }

    @When("{I |}add team template '$teamName' into add team template to template '$templateName' team popup")
    public void addTeamTemplateIntoTemplateTeamPopup(String teamName, String templateName) {
        addTeamTemplateIntoTeamPopUp(teamName, templateName);
    }

    @Then("I should see team templates count '$count' in add template '$templateName' team user popup")
    public void checkTeamTemplatesCountInPopup(int count, String templateName) {
        checkCountTeamTemplatesIntoTeamPopUp(count, templateName);
    }

    @Given("{I |}added team template '$teamName' to template '$templateName' team folders '$folders' with role '$role' expired '$expired'")
    public void addTeamTemplateToTemplateTeamOverCore(String teamName, String templateName, String folders, Role role, String expired) {
        addTeamTemplateToTeamOverCoreApi(teamName, templateName, folders, role, expired);
    }


    @When("{I |}add team template '$teamTemplateName' into template '$templateName' team with role '$rolename' and expiry date '$expiredDate'")
    public void addTeamTemplateIntoProjectTeam(String teamTemplateName, String templateName, String rolename, String expiredDate) {
        GenericSteps gs = new GenericSteps();
        gs.clickElement("AddMemberButton", "TeamsPage");
        gs.clickElement("AddPublicProjectTeamTemplateItem", "TeamsPage");
        fillAddTeamTemplatePopUpInTemplateTeamForProject(teamTemplateName, templateName, rolename, expiredDate);
    }

    public void fillAddTeamTemplatePopUpInTemplateTeamForProject(String teamName, String projectName, String rolename, String expiredDate) {
        fillAddTeamTemplatePopUpToProject(teamName, projectName, rolename, expiredDate);
    }

    @When("{I |}select role '$roleName' in user '$userName' permissions popup for template '$templateName' team")
    public void selectRoleInPopUp(String roleName, String userName, String templateName) {
        selectRoleInTeamPopUp(roleName, userName, templateName);
    }

    @When("{I |}click Add role button on permissions popup of template team tab")
    public void clickAddRoleButtonOnProjectTeamPermissionsPopUp(){
        getSut().getPageCreator().getAdBankTeamsPage().clickAddRoleButton();
    }



    @When("{I |}click Save button on permissions popup of template team tab")
    public void clickSaveButtonOnProjectTeamPermissionsPopUp(){
        getSut().getPageCreator().getAdBankTeamsPage().clickSaveButton();
    }

    @When("{I |}remove '$role' role on permissions popup of template team tab")
    public void removeRoleOnProjectTeamPermissionsPopUp(Role role) {
        AddTeamTemplatePopUpWindow popUp = new AddTeamTemplatePopUpWindow(getSut().getPageCreator().getProjectTeamsPage());
        AddTeamTemplatePopUpWindow.RoleItem roleItem = popUp.getRoleItemByIdOrName(role.getId(),role.getName());
        if(roleItem!=null){
            popUp.getRoleItemByIdOrName(role.getId(),role.getName()).clickRemove();
        }
    }

    @When("{I |}add expiration date '$expireDate' in user '$userName' permissions popup for template '$projectName' team")
    public void selectExpireDateInPopUp(String expireDate, String userName, String projectName) {
        selectExpireDateInTeamPopUp(expireDate, userName, projectName);
    }

    @When("{I |}toggle folder '$path' in manage permissions popup of template '$templateName' team for user '$userName'")
    public void toggleFolderInPopUp(String path, String templateName, String userName) {
        toggleFolderInTeamPopUp(path, templateName, userName);
    }

    @Then("{I |}should see user '$userName' has role '$roleName' on template '$templateName' team page")
    public void checkUserRole(String userName, String roleName, String templateName) {
        for (String name : userName.split(",")) {
            checkUserRoleOnTeamPage(name, roleName, templateName);
        }
    }

    @Then("{I |}'$condition' see template team '$teamName' in agency project teams list for this project")
    public void checkAgencyProjectTeamIsInTheListOnTemplateTeamPage(String shouldState, String teamName){
        boolean should = shouldState.equals("should");
        AdBankTemplateTeamsPage adBankTemplateTeamsPage = getSut().getPageNavigator().getTemplateTeamsPage();
        List<String> teamsList = adBankTemplateTeamsPage.getAgencyProjectTeamsList();
        for (String name : teamName.split(",")) {
            assertThat(wrapVariableWithTestSession(name), should ? isIn(teamsList) : not(isIn(teamsList)));
        }
    }

    @When("{I |}add user '$userName' into template '$templateName' team with role '$role' expired '$expiredDate' for following folders: $foldersTable")
    public void addUserIntoTemplateTeam(String userName, String templateName, String role, String expiredDate, ExamplesTable foldersTable) {
        GenericSteps gs = new GenericSteps();
        gs.clickElement("AddMemberButton", "TeamsPage");
        gs.clickElement("AddMemberUserItem", "TeamsPage");
        fillAddUserPopUpInTemplateTeam(userName, templateName, role, expiredDate, foldersTable);
        gs.clickElement("AddButton", "AddTeamUserPopUp");
    }

    //new step added for angular changes
    @When("{I |}add user '$userName' into template '$templateName' team with role '$role' expired '$expiredDate' for following folders on popup: $foldersTable")
    public void addUserIntoTemplateTeampopup(String userName, String templateName, String role, String expiredDate, ExamplesTable foldersTable) {
        GenericSteps gs = new GenericSteps();
        gs.clickElement("AddMemberButton", "TeamsPage");
        gs.clickElement("AddMemberUserItem", "TeamsPage");
        fillAddUserPopUpViaAddUser(userName, templateName, role, expiredDate, foldersTable);
        gs.clickElement("AddButton", "AddTeamUserPopUp");
    }

    @When("{I |}add team template '$teamName' into template '$templateName' team expired '$expiredDate' for following folders: $foldersTable")
    public void addTeamTemplateIntoTemplateTeam(String teamName, String templateName, String expiredDate, ExamplesTable foldersTable) {
        GenericSteps gs = new GenericSteps();
        gs.clickElement("AddMemberButton", "TeamsPage");
        gs.clickElement("AddMemberTeamTemplateItem", "TeamsPage");
        fillAddTeamTemplatePopUpForTemplate(teamName, templateName, expiredDate, foldersTable);
        gs.clickElement("AddButton", "AddTeamUserPopUp");
    }

    @Then("I should see users sorted by '$fieldName' ordered '$ordering' on template '$templateName' teams page")
    public void checkUsersSorting(String fieldName, String ordering, String templateName) {
        checkSortingUsers(fieldName, ordering, templateName);
    }

    @Then("{I |}'$shouldState' see selected Include Children checkbox for folder '$path' and role '$role' in manage permissions popup of template '$templateName' team for user '$userName'")
    public void checkIncludeChildrenCheckBoxForFolder(String shouldState, String path, Role role, String templateName, String userName) {
        checkSelectingIncludeChildrenForFolder(shouldState, path, templateName, role,userName);
    }

    @Then("{I |}'$shouldState' see selected Include Children checkbox for root in manage permissions popup of template '$templateName' team for user '$userName' with role '$role'")
    public void checkIncludeChildrenCheckBoxForRoot(String shouldState, String templateName, String userName,Role role) {
        checkSelectingIncludeChildrenForRoot(shouldState, templateName, userName, role);
    }

    @When("{I |}select Include Children checkbox for folder '$path' in manage permissions popup of template '$templateName' team for user '$userName'")
    public void clickIncludeChildrenCheckBoxForFolder(String path, String templateName, String userName) {
        selectIncludeChildrenForFolder(path, templateName, userName);
    }

    @Then("I '$condition' see easyshare user '$userName' with role '$roleName' in the template '$templateName' on the team tab")
    public void checkEasyShareUser(String condition, String userName, String roleName, String templateName) {
        checkEasyShareUsers(condition, userName, roleName, templateName);
    }

    @Then("{I |}'$shouldState' see activity for user '$userName' on template team page with message '$message' and value '$value'")
    public void checkTemplateTeamActivity(String should, String userName, String message, String value) {
        checkActivity(should.equals("should"), userName, message, value);
    }

    @Then("{I |}should see following role(s) settings for folders in manage permissions popup of template '$projectName' team for user '$userName': $settingsTable")
    public void checkPermissionsSettings(String projectName, String userName, ExamplesTable settingsTable) {
        checkUsersPermissionsOnManagePermissionsTab(projectName, userName, settingsTable);
    }

    // | UserName | Message | Value |
    @Then("{I |}should see following '$sorted' activities on template '$projectName' team page: $activitiesTable")
    public void checkProjectActivity(String sorted, String projectName, ExamplesTable activitiesTable) {
        checkActivity(projectName, activitiesTable, sorted.equals("sorted"));
    }

    @When("{I |}fill Share popup of template folder for user '$userName' with role '$role' expired '$expiredDate' and '$shouldState' check access to subfolders")
    public void fillShareWindow(String userName, String role, String expiredDate, String shouldState) {
        AddShareFolderForUserPopUpWindow popup = new AddShareFolderForUserPopUpWindow(getSut().getPageNavigator().getProjectFilesPage());
        boolean should = shouldState.equals("should");
        if (!userName.isEmpty()) {
            popup.autoCompleteName.selectByVisibleText(wrapUserEmailWithTestSession(userName));
        }
        if (!role.isEmpty()) {
            role = new RolesSteps().wrapRoleName(role);
            popup.role.selectByVisibleText(role);
        }
        if (should && !popup.isAccessToSubFolderSelected()) {
            popup.selectAccessToSubFolder();
        }

        if (!expiredDate.isEmpty()) {
            DateTime expiredDateTime = parseDateTime(expiredDate);
            popup.expirationDate.selectByVisibleText(expiredDateTime.toString(DateTimeFormat.forPattern(getData().getCurrentUser().getDateTimeFormatter().getDateFormat())));
        }
    }

    @When("{I |}remove user '$userName' form template '$templateName' team page when agency project team '$teamName' was selected")
    public void removeUserWhenAgencyProjectTeamSelected(String userName, String templateName, String teamName){
        AdBankTeamsPage adBankTeamsPage = this.openTemplateTeamsPage(wrapVariableWithTestSession(templateName));
        adBankTeamsPage.selectAgencyProjectTeam(wrapVariableWithTestSession(teamName));
        User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userName));
        adBankTeamsPage.selectUser(user);
        new GenericSteps().clickElement("RemoveButton", "TeamsPage");
        new GenericSteps().clickElement("YesButton", "DeleteUserConfirmationPopUp");
    }

    @When("I select agency project team '$teamName' on template's team page")
    public void selectAgencyProjectTeam(String teamName){
        AdBankTeamsPage adBankTeamsPage = getSut().getPageCreator().getAdBankTeamsPage();
        adBankTeamsPage.selectAgencyProjectTeam(wrapVariableWithTestSession(teamName));
    }


    @When("{I |}select user '$userName' on template '$templateName' for current team page")
    public void selectUserOnCurrentTeamPage(String userName, String templateName) {
        super.selectUserOnCurrentTeamPage(userName, templateName);
    }

    @When("I add agency project team '$teamName' for folder '$folderName' in the template '$projectName'")
    public void addAgencyProjectTeamToProject(String teamName, String folderName, String projectName){
        AdBankTeamsPage adBankTeamsPage = this.openTeamsPage(projectName);
        AddAgencyProjectTeamPopUp addAgencyProjectTeamPopUp = adBankTeamsPage.openAddAgencyProjectTeamPopUp();
        addAgencyProjectTeamPopUp.selectAgencyTeam(wrapVariableWithTestSession(teamName));
        addAgencyProjectTeamPopUp.checkFolder(wrapVariableWithTestSession(folderName));
        addAgencyProjectTeamPopUp.clickSaveButton();
    }


    @Then("{I |}'$shouldState' see user '$userName' name for team '$agencyProjectTeam' in teams of template '$templateName'")
    public void checkUserName(String shouldState, String userName, String agencyProjectTeamName, String templateName) {
        checkUsersNameInTeams(shouldState, userName, templateName, agencyProjectTeamName);
    }


}
