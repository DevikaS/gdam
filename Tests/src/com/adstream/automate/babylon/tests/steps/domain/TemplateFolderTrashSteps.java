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

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 31.07.12
 * Time: 12:50
 */
public class TemplateFolderTrashSteps  extends AbstractFolderSteps {
    @Override
    protected AdbankFoldersTree getFoldersTree(String templateId, String folderId) {
        PageNavigator pageFactory = getSut().getPageNavigator();
        if (folderId == null) {
            return pageFactory.getTemplateTrashPage(templateId, "");
        } else {
            return pageFactory.getTemplateTrashPage(templateId, folderId);
        }
    }

    @Override
    protected Project getObjectByName(String objectName) {
        return getCoreApi().getTemplateByName(objectName);
    }

    @Override
    protected Project getObjectByName(String objectName, User user) {
        return getCoreApi(user).getTemplateByName(objectName);
    }

    @Override
    protected JumpLoaderPage getFilesUploadPage(String templateId, String folderId) {
        return null;
    }

    @Override
    protected AdbankFilesPage getFilesPage(String templateId, String folderId) {
        return getSut().getPageNavigator().getTemplateTrashPage(templateId, folderId);
    }

    @Override
    protected AdbankFilesPage getFilesPage() {
        return getSut().getPageCreator().getTemplateTrashPage();
    }

    @Given("{I |}am on template '$templateName' folder '$path' trash bin page")
    @When("{I |}go to template '$templateName' folder '$path' trash bin page")
    public void goToTemplateFolderTrashPage(String templateName, String path) {
        getTrashBinFilesPage(templateName, path);
    }

    @Then("{I |}should see following folders in template '$templateName' in trash bin: $foldersTable")
    public void checkProjectFolderInTrash(String templateName, ExamplesTable foldersTable) {
        checkFolders(templateName, foldersTable);
    }

    @Then("I '$condition' see the following files in the template '$projectName' trash bin in folder '$path': $fileNames")
    public void checkTrashBin(String condition, String projectName, String path, ExamplesTable fileNames){
        checkTrashBinFolderFiles(condition, projectName, path, fileNames);
    }

    @Then("{I |}should see sorting type '$sortingType' is selected on template '$templateName' trash bin page")
    public void checkSortingTypeTextProjectTrashBinPage(String sortingType, String templateName) {
        checkSelectedSortingTypeTextTrashBin(sortingType, templateName);
    }

    @Then("{I |}should see sorting files by '$sortingType' on template '$templateName' trash bin page")
    public void checkSortingFilesInTemplateTrashBin(String sortingType, String templateName) {
        checkFilesSortingTrashBin(sortingType, templateName);
    }

    @Then("{I |}'$condition' see the following files in the template '$templateName' trash bin: $fileNames")
    public void checkTrashBin(String condition, String templateName, ExamplesTable fileNames) {
        checkTrashBinFiles(condition, templateName, fileNames);
    }

    @When("{I |}restore file '$fileName' from template '$templateName' trash bin to folder '$path'")
    public void restoreFileFromTemplateTrashBin(String fileName, String templateName, String path) {
        restoreFileFromTrashBin(fileName, templateName, path);
        Common.sleep(500);
    }

    @When("{I |}restore multiple files from template '$templateName' trash bin page to folder '$path'")
    public void restoreMultipleFilesFromTemplateTrashBin(String templateName, String path) {
        restoreMultipleFilesFromTrashBin(templateName, path);
    }

    @When("{I |}close by cross button Select folder restore popup while restoring file '$fileName' from template '$templateName' trash bin to folder '$path'")
    public void closeByCrossPopUpOnTemplateTrashBin(String fileName, String templateName, String path) {
        closeByCrossTrashBinRestoreFilePopUp(fileName, templateName, path);
    }

    @When("{I |}cancel restoring file '$fileName' from template '$templateName' trash bin to folder '$path'")
    public void cancelRestoringFileFromTemplateTrashBin(String fileName, String templateName, String path) {
        cancelRestoringFileFromTrashBin(fileName, templateName, path);
    }

    @Then("{I |}'$shouldState' see folder '$path' on Select folder restore popup when restore file '$fileName' from template '$templateName' trash bin page")
    public void checkIsFolderExistInPopUpOnTemplateTrashBin(String shouldState, String path, String fileName, String templateName) {
        checkFoldersExistTrashBinRestorePopUp(shouldState, path, fileName, templateName);
    }

    @Then("{I |}'$shouldState' see folder '$path' on Select folder restore popup when restore folder '$toFolderPath' from template '$templateName' trash bin page")
    public void checkIsFolderExistOnFolderRestorePopUp(String shouldState, String toFolderPath, String path, String templateName) {
        checkFoldersExistTrashBinRestoreFolderPopUp(shouldState, toFolderPath, path, templateName);
    }

    @Then("I '$condition' see that the following files are selected in the template trash bin: $fileNames")
    public void checkSelectedFiles(String condition, ExamplesTable fileNames) {
        checkSelectedFilesTrashBin(condition, fileNames);
    }

    @Then("I '$condition' see quantity '$quantity' files with name '$fileName' in the template trash bin")
    public void checkQuantityFileWithFileNameInTheTrashBin(String condition, int quantity, String fileName) {
        checkCountFileByFileNameTrashBin(condition, quantity, fileName);
    }

    // enabledFilters comma separated
    // possible values: IMAGE, AUDIO, VIDEO, PRINT, DIGITAL
    @When("{I |}select media type filters '$enabledFilters' on template '$templateName' folder '$path' trash bin page")
    public void selectFilterFilesTemplateTrashBin(String enabledFilters, String templateName, String path) {
        enableMediaTypeFilterTrashBin(enabledFilters, templateName , path);
    }

    // fileNames comma separated
    @Then("{I |}should only see following files '$fileNames' on template '$templateName' folder '$path' trash bin page")
    public void checkTemplateTrashBin(String fileNames, String templateName, String path) {
        checkTrashBinFiles(fileNames, templateName, path);
    }

    @Then("{I |}'$shouldState' see Media Sub Type is greyed out on template '$templateName' folder '$path' trash bin page")
    public void checkMediaSubTypeState(String shouldState, String templateName, String path) {
        checkMediaSubTypeDisabled(shouldState, templateName, path);
    }

    @When("{I |}select media subtype filter '$mediaSubType' on template '$templateName' folder '$path' trash bin page")
    public void selectTemplateMediaSubType(String mediaSubType, String templateName, String path) {
        selectMediaSubTypeFilterTrashBin(templateName, path, mediaSubType);
    }

    @When("{I |}restore folder '$path' from template '$templateName' trash bin page to folder '$toFolderPath'")
    public void restoreFolderFromTemplateTrashBin(String path, String templateName, String toFolderPath) {
        restoreFolderFromTrashBin(path, templateName, toFolderPath);
    }

    @Then("{I |}'$shouldState' see '$path' folder on '$templateName' template trash bin page")
    public void checkTemplateFolderTrashBin(String shouldState, String path, String templateName) {
        checkFolderTrashBin(shouldState, path, templateName);
    }

    @Then("{I |}'$shouldState' see following folders on template '$templateName' trash bin page : $foldersTable")
    public void checkTemplateFoldersTrashBin(String shouldState, String templateName, ExamplesTable foldersTable ) {
        checkFoldersTrashBin(shouldState, templateName, foldersTable);
    }

    @When("{I |}close by cross button Select folder restore popup while restoring folder '$path' from template '$templateName' trash bin page to folder '$toFolderPath'")
    public void closeByCrossRestoreFolderFromTemplateTrashBin(String path, String templateName, String toFolderPath) {
        closeByCrossTrashBinRestoreFolderPopUp(path, templateName, toFolderPath);
    }

    @When("{I |}cancel restoring folder '$path' from template '$templateName' trash bin page to folder '$toFolderPath'")
    public void cancelRestoringFolderFromTemplateTrashBin(String path, String templateName, String toFolderPath) {
        cancelRestoreFolderFromTrashBin(path, templateName, toFolderPath);
    }

    @Then("{I |}click Restore button from popup menu of folder '$path' in template '$templateName' trash bin page")
    public void clickRestoreForTemplateFolderTrashBin(String path, String templateName) {
        clickRestoreForFolder(path, templateName);
    }
}