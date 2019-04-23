package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.PageNavigator;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankWorkRequestTemplateFilesPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AdbankFilesPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AdbankFoldersTree;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.JumpLoaderPage;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

/**
 * User: lynda-k
 * Date: 19.06.14
 * Time: 12:38
 */
public class WorkRequestTemplateFolderSteps extends AbstractFolderSteps {
    @Override
    protected AdbankFoldersTree getFoldersTree(String workRequestTemplateId, String folderId) {
        PageNavigator pageFactory = getSut().getPageNavigator();
        return (folderId == null)
                ? pageFactory.getWorkRequestTemplateOverviewPage(workRequestTemplateId)
                : pageFactory.getWorkRequestTemplateFilesPage(workRequestTemplateId, folderId);
    }

    public Project getObjectByName(String objectName) {
        return getCoreApi().getWorkRequestTemplateByName(objectName);
    }

    public Project getObjectByName(String objectName, User user) {
        return getCoreApi(user).getWorkRequestTemplateByName(objectName);
    }

    protected JumpLoaderPage getFilesUploadPage(String workRequestTemplateId, String folderId) {
        return getSut().getPageNavigator().getProjectFilesUploadPage(workRequestTemplateId, folderId);
    }

    protected AdbankFilesPage getFilesPage(String workRequestTemplateId, String folderId) {
        return getSut().getPageNavigator().getWorkRequestTemplateFilesPage(workRequestTemplateId, folderId);
    }

    protected AdbankFilesPage getFilesPage() {
        return getSut().getPageCreator().getWorkRequestTemplateFilesPage();
    }

    @Given("I am on work request template '$workRequestTemplateName' files page")
    @When("{I |}go to work request template '$workRequestTemplateName' files page")
    public void openWorkRequestTemplateFilesPage(String workRequestTemplateName) {
        openObjectFilesPage(workRequestTemplateName);
    }

    @Given("{I am |}on work request template '$workRequestTemplateName' folder '$path' page")
    @When("{I |}go to work request template '$workRequestTemplateName' folder '$path' page")
    public AdbankFoldersTree openProjectFolderPage(String workRequestTemplateName, String path) {
        return openObjectFolderPage(workRequestTemplateName, path);
    }

    @Given("{I |}waited while transcoding is finished on Work request template '$workRequestTemplate' in folder '$path' for '$fileName' file")
    @When("{I |}wait while transcoding is finished on Work request template '$workRequestTemplate' in folder '$path' for '$fileName' file")
    public void waitForProjectFileTranscodingFinished(String projectName, String path, String fileName) {
        waitForFileSpecAvailableInSpecificRevision(projectName, path, fileName, -1);
    }

    @Given("{I |}clicked on Want to copy files to another Work request template link on move/copy file '$fileName' popup")
    @When("{I |}click on Want to copy files to another Work request template link on move/copy file '$fileName' popup")
    public void clickWantToCopyFilesToAnotherProjectLinkOnMoveFilePopup(String fileName) {
        super.clickWantToCopyFilesToAnotherProjectLinkOnMoveFilePopup(fileName);
    }

    @Given("{I |}deleted file '$fileName' in Work request template '$projectName' folder '$path'")
    @When("{I |}delete file '$fileName' in Work request template '$projectName' folder '$path'")
    public void deleteProjectFile(String fileName, String projectName, String path) {
        deleteFile(projectName, path, fileName);
    }

    @Given("{I |}uploaded '$fileName' file into '$path' folder for '$workRequestTemplate' work request template")
    @When("{I |}upload '$fileName' file into '$path' folder for '$workRequestTemplate' work request template")
    public void createProjectFile(String fileName, String path, String workRequestTemplate) {
        createFile(fileName, path, workRequestTemplate);
    }

    @Given("{I |}created '$path' folder for work request template '$workRequestTemplateName'")
    @When("{I |}create '$path' folder for work request template '$workRequestTemplateName'")
    public Content createProjectFolderOverCore(String path, String workRequestTemplateName) {
        return createFolderOverCoreApi(path, workRequestTemplateName);
    }
    @Given("{I |}selected file '$fileName' on work request template files page")
    @When("{I |}select file '$fileName' on work request template files page")
    public void selectFileOnProjectFilesPage(String fileName) {
        AdbankWorkRequestTemplateFilesPage page = getSut().getPageCreator().getWorkRequestTemplateFilesPage();
        for (String fN : fileName.split(",")) page.selectFileByFileName(fN);
    }

    @When("{I |}create '$path' folder in '$workRequestTemplateName' Work Request Template")
    public void createTemplateFolder(String path, String workRequestTemplateName) {
        createFolder(path, workRequestTemplateName);
    }


    @Then("{I |}'$condition' see file '$fileName' on work request template '$workRequestTemplateName' folder '$folderName' files page")
    public void checkFileOnThePageAfterDelete(String condition, String fileName, String workRequestTemplateName, String folderName) {
        checkFiles(condition, fileName, workRequestTemplateName, folderName);
    }

    @Then("{I |}'$shouldState' see Download link for '$linkType' type on Download popup for work request template '$workRequestTemplateName' folder '$path'")
    public void checkVisibilityDownloadLink(String shouldState, String linkType, String workRequestTemplateName, String path) {
        super.checkVisibilityDownloadLink(shouldState, workRequestTemplateName, path, linkType);
    }

    @Then("{I |}'$condition' see following folders in '$workRequestTemplateName' work request template: $foldersTable")
    public void checkWorkRequestTemplateFolders(String condition, String workRequestTemplateName, ExamplesTable foldersTable) {
        checkFolders(condition, workRequestTemplateName, foldersTable);
    }

    @Then("{I |}'$shouldSee' see '$path' folder in '$workRequestTemplateName' work request template")
    public void checkProjectFolder(String shouldSee, String path, String workRequestTemplateName) {
        checkFolder(shouldSee, path, workRequestTemplateName);
    }

}