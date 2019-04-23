package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.ContactSearchingParams;
import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.data.Logo;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankProjectOverviewPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankProjectTeamsPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.*;
import com.adstream.automate.babylon.tests.steps.core.GenericSteps;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Alias;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import static org.hamcrest.Matchers.isIn;

/**
 * User: ruslan.semerenko
 * Date: 25.06.12 19:49
 */
public class ProjectTeamsSteps extends AbstractTeamsStep {

    @Override
    protected AdBankTeamsPage getTeamsPage(String projectId) {
        return getSut().getPageNavigator().getProjectTeamsPage(projectId);
    }

    @Override
    protected AdBankTeamsPage getTeamsPage(String projectId, String agencyTeamId) {
        return getSut().getPageNavigator().getProjectAgencyTeamsPage(projectId, agencyTeamId);
    }

    protected Project getObjectByName(String projectName) {
        return getCoreApi().getProjectByName(projectName);
    }

    protected Project getObjectByName(String projectName, User user) {
        return getCoreApi(user).getProjectByName(projectName);
    }

    protected AdBankTeamsPage getTeamsPageByUser(String projectId, String userId) {
        return getSut().getPageNavigator().getProjectTeamsPage(projectId, userId);
    }

    protected AdBankTeamsPage getCurrentTeamsPage() {
        return getSut().getPageCreator().getProjectTeamsPage();
    }

    @Given("I am on project '$projectName' teams page")
    @When("{I |}go to project '$projectName' teams page")
    public AdBankTeamsPage openProjectTeamsPage(String projectName) {
        return openTeamsPage(projectName);
    }

    @Given("I am on project '$projectName' teams page using UI")
    @When("{I |}go to project '$projectName' teams page using UI")
    public void openProjectTeamsPageUsingUI(String projectName){
        AdbankProjectOverviewPage page = getSut().getPageCreator().getProjectOverviewPage();
        page.clickTeamtab();

    }

    @Then("team page loading should be '$teamLoadingTime' seconds after clicking on Team tab")
    public void checkTeamLoadingTime(String teamLoadingTime){
        Long actualLoadingTime = getSut().getPageCreator().getProjectOverviewPage().getTeamLoadingtime();
        Long expectedLoadingTime = Long.parseLong(teamLoadingTime);
        assertThat(actualLoadingTime, is(lessThanOrEqualTo(expectedLoadingTime)));
    }

    @Given("I am on project '$projectName' teams page of user '$userPlan'")
    @When("{I |}go to project '$projectName' teams page of user '$userPlan'")
    public AdBankTeamsPage openProjectTeamsPage(String projectName, String userPlan) {
        User user = getData().getUserByType(userPlan);
        try {
            return openTeamsPage(projectName, user);
        } catch (Exception e) {
            return null;
        }

    }

    @When("I open [Add Agency Team] pop up for project '$projectName'")
    public void openAddAgencyTeamPopUp(String projectName){
        AdBankTeamsPage adBankTeamsPage = this.openProjectTeamsPage(projectName);
        adBankTeamsPage.openAddAgencyProjectTeamPopUp();
    }

    @Then("{I |} should see that '$agencyProjTeamName' agency team is available in [Select Agency Project Team] drop down")
    public void checkAgencyProjectTeamIsPresentInSelectAptDropDown(String projectName){
        AddAgencyProjectTeamPopUp addAgencyProjectTeamPopUp = new AddAgencyProjectTeamPopUp(
                getSut().getPageCreator().getAdBankTeamsPage());
        assertThat(wrapVariableWithTestSession(projectName),
                isIn(addAgencyProjectTeamPopUp.getAgencyProjectTeamsListFromDropdown()));
    }


    @Then("{I |}should see project team page '$pageName'")
    public void checkTeamPage(String pageName) {
        assertThat(getSut().getWebDriver().getCurrentUrl(), containsString(pageName));
    }

    @Then("{I |}should be on project '$projectName' team page")
    public void checkProjectTeamPage(String projectName) {
        String projectId = getCoreApi().getProjectByName(wrapVariableWithTestSession(projectName)).getId();
        assertThat(getSut().getWebDriver().getCurrentUrl(), containsString(projectId));
        assertThat(getSut().getWebDriver().getCurrentUrl(), containsString("team"));
    }

    @Given("{I |}shared each folder from project '$projectName' to user '$userName' with role '$roleName' expired date '$expired'")
    @When("{I |}share each folder from project '$projectName' to user '$userName' with role '$roleName' expired date '$expired'")
    public void shareUsersForEachProjectFoldersOverCore(String projectName, User user, Role role, DateTime expired) {
        super.shareUsersForEachProjectFoldersOverCore(projectName, user, role, expired);
    }

    // users and folders are comma-separated
    @Given("{I |}added users '$users' to project '$projectName' team folders '$folders' with role '$roleName' expired '$expired'")
    @When("{I |}add users '$users' to project '$projectName' team folders '$folders' with role '$roleName' expired '$expired'")
    public void addUsersToProjectTeamOverCore(String users, String projectName, String folders, String roleName, String expired) {
        addUserToTeamOverCore(users, projectName, folders, roleName, expired);
    }

    // users and folders are comma-separated
    @Given("{I |}added users '$users' to project '$projectName' team with role '$roleName' expired '$expired'")
    @When("{I |}add users '$users' to project '$projectName' team with role '$roleName' expired '$expired'")
    public void addUsersToProjectTeamOverCore(String users, String projectName, String roleName, String expired) {
        addUserToTeamOverCore(users, projectName, roleName, expired);
    }

    @Given("{I |}fill Share popup by users '$users' in project '$projectName' folders '$folders' with role '$roleName' expired '$expired' and '$shouldState' access to subfolders")
    @When("{I |}filling Share popup by users '$users' in project '$projectName' folders '$folders' with role '$roleName' expired '$expired' and '$shouldState' access to subfolders")
    public void shareUsersForProjectFoldersOverCore(String users, String projectName, String folders, String roleName, String expired, String shouldState) {
        shareUsersOverCore(users, projectName, folders, roleName, expired, shouldState);
    }

    @Given("{I |}fill Share popup by users '$users' in project '$projectName' for following folders '$folders' with role '$roleName' expired '$expired' and '$shouldState' access to subfolders")
    @Alias("{I |}added users '$users' to project '$projectName' team folders '$folders' with role '$roleName' expired '$expired' and '$shouldState' access to subfolders")
    @When("{I |}filling Share popup by users '$users' in project '$projectName' for following folders '$folders' with role '$roleName' expired '$expired' and '$shouldState' access to subfolders")
    public void shareUsersForEveryProjectsFoldersOverCoreApi(String users, String projectName, String folders, String roleName, String expired, String shouldState) {
        for (String folder : folders.split(",")) {
            shareUsersOverCore(users, projectName, folder, roleName, expired, shouldState);
            Common.sleep(1000);  // for different time in notifications
        }
    }

    @Given("{I |}added team template '$teamName' to project '$projectName' team folders '$folders' with role '$role' expired '$expired'")
    public void addTeamTemplateToProjectTeamOverCore(String teamName, String projectName, String folders, Role role, String expired) {
        addTeamTemplateToTeamOverCoreApi(teamName, projectName, folders, role, expired);
    }

    @Given("{I |}fill Share popup by team template '$teamName' in project '$projectName' folders '$folders' with role '$role' expired '$expired' and '$shouldState' access to subfolders")
    public void shareTeamTemplateToProjectOverCore(String teamName, String projectName, String folders, Role role, String expired, String shouldState) {
        shareTeamTemplateOverCore(teamName, projectName, folders, role, expired, shouldState);
    }

    @When("{I |}fill add user popup with user '$userName' into project '$projectName' team with role '$role' expired '$expiredDate' for folder '$path'")
    public void fillAddUserPopUpInProjectTeam(String userName, String projectName, String role, String expiredDate, String path) {
        String tableString = "|Folder|";
        for ( String pathItem : path.split(",") ) {
            tableString += String.format("\r\n|%s|", pathItem);
        }
        ExamplesTable table = new ExamplesTable(tableString);
        fillAddUserPopUpInProjectTeam(userName, projectName, role, expiredDate, table);
    }

    //Newly added method to counter with new angular changes for Add user
    @When("{I |}fill add user popup with user '$userName' into project '$projectName' team with role '$role' expired '$expiredDate' for folder on popup '$path'")
    public void fillAddUserPopUpInProjectTeamPopup(String userName, String projectName, String role, String expiredDate, String path) {
        String tableString = "|Folder|";
        for ( String pathItem : path.split(",") ) {
            tableString += String.format("\r\n|%s|", pathItem);
        }
        ExamplesTable table = new ExamplesTable(tableString);
        fillAddUserPopUpViaAddUser(userName, projectName, role, expiredDate, table);
    }


    // NGN-18452 - Share Folder along with project
    @When("{I |}share with user '$userName' both project '$projectName' and folder '$folderName' with role '$roleName' expired '$date'")
    public void selectAddUserPopUpInProjectTeamPopup(String userName, String projectName, String path, String role, String expiredDate) {
        String tableString = "|Folder|";
        for ( String pathItem : path.split(",") ) {
            tableString += String.format("\r\n|%s|", pathItem);
        }
        ExamplesTable table = new ExamplesTable(tableString);
        fillAddUserPopUpViaAddUserWithProject(userName, projectName, role, expiredDate, table);
    }

    @When("{I |}click '$button' button on Add User pop-up")
    public void clickButton(String buttonName){
        By elementLocator = By.xpath("//button[contains(.,'OK')]");
        if(getSut().getWebDriver().isElementVisible(elementLocator))
            getSut().getWebDriver().findElement(elementLocator).click();
        Common.sleep(2000);
    }

    @When("{I |}fill add user popup on teams page with user '$userName' into project '$projectName' team with role '$role' expired '$expiredDate' for folder '$path'")
    public void fillAddUserPopUpInProjectTeamOnTeamsPage(String userName, String projectName, String role, String expiredDate, String path) {
        String tableString = "|Folder|";
        for ( String pathItem : path.split(",") ) {
            tableString += String.format("\r\n|%s|", pathItem);
        }
        ExamplesTable table = new ExamplesTable(tableString);
        fillAddUserPopUpViaAddUser(userName, projectName, role, expiredDate, table);
    }

    private void selectAgencyProjectTeamOnProjectTeamTab(String teamName, String projectName){
        AdBankTeamsPage adBankTeamsPage = this.openProjectTeamsPage(wrapVariableWithTestSession(projectName));
        adBankTeamsPage.selectAgencyProjectTeam(wrapVariableWithTestSession(teamName));
    }

    // | Folder |
    @When("{I |}fill add user popup with user '$userName' into project '$projectName' team with role '$role' expired '$expiredDate' for following folders: $foldersTable")
    public void fillAddUserPopUpInProjectTeam(String userName, String projectName, String role, String expiredDate, ExamplesTable foldersTable) {
        fillAddUserPopUp(userName, projectName, role, expiredDate, foldersTable);
    }

    @When("{I |}add user '$userName' into add user to project '$projectName' team popup")
    public void addUserIntoProjectTeamPopup(String userName, String projectName) {
        addUserIntoTeamPopUp(userName, projectName);
    }

    // | UserName |
    @When("{I |}add following users into add user to project '$projectName' team popup: $usersTable")
    public void addUsersIntoProjectTeamPopup(String projectName, ExamplesTable usersTable) {
        for (Map<String, String> row : usersTable.getRows()) {
            addUserIntoProjectTeamPopup(row.get("UserName"), projectName);
        }
        Common.sleep(1000);
    }

    @Given("{I |}added user '$userName' into project '$projectName' team with role '$role' expired '$expiredDate' for folder '$path'")
    @When("{I |}add user '$userName' into project '$projectName' team with role '$role' expired '$expiredDate' for folder '$path'")
    public void addUserIntoProjectTeam(String userName, String projectName, String role, String expiredDate, String path) {
        GenericSteps gs = new GenericSteps();
        gs.clickElement("AddMemberButton", "TeamsPage");
        gs.clickElement("AddMemberUserItem", "TeamsPage");
        fillAddUserPopUpInProjectTeam(userName, projectName, role, expiredDate, path);
        gs.clickElement("AddButton", "AddTeamUserPopUp");
        Common.sleep(1000);
    }

    //Newly added method to counter with new angular changes for Add user
    @Given("{I |}added user '$userName' into project '$projectName' team with role '$role' expired '$expiredDate' for folder on popup '$path'")
    @When("{I |}add user '$userName' into project '$projectName' team with role '$role' expired '$expiredDate' for folder on popup '$path'")
    public void addUserIntoProjectTeampopup(String userName, String projectName, String role, String expiredDate, String path) {
        String tableString = "|Folder|";
        for ( String pathItem : path.split(",") ) {
            tableString += String.format("\r\n|%s|", pathItem);
        }
        ExamplesTable table = new ExamplesTable(tableString);
         GenericSteps gs = new GenericSteps();
        gs.clickElement("AddMemberButton", "TeamsPage");
        gs.clickElement("AddMemberUserItem", "TeamsPage");
        fillAddUserPopUpViaAddUser(userName, projectName, role, expiredDate, table);
        gs.clickElement("AddButton", "AddTeamUserPopUp");
        Common.sleep(1000);
    }






    @When("{I |}add user '$userName' into project '$projectName' team with role '$role' expired '$expiredDate' for following folders: $foldersTable")
    public void addUserIntoProjectTeam(String userName, String projectName, String role, String expiredDate, ExamplesTable foldersTable) {
        GenericSteps gs = new GenericSteps();
        gs.clickElement("AddMemberButton", "TeamsPage");
        gs.clickElement("AddMemberUserItem", "TeamsPage");
        fillAddUserPopUpInProjectTeam(userName, projectName, role, expiredDate, foldersTable);
        gs.clickElement("AddButton", "AddTeamUserPopUp");
    }


    //Newly added method to counter with new angular changes for Add user
    @When("{I |}add user '$userName' into project '$projectName' team with role '$role' expired '$expiredDate' for following folders on popup: $foldersTable")
    public void addUserIntoProjectTeampopup(String userName, String projectName, String role, String expiredDate, ExamplesTable foldersTable) {
        GenericSteps gs = new GenericSteps();
        gs.clickElement("AddMemberButton", "TeamsPage");
        gs.clickElement("AddMemberUserItem", "TeamsPage");
        fillAddUserPopUpViaAddUser(userName, projectName, role, expiredDate, foldersTable);
        gs.clickElement("AddButton", "AddTeamUserPopUp");
    }

    @When("{I |}add team template '$teamName' into project '$projectName' team for folders: $exampleTable")
    public void addTeamTemplateIntoPrivateProjectTeam(String teamName, String projectName, ExamplesTable exampleTable) {
        GenericSteps gs = new GenericSteps();
        gs.clickElement("AddMemberButton", "TeamsPage");
        gs.clickElement("AddMemberTeamTemplateItem", "TeamsPage");
        for (Map<String, String> row : parametrizeTableRows(exampleTable)) {
            fillAddPrivateTemplate(teamName, projectName, row.get("Roles"), row.get("Expire"), row.get("Folder"));
        }
        gs.clickElement("AddButton", "AddTeamUserPopUp");
        Common.sleep(1000);
    }

    //New step for angular changes
    @When("{I |}add team template '$teamName' into project '$projectName' team for folders on popup: $exampleTable")
    public void addTeamTemplateIntoPrivateProjectTeamViaPopup(String teamName, String projectName, ExamplesTable exampleTable) {
        GenericSteps gs = new GenericSteps();
        gs.clickElement("AddMemberButton", "TeamsPage");
        gs.clickElement("AddMemberTeamTemplateItem", "TeamsPage");
        Common.sleep(2000);
        for (Map<String, String> row : parametrizeTableRows(exampleTable)) {
            fillAddPrivateTemplateVisAdduser(teamName, projectName, row.get("Roles"), row.get("Expire"), row.get("Folder"));
        }
        gs.clickElement("AddButton", "AddTeamUserPopUp");
        Common.sleep(1000);
    }
    @When("{I |}add team template '$templateName' into project '$projectName' team expired '$expiredDate' for following folders: $foldersTable")
    public void addTeamTemplateIntoProjectTeam(String templateName, String projectName, String expiredDate, ExamplesTable foldersTable) {
        GenericSteps gs = new GenericSteps();
        gs.clickElement("AddMemberButton", "TeamsPage");
        gs.clickElement("AddMemberTeamTemplateItem", "TeamsPage");
        fillAddTeamTemplatePopUpInProjectTeam(templateName, projectName, expiredDate, foldersTable);
      //  clickAddRoleButtonOnProjectTeamPermissionsPopUp();
        //clickSaveButtonOnProjectTeamPermissionsPopUp();
        gs.clickElement("AddButton", "AddTeamUserPopUp");
    }

    @When("{I |}add team template '$templateName' into project '$projectName' team with role '$rolename' and expiry date '$expiredDate'")
    public void addTeamTemplateIntoProjectTeam(String templateName, String projectName, String rolename, String expiredDate ) {
        GenericSteps gs = new GenericSteps();
        gs.clickElement("AddMemberButton", "TeamsPage");
        gs.clickElement("AddPublicProjectTeamTemplateItem", "TeamsPage");
        fillAddTeamTemplatePopUpInProjectTeamForProject(templateName, projectName, rolename, expiredDate);
    }

    @When("{I |}fill add team template popup with team '$teamName' into project '$projectName' team expired '$expiredDate' for folder '$path'")
    public void fillAddTeamTemplatePopUpInProjectTeam(String teamName, String projectName, String expiredDate, String path) {
        String tableString = "|Folder|";
        for (String pathItem : path.split(",")) tableString += String.format("\r\n|%s|", pathItem);
        fillAddTeamTemplatePopUpInProjectTeam(teamName, projectName, expiredDate, new ExamplesTable(tableString));
    }

    @When("{I |}fill add team template popup with team '$teamName' into project '$projectName' team expired '$expiredDate' for folder '$path' without clicking add role")
    public void fillAddTeamTemplatePopUpInProjectTeamwithoutAddRole(String teamName, String projectName, String expiredDate, String path) {
        String tableString = "|Folder|";
        for (String pathItem : path.split(",")) tableString += String.format("\r\n|%s|", pathItem);
        fillAddTeamTemplatePopUpInProjectTeamWithoutAddRole(teamName, projectName, expiredDate, new ExamplesTable(tableString));
    }


    @When("I start type team templates '$teamTemplateName' name for project '$projectName'")
    public void startTypeTeamTemplatesName(String teamTemplateName, String projectName) {
        AddTeamTemplatePopUpWindow popup = new AddTeamTemplatePopUpWindow(openProjectTeamsPage(projectName));
        popup.startTypeName(teamTemplateName);
    }

    @Then("I should see team templates in accordance with template '$template' for project '$projectName'")
    public void checkVisibilityOfTeamTemplatesAnotherUser(String template, String projectName) {
        AddTeamUserPopUpWindow popup = new AddTeamUserPopUpWindow(openProjectTeamsPage(projectName));
        List<String> listFromDD = popup.getAvailableTeams();
        List<String> teamTemplates = getCoreApi().getTeamTemplates(new ContactSearchingParams());
        List<String> teamTemplateNamesApi = new ArrayList<>();
        for (String teamTemplate : teamTemplates) {
            if (teamTemplate.startsWith(template)) {
                teamTemplateNamesApi.add(teamTemplate);
            }
        }

      assertThat("Templates count", listFromDD.size(), equalTo(teamTemplateNamesApi.size()));
      assertThat("Templates list correct", teamTemplateNamesApi, containsInAnyOrder(listFromDD.toArray()));
    }

    // | Folder |
    //@When("{I |}fill add team template popup with team '$teamName' into project '$projectName' team expired '$expiredDate' for following folders: $foldersTable")
    public void fillAddTeamTemplatePopUpInProjectTeam(String teamName, String projectName, String expiredDate, ExamplesTable foldersTable) {
        fillAddTeamTemplatePopUp(teamName, projectName, expiredDate, foldersTable);
    }

    public void fillAddTeamTemplatePopUpInProjectTeamForProject(String teamName, String projectName, String rolename, String expiredDate) {
        fillAddTeamTemplatePopUpToProject(teamName, projectName, rolename, expiredDate);
    }

    public void fillAddTeamTemplatePopUpInProjectTeamWithoutAddRole(String teamName, String projectName, String expiredDate, ExamplesTable foldersTable) {
        fillAddTeamTemplatePopUpwithoutAddrole(teamName, projectName, expiredDate, foldersTable);
    }

    @When("{I |}add team template '$teamName' into add team template to project '$projectName' team popup")
    public void addTeamTemplateIntoProjectTeamPopup(String teamName, String projectName) {
        addTeamTemplateIntoTeamPopUp(teamName, projectName);
    }

    @Then("{I |}'$shouldState' see user '$userName' name in teams of project '$projectName'")
    public void checkUserName(String shouldState, String userName, String projectName) {
        checkUsersNameInTeams(shouldState, userName, projectName, "");
    }

    @Then("{I |}'$shouldState' see user '$userName' name in teams for client project '$projectName'")
    public void checkClientUserName(String shouldState, String userName, String projectName) {
        checkUsersNameInTeamsForClient(shouldState, userName, projectName, "");
    }

    @Then("{I |}'$shouldState' see the following users on project team page with interval: $fields")
    public void checkUserNameWithInterval(String shouldState, ExamplesTable fields) {
        // checkUsersNameInTeamsWithInterval(shouldState, userName, projectName, "");
        for (int i = 0; i < fields.getRowCount(); i++) {
            Map<String, String> parameters = parametrizeTabularRow(fields, i);
            checkUsersNameInTeamsWithInterval(parameters.get("Should"), parameters.get("UserName"), parameters.get("Project"), "");

        }
    }


    @Then("{I |}'$shouldState' see user '$userName' name for team '$agencyProjectTeam' in teams of project '$projectName'")
    public void checkUserName(String shouldState, String userName, String agencyProjectTeamName, String projectName) {
        checkUsersNameInTeams(shouldState, userName, projectName, agencyProjectTeamName);
    }


    @Then("{I |}'$condition' see project team '$teamName' in agency project teams list for project '$projectName'")
    public void checkAgencyProjectTeamIsInTheList(String condition, String teamName, String projectName){
        boolean shouldState = condition.equals("should");
        String expectedTeam = wrapVariableWithTestSession(teamName);
        List<String> actualTeamsList = openTeamsPage(wrapVariableWithTestSession(projectName)).getAgencyProjectTeamsList();

        assertThat(actualTeamsList, shouldState ? hasItem(expectedTeam) : not(hasItem(expectedTeam)));
    }

    @Then("{I |}'$condition' see project team '$teamName' in agency project teams list for this project")
    public void checkAgencyProjectTeamIsInTheList(String shouldState, String teamName){
        boolean should = shouldState.equals("should");
        AdBankTeamsPage adBankTeamsPage = getSut().getPageCreator().getAdBankTeamsPage();
        List<String> teamsList = adBankTeamsPage.getAgencyProjectTeamsList();
        for (String name : teamName.split(",")) {
            assertThat(wrapVariableWithTestSession(name), should ? isIn(teamsList) : not(isIn(teamsList)));
        }
    }

    // | UserName |
    @Then("{I |}'$shouldState' see following users on project '$projectName' team page: $usersTable")
    public void checkUsersCount(String shouldState, String projectName, ExamplesTable usersTable) {

        for (Map<String, String> row : usersTable.getRows()) {

            checkUserName(shouldState, row.get("UserName"), projectName);
        }
    }

    @Then("{I |}should see user '$userName' has role '$roleName' on project '$projectName' team page")
    public void checkUserRole(String userName, String roleName, String projectName) {
        for (String name : userName.split(",")) {
            checkUserRoleOnTeamPage(name, roleName, projectName);
        }
    }

    @Then("{I |}should see role '$roleName' displayed once for user '$userName' details on project '$projectName' team page")
    public void checkUserRoleDisplayedOnce(String roleName, String userName, String projectName) {
        checkUserRoleOnTeamPageDisplayedOnce(userName, roleName, projectName);
    }

    @Then("{I |}'$condition' see role '$roleName' for user '$userName' details on project '$projectName' team page")
    public void checkUserRolePresent(String condition, String roleName, String userName, String projectName) {
        checkUserRolePresentOnTeamPage(condition.equalsIgnoreCase("should"), userName, roleName, projectName);
    }

    @Then("I should see users count '$count' on project '$projectName' team")
    public void checkUsersCounter(int count, String projectName) {
        checkUsersCounterOnTeamPage(count, projectName);
    }

    @Then("I should see user '$text' is displayed on '$projectName' team page")
    public void checkUserDisplay(String userName, String projectName) {
        checkUserDisplayedOnTeamPage(userName, projectName);
    }

    @Then("I should see users count '$count' selected on project '$projectName' team")
    public void checkNumOfSelectedUsers(int count, String projectName) {
        checkCountSelectedUsersOnTeamPage(count, projectName);
    }

    @Then("I should see users count '$count' in add project '$projectName' team user popup")
    public void checkUsersCountInPopup(int count, String projectName) {
        checkUsersCountInTeamPopUp(count, projectName);
    }

    @Then("I should see team templates count '$count' in add project '$projectName' team user popup")
    public void checkTemplatesCountInPopup(int count, String projectName) {
        checkCountTeamTemplatesIntoTeamPopUp(count, projectName);
    }

    @Then("I should see user by first name '$firstName' is available for selecting in add user to project '$projectName' team popup")
    @Alias("I should see team template '$templateName' is available for selecting in add team template to project '$projectName' team popup")
    public void checkUserAvailableForSelecting(String firstName, String projectName) {
        selectUserInLookUpInTeamPopUp(firstName, projectName);
    }

    @Then("I '$should' see user email '$userEmail' is available for selecting in add user to team popup")
    public void checkUserAvailableForSelectingByEmail(String should, String userEmail) {
        userEmail = wrapUserEmailWithTestSession(userEmail);
        checkTextInUserLookUpInTeamPopUp(should, userEmail);
    }

    @Then("{I should see |}logo is visible for user by first name '$firstName' in add user to project '$projectName' team popup")
    public void checkUserLogoAvailableForSelecting(String firstName, String projectName) {
        checkUsersLogoInLookUpInTeamPopUp(firstName, projectName);
    }

    @Then("{I |}'$shouldState' see role '$roleName' in roles list of add user to project '$projectName' team popup")
    public void checkRoleInRolesList(String shouldState, String roleName, String projectName) {
        checkRoleInLookUpInTeamPopUp(shouldState, roleName, projectName);
    }

    // | Name |
    @Then("{I |}'$condition' see following roles in roles list of manage permissions popup of project '$projectName' team: $roles")
    public void checkRolesInRolesList(String condition, String projectName, ExamplesTable roles) {
        List<String> expectedRolesList = new ArrayList<>();
        for (Map<String, String> row : parametrizeTableRows(roles)) expectedRolesList.add(row.get("Name"));
        checkRolesInLookUpInTeamPopUp(condition, expectedRolesList, projectName);
    }

    @Then("I should see project name '$expectedProjectName' in add user to project team popup")
    public void checkProjectNameInPopUp(String expectedProjectName) {
        checkProperDisplayName(expectedProjectName);
    }

    // | folder |
    @Then("I should see following folders in add user to project '$projectName' team popup: $foldersTable")
    public void checkFoldersInPopUp(String projectName, ExamplesTable foldersTable) {
        //checkFoldersInTeamPopUp(projectName, foldersTable);
        checkFoldersInTeampermissionsPopUp(projectName, foldersTable);
    }

    @When("{I |}open user '$userName' details on project '$projectName' team page")
    public void openUser(String userName, String projectName) {
        openUserDetails(userName, projectName);
    }

    @When("{I |}select user '$userName' on project '$projectName' team page")
    public void selectUser(String userName, String projectName) {
        selectUserOnTeamPage(userName, projectName);
    }

    @When("I select users on project '$projectName' team page: $usersName")
    public void selectUsers(String projectName, ExamplesTable usersName) {
        for (Map<String, String> row: usersName.getRows()) {
            selectUserOnCurrentTeamPage(row.get("UserName"),projectName);
        }
    }

    @When("{I |}select user '$userName' on project '$projectName' for current team page")
    public void selectUserOnCurrentTeamPage(String userName, String projectName) {
        super.selectUserOnCurrentTeamPage(userName, projectName);
    }


    @When("{I |}select easyshare user '$userEmail' on project '$projectName' team page")
    public void selectEasyshareUser(String userEmail, String projectName) {
        selectEasyshareUserOnTeamPage(userEmail, projectName);
    }

    @Given("{I |}removed user '$userName' from project '$projectName' team page")
    @When("{I |}remove user '$userName' from project '$projectName' team page")
    public void removeUser(String userName, String projectName) {
        selectUser(userName, projectName);
        new GenericSteps().clickElement("RemoveButton", "TeamsPage");
        new GenericSteps().clickElement("YesButton", "DeleteUserConfirmationPopUp");
        Common.sleep(2000);
    }

    @Given("{I |}clicked on Remove button on project team page")
    @When("{I |}clicked on Remove button on project team page")
    public void clickRemoveButton() {
        new GenericSteps().clickElement("RemoveButton", "TeamsPage");
        new GenericSteps().clickElement("YesButton", "DeleteUserConfirmationPopUp");
        Common.sleep(2000);
    }

    @When("{I |}remove user '$userName' form project '$projectName' team page when agency project team '$teamName' was selected")
    public void removeUserWhenAgencyProjectTeamSelected(String userName, String projectName, String teamName){
        AdBankTeamsPage adBankTeamsPage = this.openProjectTeamsPage(wrapVariableWithTestSession(projectName));
        adBankTeamsPage.selectAgencyProjectTeam(wrapVariableWithTestSession(teamName));
        User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userName));
        adBankTeamsPage.selectUser(user);
        new GenericSteps().clickElement("RemoveButton", "TeamsPage");
        new GenericSteps().clickElement("YesButton", "DeleteUserConfirmationPopUp");
    }

    @When("{I |}remove easyshare user '$userEmail' from project '$projectName' team page")
    public void removeEasyshareUser(String userEmail, String projectName) {
        selectEasyshareUser(userEmail, projectName);
        GenericSteps steps = new GenericSteps();
        steps.clickElement("RemoveButton", "TeamsPage");
        steps.clickElement("YesButton", "DeleteUserConfirmationPopUp");
    }

    @When("{I |}open user '$userName' permissions on project '$projectName' team page")
    public void openUserPermissions(String userName, String projectName) {
        openUserPermissionsPopUp(userName, projectName);
    }

    @When("{I |}select folder '$path' in manage permissions popup of project '$projectName' team for user '$userName'")
    public void selectFolderInPopUp(String path, String projectName, String userName) {
        selectFolderInTeamPopUp(path, projectName, userName);
    }

    @When("{I |}select root folder element in manage permissions popup of project '$projectName' team for user '$userName'")
    public void selectProjectRootInPopUp(String projectName, String userName) {
        selectRootFolderInTeamPopUp(projectName, userName);
    }

    @When("{I |}toggle folder '$path' in manage permissions popup of project '$projectName' team for user '$userName'")
    public void toggleFolderInPopUp(String path, String projectName, String userName) {
      //  toggleFolderInTeamPopUp(path, projectName, userName);
        toggleFolderInManagePermissionsPopUp(path, projectName, userName);
    }



    @Then("{I should see |}role '$roleName' is selected in manage permissions popup of project '$projectName' team for user '$userName'")
    public void checkPermissionByRole(String roleName, String projectName, String userName) {
        checkRolePermission(roleName, projectName, userName);
    }

    @Then("{I should see |}role '$roleName' is displayed in manage permissions popup of project '$projectName' team for user '$userName'")
    public void checkPermissionByRoleForPAR(String roleName, String projectName, String userName) {
        checkRolePermissionPAR(roleName, projectName, userName);
    }

    @Then("{I should see |}expiration time is equal to '$expirationDate' in manage permissions popup of project '$projectName' team for user '$userName'")
    public void checkExpirationTime(String expirationDate, String projectName, String userName) {
        checkExpiredTime(expirationDate, projectName, userName);
    }

    // | Folder | Role | Expiration |
    @Then("I should see following role settings for folders in manage permissions popup of project '$projectName' team for user '$userName': $settingsTable")
    public void checkPermissionSettings(String projectName, String userName, ExamplesTable settingsTable) {
        checkUsersPermissions(projectName, userName, settingsTable);
    }


    @Then("I should see following role(s) settings for folders in manage permissions popup of project '$projectName' team for user '$userName': $settingsTable")
    public void checkPermissionsSettings(String projectName, String userName, ExamplesTable settingsTable) {
        checkUsersPermissionsOnManagePermissionsTab(projectName, userName, settingsTable);
    }

    @Then("I should see logo '$logo' for user '$userName' on project '$projectName' team page")
    public void checkUserLogo(String logo, String userName, String projectName) {
        checkUserLogoOnTeamPage(logo, userName, projectName);
    }

    @When("{I |}select role '$roleName' in user '$userName' permissions popup for project '$projectName' team")
    public void selectRoleInPopUp(String roleName, String userName, String projectName) {
        selectRoleInTeamPopUp(roleName, userName, projectName);
    }

    @Then("I '$condition' see the role '$roleName' in the role list")
    public void checkRolePresent(String condition, String roleName){
        TeamUserPermissionsPopUpWindow popUp = new TeamUserPermissionsPopUpWindow(getSut().getPageCreator().getProjectTeamsPage());
        boolean shouldState = condition.equals("should");
        boolean isRoleDisplayed = popUp.isRolePresentInList(wrapVariableWithTestSession(roleName));
        assertThat(shouldState, equalTo(isRoleDisplayed));
    }

    @When("{I |}add expiration date '$expireDate' in user '$userName' permissions popup for project '$projectName' team")
    public void selectExpireDateInPopUp(String expireDate, String userName, String projectName) {
        selectExpireDateInTeamPopUp(expireDate, userName, projectName);
    }

    @When("{I |}click Add role button on permissions popup of project team tab")
    public void clickAddRoleButtonOnProjectTeamPermissionsPopUp(){
        getSut().getPageCreator().getAdBankTeamsPage().clickAddRoleButton();
    }

    @When("{I |}click Save button on permissions popup of project team tab")
    public void clickSaveButtonOnProjectTeamPermissionsPopUp(){
        getSut().getPageCreator().getAdBankTeamsPage().clickSaveButton();
    }

    @When("{I |}remove '$role' role on permissions popup of project team tab")
    public void removeRoleOnProjectTeamPermissionsPopUp(Role role) {
        AddTeamTemplatePopUpWindow popUp = new AddTeamTemplatePopUpWindow(getSut().getPageCreator().getProjectTeamsPage());
        AddTeamTemplatePopUpWindow.RoleItem roleItem = popUp.getRoleItemByIdOrName(role.getId(),role.getName());
        if(roleItem!=null){
            roleItem.clickRemove();
        }
    }


    @When("{I |}remove '$role' role on manage permissions popup of project team tab")
    public void removeRoleOnProjectManagePermissionsPopUp(Role role) {
        TeamUserPermissionsPopUpWindow popUp = new TeamUserPermissionsPopUpWindow(getSut().getPageCreator().getProjectTeamsPage());
        TeamUserPermissionsPopUpWindow.RoleItemForManagePermissionPopup roleItem = popUp.getRoleItemByIdOrNameForManagePermissionPopup(role.getId(), role.getName());
        if(roleItem!=null) {
            roleItem.clickRemove();
        }

    }
    @Then("{I |}'$shouldState' see the remove icon on manage permissions popup of project team tab")
    public void removeIconForRole(String condition) {
        TeamUserPermissionsPopUpWindow popUp = new TeamUserPermissionsPopUpWindow(getSut().getPageCreator().getProjectTeamsPage());
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean isRemoveIconForRoleDisplayed = popUp.IsRemoveIconForRoleDisplayed();
        assertThat(false, equalTo(isRemoveIconForRoleDisplayed));
    }

    @When("{I |}assign role '$roleName' in user '$userName' permissions popup for folder '$path' on project '$projectName' team")
    public void assignFolderRoleInPopUp(String roleName, String userName, String path, String projectName) {
        openUserPermissionsPopUp(userName, projectName);
        assignFolderRoleInTeamPopUp(roleName, userName, path, projectName);
    }

    @When("{I |}change role to '$roleName' from agency project team '$teamName' in user '$userName' permissions popup for folder '$path' on project '$projectName' team")
    public void assignFolderRoleFromAgencyProjectTeamInPopUp(String roleName, String teamName, String userName, String path, String projectName){
        this.selectAgencyProjectTeamOnProjectTeamTab(teamName, projectName);
        openUserPermissionsPopUp(userName, projectName);
        assignFolderRoleInTeamPopUp(roleName, userName, path, projectName);
    }

    @When("{I |}open permissions from agency project team '$teamName' for user '$userName' in project '$projectName'")
    public void openPermissionsForUserFromAgencyTeamOnProjectTeamPage(String teamName, String userName, String projectName){
        this.selectAgencyProjectTeamOnProjectTeamTab(teamName, projectName);
        openUserPermissionsPopUp(userName,projectName);
    }

    @When("{I |}'$checkOrUncheck' folder checkbox '$path' on permissions pop up")
    public void checkFolderOnPermissionsPopUp(String checkUnckeck, String path){
        new TeamUserPermissionsPopUpWindow(getCurrentTeamsPage()).checkUncheckFolderCheckbox(checkUnckeck, wrapPathWithTestSession(path));
    }

    @When("{I |}select folder '$path' on permissions pop up")
    public void selectFolderOnPermissionsPopUp(String path){
        TeamUserPermissionsPopUpWindow teamUserPermissionsPopUpWindow = new TeamUserPermissionsPopUpWindow(getCurrentTeamsPage());
        teamUserPermissionsPopUpWindow.selectFolder(wrapPathWithTestSession(path));
    }

    @When("{I |}select default role '$role' on permissions pop up")
    public void selectRoleOnPermissionsPopUp(String roleName){
        TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(getCurrentTeamsPage());
        popup.selectRole(roleName);
        popup.clickAddRoleButton();
    }

    // | TeamTemplate | Role |
    @When("{I |}fill Share window of project folder for following team templates : $teamTemplatesTable")
    public void fillSharePopUpByTeamTemplates(ExamplesTable teamTemplatesTable) {
        AddShareFolderForUserPopUpWindow popup = new AddShareFolderForUserPopUpWindow(getSut().getPageNavigator().getProjectFilesPage());
        for (Map<String, String> row : teamTemplatesTable.getRows()) {
            String teamTemplateName = row.get("TeamTemplate");
            if (!teamTemplateName.isEmpty()) {
                teamTemplateName = wrapVariableWithTestSession(teamTemplateName);
                popup.typeUserToShare(teamTemplateName);
                popup.waitForAutoCompletePopUp();
                Common.sleep(1000);
                popup.autoCompleteName.selectByVisibleText(teamTemplateName);
                String roleName = row.containsKey("Role") ? wrapVariableWithTestSession(row.get("Role")) : "Project User";
                popup.selectRoleForAllUsers(roleName);
                popup.clickAddMore();
            }


        }
    }

    @When("{I |}fill Share window of project folder for following team template '$teamTemplateName' with expired date '$expiredDate'")
    public void fillSharePopUpByTeamTemplate(String teamTemplateName, String expiredDate) {
        AddShareFolderForUserPopUpWindow popup = new AddShareFolderForUserPopUpWindow(getSut().getPageNavigator().getProjectFilesPage());
        if (!teamTemplateName.isEmpty()) {
            teamTemplateName = wrapVariableWithTestSession(teamTemplateName);
            popup.typeUserToShare(teamTemplateName);
            popup.waitForAutoCompletePopUp();
            Common.sleep(500);
            popup.autoCompleteName.selectByVisibleText(teamTemplateName);
        }
        if (!expiredDate.isEmpty()) {
            DateTime expiredDateTime = parseDateTime(expiredDate);
            popup.expirationDate.selectByVisibleText(expiredDateTime.toString(DateTimeFormat.forPattern(getContext().userDateTimeFormat)));
        }
        popup.clickAddMore();
    }

    // |User|Role|ExpiredDate|ShouldAccess|
    @Given("{I |}filled Share window of project folder for following users: $usersTable")
    @When("{I |}fill Share window of project folder for following users: $usersTable")
    public void fillSharePopUpForUsers(ExamplesTable usersTable) {
        AddShareFolderForUserPopUpWindow popup =
                new AddShareFolderForUserPopUpWindow(getSut().getPageNavigator().getProjectFilesPage());
        Common.sleep(1000);
        for (Map<String, String> row : usersTable.getRows()) {
            String userName = row.get("User");
            if (!userName.isEmpty()) {
                String userEmail = wrapUserEmailWithTestSession(userName);
                popup.typeUserToShare(userEmail);
                popup.autoCompleteName.selectByVisibleText(userEmail);
                Common.sleep(1000);
            }
            String shouldState = row.get("ShouldAccess");
            boolean should = shouldState.equals("should");
            if (should && !popup.isAccessToSubFolderSelected()) {
                popup.selectAccessToSubFolder();
            }
            String roleName = row.get("Role");
            if (!roleName.isEmpty()) {
                roleName = new RolesSteps().wrapRoleName(roleName);
                popup.role.selectByVisibleText(roleName);
            }
            String expiredDate = row.get("ExpiredDate");
            if (!expiredDate.isEmpty()) {
                DateTime expiredDateTime = parseDateTime(expiredDate);
                String formattedDate = expiredDateTime.toString(DateTimeFormat.forPattern(getContext().userDateTimeFormat));
                popup.expirationDate.selectByVisibleText(formattedDate);
            }
            popup.clickAddMore();
        }
        Common.sleep(500);
    }

    @When("{I |}change data on Users already on this folder tab on following: $usersTable")
    public void changeFilledData(ExamplesTable usersTable) {
        AddShareFolderForUserPopUpWindow popup = new AddShareFolderForUserPopUpWindow(getSut().getPageNavigator().getProjectFilesPage());
        for (int i = 0; i < usersTable.getRowCount(); i++) {
            String userEmail = wrapUserEmailWithTestSession(usersTable.getRow(i).get("User"));
            String roleName = wrapVariableWithTestSession(usersTable.getRow(i).get("Role"));
            String expiredDate = usersTable.getRow(i).get("ExpiredDate");
            if (!expiredDate.isEmpty()) {
                DateTime expiredDateTime = parseDateTime(expiredDate);
                expiredDate = expiredDateTime.toString(DateTimeFormat.forPattern(getContext().userDateTimeFormat));
            }
            String shouldState = usersTable.getRow(i).get("ShouldAccess");
            boolean should = shouldState.equals("should");
            User user = getCoreApi().getUserByEmail(userEmail);
            if (user != null) {
                popup.getExistedUserRole(user).selectByVisibleText(roleName);
                popup.getExistedExpiredDate(user).selectByVisibleText(expiredDate);
                if (should) {
                    if (!popup.isAccessToSubFolder(user)) {
                        Common.sleep(1000);
                        popup.getAccessToSubFolder(user).click();
                    }
                } else {
                    if (popup.isAccessToSubFolder(user)) {
                        popup.getAccessToSubFolder(user).click();
                    }
                }
            } else {
                User userNew = new User();
                userNew.setFirstName("");
                userNew.setEmail(userEmail);
                BaseObject obj = new BaseObject();
                obj.setName(roleName);
                userNew.setRoles(new BaseObject[] {obj});
                popup.getExistedUserRole(userNew).selectByVisibleText(roleName);
                popup.getExistedExpiredDate(userNew).selectByVisibleText(expiredDate);
                if (should) {
                    if (!popup.isAccessToSubFolder(userNew)) {
                        popup.getAccessToSubFolder(userNew).click();
                    }
                } else {
                    if (popup.isAccessToSubFolder(userNew)) {
                        popup.getAccessToSubFolder(userNew).click();
                    }
                }
            }
        }
    }

    @When("{I |}fill Share popup of project folder for user '$userName' with role '$role' expired '$expiredDate' and '$shouldState' check access to subfolders")
    public void fillShareWindow(String userName, String role, String expiredDate, String shouldState) {
        AddShareFolderForUserPopUpWindow popup = new AddShareFolderForUserPopUpWindow(getSut().getPageNavigator().getProjectFilesPage());
        boolean should = shouldState.equals("should");
        if (!userName.isEmpty()) {
            String userEmail = wrapUserEmailWithTestSession(userName);
            popup.typeUserToShare(userEmail);
            popup.autoCompleteName.selectByVisibleText(userEmail);
        }
        //access subfolder checkboxis not clickable when the mandatory fields on the page(username/role) are in red. so moving it down
        if (should && !popup.isAccessToSubFolderSelected()) {
            popup.selectAccessToSubFolder();
            Common.sleep(4000);
        }
        if (!expiredDate.isEmpty()) {
            DateTime expiredDateTime = parseDateTime(expiredDate);
            popup.expirationDate.selectByVisibleText(expiredDateTime.toString(DateTimeFormat.forPattern(getContext().userDateTimeFormat)));
        }

        if (!role.isEmpty()) {
            role = new RolesSteps().wrapRoleName(role);
            popup.role.selectByVisibleText(role);
        }
        Common.sleep(1000);
    }

    // action: Add , Save , Close, CancelUsersAlreadyOnThisFolder , CancelAddUsers
    @When("{I |}go to Users already on this folder tab after '$action' filled users on Share window")
    @Alias("{I |}go to Users already on this folder tab after '$action' {changes on |}Share window")
    public void goToUsersAlreadyOnThisFolderTab(String action) {
        GenericSteps gs = new GenericSteps();
        gs.clickElement(action, "ShareWindow");
        gs.clickElement("UsersAlreadyOnThisFolder", "ShareWindow");
    }

    @Then("I should see on selected '$tabName' tab on Share window the following users in current order : $usersTable")
    public void checkSharedUsersOnTab(String tabName, ExamplesTable usersTable) {
        AddShareFolderForUserPopUpWindow popup = new AddShareFolderForUserPopUpWindow(getSut().getPageNavigator().getProjectFilesPage());
        List<String> userNames = popup.getUserNamesOnUsersTab(tabName);
        assertThat(userNames.size(), equalTo(usersTable.getRowCount()));
        for (int i = 0; i < usersTable.getRowCount(); i++) {
            String roleName;
            if (usersTable.getRow(i).get("Role").equals("project.admin")) {
                roleName = usersTable.getRow(i).get("Role");
            } else {
                roleName = wrapVariableWithTestSession(usersTable.getRow(i).get("Role"));
            }
            String expiredDate = usersTable.getRow(i).get("ExpiredDate");
            if (!expiredDate.isEmpty()) {
                DateTime expiredDateTime = parseDateTime(expiredDate);
                expiredDate = expiredDateTime.toString(DateTimeFormat.forPattern(getContext().userDateTimeFormat));
            }
            String shouldAccess = usersTable.getRow(i).get("ShouldAccess");
            boolean should = shouldAccess.equals("should");
            String userEmail = wrapUserEmailWithTestSession(usersTable.getRow(i).get("Email"));
            User user = getCoreApiAdmin().getUserByEmail(userEmail);
            if (user != null && user.getFirstName() != null) {
                assertThat(userNames.get(i), equalTo(user.getFirstName() + " " + user.getLastName() + " " + userEmail));
                assertThat(popup.getExistedUserRole(user).getDisplayedValue(), equalTo(roleName));
                assertThat(popup.getExistedExpiredDate(user).getDisplayedValue(), equalTo(expiredDate));
                assertThat(popup.isAccessToSubFolder(user), equalTo(should));
            } else {      //es user
                User userNew = new User();
                userNew.setFirstName("");
                userNew.setEmail(userEmail);
                assertThat(userNew.getEmail(), equalTo(userNames.get(i)));
                assertThat(popup.getExistedUserRole(userNew).getDisplayedValue(), equalTo(roleName));
                assertThat(popup.getExistedExpiredDate(userNew).getDisplayedValue(), equalTo(expiredDate));
                assertThat(popup.isAccessToSubFolder(userNew), equalTo(should));
            }
        }
    }

    @Then("I should see on selected '$tabName' tab on Share window the following the same users with different roles in current order : $usersTable")
    public void checkSharedSameUsers(String tabName, ExamplesTable usersTable) {
        AddShareFolderForUserPopUpWindow popup = new AddShareFolderForUserPopUpWindow(getSut().getPageNavigator().getProjectFilesPage());
        List<String> userNames = popup.getUserNamesOnUsersTab(tabName);
        assertThat(userNames.size(), equalTo(usersTable.getRowCount()));
        for (int i = 0; i < usersTable.getRowCount(); i++) {
            String roleName;
            if (usersTable.getRow(i).get("Role").equals("project.admin")) {
                roleName = usersTable.getRow(i).get("Role");
            } else {
                roleName = wrapVariableWithTestSession(usersTable.getRow(i).get("Role"));
            }
            String expiredDate = usersTable.getRow(i).get("ExpiredDate");
            if (!expiredDate.isEmpty()) {
                DateTime expiredDateTime = parseDateTime(expiredDate);
                expiredDate = expiredDateTime.toString(DateTimeFormat.forPattern(getContext().userDateTimeFormat));
            }
            String shouldAccess = usersTable.getRow(i).get("ShouldAccess");
            boolean should = shouldAccess.equals("should");
            String userEmail = wrapUserEmailWithTestSession(usersTable.getRow(i).get("Email"));
            User user = getCoreApiAdmin().getUserByEmail(userEmail);
            if (user != null && user.getFirstName() != null) {
                int k = 1;
                assertThat(userNames.get(i), equalTo(user.getFirstName() + " " + user.getLastName() + " " + userEmail));
                if (i == 0) {  // first user is agency admin
                    assertThat(popup.getExistedUserRolesByOneUser(user, i).getDisplayedValue(), equalTo(roleName));
                    assertThat(popup.getExistedExpiredDateByOneUser(user, i).getDisplayedValue(), equalTo(expiredDate));
                    assertThat(popup.isAccessToSubFolderByOneUser(user, i), equalTo(should));
                } else {
                    // users list by one user begin from 0 index
                    assertThat(popup.getExistedUserRolesByOneUser(user, i - k).getDisplayedValue(), equalTo(roleName));
                    assertThat(popup.getExistedExpiredDateByOneUser(user, i - k).getDisplayedValue(), equalTo(expiredDate));
                    assertThat(popup.isAccessToSubFolderByOneUser(user, i - k), equalTo(should));
                }
            } else {
                throw new NullPointerException("User with following email " + userEmail + " is not exist in system!!! Please check if email is correct.");
            }
        }
    }

    @Then("I should see on selected '$tabName' tab on Share window the following the same users with different roles : $usersTable")
    public void checkSharedSameUsersNoOrder(String tabName, ExamplesTable usersTable) {
        AddShareFolderForUserPopUpWindow popup = new AddShareFolderForUserPopUpWindow(getSut().getPageNavigator().getProjectFilesPage());
        List<String> userNames = popup.getUserNamesOnUsersTab(tabName);
        assertThat(userNames.size(), equalTo(usersTable.getRowCount()));
        for (int i = 0; i < usersTable.getRowCount(); i++) {
            String roleName;
            if (usersTable.getRow(i).get("Role").equals("project.admin")) {
                roleName = usersTable.getRow(i).get("Role");
            } else {
                roleName = wrapVariableWithTestSession(usersTable.getRow(i).get("Role"));
            }
            String expiredDate = usersTable.getRow(i).get("ExpiredDate");
            if (!expiredDate.isEmpty()) {
                DateTime expiredDateTime = parseDateTime(expiredDate);
                expiredDate = expiredDateTime.toString(DateTimeFormat.forPattern(getContext().userDateTimeFormat));
            }
            String shouldAccess = usersTable.getRow(i).get("ShouldAccess");
            boolean should = shouldAccess.equals("should");
            String userEmail = wrapUserEmailWithTestSession(usersTable.getRow(i).get("Email"));
            User user = getCoreApiAdmin().getUserByEmail(userEmail);
            if (user != null && user.getFirstName() != null) {
                int k = 1;
                assertThat(userNames.get(i), equalTo(user.getFirstName() + " " + user.getLastName() + " " + userEmail));
                if (i == 0) {  // first user is agency admin
                    assertThat(popup.getExistedUserRolesByOneUser(user, i).getDisplayedValue(), equalTo(roleName));
                    assertThat(popup.getExistedExpiredDateByOneUser(user, i).getDisplayedValue(), equalTo(expiredDate));
                    assertThat(popup.isAccessToSubFolderByOneUser(user, i), equalTo(should));
                } else {
                    // users list by one user begin from 0 index
                    assertThat(popup.getExistedUserRole(user).getValues(), hasItem(roleName));
                    assertThat(popup.getExistedExpiredDateByOneUser(user, i - k).getDisplayedValue(), equalTo(expiredDate));
                    assertThat(popup.isAccessToSubFolderByOneUser(user, i - k), equalTo(should));
                }
            } else {
                throw new NullPointerException("User with following email " + userEmail + " is not exist in system!!! Please check if email is correct.");
            }
        }
    }


    @When("{I |}fill Share popup of project folder by following role '$roleName'")
    public void fillRoleInSharePopUp(String roleName) {
        AddShareFolderForUserPopUpWindow popup = new AddShareFolderForUserPopUpWindow(getSut().getPageNavigator().getProjectFilesPage());
        if (!roleName.isEmpty()) {
            roleName = new RolesSteps().wrapRoleName(roleName);
            popup.role.selectByVisibleText(roleName);
            Common.sleep(1000);
        }
    }

    @When("{I |}fill Share popup of project folder by following user '$userName'")
    public void fillUserNameInSharePopUp(String userName) {
        AddShareFolderForUserPopUpWindow popup = new AddShareFolderForUserPopUpWindow(getSut().getPageNavigator().getProjectFilesPage());
        if (!userName.isEmpty()) {
            userName = wrapUserEmailWithTestSession(userName);
            popup.typeUserToShare(userName);
            popup.waitForAutoCompletePopUp();
        }
    }

    @When("{I |}fill Share popup of project folder by following team '$teamName' with expiration date '$expiredDate'")
    public void fillUserNameInShaePopUpByTeam(String teamName, String expiredDate) {
        AddShareFolderForUserPopUpWindow popup = new AddShareFolderForUserPopUpWindow(getSut().getPageNavigator().getProjectFilesPage());
        if (!teamName.isEmpty()) {
            teamName = wrapVariableWithTestSession(teamName);
            popup.typeUserToShare(teamName);
            Common.sleep(1000);
        }
        if (!expiredDate.isEmpty()) {
            DateTime expiredDateTime = parseDateTime(expiredDate);
            popup.expirationDate.selectByVisibleText(expiredDateTime.toString(DateTimeFormat.forPattern(getContext().userDateTimeFormat)));
        }
    }

    @When("{I |}type on Share popup of project folder in Users box such first user name '$firstName' and last user name '$lastName'")
    public void typeFirstLastNameUser(String firstName, String lastName) {
        AddShareFolderForUserPopUpWindow popup = new AddShareFolderForUserPopUpWindow(getSut().getPageNavigator().getProjectFilesPage());
        if (!firstName.isEmpty() && !lastName.isEmpty()) {
            String userName = firstName + " " + lastName;
            popup.typeUserToShare(userName);
            Common.sleep(1000);
        }
    }

    @Then("{I |}'$shouldState' see user '$userEmail' in autocomplete popup on Share window")
    public void checkUserInAutoCompletePopUp(String shouldState, String userEmail) {
        AddShareFolderForUserPopUpWindow popup = new AddShareFolderForUserPopUpWindow(getSut().getPageNavigator().getProjectFilesPage());
        userEmail = wrapUserEmailWithTestSession(userEmail);
        boolean should = shouldState.equalsIgnoreCase("should");
        boolean isUsername = popup.isSearchResultsContainsString(userEmail);
        assertThat(isUsername, is(should));
    }

    @Then("{I |}should see user with email '$userEmail' on '$numberPosition' position in autocomplete popup on Share window")
    public void checkTextInAutoCompletePopUp(String userEmail, int numberPosition) {
        AddShareFolderForUserPopUpWindow popup = new AddShareFolderForUserPopUpWindow(getSut().getPageNavigator().getProjectFilesPage());
        userEmail = wrapUserEmailWithTestSession(userEmail);
        assertThat(popup.getSearchResult(numberPosition - 1), containsString(userEmail));
    }

    @Then("{I |}should see team template '$teamName' on '$numberPosition' position in autocomplete popup on Share window")
    public void checkTeamTemplateInAutoCompletePopUp(String teamTemplate, int numberPosition) {
        AddShareFolderForUserPopUpWindow popup = new AddShareFolderForUserPopUpWindow(getSut().getPageNavigator().getProjectFilesPage());
        teamTemplate = wrapVariableWithTestSession(teamTemplate);
        assertThat(teamTemplate, containsString(popup.getSearchResultByTeamTemplate(numberPosition - 1)));
    }

    @Then("{I |}'$shouldState' see such text '$text' in user name on '$numberPosition' position in autocomplete popup on Share window")
    public void checkTextAboveUserNameInAutoCompletePopUp(String shouldState, String text, int numberPosition) {
        AddShareFolderForUserPopUpWindow popup = new AddShareFolderForUserPopUpWindow(getSut().getPageNavigator().getProjectFilesPage());
        boolean should = shouldState.equals("should");
        if (should) {
            assertThat(popup.getSearchResult(numberPosition - 1), containsString(text));
        } else {
            assertThat(popup.getSearchResult(numberPosition - 1), not(containsString(text)));
        }
    }

    @Then("{I |}should see tiny text '$text' on '$numberPosition' position in autocomplete popup under search result on Share window")
    public void checkTinyTextUnderUserName(String text, int numberPosition) {
        AddShareFolderForUserPopUpWindow popup = new AddShareFolderForUserPopUpWindow(getSut().getPageNavigator().getProjectFilesPage());
        assertThat(popup.getTinyTextInAutoCompletePopUp(numberPosition - 1), equalTo(text));
    }

    @When("{I |}select user with name '$userName' in Share popup of project folder")
    public void selectUserNameInSharePopUp(String userName) {
        AddShareFolderForUserPopUpWindow popup = new AddShareFolderForUserPopUpWindow(getSut().getPageNavigator().getProjectFilesPage());
        if (!userName.isEmpty()) {
            userName = wrapUserEmailWithTestSession(userName);
            popup.autoCompleteName.selectByVisibleText(userName);
        }
    }

    @When("{I |}select team template with name '$teamName' in Share popup of project folder")
    public void selectTeamTemplate(String teamName) {
        AddShareFolderForUserPopUpWindow popup = new AddShareFolderForUserPopUpWindow(getSut().getPageNavigator().getProjectFilesPage());
        if (!teamName.isEmpty()) {
            teamName = wrapVariableWithTestSession(teamName);
            popup.autoCompleteName.selectByVisibleText(teamName);
        }
    }

    @Then("{I |}should see logo '$logo' on '$numberPosition' position in autocomplete popup on Share window")
    public void checkLogo(String logo, int numberPosition) {
        AddShareFolderForUserPopUpWindow popup = new AddShareFolderForUserPopUpWindow(getSut().getPageNavigator().getProjectFilesPage());
        byte[] realUserLogo = popup.getLogoSize(numberPosition - 1);
        byte[] uploadedUserLogo = Logo.valueOf(logo).getBytes();
        byte[] emptyLogo = Logo.EMPTY.getBytes();
        if (!logo.equals("EMPTY")) {
            assertThat("User logo " + logo + " is not loaded!", realUserLogo.length, equalTo(uploadedUserLogo.length));
        } else {
            assertThat("User logo is not empty!", realUserLogo.length, equalTo(emptyLogo.length));
        }
    }

    @Then("{I |}should see user with first name '$firstName' last name '$lastName' and email '$userEmail' in Share popup of project folder")
    public void checkSelectedUserNameInSharePopUp(String firstName, String lastName, String userEmail) {
        AddShareFolderForUserPopUpWindow popup = new AddShareFolderForUserPopUpWindow(getSut().getPageNavigator().getProjectFilesPage());
        userEmail = wrapUserEmailWithTestSession(userEmail);
        String userName = firstName.isEmpty() || lastName.isEmpty() ? userEmail : firstName + " " + lastName + " " + userEmail;

        assertThat(userName, equalTo(popup.autoCompleteName.getDisplayedValue()));
    }

    @Then("{I |}'$shoudState' see user '$userEmail' with role '$roleName' on Users already on this folder tab")
    public void checkVisibilityUsersAndRoles(String shouldState, String userEmail, String roleName) {
        AddShareFolderForUserPopUpWindow popup = new AddShareFolderForUserPopUpWindow(getSut().getPageNavigator().getProjectFilesPage());
        boolean isUsersPresent = shouldState.equalsIgnoreCase("should");
        List<String> userNames = popup.getUserNames();
        List<String> rolesName = popup.getAddedRolesName();
        userEmail = wrapUserEmailWithTestSession(userEmail);
        roleName = new RolesSteps().wrapRoleName(roleName);
        User user = getCoreApi().getUserByEmail(userEmail);
        if (user != null) {
            String userName = user.getFullName() + "\n" + user.getEmail();
            assertThat(userNames, isUsersPresent ? hasItem(userName) : not(hasItem(userName)));
            assertThat(rolesName, isUsersPresent ? hasItem(roleName) : not(hasItem(roleName)));
        } else {
            assertThat(userNames, isUsersPresent ? hasItem(userEmail) : not(hasItem(userEmail)));
            assertThat(rolesName, isUsersPresent ? hasItem(roleName) : not(hasItem(roleName)));
        }
    }

    @Then("I should see count '$count' next following tab '$tabName' on Share window")
    public void checkCountUsers(String count, String tabName) {
        AddShareFolderForUserPopUpWindow popup = new AddShareFolderForUserPopUpWindow(getSut().getPageNavigator().getProjectFilesPage());
        count = "(" + count + ")";
        if (tabName.equals("Add users")) {
            assertThat(popup.getCountNextAddUsers(), equalTo(count));
        } else {
            assertThat(popup.getCountNextUsersAlreadyOnThisFolder(), equalTo(count));
        }
    }

    @When("I remove user '$userEmail' from users tab on Share window")
    public void removeUsers(String userEmail) {
        AddShareFolderForUserPopUpWindow popup = new AddShareFolderForUserPopUpWindow(getSut().getPageNavigator().getProjectFilesPage());
        if (!userEmail.isEmpty()) {
            userEmail = wrapUserEmailWithTestSession(userEmail.toLowerCase());
            User user = getCoreApi().getUserByEmail(userEmail);
            if (user != null) {
                popup.deleteUsersFromAddUsersTab(user);
            } else {
                User userNew = new User();
                userNew.setFirstName("");
                userNew.setEmail(userEmail);
                popup.deleteUsersFromAddUsersTab(userNew);
            }
        }
    }

    @Then("I should see '$numberPages' page on '$tabName' tab on Share window")
    public void checkNumberPages(int numberPages, String tabName) {
        AddShareFolderForUserPopUpWindow popup = new AddShareFolderForUserPopUpWindow(getSut().getPageNavigator().getProjectFilesPage());
        if (tabName.equals("Add users")) {
            assertThat(popup.getNumberPageOnAddUsersTab(), equalTo(numberPages));
        } else {  // Users already on this folder tab
            assertThat(popup.getNumberPageOnUsersAlreadyOnThisFolderTab(), equalTo(numberPages));
        }
    }

    @Then("{I |}should see '$numberPage' page is selected on users tab on Share window")
    public void checkCurrentPage(int numberPage) {
        AddShareFolderForUserPopUpWindow popup = new AddShareFolderForUserPopUpWindow(getSut().getPageNavigator().getProjectFilesPage());
        assertThat(popup.getCurrentPageOnUsersTab(), equalTo(numberPage));
    }

    @When("{I |}go to '$numberPage' page on users tab on Share window")
    public void goToPageByNumber(int numberPage) {
        AddShareFolderForUserPopUpWindow popup = new AddShareFolderForUserPopUpWindow(getSut().getPageNavigator().getProjectFilesPage());
        popup.goToPage(numberPage);
    }

    @When("I toggle role checkbox in manage permissions popup of project '$projectName' team for user '$userName'")
    public void selectRoleInPopUp(String projectName, String userName) {
        TeamUserPermissionsPopUpWindow popup = new TeamUserPermissionsPopUpWindow(openTeamsPage(projectName, userName));
        popup.clickRoleCheckBox();
    }

    @When("{I |}click on '$pageAction' on Share window")
    public void goToPageByNumber(String pageAction) {
        AddShareFolderForUserPopUpWindow popup = new AddShareFolderForUserPopUpWindow(getSut().getPageNavigator().getProjectFilesPage());
        popup.clickPaginationNavigationByName(pageAction);
    }

    @Then("I should see '$userName' user name and '$roleName' role in teams of '$projectName' project")
    public void checkUsersInProjectTeamPage(User user, Role role, Project project) {
        String fullName = user.getFullName();
        AdbankProjectTeamsPage teamsPage = getSut().getPageNavigator().getProjectTeamsPage(project.getId());

        List<String> users = teamsPage.getUserNames();
        assertThat("User name '" + fullName + "' is present on page", users, hasItem(fullName));
        assertThat("User role", teamsPage.getRoleForUser(fullName), equalTo(role.getName()));
    }

    @Then("I '$condition' see easyshare user '$userName' with role '$roleName' in the project '$projectName' on the team tab")
    public void checkEasyShareUser(String condition, String userName, String roleName, String projectName) {
        checkEasyShareUsers(condition, userName, roleName, projectName);
    }

    @Then("I should see users sorted by '$fieldName' ordered '$ordering' on project '$projectName' teams page")
    public void checkUsersSorting(String fieldName, String ordering, String projectName) {
        checkSortingUsers(fieldName, ordering, projectName);
    }

    @Then("{I |}'$condition' see selected user '$userName' into project '$projectName' team page")
    public void checkSelectedUser(String condition, String userName, String projectName) {
        checkUserSelected(condition, userName, projectName);
    }

    @Then("{I |}'$shouldState' see selected Include Children checkbox for folder '$path' and role '$role' in manage permissions popup of project '$projectName' team for user '$userName'")
    public void checkIncludeChildrenCheckBoxForFolder(String shouldState, String path,Role role ,String projectName, String userName) {
        checkSelectingIncludeChildrenForFolder(shouldState, path, projectName,role, userName);
    }

   // | Folder | Role | Expiration | RoleCheckBoxState | EnableState |
    @Then("I should see following inherited permissions settings for folders in manage permissions popup of project '$projectName' team for user '$userName': $settingsTable")
    public void checkInheritedPermissionSettings(String projectName, String userName, ExamplesTable settingsTable) {
        checkInheritedUsersPermissions(projectName, userName, settingsTable);
    }

    // | Role | Expiration |
    @Then("{I |}should see following role settings for whole project in manage permissions popup of project '$projectName' team for owner '$userName': $settingsTable")
    public void checkPermissionsSettingsForSelectedProject(String projectName, String userName, ExamplesTable settingsTable) {
        checkOwnersPermissions(projectName, userName, settingsTable);
    }

    @Then("{I |}'$condition' see selected 'Role' checkbox in manage permissions popup of project '$projectName' team for user '$userName'")
    public void checkPermissionsSettingsForSelectedProject(String condition, String projectName, String userName) {
        checkIsRoleChecked(projectName, userName, condition.equalsIgnoreCase("should"));
    }

    @Then("{I |}I '$condition' see selected root folder element in manage permissions popup of project '$projectName' team for user '$userName'")
    public void checkPermissionsSettingsForSelectedRootFolder(String condition, String projectName, String userName) {
        checkIsRootFolderIsSelected(projectName, userName, condition.equalsIgnoreCase("should"));
    }

    @Then("{I |}'$shouldState' see selected Include Children checkbox for root in manage permissions popup of project '$projectName' team for user '$userName' with role '$role'")
    public void checkIncludeChildrenCheckBoxForRoot(String shouldState, String projectName, String userName, Role role) {
        checkSelectingIncludeChildrenForRoot(shouldState, projectName, userName,role);
    }

    // | folder | Editable |
    @Then("{I |}should see following folders in following state in user '$userName' permissions project '$projectName' team popup: $foldersTable")
    public void checkFoldersForUser(String userName ,String projectName, ExamplesTable foldersTable) {
        checkFoldersInTeamUsersPopUp(userName, projectName, foldersTable);
    }

    @When("{I |}select Include Children checkbox for folder '$path' in manage permissions popup of project '$projectName' team for user '$userName'")
    public void clickIncludeChildrenCheckBoxForFolder(String path, String projectName, String userName) {
        selectIncludeChildrenForFolder(path, projectName, userName);
    }

    @Deprecated
    @Then("{I |}'$shouldState' see activity for user '$userName' on project team page with message '$message' and value '$value'")
    public void checkProjectActivity(String should, String userName, String message, String value) {
        checkActivity(should.equals("should"), userName, message, value);
    }

    @Then("{I |}'$should' see activity where user '$sender' shared project '$projectName' to user '$userName' on Project Team Page")
    public void checkSharedProjectActivity(String should, String senderName, String projectName, String recipientName) {
        checkProjectShareActivity(should, senderName, projectName, recipientName);
    }

    @Then("{I |}'$should' see activity where user '$userEmail' upload file '$fileName' on Project Team Page")
    public void checkUploadedFileActivity(String condition, String userEmail, String fileName) {
        checkUploadFileActivity(condition, userEmail, fileName);
    }

    @Then("{I |}'$should' see activity where user '$userEmail' create project '$projectName' on Project Team Page")
    public void checkUserCreateProjectActivity(String condition, String userEmail, String projectName) {
        checkCreateObjectActivity(condition, userEmail, projectName);
    }

    // | UserName | Message | Value |
    @Then("{I |}should see following '$sorted' activities on project '$projectName' team page: $activitiesTable")
    public void checkProjectActivity(String sorted, String projectName, ExamplesTable activitiesTable) {
        checkActivity(projectName, activitiesTable, sorted.equals("sorted"));
    }

    @When("{I |}click on user '$userName' in project '$projectName' team activities")
    public void clickUserInProjectActivities(String userName, String projectName) {
        clickUserInActivities(projectName, userName);
    }

    @When("{I |}click on file '$fileName' in project '$projectName' team activities")
    public void clickFileInProjectActivities(String fileName, String projectName) {
        clickFileInActivities(projectName, fileName);
    }

    @Then("{I |}'$condition' see user '$userName' is selected on project team page")
    public void checkProjectUserSelected(String condition, String userName) {
        checkUserSelected(condition, userName);
    }

    @Then("{I | } should see the number of users display per page is '$number'")
    public void checkTeamUsersPerPage(String number) {
        checkUsersPerPage(number);
    }

    @Then("{I | } should see following pagination sizes in the dropdown:$data")
    public void checkPaginationSizes(ExamplesTable data){
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            assertThat(getProjectTeamPaginationSizes().get(i), equalTo(row.get("PaginationSize")));
        }

    }

    @When("{I | } select '$number' from the pagination size dropdown")
    public void selectTeamUserPaginationSize(String number){
         selectTeamUserPaginationNumber(number);
    }

    @Then("I '$condition' see role '$roleName' in the role dropdown on Share popup")
    public void checkRoleInTheDropdown(String condition, String roleName) {
        AddShareFolderForUserPopUpWindow popup = new AddShareFolderForUserPopUpWindow(getSut().getPageNavigator().getProjectFilesPage());
        RolesSteps rs = new RolesSteps();
        roleName = rs.wrapRoleName(roleName);
        assertThat(roleName, condition.equalsIgnoreCase("should") ? isIn(popup.role.getValues()) : not(isIn(popup.role.getValues())));
    }

    @When("I select agency project team '$teamName' on project's team page")
    public void selectAgencyProjectTeam(String teamName){
        AdBankTeamsPage adBankTeamsPage = getSut().getPageCreator().getAdBankTeamsPage();
        adBankTeamsPage.selectAgencyProjectTeam(wrapVariableWithTestSession(teamName));
    }

    @When("I add agency project team '$teamName' for folder '$folderName' in the project '$projectName'")
    public void addAgencyProjectTeamToProject(String teamName, String folderName, String projectName){
        AdBankTeamsPage adBankTeamsPage = this.openTeamsPage(projectName);
        AddAgencyProjectTeamPopUp addAgencyProjectTeamPopUp = adBankTeamsPage.openAddAgencyProjectTeamPopUp();
        addAgencyProjectTeamPopUp.selectAgencyTeam(wrapVariableWithTestSession(teamName));
        addAgencyProjectTeamPopUp.checkFolder(wrapVariableWithTestSession(folderName));
        addAgencyProjectTeamPopUp.clickAddRole();
        addAgencyProjectTeamPopUp.clickSaveButton();
    }

    @When("I change following folders '$foldersName' state on the agency project team '$agencyProjectTeam' popup for user '$userName'")
    public void checkFoldersForAPT(String foldersName, String agencyProjectTeam, String userName) {
        AdBankTeamsPage adBankTeamsPage = getSut().getPageCreator().getAdBankTeamsPage();
        adBankTeamsPage.selectAgencyProjectTeam(wrapVariableWithTestSession(agencyProjectTeam));
        User user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userName));
        adBankTeamsPage.openUserDetails(user);
        AddAgencyProjectTeamPopUp addAgencyProjectTeamPopUp = adBankTeamsPage.openAddAgencyProjectTeamPopUp();
        for (String folder: foldersName.split(",")) {
            addAgencyProjectTeamPopUp.checkFolder(wrapVariableWithTestSession(folder));
        }
        addAgencyProjectTeamPopUp.clickSaveButtonOtherMethod();
    }

    @Then("I '$shouldState' see users on agency project team page are sorted by 'Name' field in order '$order'")
    public void checkUsersFromAgencyTeamAreSorted(String condition, String order){
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> expectedSortedList;
        List<String> actualSortedList;
        AdBankTeamsPage adBankTeamsPage = getSut().getPageCreator().getAdBankTeamsPage();
        actualSortedList = adBankTeamsPage.getUserNames();
        expectedSortedList = adBankTeamsPage.getUserNames();
        Collections.sort(expectedSortedList);
        if(order.equals("descending")){
            Collections.reverse(expectedSortedList);
        }
        assertThat(actualSortedList, shouldState ? equalTo(expectedSortedList) : not(equalTo(expectedSortedList)));

    }

    @Given("{I |} add into agency project team '$teamName' following objects: $objectsTable")
    public void addObjectIntoAgencyProjectTeam(String teamName, ExamplesTable objectsTable) {

    }

    // | UserName | Message | Value |
    @Then("{I |}'$condition' see following activities in 'Recent Activity' section on Project Team page: $data")
    public void checkThatActivityPresentOnRecentActivitySectionOnProjectOverview(String condition, ExamplesTable data) {
        getSut().getPageNavigator().getProjectTeamsPage();
        checkThatActivityPresentOnRecentAcitivitySectionOnProjectOverview(condition, data);
    }

    // | UserName | Message | Value |
    @Then("{I |}'$condition' see following activities in 'Recent Activity' section on opened Project Team page: $data")
    public void checkThatActivityPresentOnRecentAcitivitySectionOnProjectOverview(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualActivities = getSut().getPageCreator().getProjectTeamsPage().getActivitiesList();

        for (Map<String, String> row : parametrizeTableRows(data)) {
            String expectedActivity = createActivityOnPage(row.get("UserName"), row.get("Message"), row.get("Value").matches("(/.*)") ? getPathToFile(row.get("Value")) : row.get("Value"));
            assertThat(actualActivities, shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
        }
    }

    private String getPathToFile(String path) {
        String[] val = path.split("/");
        int size = val.length;
        path = "";
        for (int i = 1; i < size - 1; i++) {
            path += val[i] + getData().getSessionId() + "/";
        }
        return "/" + path + val[size - 1];
    }

    private String createActivityOnPage(String userName, String message, String value) {
        if (message.matches("((created|updated|clone) (the |)(project|template)|hat folgendes Projekt erstellt|a créé le projet|creó el proyecto)"))
            value = wrapVariableWithTestSession(value);
        User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userName));

        return String.format("%s %s %s", user.getFullName(), message, value);
    }
}