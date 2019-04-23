package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.PageNavigator;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankProjectFilesPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankWorkRequestFilesPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.*;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.util.Arrays;

/**
 * User: lynda-k
 * Date: 19.06.14
 * Time: 12:38
 */
public class WorkRequestFolderSteps extends AbstractFolderSteps {
    @Override
    protected AdbankFoldersTree getFoldersTree(String workRequestId, String folderId) {
        PageNavigator pageFactory = getSut().getPageNavigator();
        if (folderId == null) {
            return pageFactory.getWorkRequestOverviewPage(workRequestId);
        } else {
            return pageFactory.getWorkRequestFilesPage(workRequestId, folderId);
        }
    }

    public Project getObjectByName(String objectName) {
        return getCoreApi().getWorkRequestByName(objectName);
    }

    public Project getObjectByName(String objectName, User user) {
        return getCoreApi(user).getWorkRequestByName(objectName);
    }

    protected JumpLoaderPage getFilesUploadPage(String workRequestId, String folderId) {
        return getSut().getPageNavigator().getProjectFilesUploadPage(workRequestId, folderId);
    }

    protected AdbankFilesPage getFilesPage(String workRequestId, String folderId) {
        return getSut().getPageNavigator().getWorkRequestFilesPage(workRequestId, folderId);
    }

    protected AdbankFilesPage getFilesPage() {
        return getSut().getPageCreator().getWorkRequestFilesPage();
    }

    @Given("{I am |}on work request '$workRequestName' folder '$path' page")
    @When("{I |}go to work request '$workRequestName' folder '$path' page")
    public AdbankFoldersTree openProjectFolderPage(String workRequestName, String path) {
        return openObjectFolderPage(workRequestName, path);
    }

    @Given("{I |}waited while transcoding is finished on Work request '$workRequest' in folder '$path' for '$fileName' file")
    @When("{I |}wait while transcoding is finished on Work request '$workRequest' in folder '$path' for '$fileName' file")
    public void waitForProjectFileTranscodingFinished(String projectName, String path, String fileName) {
        waitForFileSpecAvailableInSpecificRevision(projectName, path, fileName, -1);
    }

    @Given("{I |}clicked on Want to copy files to another Work request link on move/copy file '$fileName' popup")
    @When("{I |}click on Want to copy files to another Work request link on move/copy file '$fileName' popup")
    public void clickWantToCopyFilesToAnotherProjectLinkOnMoveFilePopup(String fileName) {
        super.clickWantToCopyFilesToAnotherProjectLinkOnMoveFilePopup(fileName);
    }

    @Given("{I |}moved folder '$movedFolder' in folder '$parentFolder' in work request '$workRequestName'")
    @When("{I |}move folder '$copiedFolder' in folder '$parentFolder' in work request '$workRequestName'")
    public void moveFolderToAnotherFolderInWorkRequest(String movedFolder, String parentFolder, String workRequestName) {
        String projectId = getObjectByName(wrapVariableWithTestSession(workRequestName)).getId();
        String copiedFolderId = getCoreApi().getFolderByName(projectId, projectId, wrapVariableWithTestSession(movedFolder)).getId();
        String parentFolderId = getCoreApi().getFolderByName(projectId, projectId, wrapVariableWithTestSession(parentFolder)).getId();

        getCoreApi().moveFolder(Arrays.asList(copiedFolderId), parentFolderId, false);
    }

    @Given("{I |}deleted file '$fileName' in Work request '$projectName' folder '$path'")
    @When("{I |}delete file '$fileName' in Work request '$projectName' folder '$path'")
    public void deleteProjectFile(String fileName, String projectName, String path) {
        deleteFile(projectName, path, fileName);
    }

    @Given("{I |}uploaded '$fileName' file into '$path' folder for '$workRequest' work request")
    @When("{I |}upload '$fileName' file into '$path' folder for '$workRequest' work request")
    public void createProjectFile(String fileName, String path, String workRequest) {
        createFile(fileName, path, workRequest);
    }

    @Given("{I |}created '$path' folder for work request '$workRequestName'")
    @When("{I |}create '$path' folder for work request '$workRequestName'")
    public Content createProjectFolderOverCore(String path, String workRequestName) {
        return createFolderOverCoreApi(path, workRequestName);
    }

    @Given("{I |}selected file '$fileName' on work request files page")
    @When("{I |}select file '$fileName' on work request files page")
    public void selectFileOnProjectFilesPage(String fileName) {
        AdbankWorkRequestFilesPage page = getSut().getPageCreator().getWorkRequestFilesPage();
        for (String fN : fileName.split(",")) page.selectFileByFileName(fN);
    }

    @Given("{I |}added file '$fileName' from library on work request '$workRequest' folder '$path' files page")
    @When("{I |}add file '$fileName' from library on work request '$workRequest' folder '$path' files page")
    public void addFileFromLibrary(String fileName, String workRequest, String path) {
        super.addFileFromLibrary(workRequest, path, fileName);
    }

    @Then("{I |}'$condition' see file '$fileName' on work request '$workRequestName' folder '$folderName' files page")
    public void checkFileOnThePageAfterDelete(String condition, String fileName, String workRequestName, String folderName) {
        checkFiles(condition, fileName, workRequestName, folderName);
    }

    @Then("{I |}'$shouldState' see Download link for '$linkType' type on Download popup for work request '$workRequestName' folder '$path'")
    public void checkVisibilityDownloadLink(String shouldState, String linkType, String workRequestName, String path) {
        super.checkVisibilityDownloadLink(shouldState, workRequestName, path, linkType);
    }

    @Then("{I |}'$condition' see following folders in '$workRequestName' work request: $foldersTable")
    public void checkWorkRequestFolders(String condition, String workRequestName, ExamplesTable foldersTable) {
        checkFolders(condition, workRequestName, foldersTable);
    }

    @Given("{I |}selected folder '$fileName' on work request files page")
    @When("{I |}select folder '$fileName' on work request files page")
    public void selectProjectsOnProjectFilesPage(String folderName) {
        AdbankWorkRequestFilesPage page = getSut().getPageCreator().getWorkRequestFilesPage();
        String[] fileNames = folderName.split(",");
        for (String fN : fileNames) {
            String folder = wrapVariableWithTestSession(fN).replace("/", "");

            if (!page.isFolderSelected(folder)) {
                page.selectFileByFileName(folder);
            }
        }
    }

    @Given("{I |}opened share popup in work request '$projectName' for folder '$folderName' from root work request")
    @When("{I |}open share popup in work request '$projectName' for folder '$folderName' from root work request")
    public void openSharePopUpFromRootProject(String projectName, String folderName) {
        openProjectFolderPage(projectName, "root");
        selectProjectsOnProjectFilesPage(folderName);
        clickShareUsingShareButton();
    }

    private void clickShareUsingShareButton(){
        AdbankProjectFilesPage adbankProjectFilesPage = getSut().getPageCreator().getProjectFilesPage();
        adbankProjectFilesPage.clickShareFolderButton();
    }

    @Given("{I |}waited while preview is available in folder '$path' on work request '$wrName' files page")
    @When("{I |}wait while preview is available in folder '$path' on work request '$wrName' files page")
    public void waitForWRFilesPreviewAvailable(String path, String wrName) {
        waitForPreviewAvailable(wrName, path);
    }

}