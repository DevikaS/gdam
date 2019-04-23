package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileApprovalsPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileCommentsPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileVersionHistoryPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.*;
import com.adstream.automate.babylon.sut.pages.admin.approvals.elements.StagePopup;
import com.adstream.automate.hamcrest.StringByRegExpCheck;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;
import org.junit.Assert;

import java.util.List;
import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import static org.hamcrest.Matchers.is;

/**
 * Created with IntelliJ IDEA.
 * User: reznik-d
 * Date: 12.03.13
 * Time: 16:43
 */
public class ProjectFileApprovalsSteps extends AbstractFileViewSteps {

    @Override
    public Project getObjectByName(String objectName) {
        return getCoreApi().getProjectByName(objectName);
    }

    @Override
    public Project getObjectByName(String objectName, User user) {
        return getCoreApi(user).getProjectByName(objectName);
    }

    @Override
    protected AdbankProjectFileRelatedFilesPage getProjectRelatedFilesPage(String projectId, String folderId, String fileId) {
        return null;
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
        return null;
    }

    @Override
    protected AdbankFileApprovalsPage getFileApprovalsPage(String projectId, String folderId, String fileId) {
        // direct page open works 50/50. so, open by clicking on tab
        return getSut().getPageNavigator().getProjectFileInfoPage(projectId, folderId, fileId).selectApprovalsTab();
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
    @Given("{I am |}on file '$filePath' info page in folder '$path' project '$projectName' tab approvals")
    @When("{I |}go to file '$filePath' info page in folder '$path' project '$projectName' tab approvals")
    public void openProjectFileApprovalsTab(String filePath, String path, String projectName) {
        openFileApprovalsPage(filePath, path, projectName);
    }

    //| Name | Description | Deadline | Approvers | Started |
    @Given("{I |}added approval stage on file '$fileName' approvals page in folder '$path' project '$projectName': $data")
    @When("{I |}add approval stage on file '$fileName' approvals page in folder '$path' project '$projectName': $data")
    public void addApprovalStage(String fileName, String path, String projectName, ExamplesTable data) {
        super.createApprovalStageOverMiddlewareApi(fileName, path, projectName, data);
    }

    //| Name | Description | Deadline | Approvers | Started |
    @Given("{I |}created approval stage on file '$fileName' approvals page in folder '$path' project '$projectName': $data")
    @When("{I |}create approval stage on file '$fileName' approvals page in folder '$path' project '$projectName': $data")
    public void createApprovalStage(String fileName, String path, String projectName, ExamplesTable data) {
        super.createApprovalStage(fileName, path, projectName, data);
    }

    //| Name | Description | Deadline | Approvers | Started |
    @Given("{I |}filled approval stage on opened Add a new Stage popup with following information: $data")
    @When("{I |}fill approval stage on opened Add a new Stage popup with following information: $data")
    public void fillApprovalStagePopup(ExamplesTable data) {
        super.fillApprovalStagePopup(parametrizeTableRows(data).get(0));
    }

    @Given("{I |}filled approval stage on opened Add a new Stage popup with following information for client: $data")
    @When("{I |}fill approval stage on opened Add a new Stage popup with following information for client: $data")
    public void fillApprovalStagePopupForClient(ExamplesTable data) {
        super.fillApprovalStagePopupForClient(parametrizeTableRows(data).get(0));
    }

    @Given("{I |}clicked Send for Approval button in More dropdown on file approvals page")
    @When("{I |}click Send for Approval button in More dropdown on file approvals page")
    public void clickSendForApprovalButton() {
        AdbankFileApprovalsPage page = getSut().getPageCreator().getProjectFileApprovalsPage();
        page.clickMoreButton();
        page.clickSendForApprovalItem();
    }

    @Given("{I |}clicked '$button' element on opened Add a new Stage popup")
    @When("{I |}click '$button' element on opened Add a new Stage popup")
    public void clickButtonOnApprovalStagePopup(String button) {
        super.clickButtonOnApprovalStagePopup(button);
    }

    @Given("{I |}clicked '$button' element on opened Add a new Stage popup without delay")
    @When("{I |}click '$button' element on opened Add a new Stage popup without delay")
    public void clickButtonOnApprovalStagePopupwithoutdelay(String button) {
        super.clickButtonOnApprovalStagePopupwithoutdelay(button);
    }

    @Given("{I |}clicked Submit for approval on opened approvals page")
    @When("{I |}click Submit for approval on opened approvals page")
    public void clickSubmitForApproval() {
        getSut().getPageCreator().getProjectFileApprovalsPage().clickSubmitForApprovalLink();
    }

    @When("{I |}click Save button on save as an approval template pop up")
    public void clickSaveAsTemplateButtonPopUp() {
        new SaveAsApprovalTemplatePopup(getSut().getPageCreator().getProjectFileApprovalsPage()).clickAction();
    }

    @Given("{I |}clicked button save as an template on approval page")
    @When("{I |}click button save as an template on approval page")
    public void clickSaveAsTemplateButton() {
        getSut().getPageCreator().getProjectFileApprovalsPage().clickSaveAsTemplateButton();
    }

    @When("{I |}clicked Apply a template on opened approvals page")
    public void clickApplyTemplate() {
        getSut().getPageCreator().getProjectFileApprovalsPage().clickApplyTemplateLink();
    }

    @Given("{I |}clicked Add approval stage on opened approvals page")
    @When("{I |}click Add approval stage on opened approvals page")
    public void clickAddApprovalStage() {
        getSut().getPageCreator().getProjectFileApprovalsPage().clickAddApprovalStage();
    }

    @Given("{I |}saved approval as template '$templateName' on opened approvals page")
    @When("{I |}save approval as template '$templateName' on opened approvals page")
    public void saveApprovalAsTemplate(String templateName) {
        getSut().getPageCreator().getProjectFileApprovalsPage()
                .clickSaveAsTemplateButton().typeName(wrapVariableWithTestSession(templateName)).action.click();
    }

    @Given("{I |}applied approval template '$templateName' on opened approvals page")
    @When("{I |}apply approval template '$templateName' on opened approvals page")
    public void applyApprovalTemplate(String templateName) {
        getSut().getPageCreator().getProjectFileApprovalsPage()
                .clickApplyTemplateLink().selectTemplate(wrapVariableWithTestSession(templateName)).action.click();
    }

    @Given("{I |}started approval on file '$fileName' approvals page in folder '$path' project '$projectName'")
    @When("{I |}start approval on file '$fileName' approvals page in folder '$path' project '$projectName'")
    public void startApproval(String fileName, String path, String projectName) {
        super.startApproval(fileName, path, projectName);
    }

    @Given("{I |}'$action' stage '$stageName' with comment '$comment' on file '$fileName' approvals page in folder '$path' project '$projectName'")
    @When("{I |}'$action' stage '$stageName' with comment '$comment' on file '$fileName' approvals page in folder '$path' project '$projectName'")
    public void approveStage(String action, String stageName, String comment, String fileName, String path, String projectName) {
        super.approveOrRejectStage(fileName, path, projectName, stageName, action, comment);
    }

    @When("{I |}update '$approver' approver comment from stage '$stage' with text '$text'")
    public void updateApproverComment(String approver, String stage, String text) {
        User user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(approver));
        AdbankFileApprovalsPage fileApprovalsPage = getSut().getPageCreator().getProjectFileApprovalsPage();
        ApprovalCommentPopUp approvalCommentPopUp = fileApprovalsPage.clickEditComment(stage, user.getFullName());
        approvalCommentPopUp.typeComment(text);
        approvalCommentPopUp.clickOkButton();
    }

    //| Name |
    @When("{I |}add the following users to the stage '$stage': $examples")
    public void addUsersToTheStage(String stage, ExamplesTable data) {
        AdbankFileApprovalsPage fileApprovalsPage = getSut().getPageCreator().getProjectFileApprovalsPage();
        StagePopUp popup = fileApprovalsPage.clickEditStage(wrapVariableWithTestSession(stage));
        for (Map<String, String> row : parametrizeTableRows(data)) {
            if (row.get("Name") == null || row.get("Name").isEmpty()) Assert.fail("Please define mandatory parameters!");
            User approver = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(row.get("Name")));
            popup.addApproverToStage(approver.getFullName(), approver.getEmail());
        }

        popup.clickSaveAndCloseLink();
    }

    @When("{I |}'$action' the stage as approver")
    public void approveRejectStageAsApprover(String action) {
        AdbankFileApprovalsPage fileApprovalsPage = getSut().getPageCreator().getProjectFileApprovalsPage();
        ApprovalCommentPopUp approvalCommentPopUp = fileApprovalsPage.clickApproveRejectStageAsApprover(action);
        approvalCommentPopUp.clickOkButton();
    }

    @When("{I |}'$action' the stage with comment '$comment' as approver")
    public void approveRejectStageWithCommentAsApprover(String action, String comment) {
        AdbankFileApprovalsPage fileApprovalsPage = getSut().getPageCreator().getProjectFileApprovalsPage();
        ApprovalCommentPopUp approvalCommentPopUp = fileApprovalsPage.clickApproveRejectStageAsApprover(action);
        approvalCommentPopUp.typeComment(comment);
        approvalCommentPopUp.clickOkButton();
    }

    @When("{I |}start approval")
    public void startApproval() {
        getSut().getPageCreator().getProjectFileApprovalsPage().clickStartApproval();
    }

    @When("{I |}click start approval")
    public void clickstart() {
        getSut().getPageCreator().getProjectFileApprovalsPage().StartApprovals();
    }

    @Given("{I |}removed the approver '$approver' from the stage '$stage'")
    @When("{I |}remove the approver '$approver' from the stage '$stage'")
    public void removeApprover(String approver, String stage) {
        AdbankFileApprovalsPage fileApprovalsPage = getSut().getPageCreator().getProjectFileApprovalsPage();
        StagePopUp stagePopUp = fileApprovalsPage.clickEditStage(wrapVariableWithTestSession(stage));
        stagePopUp.removeUser(getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(approver)).getFullName());
        stagePopUp.clickSaveAndCloseLink();
    }

    // $action should be given as check or uncheck
    @When("{I |}'$action' auto close checkbox on file '$file' approvals page in folder '$path' in project '$projectName'")
    public void choseApprovalAutoCloseOption(String action, String file, String path, String projectName) {
        AdbankFileApprovalsPage page = openFileApprovalsPage(file, path, projectName);
        if (action.equalsIgnoreCase("check")) {
            page.selectAutoCloseCheckbox();
        } else if (action.equalsIgnoreCase("uncheck")) {
            page.deselectAutoCloseCheckbox();
        } else {
            throw new IllegalArgumentException(String.format("Unknown action '%s' for auto close checkbox", action));
        }
        Common.sleep(2000);
    }

    @When("{I |}close approval on opened file approvals page")
    public void closeApproval() {
        getSut().getPageCreator().getProjectFileApprovalsPage().clickCloseButton().apply.click();
        Common.sleep(2000);
    }

    @When("{I |}cancel approval on opened file approvals page")
    public void cancelApproval() {
        getSut().getPageCreator().getProjectFileApprovalsPage().clickCancelButton().apply.click();
        Common.sleep(2000);
    }

    @Given("{I |}removed '$stage' approval stage")
    @When("{I |}remove '$stage' approval stage")
    public void removeStage(String stage) {
        AdbankFileApprovalsPage fileApprovalsPage = getSut().getPageCreator().getProjectFileApprovalsPage();
        RemoveStageConfirmationPopUp popUp = fileApprovalsPage.clickRemoveStage(wrapVariableWithTestSession(stage));
        popUp.action.click().getDriver().sleep(100);
    }

    @When("{I |}click edit '$stage' approval stage")
    public void clickEditButtonForSpecificStage(String stage) {
        getSut().getPageCreator().getProjectFileApprovalsPage().clickEditStage(wrapVariableWithTestSession(stage));
    }

    @Given("{I |}approved stage section '$stageName' on opened file approvals page")
    @When("{I |}approve stage section '$stageName' on opened file approvals page")
    public void approveSpecificStage(String stage) {
        getSut().getPageCreator().getProjectFileApprovalsPage().clickApproveStage(wrapVariableWithTestSession(stage)).clickAction();
    }

    @When("{I |}reject stage section '$stageName' on opened file approvals page")
    public void rejectSpecificStage(String stage) {
        getSut().getPageCreator().getProjectFileApprovalsPage().clickRejectStage(wrapVariableWithTestSession(stage)).clickAction();
    }

    @When("{I |}send reminder for '$stage' approval stage")
    public void sendReminderForSpecificStage(String stage) {
        AdbankFileApprovalsPage fileApprovalsPage = getSut().getPageCreator().getProjectFileApprovalsPage();
        fileApprovalsPage.sendReminder(wrapVariableWithTestSession(stage));
    }

    //| Approvers | Name | Descripton | Deadline | Reminder |
    @When("{I |}update approval stages using the following data: $examples")
    public void editStage(ExamplesTable examples) {
        AdbankFileApprovalsPage page = getSut().getPageCreator().getProjectFileApprovalsPage();
        for (Map<String, String> row : parametrizeTableRows(examples)) {
            page.clickEditStage(wrapVariableWithTestSession(row.get("Name")));
            fillApprovalStagePopup(row).clickSaveAndCloseLink();
        }
    }

    @When("{I |}expand approvers section for stage '$stageName' on opened file approvals page")
    public void expandApprovalsSection(String stageName) {
        getSut().getPageCreator().getProjectFileApprovalsPage().expandApproversSection(wrapVariableWithTestSession(stageName));
    }

    @When("{I |}click by following breadcrumb link '$link'")
    public void clickByFollowingBreadcrumbLink(String link) {
        getSut().getPageCreator().getProjectFileApprovalsPage().clickByFollowingBreadcrumbLink(wrapVariableWithTestSession(link));
    }

    @Then("{I |}'$condition' see following approvers information in stage '$stageName' on opened file approvals page: $data")
    public void checkApproversInformation(String condition, String stageName, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        expandApprovalsSection(stageName);
        List<Map<String,String>> actualInfoFields = getSut().getPageCreator().getProjectFileApprovalsPage().getApproversInfo(wrapVariableWithTestSession(stageName));

        for (Map<String,String> expectedInfoField : parametrizeTableRows(data)) {
            User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(expectedInfoField.get("UserName")));
            expectedInfoField.put("UserName", user.getFullName() == null ? user.getEmail() : user.getFullName());
            assertThat(actualInfoFields, shouldState ? hasItem(expectedInfoField) : not(hasItem(expectedInfoField)));
        }
    }

    @Then("{I |}'$condition' see following owners '$owners' on Advanced Settings popup for stage '$stageName' on opened file approvals page")
    public void checkThatOwnersVisible(String condition, String owners, String stageName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AdbankFileApprovalsPage page = getSut().getPageCreator().getProjectFileApprovalsPage();
        List<String> actualOwners = page.clickAdvancedSettingsOnStage(wrapVariableWithTestSession(stageName)).getOwnerNames();

        for (String owner : owners.split(",")) {
            User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(owner));
            String expectedOwner = user.getFullName() == null ? user.getEmail() : user.getFullName();
            assertThat(actualOwners, shouldState ? hasItem(expectedOwner) : not(hasItem(expectedOwner)));
        }
    }

    // | Name | Reminder | Deadline | Description |
    @Then("{I |}'$condition' see approval stages with the following information: $data")
    public void checkApproversInformation(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<Map<String,String>> actualInfoFields = getSut().getPageCreator().getProjectFileApprovalsPage().getStagesInfo();

        for (Map<String,String> expectedInfoField : parametrizeTableRows(data)) {
            expectedInfoField.put("Name", wrapVariableWithTestSession(expectedInfoField.get("Name")));

            if (expectedInfoField.get("Status") == null) {
                for (Map<String,String> infoField : actualInfoFields) infoField.remove("Status");
            } else {
                expectedInfoField.put("Status", expectedInfoField.get("Status").toLowerCase());
            }

            if (expectedInfoField.get("Reminder") == null) {
                for (Map<String,String> infoField : actualInfoFields) infoField.remove("Reminder");
            } else if (expectedInfoField.get("Reminder").isEmpty()) {
                expectedInfoField.put("Reminder", "No reminder specified.");
            }

            if (expectedInfoField.get("Deadline") == null) {
                for (Map<String,String> infoField : actualInfoFields) infoField.remove("Deadline");
            } else if (expectedInfoField.get("Deadline").isEmpty()) {
                expectedInfoField.put("Deadline", "No deadline specified.");
            }

            if (expectedInfoField.get("Description") == null)
                for (Map<String,String> infoField : actualInfoFields) infoField.remove("Description");

                assertThat(actualInfoFields, shouldState ? hasItem(expectedInfoField) : not(hasItem(expectedInfoField)));
        }
    }

    @Then("{I |}'$condition' see approvals buttons for stage '$stageName' on opened file approvals page")
    public void checkApprovalsButtons(String condition, String stageName) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getProjectFileApprovalsPage().isApprovalsButtonsVisible(wrapVariableWithTestSession(stageName));
        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$shouldState' see button '$button' on opened file approvals page")
    public void checkSpecificButton(String should, String button) {
        boolean shouldState = should.equalsIgnoreCase("should");
        AdbankFileApprovalsPage page = getSut().getPageCreator().getProjectFileApprovalsPage();

        if (button.equalsIgnoreCase("approve")) {
            assertThat(page.isApproveButtonPresent(), is(shouldState));
        } else if (button.equalsIgnoreCase("reject")) {
            assertThat(page.isRejectButtonPresent(), is(shouldState));
        } else {
            throw new IllegalArgumentException(String.format("Wrong button name %s", button));
        }
    }

    //| Name |
    @Then("{I |}'$condition' see the following users in the stage '$stage': $examples")
    public void checkThatUsersPresentInTheStage(String condition, String stage, ExamplesTable examples) {
        AdbankFileApprovalsPage fileApprovalsPage = getSut().getPageCreator().getProjectFileApprovalsPage();
        boolean should = condition.equals("should");
        for (int i = 0; i < examples.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(examples, i);
            if ((row.get("Name") == null)) {
                Assert.fail("Please define mandatory parameters!");
            }
            User user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(row.get("Name")));
            assertThat(fileApprovalsPage.isUserPresentInTheStage(stage, user.getFullName()), equalTo(should));
        }
    }

    @Then("{I |}'$condition' see the stage '$stageName' on file '$fileName' approvals page in folder '$path' project '$projectName'")
    public void checkThatStagePresents(String condition, String stageName, String fileName, String path, String projectName) {
        checkThatApprovalStagePresent(condition, fileName, path, projectName, stageName);
    }

    @Then("{I |}'$condition' see the stage '$stage' is locked")
    public void checkIfStageLocked(String condition, String stage) {
        AdbankFileApprovalsPage fileApprovalsPage = getSut().getPageCreator().getProjectFileApprovalsPage();
        boolean should = condition.equals("should");
        assertThat(fileApprovalsPage.isStageLocked(stage), equalTo(should));
    }

    @Then("{I |}should see the stage '$stage' in '$color' color")
    public void checkStageColor(String stage, String color) {
        AdbankFileApprovalsPage fileApprovalsPage = getSut().getPageCreator().getProjectFileApprovalsPage();
        assertThat(fileApprovalsPage.getStageColor(stage), equalTo(color));
    }

    @Then("{I |}should see reject stage in '$color' color")
    public void checkColorOfRejectedStage(String color) {
        AdbankFileApprovalsPage fileApprovalsPage = getSut().getPageCreator().getProjectFileApprovalsPage();
        assertThat(fileApprovalsPage.getColorOfRejectedStage(), equalTo(color));
    }

    //| Approver | Stage |(optional)
    @Then("{I |}'$condition' see the following users under relevant stage: $examples")
    public void checkThatUserIsUnderRelevantStage(String condition, ExamplesTable examples) {
        AdbankFileApprovalsPage fileApprovalsPage = getSut().getPageCreator().getProjectFileApprovalsPage();
        String stage = "1";
        boolean should = condition.equals("should");
        for (int i = 0; i < examples.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(examples, i);
            if ((row.get("Approvers") == null)) {
                Assert.fail("Please define mandatory parameters!");
            }
            if (row.get("Stage") != null) {
                stage = row.get("Stage");
            }
            User user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(row.get("Approvers")));
            assertThat(fileApprovalsPage.isUserPresentInTheStage(stage, user.getFullName()), equalTo(should));
        }
    }

    @Then("{I |}should see '$text' text on approvals tab")
    public void checkTextOnApproval(String text) {
        AdbankFileApprovalsPage fileApprovalsPage = getSut().getPageCreator().getProjectFileApprovalsPage();
        assertThat(fileApprovalsPage.getNotificationText(), equalTo(text));
    }

    @Then("{I |}should see '$notification' notification on approvals tab")
    public void checkNotification(String text) {
        AdbankFileApprovalsPage fileApprovalsPage = getSut().getPageCreator().getProjectFileApprovalsPage();
        assertThat(fileApprovalsPage.getPopUpNotificationText(), equalTo(text));
    }

    @Then("{I |}'$condition' see Send Updates button for stage '$stage'")
    public void checkIsSendUpdatesButtonPresent(String condition, String stage) {
        boolean should = condition.equals("should");
        AdbankFileApprovalsPage fileApprovalsPage = getSut().getPageCreator().getProjectFileApprovalsPage();
        assertThat(fileApprovalsPage.isSendUpdatesButtonPresent(stage), equalTo(should));
    }

    @Then("{I |}'$condition' be on the file approvals page")
    public void checkThatOpenedPageIsAssetInfo(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        try {
            getSut().getPageCreator().getProjectFileApprovalsPage();
            assertThat(true, is(expectedState));
        } catch (Exception e) {
            assertThat(false, is(expectedState));
        }
    }

    @Then("{I |}'$condition' see that All must approve option is selected by default on create stage form")
    public void checkThatAllMustApproveOptionSelected(String condition) {
        boolean should = condition.equals("should");
        AdbankFileApprovalsPage fileApprovalsPage = getSut().getPageCreator().getProjectFileApprovalsPage();
        StagePopUp stagePopUp = fileApprovalsPage.clickAddApprovalStage();
        assertThat(stagePopUp.isAllMustApproveSelected(), equalTo(should));
    }

    @Then("{I |}should see the comment '$comment' from approver '$approver' in stage '$stage'")
    public void checkThatCommentPresent(String comment, String approver, String stage) {
        User user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(approver));
        AdbankFileApprovalsPage fileApprovalsPage = getSut().getPageCreator().getProjectFileApprovalsPage();
        assertThat(fileApprovalsPage.getUserComment(stage, user.getFullName()), equalTo(comment));
    }

    @Then("{I |}should see approval in '$state' state")
    public void checkApprovalStatus(String state) {
        AdbankFileApprovalsPage fileApprovalsPage = getSut().getPageCreator().getProjectFileApprovalsPage();
        assertThat(fileApprovalsPage.getCurrentApprovalStatus(), equalTo(state));
    }

    @Then("{I |}'$shouldState' see checkbox '$checkbox' selected on opened approvals page")
    public void checkAutoCloseApprovalCheckbox(String should, String checkbox) {
        boolean shouldState = should.equalsIgnoreCase("should");
        AdbankFileApprovalsPage page = getSut().getPageCreator().getProjectFileApprovalsPage();

        if (checkbox.equalsIgnoreCase("Auto Close Approval")) {
            assertThat(page.isAutoCloseCheckboxSelected(), is(shouldState));
        }
        else {
            throw new IllegalArgumentException(String.format("Wrong button name %s", checkbox));
        }
    }

    @Then("{I |}'$condition' see Close button displayed")
    public void checkCloseButtonPresent(String condition) {
        boolean should = condition.equals("should");
        AdbankFileApprovalsPage fileApprovalsPage = getSut().getPageCreator().getProjectFileApprovalsPage();
        assertThat(fileApprovalsPage.isCloseButtonPresent(), equalTo(should));
    }

    @Then("{I |}'$condition' see Close button as enabled")
    public void checkCloseButtonState(String condition) {
        boolean should = condition.equals("should");
        AdbankFileApprovalsPage fileApprovalsPage = getSut().getPageCreator().getProjectFileApprovalsPage();
        assertThat(fileApprovalsPage.isCloseButtonEnabled(), equalTo(should));
    }

    @Then("{I |}'$condition' see Change Approval Status dropdown list")
    public void checkApprovalStatusVisibilityDropDownList(String condition) {
        boolean should = condition.equals("should");
        AdbankFileApprovalsPage fileApprovalsPage = getSut().getPageCreator().getProjectFileApprovalsPage();
        assertThat(fileApprovalsPage.isApprovalStatusDropDownListPresent(), equalTo(should));
    }

    //| Name | Stage | Description | ApprovalType | Deadline (format: DD/MM/YYYY HH : mm) | Reminder (format: DD/MM/YYYY HH : mm) |
    @Then("{I |}should see approval stages with the following options: $examples")
    public void checkStageOptions(ExamplesTable examples) {
        String stage;
        AdbankFileApprovalsPage fileApprovalsPage = getSut().getPageCreator().getProjectFileApprovalsPage();

        for (int i = 0; i < examples.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(examples, i);
            stage = row.get("Stage");
            if (row.get("Name") != null) {
                String stageName = row.get("Name");
                if (!stageName.contains("Stage")) {
                    stageName = wrapVariableWithTestSession(stageName);
                }
                assertThat(fileApprovalsPage.getStageName(stage), equalTo(stageName));
            }
            if (row.get("Description") != null) {
                assertThat(fileApprovalsPage.getStageDescription(stage), equalTo(wrapVariableWithTestSession(row.get("Description"))));
            }
            if (row.get("ApprovalType") != null) {
                assertThat(fileApprovalsPage.getStageType(stage), equalTo(row.get("ApprovalType")));
            }
            if (row.get("Deadline") != null) {
                assertThat(fileApprovalsPage.getStageDeadlineDateTime(stage), equalTo(row.get("Deadline")));
            }
            if (row.get("Reminder") != null) {
                assertThat(fileApprovalsPage.getStageReminderDateTime(stage), equalTo(row.get("Reminder")));
            }
            if (row.get("Approvers") != null) {
                for (String approver : row.get("Approvers").split(",")) {
                    User user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(approver.trim()));
                    assertThat(fileApprovalsPage.isUserPresentInTheStage(stage, user.getFullName()), equalTo(true));
                }

            }
        }
    }

    @Then("{I |}'$condition' see Edit button for stage '$stage'")
    public void checkEditButtonVisibility(String condition, String stage) {
        boolean should = condition.equals("should");
        AdbankFileApprovalsPage fileApprovalsPage = getSut().getPageCreator().getProjectFileApprovalsPage();
        assertThat(fileApprovalsPage.isEditStageButtonPresent(stage), equalTo(should));
    }

    @Then("{I |}should see '$quantity' approvers for stage '$stage'")
    public void checkApproversQuantityForStage(String quantity, String stage) {
        AdbankFileApprovalsPage fileApprovalsPage = getSut().getPageCreator().getProjectFileApprovalsPage();
        assertThat(fileApprovalsPage.getApproversQuantity(stage), equalTo(quantity));
    }

    @Then("{I |}'$condition' see stage pop up")
    public void checkIsStagePopUpDisplayed(String condition) {
        boolean should = "should".equalsIgnoreCase(condition);
        AdbankFileApprovalsPage fileApprovalsPage = getSut().getPageCreator().getProjectFileApprovalsPage();
        assertThat(fileApprovalsPage.isStagePopUpDisplayed(), equalTo(should));
    }

    @When("{I |}approve file using top approve button")
    public void clickApproveTopButton() {
        approveFileUsingApproveTopButton();
    }

    @When("{I |}reject file using top reject button")
    public void clickRejectTopButton() {
        rejectFileUsingRejectTopButton();
    }



    @Then("{I |}'$condition' see template '$templateName' in available templates list on Apply template popup")
    public void checkApprovalTemplateInApplyTemplatePopup(String condition, String templateName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualTemplatesList = getSut().getPageCreator().getProjectFileApprovalsPage().clickApplyTemplateLink().getAvailableTemplates();
        String expectedTemplate = wrapVariableWithTestSession(templateName);

        assertThat(actualTemplatesList, shouldState ? hasItem(expectedTemplate) : not(hasItem(expectedTemplate)));
    }

    @Then("{I |}'$condition' see template '$templateName' in available templates list on opened Apply template popup")
    public void checkApprovalTemplateInOpenedApplyTemplatePopup(String condition, String templateName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualTemplatesList = new SelectApprovalTemplatePopup(getSut().getPageCreator().getProjectFilesPage()).getAvailableTemplates();
        String expectedTemplate = wrapVariableWithTestSession(templateName);

        assertThat(actualTemplatesList, shouldState ? hasItem(expectedTemplate) : not(hasItem(expectedTemplate)));
    }

    @Then("{I |}'$condition' see approve top button")
    public void checkVisibilityOfApproveTopButton(String condition) {
        boolean should = condition.equalsIgnoreCase("should");
        AdbankFileApprovalsPage page = getSut().getPageCreator().getProjectFileApprovalsPage();
        assertThat(page.isApproveButtonPresent(), equalTo(should));
    }

    @Then("{I |}'$condition' see reject top button")
    public void checkVisibilityOfRejectTopButton(String condition) {
        boolean should = "should".equalsIgnoreCase(condition);
        AdbankFileApprovalsPage page = getSut().getPageCreator().getProjectFileApprovalsPage();
        assertThat(page.isRejectButtonPresent(), equalTo(should));
    }

    @Then("{I should see |}message {warning|success} '$message'on clicking '$button' element on opened Add a new Stage popup")
    public void messageclickButtonOnApprovalStagePopup(String message, String button) {
        super.clickButtonOnApprovalStagePopup(button);
        if (!message.trim().isEmpty()) {
            String actualMessage = getSut().getPageCreator().getBasePage().getPopUpNotificationMessage();
            assertThat(actualMessage, StringByRegExpCheck.matches(message));

        }
    }

    @Then("{I |}'$should' see red field name on pop-up")
    public void checkRedInputName(String condition) {
        Common.sleep(1000);
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean actualState = new SaveAsApprovalTemplatePopup(getSut().getPageCreator().getProjectFileApprovalsPage()).isInputNameRed();
        assertThat(shouldState, equalTo(actualState));
    }

    @Then("{I |}should see following breadcrumbs '$breadcrumbs' on approvals page")
    public void checkBreadcrubms(String breadcrubs) {
        String getBreadcrumbs = getSut().getPageCreator().getProjectFileApprovalsPage().getBreadcrubs().replace(getData().getSessionId(), "");
        assertThat(breadcrubs, is(getBreadcrumbs));
    }
    @Then("{I }'$should' see Create New Approval pop up")
    public void checkNewApprovalPopUp( String condition){
        boolean shouldState=condition.equalsIgnoreCase("should");
        AdbankFileApprovalsPage page=getSut().getPageCreator().getProjectFileApprovalsPage();
        assertThat(page.isNewApprovalPopUpDisplayed(), equalTo(shouldState));
    }
}
