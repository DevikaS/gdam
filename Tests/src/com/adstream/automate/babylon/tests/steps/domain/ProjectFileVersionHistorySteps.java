package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileApprovalsPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileCommentsPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileVersionHistoryPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.*;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.junit.Assert;

import java.io.File;
import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;


/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 12.12.12
 * Time: 12:41
 */
public class ProjectFileVersionHistorySteps extends AbstractFileViewSteps {

    @Override
    public Project getObjectByName(String objectName) {
        return getCoreApi().getProjectByName(objectName);
    }

    @Override
    protected AdbankProjectFileRelatedFilesPage getProjectRelatedFilesPage(String projectId, String folderId, String fileId) {
        return null;
    }

    @Override
    public Project getObjectByName(String objectName, User user) {
        return getCoreApi(user).getProjectByName(objectName);
    }

    @Override
    protected AdbankFileActivityPage getFileActivityPage(String projectId, String folderId, String fileId) {
        return null;
    }

    @Override
    protected AdbankFilesInfoPage getFilesInfoPage(String projectId, String folderId, String fileId) {
        return null;
    }

    @Override
    protected AdbankFileUsageRightsPage getFileUsageRightsPage(String projectId, String folderId, String fileId) {
        return null;
    }

    @Override
    protected AdbankFileCommentsPage getFileCommentsPage(String projectId, String folderId, String fileId) {
        return null;
    }

    @Override
    protected AdbankFileVersionHistoryPage getFileVersionHistoryPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getProjectFileVersionHistoryPage(projectId, folderId, fileId);
    }

    @Override
    protected AdbankFileApprovalsPage getFileApprovalsPage(String projectId, String folderId, String fileId) {
        return null;
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

    @Given("I am on file '$filePath' info page in folder '$path' project '$projectName' tab version history")
    @When("{I |}go to file '$filePath' info page in folder '$path' project '$projectName' tab version history")
    public void openFileVersionHistoryTab(String filePath, String path, String projectName) {
        openFileVersionHistoryPage(filePath, path, projectName);
    }

    @When("{I |}download '$type' file '$filePath' for revision '$revision' on folder '$path' project '$projectName'")
    public void downloadFile(String type, String filePath, int revision, String path, String projectName) {
        AdbankFileVersionHistoryPage adbankFileVersionHistoryPage = openFileVersionHistoryPage(filePath, path, projectName);
        if (type.equalsIgnoreCase("original")) {
            adbankFileVersionHistoryPage.clickDownloadOriginalButton(revision);
        } else if (type.equalsIgnoreCase("proxy")) {
            adbankFileVersionHistoryPage.clickDownloadProxyButton(revision);
        } else {
            throw new IllegalArgumentException(String.format("Unknown download type: '%s'", type));
        }
        Common.sleep(5000);
    }

    @Then("{I |}'$condition' see download original link on the current file version history tab")
    public void checkVisibilityOfDOLink(String condition) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AdbankFileVersionHistoryPage fileVersionHistoryPage = getSut().getPageCreator().getProjectFileVersionHistoryPage();
        assertThat(fileVersionHistoryPage.isDownloadOriginalLinkVisible(), equalTo(shouldState));
    }

    //| Revision | Name | Agency |
    @Then("{I |}should see the following details on file '$filePath' version history page in folder '$path' project '$projectName': $fields")
    public void checkFileVersionInfo(String filePath, String path, String projectName, ExamplesTable examplesTable) {
        openFileVersionHistoryPage(new File(filePath).getName(), path, projectName);

        for (int i = 0; i < examplesTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(examplesTable, i);
            if ((row.get("Revision") == null) || (row.get("Name") == null) || (row.get("Agency") == null)) {
                Assert.fail("Please define mandatory parameters!");
            }
            checkVersionInfo(Integer.parseInt(row.get("Revision")), row.get("Name"), row.get("Agency"));
        }
    }

    @When("{I |}click on revision '$revision' from version history page")
    public void clickRevisionButton(String revision) {
        getSut().getPageCreator().getProjectFileVersionHistoryPage().clickOnRevisionButton(revision);
    }

    @Then("{I |}should see preview for revision '$revision' on file '$filePath' version history page in folder '$path' project '$projectName'")
    public void checkFilePreviewForRevision(int revision, String filePath, String path, String projectName) {
        checkPreviewForRevision(filePath, path, projectName, revision);
    }

    @Then("{I |}should see preview for revision '$revision' on file '$filePath' version history page in folder '$path' project '$projectName' on opening")
    public void checkFilePreviewForRevisiononOpen(int revision, String filePath, String path, String projectName) {
        OpenAndcheckPreviewForRevision(filePath, path, projectName, revision);
    }

    @Then("{I |}'$shouldState' see Download Original link for version '$version' for file '$filePath' version history page in folder '$path' project '$projectName'")
    public void checkVisibilityDownloadOriginalLinkProjectsFileForRevision(String shouldState, int version, String filepath, String path, String projectName) {
        checkVisibilityDownloadOriginalLinkForRevision(shouldState, filepath, path, projectName, version);
    }

    @Then("{I |}'$shouldState' see Download Proxy link for version '$version' for file '$filePath' version history page in folder '$path' project '$projectName'")
    public void checkVisibilityDownloadProxyLikProjectsFileForRevision(String shouldState, int version, String filepath, String path, String projectName) {
        checkVisibilityDownloadProxyLinkForRevision(shouldState, filepath, path, projectName, version);
    }

    @Then("{I |}'$condition' see revision '$revision' on file '$filePath' version history page in folder '$path' project '$projectName' marked as Current")
    public void checkThaRevisionMarkedAsCurrent(String condition, int revision, String filePath, String path, String projectName) {
        checkThatRevisionMarkedAsCurrent(condition, filePath, path, projectName, revision);
    }
    @Then("{I |}'$condition' see revision '$revision' on file '$filePath' version history page in folder '$path' {client | shared} project '$projectName' marked as Current")
    public void checkThaClientFileRevisionMarkedAsCurrent(String condition, int revision, String filePath, String path, String projectName) {
        checkThatClientFileRevisionMarkedAsCurrent(condition, filePath, path, projectName, revision);
    }

    @Then("I should see next title name '$titleName' on version history tab")
    public void checkTitleNameOnVersionHistoryTab(String titleName) {
        AdbankFileVersionHistoryPage page = getSut().getPageCreator().getProjectFileVersionHistoryPage();
        assertThat("", page.getFileTitleOnTheVersionHistorePage().contains(titleName), equalTo(true));
    }

    @Then("I should see next version '$version' on version history tab")
    public void checkVersionOnVersionHistoryTab(String version) {
        AdbankFileVersionHistoryPage page = getSut().getPageCreator().getProjectFileVersionHistoryPage();
        assertThat("",page.getVersionOnTheVersionHistoryPage(), equalTo(version));
    }

    @Then("{I |}'$condition' see approval status message '$message' for revision '$revision' on file '$filePath' version history page in folder '$path' project '$projectName'")
    public void checkApprovalStatusMessage(String condition, String message, int revision, String filePath, String path, String projectName) {
        super.checkApprovalStatusMessage(condition, message, filePath, path, projectName, revision);
    }
}
