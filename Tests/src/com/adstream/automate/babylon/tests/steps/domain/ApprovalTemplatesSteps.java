package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.admin.approvals.ApprovalTemplatePage;
import com.adstream.automate.babylon.sut.pages.admin.approvals.ApprovalTemplatesPage;
import com.adstream.automate.babylon.sut.pages.admin.approvals.elements.ApprovalTemplatePopup;
import com.adstream.automate.babylon.sut.pages.admin.approvals.elements.RemovingPopup;
import com.adstream.automate.babylon.sut.pages.admin.approvals.elements.StagePopup;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;

import java.util.List;
import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.not;

/**
 * Created with IntelliJ IDEA.
 * User: lynda-k
 * Date: 25.09.13
 * Time: 12:00
 */
public class ApprovalTemplatesSteps extends BaseStep {
    @Given("{I am |}on the approval templates page")
    @When("{I |}go to the approval templates page")
    public ApprovalTemplatesPage openApprovalTemplatesPage() {
        return getSut().getPageNavigator().getApprovalTemplatesPage();
    }

    @Given("{I am |}on the approval template '$templateName' page")
    @When("{I |}go to the approval template '$templateName' page")
    public ApprovalTemplatePage openApprovalTemplatePage(String templateName) {
        return openApprovalTemplatesPage().openApprovalTemplate(wrapVariableWithTestSession(templateName));
    }

    @Given("{I |}clicked Create New Approval Template button on approval templates page")
    @When("{I |}click Create New Approval Template button on approval templates page")
    public void clickCreateNewApprovalTemplateButton() {
        openApprovalTemplatesPage().clickCreateNewApprovalTemplateButton();
    }

    // | Name | Description |
    @Given("{I |}created approval templates with following information on approval templates page: $data")
    @When("{I |}create approval templates with following information on approval templates page: $data")
    public void createApprovalTemplate(ExamplesTable data) {
        for (Map<String, String> row : parametrizeTableRows(data)) {
            ApprovalTemplatePopup popup = openApprovalTemplatesPage().clickCreateNewApprovalTemplateButton();
            popup.typeName(wrapVariableWithTestSession(row.get("Name")));
            popup.typeDescription(row.get("Description"));
            popup.action.click();
        }
    }

    @Given("{I |}clicked Delete button on '$templateName' approval template page")
    @When("{I |}click Delete button on '$templateName' approval template page")
    public void clickDeleteTemplateButton(String templateName) {
        openApprovalTemplatePage(templateName);
        clickDeleteTemplateButton();
    }

    @Given("{I |}clicked Delete button on opened approval template page")
    @When("{I |}click Delete button on opened approval template page")
    public void clickDeleteTemplateButton() {
        getSut().getPageCreator().getApprovalTemplatePage().clickDeleteButton();
    }

    @Given("{I |}clicked '$button' button on opened Removing popup")
    @When("{I |}click '$button' button on opened Removing popup")
    public void clickButtonOnRemovingPopup(String button) {
        if (button.equalsIgnoreCase("yes")) {
            new RemovingPopup(getSut().getPageCreator().getApprovalTemplatePage()).clickYesButton();
        } else if (button.equalsIgnoreCase("no")) {
            new RemovingPopup(getSut().getPageCreator().getApprovalTemplatePage()).clickNoButton();
        } else {
            throw new IllegalArgumentException(String.format("Unknown button '%s' for removing popup", button));
        }
    }

    @Given("{I |}removed approval stage '$stageName' on opened approval template page")
    @When("{I |}remove approval stage '$stageName' on opened approval template page")
    public void removeStage(String stageName) {
        stageName = stageName.equals(ApprovalTemplatePage.INITIAL_STAGE_NAME) ? stageName : wrapVariableWithTestSession(stageName);
        getSut().getPageCreator().getApprovalTemplatePage().clickRemoveStageLink(stageName).clickYesButton();
    }

    @Given("{I |}initiated approval stage creation on opened approval template page")
    @When("{I |}initiate approval stage creation on opened approval template page")
    public void initiateStageCreation() {
        if (getSut().getPageCreator().getApprovalTemplatePage().isInitialStagePresent()) {
            getSut().getPageCreator().getApprovalTemplatePage().clickEditInitialStageLink();
        } else {
            getSut().getPageCreator().getApprovalTemplatePage().clickNewStageButton();
        }
    }

    @Given("{I |}clicked new stage button on opened approval template page")
    @When("{I |}click new stage button on opened approval template page")
    public void clickNewStageButton() {
        getSut().getPageCreator().getApprovalTemplatePage().clickNewStageButton();
    }

    @Given("{I |}saved opened approval stage popup on opened approval template page")
    @When("{I |}save opened approval stage popup on opened approval template page")
    public void saveApprovalStagePopup() {
        StagePopup popup = new StagePopup(getSut().getPageCreator().getApprovalTemplatePage());
        if (!popup.isSaveAndCloseLinkVisible()) popup.clickSaveAndBackLink();
        popup.clickSaveAndCloseLink();
    }

    // | Name | Description | Deadline | Approvers | SingleApproval | AllMustApprove | Owner |
    @Given("{I |}filled opened approval stage popup with following information on opened approval template page: $data")
    @When("{I |}fill opened approval stage popup with following information on opened approval template page: $data")
    public void fillApprovalStagePopup(ExamplesTable data) {
        StagePopup popup = new StagePopup(getSut().getPageCreator().getApprovalTemplatePage());
        Map<String,String> fields = parametrizeTableRows(data).get(0);
        if (fields.get("Name") != null) popup.typeName(wrapVariableWithTestSession(fields.get("Name")));
        if (fields.get("Description") != null) popup.typeDescription(fields.get("Description"));

        if (fields.get("Deadline") != null && !fields.get("Deadline").isEmpty()) {
            DateTime deadline = parseDateTime(fields.get("Deadline"), "dd/MM/yyyy HH:mm");
            popup.selectDeadlineDate(deadline.toString("dd/MM/yyyy"));
            popup.typeDeadlineHours(deadline.toString("HH"));
            popup.typeDeadlineMinutes(deadline.toString("mm"));
        }
        else
        {
            DateTime deadline = parseDateTime("01/05/2023 12:15", "dd/MM/yyyy HH:mm");
            popup.selectDeadlineDate(deadline.toString("dd/MM/yyyy"));
            popup.typeDeadlineHours(deadline.toString("HH"));
            popup.typeDeadlineMinutes(deadline.toString("mm"));
        }

        if (fields.get("Reminder") != null && !fields.get("Reminder").isEmpty()) {
            DateTime reminder = parseDateTime(fields.get("Reminder"), "dd/MM/yyyy HH:mm");
            popup.selectReminderDate(reminder.toString("dd/MM/yyyy"));
            popup.typeReminderHours(reminder.toString("HH"));
            popup.typeReminderMinutes(reminder.toString("mm"));
        }

        if (fields.get("Approvers") != null) {
            for (String approver : fields.get("Approvers").split(",")) {
                User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(approver.trim()));
                if (user == null || !user.getAgency().getName().equalsIgnoreCase(getData().getCurrentUser().getAgency().getName())) {
                    popup.selectApprover(wrapUserEmailWithTestSession(approver.trim()));
                } else {
                    popup.selectApprover(user.getFullName());
                }
            }
        }

        if (fields.get("SingleApproval") != null || fields.get("AllMustApprove") != null || fields.get("Owner") != null) {
            popup.clickAdvancedSettingsButton();
            if (fields.get("SingleApproval") != null && fields.get("SingleApproval").equalsIgnoreCase("checked"))
                popup.checkSingleApprovalStage();
            if (fields.get("AllMustApprove") != null && fields.get("AllMustApprove").equalsIgnoreCase("checked"))
                popup.checkMultipleApprovalStage();

            if (fields.get("Owner") != null && !fields.get("Owner").isEmpty()) {
                User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(fields.get("Owner")));
                popup.expandOwnersList();
                popup.selectOwner(user == null ? wrapUserEmailWithTestSession(fields.get("Owner")) : user.getFullName());
                popup.clickMakeStageOwnerButton();
            }
            if (fields.get("NotifyUsers") != null) {
                for (String NotifyUser : fields.get("NotifyUsers").split(",")) {
                    User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(NotifyUser.trim()));
                    if (user == null || !user.getAgency().getId().equalsIgnoreCase(getData().getCurrentUser().getAgency().getId())) {
                        popup.addAnonymoususerToStage(wrapUserEmailWithTestSession(NotifyUser.trim()));
                    } else {
                        popup.selectUsersToNotify(user.getFullName(), user.getEmail());
                    }
                }

        }

        }
        Common.sleep(2000);
    }

    // | Name | Description | Deadline | Approvers | SingleApproval | AllMustApprove | Owner |
    @Given("{I |}created approval stage with following information on opened approval template page: $data")
    @When("{I |}create approval stage with following information on opened approval template page: $data")
    public void createApprovalStage(ExamplesTable data) {
        initiateStageCreation();
        fillApprovalStagePopup(data);
        saveApprovalStagePopup();
    }

    // | Name | Description | Deadline | Approvers | SingleApproval | AllMustApprove | Owner |
    @Given("{I |}created new approval stage with following information on opened approval template page: $data")
    @When("{I |}create new approval stage with following information on opened approval template page: $data")
    public void createNewApprovalStage(ExamplesTable data) {
        clickNewStageButton();
        fillApprovalStagePopup(data);
        saveApprovalStagePopup();
    }

    // | Name | Description | Deadline | Approvers | SingleApproval | AllMustApprove | Owner |
    @Given("{I |}updated approval stage '$stageName' with following information on opened approval template page: $data")
    @When("{I |}update approval stage '$stageName' with following information on opened approval template page: $data")
    public void updateApprovalStage(String stageName, ExamplesTable data) {
        stageName = stageName.equals(ApprovalTemplatePage.INITIAL_STAGE_NAME) ? stageName : wrapVariableWithTestSession(stageName);
        getSut().getPageCreator().getApprovalTemplatePage().clickEditStageLink(stageName);
        fillApprovalStagePopup(data);
        saveApprovalStagePopup();
    }

    // | Name | Description | Deadline | Approvers | SingleApproval | AllMustApprove | Owner |
    @Given("{I |}updated approval stage '$stageName' with following information on '$templateName' approval template page: $data")
    @When("{I |}update approval stage '$stageName' with following information on '$templateName' approval template page: $data")
    public void updateApprovalStage(String stageName, String templateName, ExamplesTable data) {
        openApprovalTemplatePage(templateName);
        updateApprovalStage(stageName, data);
    }

    // | Name | Description | Deadline | Approvers | SingleApproval | AllMustApprove | Owner |
    @Given("{I |}created approval stage on '$templateName' approval template page: $data")
    @When("{I |}create approval stage on '$templateName' approval template page: $data")
    public void createApprovalStageForTemplate(String templateName, ExamplesTable data) {
        openApprovalTemplatePage(templateName);
        createApprovalStage(data);
    }

    @Then("{I |}'$condition' see template '$templateNames' on approval templates page")
    public void checkThatTemplatePresentsInList(String condition, String templateNames) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualTemplatesList = openApprovalTemplatesPage().getTemplatesList();

        for (String templateName : templateNames.split(",")) {
            String expectedTemplate = wrapVariableWithTestSession(templateName);
            assertThat(actualTemplatesList, shouldState ? hasItem(expectedTemplate) : not(hasItem(expectedTemplate)));
        }
    }

    // | FieldName | FieldValue |
    @Then("{I |}'$condition' see following information on opened template page: $data")
    public void checkTemplateInformation(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<Map<String,String>> actualFields = getSut().getPageCreator().getApprovalTemplatePage().getTemplateInformation();

        for (Map<String,String> expectedField : parametrizeTableRows(data)) {
            if (expectedField.get("FieldName").equals("Title")) {
                expectedField.put("FieldValue", wrapVariableWithTestSession(expectedField.get("FieldValue")));
            }

            assertThat(actualFields, shouldState ? hasItem(expectedField) : not(hasItem(expectedField)));
        }
    }

    @Then("{I |}'$condition' see approval stage '$stageNames' on opened approval template page")
    public void checkThatStagePresent(String condition, String stageNames) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualStagesList = getSut().getPageCreator().getApprovalTemplatePage().getStagesNamesList();

        for (String stageName : stageNames.split(",")) {
            String expectedStage = stageName.equals(ApprovalTemplatePage.INITIAL_STAGE_NAME) ? stageName : wrapVariableWithTestSession(stageName);
            assertThat(actualStagesList, shouldState ? hasItem(expectedStage) : not(hasItem(expectedStage)));
        }
    }

    @Then("{I |}'$condition' see Remove link on stage '$stageName' on opened approval template page")
    public void checkThatStageRemoveLinkPresent(String condition, String stageName) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        stageName = stageName.equals(ApprovalTemplatePage.INITIAL_STAGE_NAME) ? stageName : wrapVariableWithTestSession(stageName);
        boolean actualState = getSut().getPageCreator().getApprovalTemplatePage().isRemoveStageLinkPresent(stageName);

        assertThat(actualState, is(expectedState));
    }

    //  | Name | Description | Deadline | Reminder |
    @Then("{I |}'$condition' see approval stages with following information on opened template page: $data")
    public void checkTemplateStages(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<Map<String,String>> actualStages = getSut().getPageCreator().getApprovalTemplatePage().getStagesList();

        for (Map<String,String> expectedStage : parametrizeTableRows(data)) {
            if (!expectedStage.get("Name").equals(ApprovalTemplatePage.INITIAL_STAGE_NAME))
                expectedStage.put("Name", wrapVariableWithTestSession(expectedStage.get("Name")));
            if (expectedStage.get("Reminder") == null || expectedStage.get("Reminder").isEmpty())
                expectedStage.put("Reminder", "No reminder specified.");
            if (expectedStage.get("Deadline") == null || expectedStage.get("Reminder").isEmpty())
                expectedStage.put("Deadline", "No deadline specified.");


            assertThat(actualStages, shouldState ? hasItem(expectedStage) : not(hasItem(expectedStage)));
        }
    }
}
