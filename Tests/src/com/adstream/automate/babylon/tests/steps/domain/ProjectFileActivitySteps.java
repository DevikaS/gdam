package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileApprovalsPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileCommentsPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileVersionHistoryPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.*;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryAssetsActivityPage;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.util.List;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.hasItem;
import static org.hamcrest.Matchers.not;


/**
 * Created with IntelliJ IDEA.
 * User: lynda-k
 * Date: 03.06.13
 * Time: 10:41
 */
public class ProjectFileActivitySteps extends AbstractFileViewSteps implements FileActivity {

    @Override
    public Project getObjectByName(String objectName) {
        return getCoreApi().getProjectByName(objectName);
    }

    @Override
    public Project getObjectByName(String objectName, User user) {
        return getCoreApi(user).getProjectByName(objectName);
    }

    @Override
    protected AdbankFileActivityPage getFileActivityPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getProjectFileActivityPage(projectId, folderId, fileId);
    }

    @Override
    protected AdbankFilesInfoPage getFilesInfoPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getProjectFileInfoPage(projectId, folderId, fileId);
    }

    @Override
    protected AdbankFileUsageRightsPage getFileUsageRightsPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getProjectFileUsageRightsPage(projectId, folderId, fileId);
    }

    @Override
    protected AdbankFileCommentsPage getFileCommentsPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getProjectFileCommentsPage(projectId, folderId, fileId);
    }

    @Override
    protected AdbankProjectFileRelatedFilesPage getProjectRelatedFilesPage(String projectId, String folderId, String fileId) {
        return null;
    }

    @Override
    protected AdbankFileVersionHistoryPage getFileVersionHistoryPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getProjectFileVersionHistoryPage(projectId, folderId, fileId);
    }

    @Override
    protected AdbankFileApprovalsPage getFileApprovalsPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getProjectFileApprovalsPage(projectId, folderId, fileId);
    }

    @Override
    protected AdbankFileAttachmentsPage getFileAttachmentsPage(String projectId, String folderId, String fileId) {
        return null;
    }

    //QA358-Frame Grabber Changes Starts
    @Override
    protected AdbankFileFramesPage getFileFramesPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getProjectFileFramesPage(projectId, folderId, fileId);
    }
    //QA358-Frame Grabber Changes Ends

    @Given("{I |}opened activity page in project '$projectName' folder '$folderName' of file '$fileName'")
    @When("{I |}open activity page in project '$projectName' folder '$folderName' of file '$fileName'")
    public void openFileActivityPage(String projectName, String folderName, String fileName) {
        String projectId = getCoreApi().getProjectByName(wrapVariableWithTestSession(projectName)).getId();
        String folderId = getCoreApi().getFolderByName(projectId, projectId, wrapVariableWithTestSession(folderName)).getId();
        String fileId = getCoreApi().getFileByName(folderId, fileName).getId();

        getFileActivityPage(projectId, folderId, fileId);
    }

    @When("{I |}click on user name '$userName' in Activity tab on open uploaded file '$filePath' in folder '$path' project '$projectName'")
    public void clickOnUserName(String userName, String filePath, String path, String projectName) {
        clickUserNameOnActivity(userName, filePath, path, projectName);
    }

    @When("{I |}click on filter button in Activity tab on open uploaded file '$filePath' in folder '$path' project '$projectName'")
    public void clickOnFilterButton(String filePath, String path, String projectName) {
        clickFilterOnActivityTab(filePath, path, projectName);
    }

    @When("{I |}set Action '$action' on Activity tab on open uploaded file '$filePath' in folder '$path' project '$projectName'")
    public void setActionActivityComboBox(String action, String filePath, String path, String projectName) {
        setActionOnActivityTab(action, filePath, path, projectName);
    }

    @When("{I |} type an userName '$userName' on Activity tab on open uploaded file '$filePath' in folder '$path' project '$projectName'")
    public void typeUserNameFilter(String userName,String filePath, String path, String projectName) {
        setUserNameOnActivityTab(userName, filePath, path, projectName);
    }

    @Given("{I |}choosed next filter on Recent Activity: action '$action' and user '$user' on file activity page")
    @When("{I |}choose next filter on Recent Activity: action '$action' and user '$user' on file activity page")
    public void chooseFilter(String action, String user) {
        AdbankFileActivityPage assetsActivityPage = getSut().getPageCreator().getAdbankLibraryAssetsActivityPage();
        AdbankFileActivityPage.FileActivityFilter dashboardActivityFilter = assetsActivityPage.new FileActivityFilter(assetsActivityPage);
        dashboardActivityFilter.chooseFilter(action, user.isEmpty() ? "" : wrapUserEmailWithTestSession(user));
    }

    @When("{I |}click on user '$userName' on file '$fileName' activity tab in project '$projectName' folder '$path'")
    public void clickUserInProjectActivities(String userName, String fileName, String projectName, String path) {
        clickUserInFileActivities(projectName, path, fileName, userName);
    }

    // | User | Logo | ActivityType | ActivityMessage |
    @Then("{I |}'$condition' see on Activity tab for file '$filePath' in folder '$path' project '$projectName' following recent user's activity : $activityTables")
    public void checkActivityTab(String condition, String filePath, String path, String projectName, ExamplesTable activityTables) {

        checkObjectActivity(condition.equalsIgnoreCase("should"), filePath, path, projectName, activityTables);
    }

    // | User | Logo | ActivityType | ActivityMessage |
    @Then("{I |} should see on Activity tab for file '$filePath' in folder '$path' project '$projectName' empty results")
    public void checkActivityTabEmpty(String condition, String filePath, String path, String projectName) {
        checkObjectActivityEmpty(filePath, path, projectName);
    }

    @Then("{I |}should see count '$count' activity on activity tab '$tabName' for file '$filePath' in folder '$path' project '$projectName'")
    public void checkCountActivities(int count, String tabName, String filePath, String path, String projectName) {
        checkCountActivitiesFileInfoPage(count, tabName, filePath, path, projectName);
    }

    @Then("I should see next title name '$titleName' on activity tab current user")
    public void checkTitleNameOnActivityTab(String titleName) {
        User user = getData().getCurrentUser();
        AdbankFileActivityPage adbankFileActivityPage = getSut().getPageCreator().getProjectFileActivityPage();
        assertThat("", titleName, equalTo(adbankFileActivityPage.getFileNameOnActivityTab(user)));
    }

    @Then("{I |}'$shouldState' see activity for user '$userName' on file '$fileName' activity tab in project '$projectName' folder '$path' page with message '$message' and value '$value'")
    public void checkActivityOnProjectFileActivityTab(String shouldState, String userName, String fileName, String projectName, String path, String message, String value) {
        checkActivityFileInfoPage(shouldState, userName, fileName, projectName, path, message, value);
    }

    @Then("{I |}'$shouldState' see the activity  on file '$fileName' activity tab in project '$projectName' folder '$path': $activityTables")
    public void checkTheActivityOnProjectFileActivityTab(String shouldState, String fileName, String projectName, String path, ExamplesTable table) {
        checkTheActivityFileInfoPage(shouldState, fileName, projectName, path, table);
    }

    @Then("{I |}'$condition' see activity where user '$userName' viewed file on current page")
    public void checkViewedFileActivity(String condition, String userName) {
        viewedActivity(condition, userName);
    }

    @Override
    public void transcodedFileActivity() {

    }

    @Override
    public void sharedFileToUserActivity(String condition, String user, String file, String userFullName) {

    }

    @Override
    public void commentedFileActivity() {

    }

    @Override
    public void uploadedFileActivity() {

    }

    @Override
    public void viewedActivity(String condition, String viewerFullName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        viewerFullName = wrapUserEmailWithTestSession(viewerFullName);
        List<String> actualActivities = getSut().getPageCreator().getProjectFileActivityPage().getActivityList();
        String expectedActivity = String.format("%s viewed file", viewerFullName);

        assertThat(actualActivities, shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
    }
}