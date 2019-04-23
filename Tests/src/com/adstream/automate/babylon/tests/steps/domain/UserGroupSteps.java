package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.BaseObject;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.admin.people.*;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * User: ruslan.semerenko
 * Date: 09.07.12 16:59
 */
public class UserGroupSteps extends UserSteps {
    @Given("I am on library team '$teamName' page")
    @When("{I |}go to library team '$teamName' page")
    public UsersGroupPage openUsersGroupPage(String teamName) {
        BaseObject team = wrapNameAndGetGroup(teamName);
        return getSut().getPageNavigator().getUsersGroupPage(team.getId());
    }

    @When("{I |}delete agency project team '$teamName'")
    public void deleteAgencyProjectTeam(String teamName){
        UsersPage usersPage = openUsersPage();
        usersPage.removeAgencyProjectTeam(wrapVariableWithTestSession(teamName));
    }

    @Given("{I |}deleted library team '$teamName'")
    @When("{I |}delete library team '$teamName'")
    public void deleteLibraryTeam(String teamName){
        UsersPage usersPage = openUsersPage();
        usersPage.removeLibraryTeam(wrapVariableWithTestSession(teamName));
    }

    @Given("{I |}added '$userNames' users to '$teamName' library team on Users list page")
    @When("{I |}add '$userNames' users to '$teamName' library team on Users list page")
    public void addUsersIntoLibraryTeam(String userNames, String teamName) {
        for (String userName : userNames.split(",")) {
            searchUser(userName);
            UsersPage page = selectUser(userName);
            page.clickAddToTeam();
            AddToLibraryTeamPopUp popup = page.clickAddToLibraryTeam();
            popup.setTeamName(wrapVariableWithTestSession(teamName));
            Common.sleep(2000);
            popup.save();
        }
    }

    // | UserEmail | TeamName |
    @Given("{I |}added following users to library teams: $data")
    @When("{I |}add following users to library teams: $data")
    public void addUsersToLibraryTeamsViaCore(ExamplesTable data) {
        Map<String, String> usersPerTeam = new HashMap<String,String>();

        for (Map<String,String> row : parametrizeTableRows(data)) {
            if (usersPerTeam.get(row.get("TeamName")) == null) {
                usersPerTeam.put(row.get("TeamName"), row.get("UserEmail"));
            } else {
                usersPerTeam.put(row.get("TeamName"), String.format("%s,%s", usersPerTeam.get(row.get("TeamName")), row.get("UserEmail")));
            }
        }

        for (String teamName : usersPerTeam.keySet()) addUserToLibraryTeamViaCore(teamName, usersPerTeam.get(teamName));
    }

    @Given("{I |}added users '$userEmails' to library team '$teamName'")
    @When("{I |}add users '$userEmails' to library team '$teamName'")
    public void addUserToLibraryTeamViaCore(String userEmails, String teamName) {
        List<User> users = new ArrayList<User>();

        for (String userEmail : userEmails.split(",")) users.add(getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userEmail)));

        getCoreApi().addUsersToLibraryTeam(wrapVariableWithTestSession(teamName), users);
    }

    @Given("{I |}added '$userNames' users to '$teamName' library teams on Users list page")
    @When("{I |}add '$userNames' users to '$teamName' library teams on Users list page")
    public void addUsersIntoLibraryTeams(String userNames, String teamNames) {
        for (String teamName : teamNames.split(",")) {
            addUsersIntoLibraryTeam(userNames, teamName);
        }
    }

    @When("{I |}add selected users to '$teamName' library team on Users list page")
    public void addSelectedIntoLibraryTeam(String teamName) {
        teamName = wrapVariableWithTestSession(teamName);
        UsersPage usersPage = getSut().getPageCreator().getUsersPage();
        usersPage.clickAddToTeam();
        usersPage.clickAddToLibraryTeam().setTeamName(teamName).save();
    }

    @When("{I |}open Add to library team form and type '$teamName' group name")
    public void openLibraryTeamAndType(String teamName){
        teamName = wrapVariableWithTestSession(teamName);
        UsersPage usersPage = getSut().getPageCreator().getUsersPage();
        usersPage.clickAddToTeam();
        usersPage.clickAddToLibraryTeam().setTeamName(teamName);
    }

    @When("{I |}click '$element' element on Add to library team popup")
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
    }

    @When("{I |}try to add '$teamName' team name to Add to library team popup")
    public void inputTeamName(String teamName){
        teamName = wrapVariableWithTestSession(teamName);
        UsersPage usersPage = getSut().getPageCreator().getUsersPage();
        usersPage.clickAddToTeam();
        usersPage.clickAddToLibraryTeam().inputTeamName(teamName);
    }

    @Given("{I |}added user '$userName' to '$teamName' project team with role '$roleName' on Users list page")
    @When("{I |}add user '$userName' to '$teamName' project team with role '$roleName' on Users list page")
    public void addUserIntoProjectTeam(String userName, String teamName, String roleName) {
        addUsersToProjectTeam(userName, teamName, roleName);
    }

    @Given("{I |}added '$userNames' users to '$teamName' project team with role '$roleName' on Users list page")
    @When("{I |}add '$userNames' users to '$teamName' project team with role '$roleName' on Users list page")
    public void addUsersIntoProjectTeam(String userNames, String teamName, String roleName) {
        addUsersToProjectTeam(userNames, teamName, roleName);
    }

    @When("{I |}select agency project team '$teamName'")
    public void selectAgencyProjectTeam(String teamName){
        UsersPage usersPage = getSut().getPageCreator().getUsersPage();
        usersPage.selectAgencyProjectTeam(wrapVariableWithTestSession(teamName));
    }

    @When("{I |}select library team '$teamName'")
    public void selectLibraryTeam(String teamName) {
        openUsersPage().selectLibraryTeam(wrapVariableWithTestSession(teamName));
    }

    @When("{I |}select all users in library team '$teamName'")
    public void selectAllUsersOfLibraryTeam(String teamName) {
        UsersPage usersPage = openUsersPage();
        usersPage.selectLibraryTeam(wrapVariableWithTestSession(teamName));
        usersPage.checkSelectAllCheckBox();
    }

    @Given("{I |}removed users '$userNames' from '$teamType' team '$teamName'")
    @When("{I |}remove users '$userNames' from '$teamType' team '$teamName'")
    public void removeUserFromAgencyProjectTeam(String userNames, String teamType, String teamName){
        UsersPage usersPage = openUsersPage();
        for(String userName : userNames.split(",")){
            User user = wrapNameAndGetUser(userName.trim());
            if(teamType.equalsIgnoreCase("project")){
                usersPage.removeUserFromAgencyProjectTeam(user.getFullName(), wrapVariableWithTestSession(teamName));
            }
            else if(teamType.equalsIgnoreCase("library")){
                usersPage.removeUserFromLibraryTeam(user.getFullName(), wrapVariableWithTestSession(teamName));
            }
        }
    }

    //The existing user is removed from the Library team inorder to remove all his library permissions
    @Given("{I |}removed existing client users '$userNames' from '$teamType' team '$teamName' using UI")
    @When("{I |}remove existing client users '$userNames' from '$teamType' team '$teamName' using UI")
    public void removeClientUserFromAgencyProjectTeam_UI(String userNames, String teamType, String teamName) {
        UsersPage usersPage = openUsersPage();
        for (String userName : userNames.split(",")) {
            if(teamType.equalsIgnoreCase("library")){
                usersPage.removeClientUserFromLibraryTeam(userName, teamName);
            }
        }
    }

    //The user is removed from the Library team inorder to remove all his library permissions only if existing
    @Given("{I |}removed client users '$userNames' from '$teamType' team '$teamName' if existing using UI")
    @When("{I |}remove client users '$userNames' from '$teamType' team '$teamName' if existing using UI")
    public void checkAndRemoveClientUserFromAgencyProjectTeamIfExists_UI(String userNames, String teamType, String teamName) {
        UsersPage usersPage = openUsersPage();
        if(usersPage.isLibraryTeamVisible(teamName)) {
            for (String userName : userNames.split(",")) {
                if (teamType.equalsIgnoreCase("library")) {
                    usersPage.removeClientUserFromLibraryTeam(userName, teamName);
                }
            }
        }
    }


    // teamType: library, project
    @When("{I |}try to remove users '$userNames' from '$teamType' team '$teamName'")
    public void tryRemoveUserFromTeam(String userNames, String teamType, String teamName){
        UsersPage usersPage = this.openUsersPage();
        for(String userName : userNames.split(",")) {
            User user = wrapNameAndGetUser(userName.trim());
            String userFullName, team;
            userFullName = user.getFullName();
            team = wrapVariableWithTestSession(teamName);
            usersPage.clickRemoveUserFromTeam(userFullName, team, teamType);
        }
    }

    @Given("{I |}added '$userName' users to '$teamName' project team with default role '$roleName' on Users list page")
    @When("{I |}add '$userName' users to '$teamName' project team with default role '$roleName' on Users list page")
    public void addUsersToProjectTeam(String userName, String teamName, String roleName) {
        teamName = wrapVariableWithTestSession(teamName);
        for (String name : userName.split(",")) {
            searchUser(name);
            UsersPage usersPage = selectUser(name);
            usersPage.clickAddToTeam();
            usersPage.clickAddToProjectTeam().setTeamName(teamName).selectProjectRole(wrapRoleName(roleName)).save();
        }
    }

    @Then("{I |}should see users count is '$count' in this agency project team")
    public void checkUsersCountIsCorrect(int usersCount){
        UsersPage usersPage = getSut().getPageCreator().getUsersPage();
        assertThat(usersPage.getUsersCount(), equalTo(usersCount));
    }

    @Then("{I |}'$condition' see user '$userEmail' in project team '$projectTeamName' with role '$projectRole'")
    public void checkUserIsPresentInAgencyProjectTeam(String condition, String userName, String projectTeamName, String projectRole){
        getSut().getPageNavigator().getUsersPage().selectAgencyProjectTeam(wrapVariableWithTestSession(projectTeamName));
        checkUserIsPresentInAgencyProjectTeam(condition, userName, projectRole);
    }

    @Then("{I |}'$condition' see user '$userEmail' with role '$projectRole' in opened project team page")
    public void checkUserIsPresentInAgencyProjectTeam(String condition, String userName, String projectRole){
        boolean shouldState = condition.equalsIgnoreCase("should");
        String expectedUserName = wrapNameAndGetUser(userName).getFullName();
        String expectedProjectRole = wrapRoleName(projectRole);
        expectedProjectRole = expectedProjectRole.replaceAll("\\.", " ");
        expectedProjectRole = expectedProjectRole.substring(0,1).toUpperCase() + expectedProjectRole.substring(1);
        List<String> actualUsersList = getSut().getPageCreator().getAgencyProjectTeamPage().getUsersList();

        assertThat(actualUsersList, shouldState ? hasItem(expectedUserName) : not(hasItem(expectedUserName)));

        if(shouldState) {
            String actualProjectRole = getSut().getPageCreator().getAgencyProjectTeamPage().getUsersRole(expectedUserName);
            assertThat(actualProjectRole.toLowerCase(), equalTo(expectedProjectRole.toLowerCase()));
        }
    }

    @Then("{I |}'$condition' see '$teamName' '$teamType' team on Users list page")
    public void checkThatUserTeamPresentOnPage(String condition, String team, String teamType) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String expectedTeam = wrapVariableWithTestSession(team);

        if (teamType.equalsIgnoreCase("library")) {
            assertThat(openUsersPage().getLibraryTeamsList(), shouldState ? hasItem(expectedTeam) : not(hasItem(expectedTeam)));
        } else if (teamType.equalsIgnoreCase("project")) {
            assertThat(openUsersPage().getProjectTeamsList(), shouldState ? hasItem(expectedTeam) : not(hasItem(expectedTeam)));
        } else {
            throw new IllegalArgumentException("Incorrect teamType, it should be 'library' or 'project'");
        }
    }

    @Then("{I |}'$condition' see '$userName' user in '$groupName' users group")
    public void checkUserPresentInGroup(String condition, String userName, String groupName) {
        boolean shouldState = condition.equals("should");
        User user = wrapNameAndGetUser(userName);
        BaseObject group = wrapNameAndGetGroup(groupName);
        UsersGroupPage groupPage = getSut().getPageNavigator().getUsersGroupPage(group.getId());
        assertThat(groupPage.getUserElement(user.getId()), shouldState ? notNullValue() : nullValue());

    }

    @Then("{I |}'$shouldState' see following users in '$groupName' users group: $usersTable")
    public void checkUsersPresentInGroup(String shouldState, String groupName, ExamplesTable usersTable) {
        for (Map<String, String> row : usersTable.getRows()) {
            checkUserPresentInGroup(shouldState, row.get("User Name"), groupName);
        }
    }

    @Then("{I |}'$shouldState' see following users '$userNames' in '$groupName' users group")
    public void checkUsersPresentInGroup(String shouldState, String userNames, String groupName) {
        for(String userName : userNames.split(",")){
            checkUserPresentInGroup(shouldState, userName.trim(), groupName);
        }
    }

    @Then("{I |}'$condition' see create new link near '$groupName' group name on autocomplete form")
    public void checkIsCreateNewLinkPresent(String condition, String groupName){
        boolean should = condition.equalsIgnoreCase("should");
        groupName = wrapVariableWithTestSession(groupName);
        AddToLibraryTeamPopUp popup = new AddToLibraryTeamPopUp(getSut().getPageCreator().getUsersPage());
        assertThat(popup.isCreateNewTeamLinkPresent(groupName), equalTo(should));
    }

    @Then("{I |}'$condition' see '$groupName' group name in search results on autocomplete form")
    public void checkIsGroupPresentInTheList(String condition, String groupName){
        boolean should = condition.equalsIgnoreCase("should");
        groupName = wrapVariableWithTestSession(groupName);
        AddToLibraryTeamPopUp popup = new AddToLibraryTeamPopUp(getSut().getPageCreator().getUsersPage());
        assertThat(popup.isTeamPresentInTheList(groupName), equalTo(should));
    }

    public BaseObject wrapNameAndGetGroup(String groupName) {
        groupName = wrapVariableWithTestSession(groupName);
        return getCoreApi().getLibraryTeamByName(groupName);
    }
}