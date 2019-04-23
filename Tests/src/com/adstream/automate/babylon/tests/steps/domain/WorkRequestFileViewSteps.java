package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileApprovalsPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileCommentsPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileVersionHistoryPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.*;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;

import java.io.File;

/**
 * User: lynda-k
 * Date: 19.06.14
 * Time: 15:06
 */
public class WorkRequestFileViewSteps extends AbstractFileViewSteps {

    @Override
    public Project getObjectByName(String objectName) {
        return getCoreApi().getWorkRequestByName(objectName);
    }

    @Override
    public Project getObjectByName(String objectName, User user) {
        return getCoreApi(user).getWorkRequestByName(objectName);
    }

    @Override
    protected AdbankFileActivityPage getFileActivityPage(String workRequestId, String folderId, String fileId) {
        return getSut().getPageNavigator().getWorkRequestFileActivityPage(workRequestId, folderId, fileId);
    }

    @Override
    protected AdbankFilesInfoPage getFilesInfoPage(String workRequestId, String folderId, String fileId) {
        return getSut().getPageNavigator().getWorkRequestFileInfoPage(workRequestId, folderId, fileId);
    }

    @Override
    protected AdbankFileCommentsPage getFileCommentsPage(String workRequestId, String folderId, String fileId) {
        return null;
    }

    @Override
    protected AdbankFileUsageRightsPage getFileUsageRightsPage(String workRequestId, String folderId, String fileId) {
        return null;
    }

    @Override
    protected AdbankFileVersionHistoryPage getFileVersionHistoryPage(String workRequestId, String folderId, String fileId) {
        return null;
    }

    @Override
    protected AdbankFileApprovalsPage getFileApprovalsPage(String workRequestId, String folderId, String fileId) {
        return null;
    }

    @Override
    protected AdbankFileAttachmentsPage getFileAttachmentsPage(String workRequestId, String folderId, String fileId) {
        return null;
    }

    //QA358-Frame Grabber Changes Starts
    @Override
    protected AdbankFileFramesPage getFileFramesPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getProjectFileFramesPage(projectId, folderId, fileId);
    }
    //QA358-Frame Grabber Changes Ends

    @Override
    protected AdbankProjectFileRelatedFilesPage getProjectRelatedFilesPage(String workRequestId, String folderId, String fileId) {
        return null;
    }

    @Given("{I am |}on file '$filePath' info page in folder '$path' work request '$workRequestName'")
    @When("{I |}go to file '$filePath' info page in folder '$path' work request '$workRequestName'")
    public AdbankFilesInfoPage openFileInfo(String filePath, String path, String workRequestName) {
        return openFileInfoPage(new File(filePath).getName(), path, workRequestName);
    }

    @Then("{I |}'$condition' see Download link for '$linkType' type on Download popup on file '$fileName' info page for work request '$workRequestName' folder '$path'")
    public void checkDownloadLinksOnFileDownloadPopup(String condition, String linkType, String fileName, String workRequestName, String path) {
        super.checkDownloadLinksOnFileDownloadPopup(condition, linkType, fileName, path, workRequestName);
    }

    @Then("{I |}'$condition' see Download link for '$linkType' type on file '$fileName' info page for work request '$workRequestName' folder '$path'")
    public void checkDownloadLinks(String condition, String linkType, String fileName, String workRequestName, String path) {
        super.checkDownloadLinks(condition, linkType, fileName, path, workRequestName);
    }

    @Then("{I |}'$shouldState' see Download Original button on file '$filePath' info page in folder '$path' work request '$workRequestName'")
    public void checkVisibilityDownloadOriginalBtnProjectsFile(String shouldState, String filePath, String path, String workRequestName) {
        checkVisibilityDownloadOriginalBtn(shouldState, filePath, path, workRequestName);
    }
}