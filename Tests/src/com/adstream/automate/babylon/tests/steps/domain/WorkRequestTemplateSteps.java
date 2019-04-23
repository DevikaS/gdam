package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.sut.data.MetadataItem;
import com.adstream.automate.babylon.sut.pages.adbank.projects.*;
import com.adstream.automate.babylon.tests.RelativePathConverter;
import org.apache.commons.lang3.StringUtils;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static java.util.Arrays.asList;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * User: lynda-k
 * Date: 19.07.14
 * Time: 14:54
 */
public class WorkRequestTemplateSteps extends AbstractProjectSteps {

    public AdbankWorkRequestTemplateOverviewPage openWorkRequestTemplateOverviewPage(String objectId) {
        return getSut().getPageNavigator().getWorkRequestTemplateOverviewPage(objectId);
    }

    public AdbankTemplatesListPage openObjectListPage() {
        return getSut().getPageNavigator().getTemplateListPage();
    }

    public AdbankWorkRequestTemplateSettingsPage openObjectSettingsPage(String objectId) {
        AdbankWorkRequestTemplateOverviewPage page = openWorkRequestTemplateOverviewPage(objectId);
        return page.isEditWorkRequestTeplatePopUpVisible() ? new AdbankWorkRequestTemplateSettingsPage(getSut().getWebDriver()) : page.clickEdit();
    }

    public AdbankProjectsListPage getCurrentObjectListPage() {
        return getSut().getPageCreator().getProjectListPage();
    }

    public Project getObjectByName(String objectName) {
        return getCoreApi().getWorkRequestTemplateByName(objectName);
    }

    @Given("{I |}opened Create New Work Request Template popup")
    @When("{I |}open Create New Work Request Template popup")
    public AdbankWorkRequestTemplateCreatePage openCreateWorkRequestTemplatePopup() {
        AdbankWorkRequestTemplatesListPage page = getSut().getPageNavigator().getWorkRequestTemplatesListPage();
        return page.isCreateNewWorkRequestTemplatePopUpVisible() ? new AdbankWorkRequestTemplateCreatePage(getSut().getWebDriver()) : page.clickCreateNewWorkRequestTemplate();
    }

    @When("{I |}upload brief '$fileName' on opened create work request template popup")
    public void uploadLargeLogoToProject(String fileName) {
        new AdbankWorkRequestTemplateCreatePage(getSut().getWebDriver()).uploadBrief(RelativePathConverter.getFullPath(fileName));
    }

    @Given("{I |}created '$workRequestTemplateName' work request template with '$fields'")
    @When("{I |}create '$workRequestTemplateName' work request template with '$fields'")
    public void createWorkRequestTemplateOverCoreApi(String workRequestTemplateName, String fields) {
        workRequestTemplateName = wrapVariableWithTestSession(workRequestTemplateName);
        Project workRequestTemplate = getWorkRequestTemplateBuilder().getProject(workRequestTemplateName, fields);
        if (getCoreApi().getWorkRequestTemplateByName(workRequestTemplateName, 0) == null) {
            getCoreApi().createProject(workRequestTemplate);
            getCoreApi().getWorkRequestTemplateByName(workRequestTemplateName);
        }
    }

    @Given("{I |}created '$workRequestTemplateName' work request template")
    @When("{I |}create '$workRequestTemplateName' work request template")
    public void createDefaultWorkRequestTemplateOverCoreApi(String workRequestTemplateName) {
        createWorkRequestTemplateOverCoreApi(workRequestTemplateName, null);
    }

    @When("{I |}open file '$fileName' on work request template files page")
    public void openWorkRequestTemplateFile(String fileName) {
        getSut().getPageCreator().getWorkRequestTemplateFilesPage().openFile(fileName);
    }

    // | FieldName | FieldValue |
    @Given("{I |}created new work request template with following fields: $data")
    @When("{I |}create new work request template with following fields: $data")
    public void createWorkRequestTemplateThrowsUI(ExamplesTable data) {
        openCreateWorkRequestTemplatePopup();
        fillWorkRequestTemplateFields(data);
        clickSaveBtn();
    }

    // | Name | Job Number | Advertiser | Product/Brand | Campaign | Media Type | Start Date | End Date | Logo | Administrators |
    @When("{I |}fill the following fields for work request template: $data")
    public void fillFields(ExamplesTable data) {
        Map<String, String> prepareObject = prepareObjectFields(getWorkRequestTemplateBuilder().getProject(parametrizeTabularRow(data)));
        if (!data.getHeaders().contains("Business Unit")) prepareObject.remove("Business Unit");
        getSut().getPageCreator().getWorkRequestTemplateCreatePage()
                .fill(prepareObject);
    }

    // | FieldName | FieldValue |
    @Given("{I |}filled following fields on {Create|Edit} New Work Request Template popup: $data")
    @When("{I |}fill following fields on {Create|Edit} New Work Request Template popup: $data")
    public void fillWorkRequestTemplateFields(ExamplesTable data) {
        AdbankWorkRequestTemplateCreatePage page = getSut().getPageCreator().getWorkRequestTemplateCreatePage();
        for (MetadataItem row : wrapMetadataFields(data, "FieldName", "FieldValue")) {
            if (asList("Start date", "End date", "Date de début", "Date de fin").contains(row.getKey())) {
                DateTime dataTime = parseDateTime(row.getValue(), TestsContext.getInstance().storiesDateTimeFormat);
                row.setValue(dataTime.toString(getContext().userDateTimeFormat));
            }
            if (row.getKey().equals("Business Unit")) {
                page.fillFieldByName(row.getKey(), wrapAgencyName(row.getValue()));
            } else {
                page.fillFieldByName(row.getKey(), row.getValue());
            }
        }
    }

    // | Name | Job Number | Advertiser | Product/Brand | Campaign | Media Type | Start Date | End Date | Logo | Administrators |
    @Given("{I |}edited the following fields for '$workRequestTemplateName' work request template: $fieldsTable")
    @When("{I |}edit the following fields for '$workRequestTemplateName' work request template: $fieldsTable")
    public void editFields(String workRequestTemplateName, ExamplesTable fieldsTable) {
        editWorkRequestFields(workRequestTemplateName, fieldsTable);
    }

    @Given("{I |}checked 'Allow other users in my Business Unit to create projects from this template' on opened {Create|Edit} Work Request Template popup")
    @When("{I |}check 'Allow other users in my Business Unit to create projects from this template' on opened {Create|Edit} Work Request Template popup")
    public void checkAllowOtherUsersInMyAgencyUseThisTemplate() {
        getSut().getPageCreator().getWorkRequestTemplateCreatePage().checkAllowOtherUsersInMyAgencyUseThisTemplate();
    }

    @Given("{I |}clicked Save button on opened {Create|Edit} Work Request Template popup")
    @When("{I |}click Save button on opened {Create|Edit} Work Request Template popup")
    public void clickSaveButtonOnWorkRequestTemplatePopup() {
        clickSaveBtn();
    }

    @Given("I am on work request template '$templateName' overview page")
    @When("I go to work request template '$templateName' overview page")
    public void goToTemplateOverviewPage(String templateName) {
        Project template = getCoreApi().getWorkRequestTemplateByName(wrapVariableWithTestSession(templateName));
        openWorkRequestTemplateOverviewPage(template.getId());
    }

    @Given("I click on Delete template on Work Request template overview page")
    @When("I clicked on Delete template on Work Request template overview page")
    public void clickDeleteProjectLink(){
        AdbankWorkRequestTemplateOverviewPage page = getSut().getPageCreator().getWorkRequestTemplateOverviewPage();
        page.clickDeleteTemplateLink();
    }

    @Then("{I |}'$condition' be on the Create New Work Request Template popup")
    public void checkThatWorkRequestTemplateCreatePageOpened(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = true;

        try {
            getSut().getPageCreator().getWorkRequestTemplateCreatePage();
        } catch (Exception e) {
            actualState = false;
        } finally {
            assertThat(actualState, is(expectedState));
        }
    }

    // | FieldName | FieldValue |
    @Then("{I |}'$condition' see following fields on opened {Create|Edit} Work Request Template popup: $data")
    public void checkFieldsOnWorkRequestTemplateSettingsPage(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<Map<String,String>> actualFieldsList = getSut().getPageCreator().getWorkRequestTemplateCreatePage().getProjectFieldsList("all");

        for (Map<String,String> row : parametrizeTableRows(data)) {
            String fieldName = row.get("FieldName");
            String fieldValue = row.get("FieldValue");

            if (fieldName.equals("Advertiser") || fieldName.equals("Brand") || fieldName.equals("Sub Brand")
                    || fieldName.equals("Product") || fieldName.equals("Name")) {
                fieldValue = "";
                for (String value : row.get("FieldValue").split(","))
                    fieldValue += String.format("%s,", wrapVariableWithTestSession(value));
                fieldValue = fieldValue.replaceAll(",$","");
            }

            Map<String,String> expectedField = new HashMap<>();
            expectedField.put(fieldName, fieldValue);

            assertThat(actualFieldsList, shouldState ? hasItem(expectedField) : not(hasItem(expectedField)));
        }
    }

    @Then("{I |}'$condition' see following fields on opened Work Request Template '$workRequestTemplateName' Overview page: $data")
    public void checkFieldsOnWorkRequestTemplateOverviewPage(String condition, String workRequestTemplateName, ExamplesTable data) {
        openWorkRequestTemplateOverviewPage(getObjectByName(wrapVariableWithTestSession(workRequestTemplateName)).getId());
        checkFieldsOnWorkRequestTemplateOverviewPage(condition, data);
    }

    @Then("{I |}'$condition' see following fields on opened Work Request Template Overview page: $data")
    public void checkFieldsOnWorkRequestTemplateOverviewPage(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<Map<String,String>> actualFieldsList = getSut().getPageCreator().getWorkRequestTemplateOverviewPage().getWorkRequesFieldsList();

        for (MetadataItem row : wrapMetadataFields(data, "FieldName", "FieldValue")) {
            if (asList("Start date", "End date", "Date de début", "Date de fin").contains(row.getKey()))
                row.setValue(parseDateTime(row.getValue(), TestsContext.getInstance().storiesDateTimeFormat)
                        .toString(getData().getCurrentUser().getDateTimeFormatter().getDateFormat()));

            if (row.getKey().equals("Project Owners") && row.getValue() != null && !row.getValue().isEmpty()) {
                List<String> admins = new ArrayList<>();
                for (String email : row.getValue().split(",")) {
                    admins.add(getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(email)).getFullName());
                }
                row.setValue(StringUtils.join(admins, ","));
            }


            Map<String,String> expectedField = new HashMap<>();
            expectedField.put(row.getKey(), row.getValue());

            assertThat(actualFieldsList, shouldState ? hasItem(expectedField) : not(hasItem(expectedField)));
        }
    }

    @Then("{I |}'$condition' see '$button' button on Work Request Template '$workRequestTemplateName' Overview page")
    public void checkPublishUnpublishButton(String condition, String button, String workRequestTemplateName) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = openWorkRequestTemplateOverviewPage(workRequestTemplateName).isPublishUnpublishButtonPresent(button);

        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}should not see checkbox Publish Immediately on opened Work Request Template pop up")
    public void checkPublishImmediately() {
        assertThat("Publish Immediately should not exist!", !(getSut().getPageCreator().getWorkRequestTemplateCreatePage().isPublishImmediately()));
    }

    @Then("{I |}'$condition' see Allow other users in my Business Unit to create projects from this template on edit popup")
    public void checkAllowUsersBUCreateProjectIsAvailabe(String condition) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        assertThat("Something is wrong with visibility of 'Allow other users in my Business Unit...'",
                shouldState == getSut().getPageCreator().getWorkRequestTemplateCreatePage().isAllowOtherUsersInMyAgencyUseThisTemplate());
    }

    @Then("{I |}'$condition' see remove button next to uploaded brief on Work Request Template edit popup")
    public void checkRemoveButtonNextToUploadedBrief(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getWorkRequestTemplateCreatePage().isRemoveButtonPresentNextToUploadedBrief();

        assertThat(actualState, is(expectedState));
    }

    @Then("I '$condition' see delete template link on work request template '$templateName' overview page")
    public void checkDeleteTemplateLink(String condition, String templateName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        Project template = getCoreApi().getWorkRequestTemplateByName(wrapVariableWithTestSession(templateName));
        AdbankWorkRequestTemplateOverviewPage templateOverviewPage = getSut().getPageCreator().getWorkRequestTemplateOverviewPage();
        assertThat(templateOverviewPage.isDeleteTemplateLinkVisible(), equalTo(shouldState));
    }



}