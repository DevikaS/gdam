package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.PageNavigator;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AdbankFilesPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AdbankFoldersTree;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.JumpLoaderPage;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import static org.hamcrest.MatcherAssert.assertThat;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 30.07.12
 * Time: 11:27

 */
public class ProjectFolderTrashSteps  extends AbstractFolderSteps {


    @Override
    protected AdbankFoldersTree getFoldersTree(String projectId, String folderId) {
        PageNavigator pageFactory = getSut().getPageNavigator();
        if (folderId == null) {
            return pageFactory.getProjectTrashPage(projectId, "");
        } else {
            return pageFactory.getProjectTrashPage(projectId, folderId);
        }
    }

    public Project getObjectByName(String objectName) {
        return getCoreApi().getProjectByName(objectName);
    }

    public Project getObjectByName(String objectName, User user) {
        return getCoreApi(user).getProjectByName(objectName);
    }

    @Override
    protected JumpLoaderPage getFilesUploadPage(String projectId, String folderId) {
        return null;
    }

    @Override
    protected AdbankFilesPage getFilesPage(String projectId, String folderId) {
        return getSut().getPageNavigator().getProjectTrashPage(projectId, folderId);
    }

    @Override
    protected AdbankFilesPage getFilesPage() {
        return getSut().getPageCreator().getProjectTrashPage();
    }

    @Given("{I |}am on project '$projectName' folder '$path' trash bin page")
    @When("{I |}go to project '$projectName' folder '$path' trash bin page")
    public void goToProjectFolderTrashPage(String projectName, String path) {
        getTrashBinFilesPage(projectName, path);
    }

    @Then("{I |}should see following folders in project '$projectName' in trash bin: $foldersTable")
    public void checkProjectFolderInTrash(String projectName, ExamplesTable foldersTable) {
        checkFolders(projectName, foldersTable);
    }

    @Then("{I |}should see following folder '$folderName' in project '$projectName' in trash bin")
    public void checkProjectFolderInTrash(String folderName, String projectName) {
        checkFolder("", folderName, projectName);
    }

    @Then("{I |} should see following count '$count' of total files in project trash")
    public void checkCountOfTotalFiles(int count) {
        int actualState = getSut().getPageCreator().getProjectFilesPage().getCountOfTotalProject();
        assertThat(String.format("Wrong number of files in project trash: %d, but should be %d", actualState, count), count == actualState);
    }

    @Then("I '$condition' see the following files in the project '$projectName' trash bin in folder '$path': $fileNames")
    public void checkTrashBin(String condition, String projectName, String path, ExamplesTable fileNames){
        checkTrashBinFolderFiles(condition, projectName, path, fileNames);
    }

    @Then("{I |}should see sorting type '$sortingType' is selected on project '$projectName' trash bin page")
    public void checkSortingTypeTextProjectTrashBinPage(String sortingType, String projectName) {
        checkSelectedSortingTypeTextTrashBin(sortingType, projectName);
    }

    @Then("{I |}should see sorting files by '$sortingType' on project '$projectName' trash bin page")
    public void checkSortingFilesInProjectTrashBin(String sortingType, String projectName) {
        checkFilesSortingTrashBin(sortingType, projectName);
    }

    @When("{I |}restore file '$fileName' from project '$projectName' trash bin to folder '$path'")
    public void restoreFileFromProjectTrashBin(String fileName, String projectName, String path) {
        restoreFileFromTrashBin(fileName, projectName, path);
        Common.sleep(1000);
    }

    @Then("{I |}'$condition' see the following files in the project '$projectName' trash bin: $fileNames")
    public void checkTrashBin(String condition, String projectName, ExamplesTable fileNames) {
        checkTrashBinFiles(condition, projectName, fileNames);
    }

    @When("{I |}restore multiple files from project '$projectName' trash bin page to folder '$path'")
    public void restoreMultipleFilesFromProjectTrashBin(String projectName, String path) {
        restoreMultipleFilesFromTrashBin(projectName, path);
        Common.sleep(1000);
    }

    @When("{I |}cancel restoring file '$fileName' from project '$projectName' trash bin to folder '$path'")
    public void cancelRestoringFileFromProjectTrashBin(String fileName, String projectName, String path) {
        cancelRestoringFileFromTrashBin(fileName, projectName, path);
    }

    @When("{I |}close by cross button Select folder restore popup while restoring file '$fileName' from project '$projectName' trash bin to folder '$path'")
    public void closeByCrossPopUpOnProjectTrashBin(String fileName, String projectName, String path) {
        closeByCrossTrashBinRestoreFilePopUp(fileName, projectName, path);
    }

    @When("{I |}click restore button for file '$fileName' from project '$projectName' trash bin page")
    public void clickRestoreButtonForFile(String fileName, String projectName) {
        clickRestoreFileTrashBin(fileName, projectName);
    }

    @Then("{I |}'$shouldState' see folder '$path' on Select folder restore popup when restore file '$fileName' from project '$projectName' trash bin page")
    public void checkIsFolderExistInPopUpOnProjectTrashBin(String shouldState, String path, String fileName, String projectName) {
        checkFoldersExistTrashBinRestorePopUp(shouldState, path, fileName, projectName);
    }

    @Then("{I |}'$shouldState' see folder '$path' on Select folder restore popup when restore folder '$toFolderPath' from project '$projectName' trash bin page")
    public void checkIsFolderExistOnFolderRestorePopUp(String shouldState, String toFolderPath, String path, String projectName) {
        checkFoldersExistTrashBinRestoreFolderPopUp(shouldState, toFolderPath, path, projectName);
    }

    // enabledFilters comma separated
    // possible values: IMAGE, AUDIO, VIDEO, PRINT, DIGITAL
    @When("{I |}select media type filters '$enabledFilters' on project '$projectName' folder '$path' trash bin page")
    public void selectFilterFilesProjectTrashBin(String enabledFilters, String projectName, String path) {
        enableMediaTypeFilterTrashBin(enabledFilters, projectName , path);
    }

    @Then("I '$condition' see that the following files are selected in the project trash bin: $fileNames")
    public void checkSelectedFiles(String condition, ExamplesTable fileNames) {
        checkSelectedFilesTrashBin(condition, fileNames);
    }

    @Then("I '$condition' see quantity '$quantity' files with name '$fileName' in the project trash bin")
    public void checkQuantityFileWithFileNameInTheTrashBin(String condition, int quantity, String fileName) {
        checkCountFileByFileNameTrashBin(condition, quantity, fileName);
    }

    // fileNames comma separated
    @Then("{I |}should only see following files '$fileNames' on project '$projectName' folder '$path' trash bin page")
    public void checkProjectTrashBin(String fileNames, String projectName, String path) {
       checkTrashBinFiles(fileNames, projectName, path);
    }

    @Then("{I |}'$shouldState' see Media Sub Type is greyed out on project '$projectName' folder '$path' trash bin page")
    public void checkMediaSubTypeState(String shouldState, String projectName, String path) {
        checkMediaSubTypeDisabled(shouldState, projectName, path);
    }

    @When("{I |}select media subtype filter '$mediaSubType' on project '$projectName' folder '$path' trash bin page")
    public void selectProjectMediaSubType(String mediaSubType, String projectName, String path) {
        selectMediaSubTypeFilterTrashBin(projectName, path, mediaSubType);
    }

    @When("{I |}restore folder '$path' from project '$projectName' trash bin page to folder '$toFolderPath'")
    public void restoreFolderFromProjectTrashBin(String path, String projectName, String toFolderPath) {
        restoreFolderFromTrashBin(path, projectName, toFolderPath);
    }

    @Then("{I |}'$shouldState' see '$path' folder on '$projectName' project trash bin page")
    public void checkProjectFolderTrashBin(String shouldState, String path, String projectName) {
        checkFolderTrashBin(shouldState, path, projectName);
    }

    @Then("{I |}'$shouldState' see following folders on project '$projectName' trash bin page : $foldersTable")
    public void checkProjectFoldersTrashBin(String shouldState, String projectName, ExamplesTable foldersTable ) {
        checkFoldersTrashBin(shouldState, projectName, foldersTable);
    }

    @When("{I |}close by cross button Select folder restore popup while restoring folder '$path' from project '$projectName' trash bin page to folder '$toFolderPath'")
    public void closeByCrossRestoreFolderFromProjectTrashBin(String path, String projectName, String toFolderPath) {
        closeByCrossTrashBinRestoreFolderPopUp(path, projectName, toFolderPath);
    }

    @When("{I |}cancel restoring folder '$path' from project '$projectName' trash bin page to folder '$toFolderPath'")
    public void cancelRestoringFolderFromProjectTrashBin(String path, String projectName, String toFolderPath) {
        cancelRestoreFolderFromTrashBin(path, projectName, toFolderPath);
    }

    @Then("{I |}click Restore button from popup menu of folder '$path' in project '$projectName' trash bin page")
    public void clickRestoreForProjectFolderTrashBin(String path, String projectName) {
        clickRestoreForFolder(path, projectName);
    }
}