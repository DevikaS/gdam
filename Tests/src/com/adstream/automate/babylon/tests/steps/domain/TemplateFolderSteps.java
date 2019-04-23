package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.PageNavigator;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankTemplateFilesPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankTemplateFilesUploadPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.*;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.jbehave.core.steps.Parameters;
import org.junit.Assert;
import org.openqa.selenium.WebElement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;

/**
 * User: ruslan.semerenko
 * Date: 07.05.12 16:18
 */
public class TemplateFolderSteps extends AbstractFolderSteps {
    @Override
    protected AdbankFoldersTree getFoldersTree(String templateId, String parentId) {
        PageNavigator pageFactory = getSut().getPageNavigator();
        if (parentId == null) {
            return pageFactory.getTemplateOverviewPage(templateId);
        }
        return pageFactory.getTemplateFilesWithFoldersPage(templateId, parentId);
    }

    public Project getObjectByName(String objectName) {
        return getCoreApi().getTemplateByName(objectName);
    }

    public Project getObjectByName(String objectName, User user) {
        return getCoreApi(user).getTemplateByName(objectName);
    }

    protected JumpLoaderPage getFilesUploadPage(String projectId, String folderId) {
        return getSut().getPageNavigator().getTemplateFilesUploadPage(projectId, folderId);
    }

    protected AdbankFilesPage getFilesPage(String projectId, String folderId) {
        return getSut().getPageNavigator().getTemplateFilesWithFoldersPage(projectId, folderId);
    }

    protected AdbankFilesPage getFilesPage() {
        return getSut().getPageCreator().getTemplateFilesPage();
    }

    @Given("{I |}created '$path' folder for template '$templateName'")
    @When("{I |}create '$path' folder for template '$templateName'")
    public Content createTemplateFolderOverCore(String path, String templateName) {
        return createFolderOverCoreApi(path, templateName);
    }

    @Given("{I |}created in '$templateName' template next folders: $foldersTable")
    @When("{I |}create in '$templateName' template next folders: $foldersTable")
    public List<Content> createTemplateFoldersOverCore(String templateName, ExamplesTable foldersTable) {
        return createFoldersOverCoreApi(templateName, foldersTable);
    }

    @Given("{I |}uploaded '$fileName' file into '$path' folder for '$templateName' template")
    @When("{I |}upload '$fileName' file into '$path' folder for '$templateName' template")
    public void createTemplateFile(String fileName, String path, String templateName) {
        createFile(fileName, path, templateName);
    }

    @When("{I |}copy folder '$copiedFolder' in template '$parentFolder' in template '$projectName'")
    public void createFolderCopy(String copiedFolder, String parentFolder, String projectName) {
        String projectId = getObjectByName(wrapVariableWithTestSession(projectName)).getId();
        String copiedFolderId = getCoreApi().getFolderByName(projectId, projectId, wrapVariableWithTestSession(copiedFolder)).getId();
        String parentFolderId = getCoreApi().getFolderByName(projectId, projectId, wrapVariableWithTestSession(parentFolder)).getId();

        getCoreApi().copyFolder(Arrays.asList(copiedFolderId), parentFolderId, false);
    }

    // | FileName | Path |
    @Given("{I |}uploaded into template '$templateName' following files: $filesTable")
    @When("{I |}upload into template '$templateName' following files: $filesTable")
    public void createTemplateFiles(String templateName, ExamplesTable filesTable) {
        createFiles(templateName, filesTable);
    }

    @Given("I am on template '$templateName' files page")
    @When("{I |}go to template '$templateName' files page")
    public void openTemplateFilesPage(String templateName) {
        openObjectFilesPage(templateName);
    }

    @Given("I am on template '$templateName' folder '$path' page")
    @When("{I |}go to template '$templateName' folder '$path' page")
    public void openTemplateFolderPage(String templateName, String path) {
        openObjectFolderPage(templateName, path);
    }

    @Given("I am on template '$templateName' folder '$path' upload page")
    public AdbankTemplateFilesUploadPage openTemplateFilesUploadPage(String templateName, String path) {
        openObjectFolderPage(templateName, path);
        return getSut().getPageCreator().getTemplateFilesPage().clickUploadButton();
    }

    @When(value = "{I |}create '$path' folder in '$templateName' template", priority = 1)
    public void createTemplateFolder(String path, String templateName) {
        createFolder(path, templateName);
    }

    @Then("{I |}'$shouldSee' see '$path' folder in '$templateName' template")
    public void checkProjectFolder(String shouldSee, String path, String templateName) {
        checkFolder(shouldSee, path, templateName);
    }

    @Then("{I |}should see following folders in '$templateName' template: $foldersTable")
    public void checkTemplateFolders(String templateName, ExamplesTable foldersTable) {
        checkFolders(templateName, foldersTable);
    }

    @When("I create '$count' folders in folder '$path' for template '$templateName'")
    public void createTemplateFolders(int count, String path, String templateName) {
        createFolders(count, path, templateName);
    }

    @Then("I should see '$count' folders in '$path' for template '$templateName'")
    public void checkTemplateSubFoldersCount(int count, String path, String templateName) {
        checkSubFoldersCount(count, path, templateName);
    }

    @Given("{I |}renamed folder '$path' to '$newName' in '$templateName' template")
    @When("{I |}rename folder '$path' to '$newName' in '$templateName' template")
    public void renameTemplateFolder(String path, String newName, String templateName) {
        renameFolder(path, newName, templateName);
    }

    @When("I cancel creating '$path' in '$templateName' template")
    public void cancelTemplateCreatingFolder(String path, String templateName) {
        cancelCreatingFolder(path, templateName);
    }

    @When("I close window of folder creating  '$path' in '$projectName' template")
    public void closeWindowProjectCreatingFolder(String path, String projectName) {
        closeWindowCreatingFolder(path, projectName);
    }

    @When("I '$action' file '$fileName' from template files page")
    public void deleteSelectedFiles(String action, String fileName) {
        AdbankTemplateFilesPage adbankTemplateFilesPage = getSut().getPageCreator().getTemplateFilesPage();
        adbankTemplateFilesPage.selectFileByFileName(fileName);
        adbankTemplateFilesPage.clickMoreButton();
        adbankTemplateFilesPage.clickDeleteMenuItem();
        if (action.equalsIgnoreCase("delete")) {
            adbankTemplateFilesPage.clickDeleteButtonOnPopupWindow();
        } else if (action.equalsIgnoreCase("cancel delete")) {
            adbankTemplateFilesPage.clickCancelButtonOnPopupWindow();
        } else if (action.equalsIgnoreCase("cross delete")) {
            adbankTemplateFilesPage.clickCrossButtonOnPopupWindow();
        } else {
            Assert.fail("Parameter action is undefine. It must be one of them:\ndelete\ncancel delete\ncross delete");
        }
        Common.sleep(500);
    }

    @When("I delete all files from template '$templateName' folder '$path' files page")
    public void deleteAllFilesFromTemplateFilesPage(String templateName, String path) {
        deleteAllFilesFromFilesPage(templateName, path);
    }

    @Then("I '$shouldState' see on template '$templateName' folder '$folderName' files page following files : $filesName")
    public void checkFilesOnTemplatesFilesPage(String shouldState, String templateName, String folderName, ExamplesTable filesName) {
        checkFilesOnFilesPage(shouldState, templateName, folderName, filesName);
    }

    @Then(value = "I '$shouldState' see on template '$templateName' folder '$folderName' are created by user '$userName' files page following files : $filesName", priority = 1)
    public void checkFilesOnTemplatesFilesPage(String shouldState, String templateName, String folderName, String userName, ExamplesTable filesName) {
        User user = getData().getUserByType(userName);
        if (user==null)
            user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userName));
        checkFilesOnFilesPage(shouldState, templateName, folderName, user, filesName);
    }

    @Then("{I |}'$condition' see file '$fileName' on template '$templateName' folder '$folderName' files page")
    public void checkFileOnThePageAfterDelete(String condition, String fileName, String templateName, String path) {
        checkFiles(condition, fileName, templateName, path);
    }

    @Then("I should not see for template '$templateName' files in the the following folders: $exampleTable")
    public void checkFilesVisibility(String templateName, ExamplesTable exampleTable) {
        Project template = getCoreApi().getTemplateByName(wrapVariableWithTestSession(templateName));
        for (Parameters parameters: exampleTable.getRowsAsParameters(true)) {
            AdbankTemplateFilesPage adbankTemplateFilesPage = getSut().getPageCreator().getTemplateFilesPage();
            selectFolder(parameters.valueAs("folder", String.class), wrapVariableWithTestSession(templateName)).click();
            assertThat(adbankTemplateFilesPage.getFilesCountByFileName(parameters.valueAs("FileName", String.class)), equalTo(0));
        }
    }

    @When("I delete the following files in next template{s|} and folders: $exampleTable")
    public void deleteSelectedFiles(ExamplesTable examplesTable) {
        for (Parameters parameters: examplesTable.getRowsAsParameters(true)) {
            if ((parameters.values().get("Template")!=null) && (parameters.values().get("Folder")!=null) && (parameters.values().get("FileName")!=null)) {
                openObjectFolderPage(parameters.valueAs("Template", String.class), parameters.valueAs("Folder", String.class));
                deleteSelectedFiles("delete", parameters.valueAs("FileName", String.class));
            }
        }
    }

    @Then("I '$condition' see file '$fileName' on {the |}template files page")
    public void checkFileOnThePageAfterDelete(String condition, String fileName) {
        super.checkFileOnThePageAfterDelete(condition, fileName);
    }

    @Given("I am on the Template Trash page for template '$templateName'")
    @When("I go to the Template Trash page for template '$templateName'")
    public void goToTheTemplateTrashPage(String templateName) {
        Project template = getCoreApi().getTemplateByName(wrapVariableWithTestSession(templateName));
        getSut().getPageNavigator().getTemplateTrashPage(template.getId(), "");
    }

    @When("I delete the following files from template '$templateName' and folder '$folderName': $fileNames")
    public void deleteSelectedFiles(String templateName, String folderName, ExamplesTable fileNames) {
        deleteFiles(templateName, folderName, fileNames);
    }

    @Then("{I |}should see '$fileName' file inside '$path' folder for '$templateName' template")
    public void checkTemplateFile(String fileName, String path, String templateName) {
        assertThat("Link to file", checkFile(fileName, path, templateName), equalTo(true));
    }

    @Then("I should see '$count' selected files in folder '$path' of template '$templateName'")
    public void checkTemplateSelectedFilesCount(int count, String path, String templateName) {
        checkSelectedFilesCount(count, path, templateName);
    }

    // | FileName | FilesCount (optional) |
    @Then("I should see following files inside '$path' folder for '$templateName' template: $filesTable")
    public void checkTemplateFiles(String path, String templateName, ExamplesTable filesTable) {
        checkObjectFiles(path, templateName, filesTable);
    }

    // fileNames comma separated
    @Then("{I |}should see files '$fileNames' inside '$path' folder for '$templateName' template")
    public void checkTemplateFiles (String fileNames, String path, String templateName) {
        StringBuilder tableAsString = new StringBuilder("|FileName|\r\n");
        for (String fileName : fileNames.split(",")) {
            if (fileName.isEmpty()) continue;
            tableAsString.append("|").append(fileName).append("|\r\n");
        }
        ExamplesTable filesTable = new ExamplesTable(tableAsString.toString());
        checkObjectFiles(path, templateName, filesTable);
    }

    // | File |
    @When("{I |}add to jumploader in folder '$path' of template '$templateName' following files: $filesTable")
    public void addTemplateFilesForUpload(String path, String templateName, ExamplesTable filesTable) {
        addFilesForUpload(path, templateName, filesTable);
    }

    @When("{I |}start jumploader upload in folder '$path' of template '$templateName' and '$waitState' for finish")
    public void startUpload(String path, String templateName, String waitState) {
        startJumploaderUpload(path, templateName, waitState);
    }

    @When("{I |}stop jumploader upload in folder '$path' of template '$templateName' after '$bytesUploaded' bytes uploaded")
    public void stopUpload(String path, String templateName, long bytesUploaded) {
        stopJumploaderUpload(path, templateName, bytesUploaded);
    }

    @When("{I |}resume jumploader upload in folder '$path' of template '$templateName' and '$waitState' for finish")
    public void resumeUpload(String path, String templateName, String waitState) {
        resumeJumploaderUpload(path, templateName, waitState);
    }

    @Then("I should see jumploader uploaded '$bytesUploaded' bytes in folder '$path' of template '$templateName'")
    public void checkUploadedVolume(long bytesUploaded, String path, String templateName) {
        checkJumploaderUploadedVolume(bytesUploaded, path, templateName);
    }

    @Then("I should see jumploader uploading '$is' in progress in folder '$path' of template '$templateName'")
    public void checkTemplateJumploaderProgress(String is, String path, String templateName) {
        checkJumploaderProgress(is, path, templateName);
    }

    @When("{I |}remove file index '$index' from jumploader in folder '$path' of template '$templateName'")
    public void removeTemplateFileFromJumploader(int index, String path, String templateName) {
        removeFileFromJumploader(index, path, templateName);
    }

    @When("{I |}remove all files from jumploader in folder '$path' of template '$templateName'")
    public void removeTemplateFilesFromJumploader(String path, String templateName) {
        removeFilesFromJumploader(path, templateName);
    }

    @Then("I should see files count '$count' in jumploader in folder '$path' of template '$templateName'")
    public void checkTemplateFilesCountInJumploader(int count, String path, String templateName) {
        checkFilesCountInJumploader(count, path, templateName);
    }

    @Then("{I |}should see sorting type '$sortingType' is selected on template '$templateName' folder '$path' page")
    public void checkSortingTypeTextProjectFilesPage(String sortingType,String templateName, String path) {
        checkSelectedSortingTypeText(sortingType, templateName, path);
    }

    @Then("{I |}should see sorting files by '$sortingType' on template '$templateName' folder '$path'")
    public void checkSortingTemplateFiles(String sortingType,String templateName, String path) {
        checkFilesSorting(sortingType, templateName, path);
    }

    @Then("{I |}'$condition' see folders sorted in the following order '$folders' on opened template page")
    public void checkSortingTemplateFolders(String condition, String folders) {
        List<String> expectedFolders = new ArrayList<String>();

        if (!folders.isEmpty()) {
            for (String folder : folders.split(",")) {
                expectedFolders.add(wrapVariableWithTestSession(folder.trim()));
            }
        }

        checkFoldersSorting(condition.equalsIgnoreCase("should"), expectedFolders);
    }

    @When("{I |} type folder name '$folderName' in search folders field in template '$templateName' folder '$path'")
    public void typeFolderNameInElement(String folderName, String templateName, String path) {
        typeFolderName(folderName, templateName, path);
    }

    @Then("{I |} should see folder '$path' on template '$templateName' files page")
    public void checkTemplateFoldersSearching(String path, String templateName) {
        checkFolderSearching(path, templateName);
    }

    @Given("{I |}waited while file '$fileName' fully uploaded to folder folder '$path' of template '$projectName'")
    @When("{I |}wait while file '$fileName' fully uploaded to folder folder '$path' of template '$projectName'")
    public void waitForProjectFileUploadingFinished(String fileName, String path, String templateName) {
        waitForFileAvailableInDatabase(templateName, path, fileName);
    }

    @Given("{I |}waited while transcoding is finished in folder '$path' on template '$templateName' files page")
    @When("{I |}wait while transcoding is finished in folder '$path' on template '$templateName' files page")
    public void waitForTemplateFilesTranscodingFinished(String path, String templateName) {
        waitForSpecAvailable(templateName, path);
    }

    @Given("{I |}waited while preview is available in folder '$path' on template '$templateName' files page")
    @When("{I |}wait while preview is available in folder '$path' on template '$templateName' files page")
    public void waitForTemplateFilesPreviewAvailable(String path, String templateName) {
        waitForPreviewAvailable(templateName, path);
    }

    @Given("{I |}waited while transcoding is finished on template '$templateName' in folder '$path' for '$fileName' file")
    @When("{I |}wait while transcoding is finished on template '$templateName' in folder '$path' for '$fileName' file")
    public void waitForTemplateFileTranscodingFinished(String templateName, String path, String fileName) {
        waitForTemplateFileTranscodingFinished(templateName, path, fileName, 1);
    }

    @Given("{I |}waited while preview is visible on template '$templateName' in folder '$path' for '$fileName' file")
    @When("{I |}wait while preview is visible on template '$templateName' in folder '$path' for '$fileName' file")
    public void waitForTemplateFilePreviewAvailable(String templateName, String path, String fileName) {
        waitForTemplateFilePreviewAvailable(templateName, path, fileName, 1);
    }

    @Given("{I |}waited while transcoding is finished on template '$templateName' in folder '$path' for '$fileName' file revision '$revision'")
    @When("{I |}wait while transcoding is finished on template '$templateName' in folder '$path' for '$fileName' file revision '$revision'")
    public void waitForTemplateFileTranscodingFinished(String path, String templateName, String fileName, int revision) {
        waitForFileSpecAvailableInSpecificRevision(templateName, path, fileName, revision);
    }

    @Given("{I |}waited while preview is visible on template '$templateName' in folder '$path' for '$fileName' file revision '$revision'")
    @When("{I |}wait while preview is visible on template '$templateName' in folder '$path' for '$fileName' file revision '$revision'")
    public void waitForTemplateFilePreviewAvailable(String templateName, String path, String fileName, int revision) {
        waitForFilePreviewAvailableInSpecificRevision(templateName, path, fileName, revision);
    }

    @Then("{I should see|}file '$filePath' in folder '$path' on template '$templateName' files page is fully uploaded")
    public void checkTemplateFileUploadComplete(String filePath, String path, String templateName) {
        checkFileUploadComplete(filePath, path, templateName);
    }

    @When("{I |}set media subtype '$mediaSubType' for file '$fileName' in folder '$path' of template '$templateName'")
    public void setTemplateMediaSubType(String mediaSubType, String fileName, String path, String templateName) {
        setMediaSubType(mediaSubType, fileName, path, templateName);
    }

    // | Path | FileName | SubType |
    @When("{I |}set media subtype for following files in template '$templateName': $filesTable")
    public void setTemplateMediaSubType(String templateName, ExamplesTable filesTable) {
        for (int i = 0; i < filesTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(filesTable, i);
            setMediaSubType(row.get("SubType"), row.get("FileName"), row.get("Path"), templateName);
        }
    }

    @When("{I |}set title '$title' for file '$fileName' in folder '$path' of template '$templateName'")
    public void setTemplateFileTitle(String title, String fileName, String path, String templateName) {
        setFileTitle(title, fileName, path, templateName);
    }

    @When("I create sub folder '$subFolderName' in folder '$path' in template '$templateName' using button NewFolder")
    public void createFolderWithNewFolderButton(String subFolderName, String path, String templateName) {
        Project project = getCoreApi().getTemplateByName(wrapVariableWithTestSession(templateName));
        AdbankTemplateFilesPage adbankProjectFilesPage = getSut().getPageNavigator().getTemplateFilesPage(project.getId());
        selectFolder(path, templateName).click();
        Common.sleep(3000);
        NewEditFolderPopUpWindow newEditFolderPopUpWindow = adbankProjectFilesPage.clickNewFolderButton();
        newEditFolderPopUpWindow.setFolderName(wrapVariableWithTestSession(subFolderName)).action.click();
    }

    @When("I open pop up menu of folder '$path' in template '$templateName'")
    public void openPopUpMenu(String path , String templateName) {
        openFoldersMenu(path, templateName);
    }

    @Then("{I |}'$shouldState' see in pop up menu for folder '$path' in template '$templateName' following items{ |}: $itemsTable")
    public void checkItemsInFoldersPopUp(String shouldState , String path, String templateName, ExamplesTable filesTable) {
        checkItemsInPopUp(shouldState, path, templateName, filesTable);
    }

    @Then("{I |}'$shouldState' see Download link for '$linkType' type on Download popup for template '$templateName' folder '$path'")
    public void checkVisibilityDownloadLink(String shouldState, String linkType, String objectName, String path) {
        super.checkVisibilityDownloadLink(shouldState, objectName, path, linkType);
    }


    @When("{I |}open uploaded file '$fileName' in folder '$path' template '$templateName'")
    public void openFile(String fileName, String path, String templateName){
        openUploadedFile(fileName, path, templateName);
    }

    // | item |
    @Then("{I |}'$shouldState' see in pop up menu for folder '$path' in template '$projectName' overview page following items: $itemsTable")
    public void checkItemsInFoldersPopUpOverviewPage(String shouldState , String path, String projectName, ExamplesTable filesTable) {
        super.checkItemsInPopUpOverviewPage(shouldState, projectName, filesTable);
    }


    @When(value = "{I |}delete folder '$path' in template '$projectName' with action '$action'", priority = 1)
    public void deleteTemplateFolderCancelOrCross(String path, String projectName, String action) {
        if (action.equalsIgnoreCase("cross")) {
            crossDeleteFolder(projectName, path);
        } else if (action.equalsIgnoreCase("cancel")) {
            cancelDeleteFolder(projectName, path);
        }
    }

    @Given("{I |}deleted folder '$path' in template '$templateName'")
    @When("{I |}delete folder '$path' in template '$templateName'")
    public void deleteTemplateFolder(String path, String templateName) {
        deleteFolder(templateName, path);
    }

    @Then("I should not see dropdown menu for trash bin on template page")
    public void checkDropdowmMenuForTrashBin() {
        AdbankFilesPage adbankFilesPage = getSut().getPageCreator().getProjectFilesPage();
        assertThat("", adbankFilesPage.getAllChildrenOfTrashBin().size(), equalTo(1));
        log.debug("I check div trash bin");
    }

    @When("{I |}open Share window from popup menu for folder '$path' on template '$projectName'")
    public void openFoldersPopUpMenu (String path, String projectName) {
        openShareFromPopUp(path, projectName);
    }

    // enabledFilters comma separated
    // possible values: IMAGE, AUDIO, VIDEO, PRINT, DIGITAL
    @When("{I |}select media type filters '$enabledFilters' on template '$templateName' folder '$path' page")
    public void enableTemplateMediaTypeFilter(String enabledFilters, String templateName, String path) {
        enableMediaTypeFilter(templateName, path, enabledFilters);
    }

    @When("{I |}select media subtype filter '$mediaSubType' on template '$templateName' folder '$path' page")
    public void selectTemplateMediaSubType(String mediaSubType, String templateName, String path) {
        selectMediaSubTypeFilter(templateName, path, mediaSubType);
    }

    // | Media Type | Enabled |
    @Then("{I |}should see following media type filter status on template '$templateName' folder '$path' page: $statusTable")
    public void checkTemplateMediaTypeFilterStatus(String templateName, String path, ExamplesTable statusTable) {
        checkMediaTypeFilterState(templateName, path, statusTable);
    }

    @Then("{I |}'$condition' see following folders in '$templateName' template: $foldersTable")
    public void checkProjectFolders(String condition, String templateName, ExamplesTable foldersTable) {
        checkFolders(condition, templateName, foldersTable);
    }

    @Given("I selected files on template files page: $fileNames")
    public void selectedSomeFiles(ExamplesTable fileNames) {
        AdbankTemplateFilesPage adbankTemplateFilesPage = getSut().getPageCreator().getTemplateFilesPage();
        for (Parameters parameters : fileNames.getRowsAsParameters(true)) {
            adbankTemplateFilesPage.selectFileByFileName(parameters.valueAs("FileName", String.class));
        }
    }

    @Given("{I |}selected file '$fileName' on template files page")
    @When("{I |}select file '$fileName' on template files page")
    public void selectFileOnProjectFilesPage(String fileName) {
        AdbankTemplateFilesPage adbankTemplateFilesPage = getSut().getPageCreator().getTemplateFilesPage();
        String[] fileNames = fileName.split(",");
        for (String fN : fileNames) {
            adbankTemplateFilesPage.selectFileByFileName(fN);
        }
    }

    @Given("I clicked move button on template files page")
    @When("I click move button on template files page")
    public void clickMoveButton() {
        AdbankTemplateFilesPage adbankTemplateFilesPage = getSut().getPageCreator().getTemplateFilesPage();
        adbankTemplateFilesPage.clickMoreButton();
        MoveCopyPopUpWindow moveCopyPopUpWindow = adbankTemplateFilesPage.clickMoveMenuItem();
    }

    @Given("{I |}uploaded few files '$fileName' with delimiter '$delimiter' into '$path' folder for '$templateName' template")
    @When("{I |}upload few files '$fileName' with delimiter '$delimiter' into '$path' folder for '$templateName' template")
    public void createProjectFile(String fileName, String delimiter, String path, String templateName) {
        String[] fileArray = fileName.split(delimiter);
        for (String file: fileArray) {
            createFile(file, path, templateName);
        }
    }

    @When("I select template '$project' on move/copy file popup")
    public void selectTemplateFromDropdownList(String template) {
        AdbankTemplateFilesPage adbankTemplateFilesPage = getSut().getPageCreator().getTemplateFilesPage();
        MoveCopyPopUpWindow moveCopyPopUpWindow = new MoveCopyPopUpWindow(adbankTemplateFilesPage);
        List<WebElement> list = moveCopyPopUpWindow.getAvailableForSearchProjectsList();
        for (WebElement webElement : list) {
            if (webElement.getText().equalsIgnoreCase(wrapVariableWithTestSession(template))) {
                webElement.click();
                return;
            }
        }
    }

    @Then("I should see preview of file '$format' into folder '$folderName' of template '$templateName'")
    public void checkTemplatesFilesPreview(String format, String folderName, String templateName) {
        checkFilesPreview(folderName, templateName);
    }

    @Given("I clicked copy button on template files page")
    @When("I click copy button on template files page")
    public void clickCopyButton() {
        super.clickCopyButton();
    }

    @Then("I '$condition' see file '$fileName' on {the |}template files page and files count are '$count'")
    public void checkFileAndFileCountOnThePage(String condition, String fileName, String count) {
        super.checkFileAndFileCountOnThePage(condition, fileName, count);
    }

    @Then("I '$condition' see file '$fileName' and files count are '$count' on the template search menu")
    public void checkFileAndFileCountOnTheTemplatePageForSearch(String condition, String fileName, int count) {
        checkFileAndFileCountOnThePageForSearch(condition, fileName, count);
    }

    @Then("I '$condition' see search input field on move/copy file popup for template")
    public void checkSearchInputOnMoveCopyPopupMenu(String condition) {
        super.checkSearchInputOnMoveCopyPopupMenu(condition);
    }

    @Then("I should see templates '$templateName' are available for selecting on move/copy file popup according to '$text'")
    public void checkSearchDropdownForTemplate(String templateName, String text) {
        checkSearchDropdown(templateName, text);
    }

    @When("I search in the '$searchType' next file '$fileName' for template '$templateName' folder '$folderName'")
    public void searchFileInTheCurrentSearchType(String searchType, String fileName, String templateName, String folderName) {
        searchFile(templateName, folderName, searchType, fileName);
    }

    @Then("I should see selected template '$template' with folder '$folder' on move/copy file popup")
    public void checkSelectedResultsVisibility(String template, String folder) {
        MoveCopyPopUpWindow moveCopyPopUpWindow = new MoveCopyPopUpWindow(getSut().getPageCreator().getProjectFilesPage());
        template = wrapVariableWithTestSession(template);
        folder = wrapVariableWithTestSession(folder).replaceAll("/", "");
        assertThat(moveCopyPopUpWindow.getProjectElementOnTreeContainerText(), equalTo(template));
        assertThat(moveCopyPopUpWindow.isFolderElemenyOnTreeContainerVisible(folder), equalTo(true));
    }

    @Given("{I |}copy '$fileName' file into '$pathTo' folder from folder '$pathFrom' for '$templateName' template")
    public void copyFileToTemplateFolder(String fileName, String pathTo, String pathFrom, String templateName) {
        copyFile(fileName, pathTo, pathFrom, templateName);
    }

    @Given("{I |}move '$fileName' file into '$pathTo' folder from folder '$pathFrom' for '$templateName' template")
    public void moveFileToTemplateFolder(String fileName, String pathTo, String pathFrom, String templateName) {
        moveFile(fileName, pathTo, pathFrom, templateName);
    }

    @Then("{I |}'$shouldState' see Download link next to original file '$fileName' and Download master using nVerge button on Download popup for template '$templateName' folder '$path'")
    public void checkVisibilityDownloadLinkDownloadMasterBtnTemplatesFile(String shouldState, String fileName, String templateName, String path) {
        checkVisibilityDownloadLinkDownloadMasterBtn(shouldState, fileName, templateName, path);
    }

    @Given("{I |}added agency project team '$aptName' into folder '$folderName' in the template '$templateName'")
    @When("{I |}add agency project team '$aptName' into folder '$folderName' in the template '$templateName'")
    public void addAPTinToTemplateFolder(String aptName, String folderName, String templateName) {
        addAPTOntoFolder(aptName, folderName, templateName);
    }

    @Then("I should see tabs for template '$templateName' folder '$folderName' according to: $tabsTable")
    public void checkTabsVisibility(String objectName, String path, ExamplesTable tabsTable) {
        getObjectTabsVisibility(objectName, path, tabsTable);
    }

    // | Folder | State |
    @Then("I should see following folders for the template '$templateName': $stateTable")
    public void checkTemplatesFoldersVisibility(String templateName, ExamplesTable stateTable) {
        checkFoldersVisibility(templateName, stateTable);
    }

    @When("{I |}open pop up menu of folder '$path' on template '$templateName' overview page")
    public void openPopUpMenuOverviewPage(String path , String templateName) {
        openFoldersMenuOverviewPage(path, templateName);
    }
}