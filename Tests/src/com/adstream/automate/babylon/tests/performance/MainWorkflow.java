package com.adstream.automate.babylon.tests.performance;

import com.adstream.automate.babylon.sut.pages.adbank.projects.*;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AddTeamUserPopUpWindow;
import com.adstream.automate.babylon.sut.pages.login.LoginPage;
import com.adstream.automate.utils.Gen;

import java.net.URL;

/**
 * User: ruslan.semerenko
 * Date: 17.07.13 14:27
 */
public class MainWorkflow extends Workflow {
    public MainWorkflow(URL baseUrl, URL coreUrl, String login, String password) {
        super(baseUrl, coreUrl, login, password);
    }

    @Override
    public WorkflowActionStats perform() {
        performAction("Open login page", new WorkflowAction() {
            @Override
            public void perform(Workflow workflow) {
                getPageNavigator().getLoginPage();
            }
        });

        performAction("Open dashboard", new WorkflowAction() {
            @Override
            public void perform(Workflow workflow) {
                new LoginPage(workflow).login(getLogin(), getPassword());
            }
        });

        performAction("Open projects list", new WorkflowAction() {
            @Override
            public void perform(Workflow workflow) {
                getPageNavigator().getProjectListPage();
            }
        });

        performAction("Open 'Create new project' form", new WorkflowAction() {
            @Override
            public void perform(Workflow workflow) {
                new AdbankProjectsListPage(workflow).clickNewProject();
            }
        });

        performAction("Create project", new WorkflowAction() {
            private AdbankProjectsCreatePage page;

            @Override
            public void prepare(Workflow workflow) {
                String projectName = Gen.getHumanReadableString(6, true);
                page = new AdbankProjectsCreatePage(workflow);
                page.setName(projectName);
                page.setMediaType("Broadcast");
            }

            @Override
            public void perform(Workflow workflow) {
                page.saveButton.click();
            }
        });

        performAction("Open files page", new WorkflowAction() {
            @Override
            public void perform(Workflow workflow) {
                String projectId = new AdbankProjectOverviewPage(workflow).getCurrentProjectId();
                getPageNavigator().getProjectFilesPage(projectId, null);
                workflow.getCache().put("projectId", projectId);
            }
        });

        performAction("Create folder", new WorkflowAction() {
            @Override
            public void perform(Workflow workflow) {
                String folderName = Gen.getHumanReadableString(6, true);
                new AdbankProjectFilesPage(workflow).createFolder(folderName);
                workflow.getCache().put("folderName", folderName);
            }
        });

        performAction("Open project team page", new WorkflowAction() {
            @Override
            public void perform(Workflow workflow) {
                String projectId = workflow.getCache().get("projectId");
                getPageNavigator().getProjectTeamsPage(projectId);
            }
        });

        performAction("Open 'Add user to project team' popup", new WorkflowAction() {
            @Override
            public void perform(Workflow workflow) {
                new AdbankProjectTeamsPage(workflow).clickAddUserButton().clickUserOption();
            }
        });

        performAction("Add user to project team", new WorkflowAction() {
            private AddTeamUserPopUpWindow popup;

            @Override
            public void prepare(Workflow workflow) {
                popup = new AddTeamUserPopUpWindow(new AdbankProjectTeamsPage(workflow));
                popup.setName("qatbabylonautotester+agencyuser@gmail.com");
                popup.toggleFolder(workflow.getCache().get("folderName"));
                popup.selectRole("project.contributor");
            }

            @Override
            public void perform(Workflow workflow) {
                popup.clickAction();
            }
        });

        return getStats();
    }
}
