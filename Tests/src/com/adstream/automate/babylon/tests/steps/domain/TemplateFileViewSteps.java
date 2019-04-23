package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileApprovalsPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileCommentsPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileVersionHistoryPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankTemplateFileInfoPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.*;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import java.io.File;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.not;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 17.09.12
 * Time: 15:08
 */
public class TemplateFileViewSteps extends AbstractFileViewSteps {

    @Override
    public Project getObjectByName(String objectName) {
        return getCoreApi().getTemplateByName(objectName);
    }

    @Override
    public Project getObjectByName(String objectName, User user) {
        return getCoreApi(user).getTemplateByName(objectName);
    }

    @Override
    protected AdbankFileActivityPage getFileActivityPage(String templateId, String folderId, String fileId) {
        return getSut().getPageNavigator().getTemplateFileActivityPage(templateId, folderId, fileId);
    }

    @Override
    protected AdbankFilesInfoPage getFilesInfoPage (String templateId, String folderId, String fileId) {
        return getSut().getPageNavigator().getTemplateFileInfoPage(templateId, folderId, fileId);
    }

    @Override
    protected AdbankFileCommentsPage getFileCommentsPage(String projectId, String folderId, String fileId) {
        return null;
    }

    @Override
    protected AdbankFileUsageRightsPage getFileUsageRightsPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getTemplateFileUsageRightsPage(projectId, folderId, fileId);
    }

    @Override
    protected AdbankFileVersionHistoryPage getFileVersionHistoryPage(String projectId, String folderId, String fileId) {
        return null;
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

    @Override
    protected AdbankProjectFileRelatedFilesPage getProjectRelatedFilesPage(String projectId, String folderId, String fileId) {
        return null;
    }

    @Given("I am on file '$filePath' info page in folder '$path' template '$templateName'")
    @When("{I |}go to file '$filePath' info page in folder '$path' template '$templateName'")
    public AdbankFilesInfoPage openFileInfo (String filePath, String path, String templateName) {
        return openFileInfoPage(new File(filePath).getName(), path, templateName);
    }

    @Given(value = "I am on file '$filePath' info page in folder '$path' template '$templateName' of user '$userName'", priority = 1)
    @When(value = "{I |}go to file '$filePath' info page in folder '$path' template '$templateName' of user '$userName'",priority = 1)
    public AdbankFilesInfoPage openFileInfo (String filePath, String path, String templateName, String userName) {
        return openFileInfoPage(userName, new File(filePath).getName(), path, templateName);
    }

    //| User | Logo | ActivityMessage |
    @Then("{I |}'$condition' see on Activity tab for file '$filePath' in folder '$path' template '$templateName' following recent user's activity : $activityTables")
    public void checkActivityTab(String condition, String filePath, String path, String templateName, ExamplesTable activityTables) {
        checkObjectActivity(condition.equalsIgnoreCase("should"), filePath, path, templateName, activityTables);
    }

    @When("{I |}click on user name '$userName' in Activity tab on open uploaded file '$filePath' in folder '$path' template '$templateName'")
    public void clickOnUserName(String userName, String filePath, String path, String templateName) {
        clickUserNameOnActivity(userName, filePath, path, templateName);
    }

    @When("{I |}click on filter button in Activity tab on open uploaded file '$filePath' in folder '$path' template '$projectName'")
    public void clickOnFilterButton(String filePath, String path, String projectName) {
        clickFilterOnActivityTab( filePath, path, projectName);
    }

    @Then("I '$condition' see template '$templateName' on file info page")
    public void checkProjectNameOnFileInfoPage(String condition, String templateName) {
        AdbankTemplateFileInfoPage adbankTemplateFileInfoPage = getSut().getPageCreator().getTemplateFileInfoPage();
        boolean should = condition.equals("should");
        templateName = "Templates // " + wrapVariableWithTestSession(templateName);
        assertThat(adbankTemplateFileInfoPage.getTemplateNameText(), should ? equalTo(templateName) : not(templateName));
    }

    @Then("I should see highlighted folder '$folderName' and template '$templateName' on file info page")
    public void checkHighlightedFolderOnFileInfoPage(String folderName, String templateName){
        AdbankTemplateFileInfoPage adbankTemplateFileInfoPage = getSut().getPageCreator().getTemplateFileInfoPage();
        folderName = wrapVariableWithTestSession(folderName.replaceAll("/", ""));
        templateName = wrapVariableWithTestSession(templateName);
        assertThat(adbankTemplateFileInfoPage.isObjectNameExistOnDropdownTreeContainerAsTitle(templateName), equalTo(true));
        assertThat(adbankTemplateFileInfoPage.isFolderHighlightedOnDropdownTreeContainer(folderName), equalTo(true));
    }

    @When("I click image button expand dropdown for file name in file info page for template")
    public void clickImageButtonExpandDropdownForFileName() {
        AdbankTemplateFileInfoPage adbankTemplateFileInfoPage = getSut().getPageCreator().getTemplateFileInfoPage();
        adbankTemplateFileInfoPage.clickImageButtonForExpandDropdown();
        Common.sleep(1000);
    }

    @When("{I |}play clip on file '$fileName' info page in folder '$path' template '$templateName'")
    public void playTemplateClip(String fileName, String path, String templateName) {
        playClip(fileName, path, templateName);
    }

    @Then("{I |}'$shouldState' see activity for user '$userName' on file '$fileName' activity tab in template '$templateName' folder '$path' page with message '$message' and value '$value'")
    public void checkActivityOnTemplateFileActivityTab(String shouldState, String userName, String fileName, String templateName, String path, String message, String value) {
        checkActivityFileInfoPage(shouldState, userName, fileName, templateName, path, message, value);
    }

    @When("{I |}downloaded file '$filePath' on folder '$path' template '$templateName' file info page")
    public void downloadTemplatesFile(String filePath, String path, String templateName) {
        downloadFile(filePath, path, templateName);
    }

    @Then("{I |}'$shouldState' see Download Original button on file '$filePath' info page in folder '$path' template '$templateName'")
    public void checkVisibilityDownloadOriginalBtnTemplatesFile(String shouldState, String filePath, String path, String templateName) {
        checkVisibilityDownloadOriginalBtn(shouldState, filePath, path, templateName);
    }

    @Then("{I |}'$shouldState' see Download master using nVerge button on file '$filePath' info page in folder '$path' template '$templateName'")
    public void checkVisibilityDownloadMasterUsingNVergeBtnTemplatesFile(String shouldState, String filePath, String path, String templateName) {
        checkVisibilityDownloadMasterUsingNVergeBtn(shouldState, filePath, path, templateName);
    }

    @Then("{I |}should see file '$filePath' info page in folder '$path' template '$templateName'")
    public void checkVisibilityFilesInfoPage(String filePath, String path, String templateName) {
        Project template = getObjectByName(wrapVariableWithTestSession(templateName));
        Content folder = getCoreApi(template.getCreatedBy()).getFolderByPath(template.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), new File(filePath).getName());
        String expectedPage = String.format("projects/projects/%s/folders/%s/files/%s/info", template.getId(), folder.getId(), file.getId());
        BabylonSteps.checkCurrentHashPage(expectedPage);
    }

    @Then("{I |}'$condition' see active Usage Rights tab on file '$filePath' info page in folder '$path' template '$templateName'")
    public void checkThatUsageRightsTabPresent(String condition, String filePath, String path, String templateName) {
        checkUsageRightsTabAvailability(condition, filePath, path, templateName);
    }

    @Then("{I |}should see following tabs on file '$filePath' info page in folder '$path' template '$templateName': $data")
    public void checkTemplatesTabsVisibility(String filePath, String path, String templateName, ExamplesTable data) {
        checkTabsVisibility(filePath, path, templateName, data);
    }
}