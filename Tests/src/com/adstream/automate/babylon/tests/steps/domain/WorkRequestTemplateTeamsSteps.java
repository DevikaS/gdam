package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AdBankTeamsPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AddAgencyProjectTeamPopUp;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AddShareFolderForUserPopUpWindow;
import com.adstream.automate.babylon.tests.steps.core.GenericSteps;
import org.jbehave.core.annotations.Alias;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;

import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.containsString;

/**
 * User: demidovskiy-r
 * Date: 01.08.12
 * Time: 19:55
 */
public class WorkRequestTemplateTeamsSteps extends AbstractTeamsStep {

    @Given("{I am |}on work request template '$workRequestTemplateName' teams page")
    @When("{I |}go to work request template '$workRequestTemplateName' teams page")
    public AdBankTeamsPage openTemplateTeamsPage(String workRequestTemplateName) {
        return openTeamsPage(workRequestTemplateName);
    }

    @Override
    protected AdBankTeamsPage getTeamsPage(String templateId) {
        return getSut().getPageNavigator().getTemplateTeamsPage(templateId);
    }

    @Override
    protected AdBankTeamsPage getTeamsPage(String templateId, String agencyTeamId) {
        return null;
    }

    protected Project getObjectByName(String objectName) {
        return getCoreApi().getWorkRequestTemplateByName(objectName);
    }

    protected Project getObjectByName(String objectName, User user) {
        return getCoreApi(user).getWorkRequestTemplateByName(objectName);
    }

    protected AdBankTeamsPage getTeamsPageByUser(String templateId, String userId) {
        return null;
    }

    protected AdBankTeamsPage getCurrentTeamsPage() {
        return null;
    }

    // users and folders are comma-separated
    @Given("{I |}added users '$users' to work request template '$workRequestTemplateName' team folders '$folders' with role '$roleName' expired '$expired'")
    public void addUsersToTemplateTeamOverCore(String users, String workRequestTemplateName, String folders, String roleName, String expired) {
        addUserToTeamOverCore(users, workRequestTemplateName, folders, roleName, expired);
    }

    @When("I add agency project team '$teamName' for folder '$folderName' in the work request template '$projectName'")
    public void addAgencyProjectTeamToProject(String teamName, String folderName, String projectName){
        AdBankTeamsPage adBankTeamsPage = this.openTeamsPage(projectName);
        AddAgencyProjectTeamPopUp addAgencyProjectTeamPopUp = adBankTeamsPage.openAddAgencyProjectTeamPopUp();
        addAgencyProjectTeamPopUp.selectAgencyTeam(wrapVariableWithTestSession(teamName));
        addAgencyProjectTeamPopUp.checkFolder(wrapVariableWithTestSession(folderName));
        addAgencyProjectTeamPopUp.clickAddRole();
        addAgencyProjectTeamPopUp.clickSaveButton();
    }

    @Then("{I |}'$shouldState' see user '$userName' name in teams of work request template '$projectName'")
    public void checkUserName(String shouldState, String userName, String projectName) {
        checkUsersNameInTeams(shouldState, userName, projectName, "");
    }


}
