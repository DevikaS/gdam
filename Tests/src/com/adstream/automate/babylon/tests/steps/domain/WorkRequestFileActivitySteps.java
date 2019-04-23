package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileApprovalsPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileCommentsPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileVersionHistoryPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.*;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.model.ExamplesTable;

/**
 * Created by pc on 02.12.2014.
 */
public class WorkRequestFileActivitySteps extends AbstractFileViewSteps {
    @Override
    protected Project getObjectByName(String objectName) {
        return getCoreApi().getWorkRequestByName(objectName);
    }

    @Override
    protected Project getObjectByName(String objectName, User user) {
        return getCoreApi().getWorkRequestByName(objectName);
    }

    @Override
    protected AdbankFilesInfoPage getFilesInfoPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getWorkRequestFileInfoPage(projectId, folderId, fileId);
    }

    @Override
    protected AdbankFileActivityPage getFileActivityPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getWorkRequestFileActivityPage(projectId, folderId, fileId);
    }

    @Override
    protected AdbankFileCommentsPage getFileCommentsPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getWorkRequestFileCommentsPage(projectId, folderId, fileId);
    }

    @Override
    protected AdbankFileUsageRightsPage getFileUsageRightsPage(String projectId, String folderId, String fileId) {
        return  getSut().getPageNavigator().getWorkRequestFileUsageRightsPage(projectId, folderId, fileId);
    }

    @Override
    protected AdbankFileVersionHistoryPage getFileVersionHistoryPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getWorkRequestFileVersionHistoryPage(projectId, folderId, fileId);
    }

    @Override
    protected AdbankFileApprovalsPage getFileApprovalsPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getWorkRequestFileApprovalsPage(projectId, folderId, fileId);
    }

    @Override
    protected AdbankFileAttachmentsPage getFileAttachmentsPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getWorkRequestFileAttachmentsPage(projectId, folderId, fileId);
    }
    //QA358-Frame Grabber Changes Starts
    @Override
    protected AdbankFileFramesPage getFileFramesPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getProjectFileFramesPage(projectId, folderId, fileId);
    }
    //QA358-Frame Grabber Changes Ends

    @Override
    protected AdbankProjectFileRelatedFilesPage getProjectRelatedFilesPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getWorkRequestRelativeFilesPage(projectId, folderId, fileId);
    }

    @Then("{I |}'$condition' see on Activity tab for file '$filePath' in folder '$path' work request '$projectName' following recent user's activity : $activityTables")
    public void checkActivityTab(String condition, String filePath, String path, String projectName, ExamplesTable activityTables) {
        checkObjectActivity(condition.equalsIgnoreCase("should"), filePath, path, projectName, activityTables);
    }

}
