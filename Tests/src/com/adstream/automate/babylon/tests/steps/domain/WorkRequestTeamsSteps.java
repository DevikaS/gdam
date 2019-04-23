package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AdBankTeamsPage;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;

import java.util.List;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.hamcrest.Matchers.not;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 01.08.12
 * Time: 19:55
 */
public class WorkRequestTeamsSteps extends AbstractTeamsStep{

    @Override
    protected AdBankTeamsPage getTeamsPage(String templateId) {
        return getSut().getPageNavigator().getWorkRequestTeamsPage(templateId);
    }

    @Override
    protected AdBankTeamsPage getTeamsPage(String templateId, String agencyTeamId) {
        return null;
    }

    protected Project getObjectByName(String objectName) {
        return getCoreApi().getWorkRequestByName(objectName);
    }

    protected Project getObjectByName(String objectName, User user) {
        return getCoreApi(user).getWorkRequestByName(objectName);
    }

    protected AdBankTeamsPage getTeamsPageByUser(String templateId, String userId) {
        return null;
    }

    protected AdBankTeamsPage getCurrentTeamsPage() {
        return getSut().getPageCreator().getWorkRequestTeamsPage();
    }

    // users and folders are comma-separated
    @Given("{I |}added users '$users' to work request '$workRequestName' team with role '$roleName' expired '$expired'")
    public void addUsersToProjectTeamOverCore(String users, String workRequestName, String roleName, String expired) {
        addUserToTeamOverCore(users, workRequestName, roleName, expired);
    }

    @Then("{I |}'$shouldState' see user '$userName' name in teams of work request '$workRequest'")
    public void checkUserName(String shouldState, String userName, String workRequest) {
        checkUsersNameInTeams(shouldState, userName, workRequest, "");
    }

    // users and folders are comma-separated
    @Given("{I |}added users '$users' to work request '$workRequestName' team folders '$folders' with role '$roleName' expired '$expired'")
    @When("{I |}add users '$users' to work request '$workRequestName' team folders '$folders' with role '$roleName' expired '$expired'")
    public void addUsersToWorkRequestTeamOverCore(String users, String workRequestName, String folders, String roleName, String expired) {
        addUserToTeamOverCore(users, workRequestName, folders, roleName, expired);
    }

    @Given("I am on work request '$workRequestName' teams page")
    @When("{I |}go to work request '$workRequestName' teams page")
    public AdBankTeamsPage openWorkRequestTeamsPage(String workRequestName) {
        return openTeamsPage(workRequestName);
    }

    @Then("{I |}'$should' see activity where user '$sender' shared folder '$folderName' to user '$recipientName' on work request Team Page")
    public void checkSharedWorkRequestFolderActivity(String should, String senderName, String folderName, String recipientName) {
        sharedFolderToUserActivity(should, senderName, folderName, recipientName);
    }

    public void sharedFolderToUserActivity(String condition, String sender, String folder, String recipient) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String senderFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(sender)).getFullName();
        String recipientFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(recipient)).getFullName();
        folder = wrapPathWithTestSession(folder);
        String expectedActivity = String.format("%s has shared folder to %s (%s) %s",
                senderFullName,
                recipientFullName,
                wrapUserEmailWithTestSession(recipient),
                wrapVariableWithTestSession(folder));

        assertThat(getActualActivities(), shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
    }

    public void removedUserActivity(String condition, String sender, String folder, String recipient) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String senderFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(sender)).getFullName();
        String recipientFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(recipient)).getFullName();
        folder = wrapPathWithTestSession(folder);
        String expectedActivity = String.format("%s has removed %s (%s) from %s",
                senderFullName,
                recipientFullName,
                wrapUserEmailWithTestSession(recipient),
                wrapVariableWithTestSession(folder));

        assertThat(getActualActivities(), shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
    }

    private List<String> getActualActivities() {
        return getSut().getPageCreator().getWorkRequestTeamsPage().getActivityList();
    }

    @Then("{I |}'$should' see activity where user '$sender' has removed user '$userName' from work request '$workRequestName' on work request Team Page")
    public void checkRemoveuserFromWRActivity(String should, String senderName, String userName, String workRequestName) {
        removedUserActivity(should, senderName, workRequestName, userName);
    }

    @Then("{I |}'$condition' see activity where user '$senderEmail' shared work request '$objectName' to user '$recipientEmail' on work request Team page")
    public void checkSharedPWRActivity(String condition, String senderEmail, String objectName, String recipientEmail) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String senderFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(senderEmail)).getFullName();
        String recipientFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(recipientEmail)).getFullName();
        objectName = wrapPathWithTestSession(objectName);
        String expectedActivity = String.format("%s has shared project to %s (%s) %s",
                senderFullName,
                recipientFullName,
                wrapUserEmailWithTestSession(recipientEmail),
                wrapVariableWithTestSession(objectName));

        assertThat(getActualActivities(), shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
    }

    @Then("{I |}'$condition' see activity for user '$creator' of publish work request '$workRequestName' on work request Team Page")
    public void publishObjectActivity(String condition, String creator, String workRequestName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String senderFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(creator)).getFullName();
        workRequestName = wrapPathWithTestSession(workRequestName);
        String expectedActivity = String.format("%s published project %s",
                senderFullName,
                wrapVariableWithTestSession(workRequestName));

        assertThat(getActualActivities(), shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
    }
}