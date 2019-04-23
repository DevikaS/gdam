package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.sut.data.MetadataItem;
import com.adstream.automate.babylon.sut.pages.adbank.projects.*;
import com.adstream.automate.babylon.tests.RelativePathConverter;
import com.adstream.automate.utils.Common;
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
 * Date: 19.06.14
 * Time: 14:54
 */
public class WorkRequestSteps extends AbstractProjectSteps{

    public AdbankWorkRequestOverviewPage openWorkRequestOverviewPage(String objectId) {
        return getSut().getPageNavigator().getWorkRequestOverviewPage(objectId);
    }

    public AdbankWorkRequestListPage openObjectListPage() {
        return getSut().getPageNavigator().getWorkRequestListPage();
    }

    public AdbankWorkRequestSettingsPage openObjectSettingsPage(String objectId) {
        AdbankWorkRequestOverviewPage page = openWorkRequestOverviewPage(objectId);
        return page.isEditWorkRequestPopUpVisible() ? new AdbankWorkRequestSettingsPage(getSut().getWebDriver()) : page.clickEdit();
    }

    public AdbankProjectsListPage getCurrentObjectListPage() {
        return getSut().getPageCreator().getProjectListPage();
    }

    public Project getObjectByName(String objectName) {
        return getCoreApi().getWorkRequestByName(objectName);
    }

    @Given("{I am|}on work request '$workRequestName' overview page")
    @When("{I |}go to work request '$workRequestName' overview page")
    public AdbankWorkRequestOverviewPage gotoWorkRequestOverviewPage(String workRequestName) {
        return openWorkRequestOverviewPage(getObjectByName(wrapVariableWithTestSession(workRequestName)).getId());
    }

    @When("{I |}click publish button on work request '$projectName' Overview page")
    public void publishWorkRequest(String workRequest) {
        openWorkRequestOverviewPage(getObjectByName(wrapVariableWithTestSession(workRequest)).getId());
        getSut().getPageCreator().getWorkRequestOverviewPage().clickPublishButton().clickNotifyButton();
    }

    @Given("{I |}opened Create New Work Request popup")
    @When("{I |}open Create New Work Request popup")
    public AdbankWorkRequestCreatePage openCreateWorkRequestPopup() {
        AdbankWorkRequestListPage page = getSut().getPageNavigator().getWorkRequestListPage();
        return page.isCreateNewWorkRequestPopUpVisible() ? new AdbankWorkRequestCreatePage(getSut().getWebDriver()) : page.clickNewWorkRequest();
    }

    @When("{I |}upload brief '$fileName' on opened create work request popup")
    public void uploadLargeLogoToProject(String fileName) {
        new AdbankWorkRequestCreatePage(getSut().getWebDriver()).uploadBrief(RelativePathConverter.getFullPath(fileName));
    }

    @Given("{I |}created '$workRequestName' work request with '$fields'")
    @When("{I |}create '$workRequestName' work request with '$fields'")
    public void createWorkRequestOverCoreApi(String workRequestName, String fields) {
        workRequestName = wrapVariableWithTestSession(workRequestName);
        Project workRequest = getWorkRequestBuilder().getProject(workRequestName, fields);
        if (getCoreApi().getWorkRequestByName(workRequestName, 0) == null) {
            getCoreApi().createProject(workRequest);
            getCoreApi().getWorkRequestByName(workRequestName);
        }
    }

    @Given("{I |}created '$workRequestName' work request")
    @When("{I |}create '$workRequestName' work request")
    public void createDefaultWorkRequestOverCoreApi(String workRequestName) {
        createWorkRequestOverCoreApi(workRequestName, null);
    }

    @When("{I |}open file '$fileName' on work request files page")
    public void openwWorkRequestFile(String fileName) {
        getSut().getPageCreator().getWorkRequestFilesPage().openFile(fileName);
    }

    // | FieldName | FieldValue |
    @Given("{I |}created new work request with following fields: $data")
    @When("{I |}create new work request with following fields: $data")
    public void createProjectThrowsUI(ExamplesTable data) {
        openCreateWorkRequestPopup();
        fillWorkRequestFields(data);
        clickSaveBtn();
    }

    // | Name | Job Number | Advertiser | Product/Brand | Campaign | Media Type | Start Date | End Date | Logo | Administrators |
    @When("{I |}fill the following fields for work request: $data")
    public void fillFields(ExamplesTable data) {
        Map<String, String> prepareObject = prepareObjectFields(getWorkRequestBuilder().getProject(parametrizeTabularRow(data)));
        if (!data.getHeaders().contains("Business Unit")) prepareObject.remove("Business Unit");
        getSut().getPageCreator().getWorkRequestCreatePage()
                .fill(prepareObject);
    }

    // | Name | Job Number | Advertiser | Product/Brand | Campaign | Media Type | Start Date | End Date | Logo | Administrators |
    @When("{I |}create new work request and fill the following fields for: $data")
    public void fillFields2(ExamplesTable data) {
        openCreateWorkRequestPopup();
        Map<String, String> prepareObject = prepareObjectFields(getWorkRequestBuilder().getProject(parametrizeTabularRow(data)));
        if (!data.getHeaders().contains("Business Unit")) prepareObject.remove("Business Unit");
        getSut().getPageCreator().getWorkRequestCreatePage()
                .fill(prepareObject);
        clickSaveBtn();
        Common.sleep(1000);
    }

    @When("{I |}select business unit '$businessUnit' on work requests list page")
    public void selectBusinessUnit(Agency businessUnit) {
        openObjectListPage().selectBusinessUnit(businessUnit.getName());
    }

    // | FieldName | FieldValue |
    @Given("{I |}filled following fields on {Create|Edit} New Work Request popup: $data")
    @When("{I |}fill following fields on {Create|Edit} New Work Request popup: $data")
    public void fillWorkRequestFields(ExamplesTable data) {
        for (MetadataItem row : wrapMetadataFields(data, "FieldName", "FieldValue")) {
            if (asList("Start date", "End date", "Date de début", "Date de fin").contains(row.getKey())) {
                DateTime dataTime = parseDateTime(row.getValue(), TestsContext.getInstance().storiesDateTimeFormat);
                row.setValue(dataTime.toString(getContext().userDateTimeFormat));
            }

            getSut().getPageCreator().getWorkRequestCreatePage().fillFieldByName(row.getKey(), (row.getValue()));
        }
    }



    @Given("{I |}specified template name '$templateName' on Create New Work Request popup")
    @When("{I |}specify template name '$templateName' on Create New Work Request popup")
    public void specifyTemplateNameOnCreateWorkRequestPopUp(String templateName) {
        getSut().getPageCreator().getWorkRequestCreatePage().setTemplateName(wrapVariableWithTestSession(templateName));
    }

    @Given("{I |}specified template name '$templateName' with following inheritance options on Create New Work Request popup: $data")
    @When("{I |}specify template name '$templateName' with following inheritance options on Create New Work Request popup: $data")
    public void specifyTemplateNameOnCreateWorkRequestPopUp(String templateName, ExamplesTable data) {
        Map<String,String> options = parametrizeTabularRow(data);
        getSut().getPageCreator().getWorkRequestCreatePage().setTemplateName(wrapVariableWithTestSession(templateName));
        for (String option : options.keySet())
            getSut().getPageCreator().getWorkRequestCreatePage().setTemplateInheritanceOption(option, Boolean.parseBoolean(options.get(option)));
    }

    @Given("{I |}deleted '$workRequest' work request")
    @When("{I |}delete '$workRequest' work request")
    public void deleteProjectOverCoreApi(String workRequest){
        workRequest = wrapVariableWithTestSession(workRequest);
        Project workRquestName = getCoreApi().getWorkRequestByName(workRequest, 0);
        getCoreApi().deleteProject(workRquestName.getId());
    }

    // | Name | Job Number | Advertiser | Product/Brand | Campaign | Media Type | Start Date | End Date | Logo | Administrators |
    @Given("{I |}edited the following fields for '$workRequest' work request: $fieldsTable")
    @When("{I |}edit the following fields for '$workRequest' work request: $fieldsTable")
    public void editFields(String workRequest, ExamplesTable fieldsTable) {
        editWorkRequestFields(workRequest, fieldsTable);
    }

    @Given("{I |}clicked Save button on opened {Create|Edit} Work Request popup")
    @When("{I |}click Save button on opened {Create|Edit} Work Request popup")
    public void clickSaveButtonOnWorkRequestPopup() {
        clickSaveBtn();
    }

    @Given("{I |}clicked create template from project for Work Request '$projectName'")
    @When("{I |}click create template from project for Work Request '$projectName'")
    public AdbankTemplateFromProjectCreatePage clickCrateTemplateFromProject(String projectName) {
        Project workRequest = getObjectByName(wrapVariableWithTestSession(projectName));
        AdbankWorkRequestOverviewPage workRequestOverviewPage = getSut().getPageCreator().getWorkRequestOverviewPage();
        return workRequestOverviewPage.clickCreateTemplateFromProject();
    }

    @Given("I click on Delete project on Work Request overview page")
    @When("I clicked on Delete project on Work Request overview page")
    public void clickDeleteProjectLink(){
        AdbankWorkRequestOverviewPage page = getSut().getPageCreator().getWorkRequestOverviewPage();
        page.clickDeleteProjectLink();
    }

    @When("{I |}select Publish Immediately checkbox on opened Create Work Request popup")
    public void selectPublishImmediatelyCheckbox() {
        getSut().getPageCreator().getWorkRequestCreatePage().selectPublishImmediatelyCheckbox();
    }

    @Then("{I |}'$condition' see selected Publish Immediately checkbox on opened Create Work Request popup")
    public void checkPublishImmediatelyCheckboxState(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getWorkRequestCreatePage().isPublishImmediatelyCheckboxSelected();

        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' see selected Template field on opened Create Work Request popup")
    public void checkTemplateFieldVisibilityState(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getWorkRequestCreatePage().isTemplateFieldVisible();

        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' be on the Create New Work Request popup")
    public void checkThatDashboardPageOpened(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = true;

        try {
            getSut().getPageCreator().getWorkRequestCreatePage();
        } catch (Exception e) {
            actualState = false;
        } finally {
            assertThat(actualState, is(expectedState));
        }
    }

    // | FieldName | FieldValue |
    @Then("{I |}'$condition' see following fields on opened {Create|Edit} Work Request popup: $data")
    public void checkFieldsOnWorkRequestSettingsPage(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<Map<String,String>> actualFieldsList = getSut().getPageCreator().getWorkRequestCreatePage().getProjectFieldsList("all");

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

    @Then("{I |}'$condition' see following fields on opened Work Request '$workRequestName' Overview page: $data")
    public void checkFieldsOnWorkRequestOverviewPage(String condition, String workRequestName, ExamplesTable data) {
        openWorkRequestOverviewPage(getObjectByName(wrapVariableWithTestSession(workRequestName)).getId());
        checkFieldsOnWorkRequestOverviewPage(condition, data);
    }

    // | UserName | Message | Value |
    @Then("{I |}'$condition' see following activities in 'Recent Activity' section on opened Work Request Overview page: $data")
    public void checkThatActivityPresentOnOpenedRecentActivitySectionOnProjectOverview(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualActivities = getSut().getPageCreator().getWorkRequestOverviewPage().getActivityList();
        User user;
        for (Map<String, String> row : parametrizeTableRows(data)) {
            user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(row.get("UserName")));
            String expectedActivity = String.format("%s %s %s", user.getFullName(), row.get("Message"), row.get("Value").matches("(/.*)") ? getWrapPathToFile(row.get("Message"), row.get("Value")) : wrapVariableWithTestSession(row.get("Value"))).trim();
            assertThat(actualActivities, shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
        }
    }

    private String getWrapPathToFile(String message, String path) {
        String[] val = path.split("/");
        int size = val.length;
        path = "";
        for (int i = 1; i < size - 1; i++) {
            path += (val[i].equals("Originals") ? val[i] : wrapVariableWithTestSession(val[i])) + "/";
        }
        if(message.equals("created file from Library asset")){
            return val[size - 1] + " /" + path + val[size - 1];
        }else {
            return "/" + path + val[size - 1];
        }
    }

    @Then("{I |}'$condition' see following fields on opened Work Request Overview page: $data")
    public void checkFieldsOnWorkRequestOverviewPage(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<Map<String,String>> actualFieldsList = getSut().getPageCreator().getWorkRequestOverviewPage().getWorkRequesFieldsList();

        for (MetadataItem row : wrapMetadataFields(data, "FieldName", "FieldValue")) {
            if (asList("Start date", "End date", "Date de début", "Date de fin").contains(row.getKey()))
                row.setValue(parseDateTime(row.getValue(), TestsContext.getInstance().storiesDateTimeFormat).toString(getData().getCurrentUser().getDateTimeFormatter().getDateFormat()));

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

    @Then("{I |}'$condition' see '$button' button on Work Request '$workRequest' Overview page")
    public void checkPublishUnpublishButton(String condition, String button, String workRequest) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        workRequest = wrapVariableWithTestSession(workRequest);
        Project workRequestName = getCoreApi().getWorkRequestByName(workRequest, 0);
        boolean actualState = openWorkRequestOverviewPage(workRequestName.getId()).isPublishUnpublishButtonPresent(button);
        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' see remove button next to uploaded brief on Work Request edit popup")
    public void checkRemoveButtonNextToUploadedBrief(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getWorkRequestCreatePage().isRemoveButtonPresentNextToUploadedBrief();

        assertThat(actualState, is(expectedState));
    }

    // | IncludeFolders | IncludeTeam | IncludeFiles |
    @Then("{I |}should see following template inheritance options on opened create work request popup: $data")
    public void checkTemplateInheritanceOptions(ExamplesTable data) {
        Map<String,String> options = parametrizeTabularRow(data);
        for (String option : options.keySet()) {
            boolean actualState = getSut().getPageCreator().getWorkRequestCreatePage().isTemplateInheritanceOptionSelected(option);
            boolean expectedState = Boolean.parseBoolean(options.get(option));

            assertThat(actualState, is(expectedState));
        }
    }

    @Then("{I |}'$condition' see metadata field '$fieldNames' on Create new Work Request popup")
    public void checkThatMetadataFieldPresentsOnNewProjectPopup(String condition, String fieldNames) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualFieldsList = openCreateWorkRequestPopup().getAllMetadataFieldsNames();
        for (String expectedFieldName : fieldNames.split(","))
            assertThat(actualFieldsList, shouldState ? hasItem(expectedFieldName) : not(hasItem(expectedFieldName)));
    }


    @Then("{I |}'$condition' see activity where user '$senderEmail' shared folder '$folderName' to user '$recipientEmail' on work request Overview page")
    public void checkCreateFolder(String condition, String senderEmail, String folderName, String recipientEmail) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String senderFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(senderEmail)).getFullName();
        String recipientFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(recipientEmail)).getFullName();
        folderName = wrapPathWithTestSession(folderName);
        String expectedActivity = String.format("%s has shared folder to %s (%s) %s",
                senderFullName,
                recipientFullName,
                wrapUserEmailWithTestSession(recipientEmail),
                wrapVariableWithTestSession(folderName));

        assertThat(getActualActivities(), shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
    }

    private List<String> getActualActivities() {
        return getSut().getPageCreator().getWorkRequestOverviewPage().getActivityList();
    }

    @Then("{I |}'$condition' see activity for user '$creator' of publish work request '$workRequestName' on work request Overview page")
    public void publishObjectActivity(String condition, String creator, String workRequestName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String senderFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(creator)).getFullName();
        workRequestName = wrapPathWithTestSession(workRequestName);
        String expectedActivity = String.format("%s published project %s",
                senderFullName,
                wrapVariableWithTestSession(workRequestName));

        assertThat(getActualActivities(), shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
    }

    @Given("{I |}set following notification settings for work request '$workRequestName': $data")
    @When("{I |}set following notification settings for work request '$workRequestName': $data")
    public void setNotificationIntoStateForUserviaCore(String workRequestName,ExamplesTable data) {
        AdbankWorkRequestOverviewPage page = getSut().getPageCreator().getWorkRequestOverviewPage();
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            page.setEmailNotificationOnWRLevel(row.get("FieldName"),row.get("State").equals("On")? ("Immediately"):row.get("State") );
        }
    }

    @Given("{I |}removed administrator '$adminName' from work request '$projectName'")
    @When("{I |}remove administrator '$adminName' from work request '$projectName'")
    public void removeWorkRequestAdmin(String adminName, String workRequestName) {
        removeAdmin(adminName, workRequestName);
    }

    @Then("{I |}'$condition' see activity where user '$senderEmail' has removed user '$recipientEmail' from work request '$wRName' on work request Overview page")
    public void checkRemoveUserOnWRActivity(String condition, String senderEmail, String recipientEmail, String wRName ) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String senderFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(senderEmail)).getFullName();
        String recipientFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(recipientEmail)).getFullName();
        wRName = wrapPathWithTestSession(wRName);
        String expectedActivity = String.format("%s has removed %s (%s) from %s",
                senderFullName,
                recipientFullName,
                wrapUserEmailWithTestSession(recipientEmail),
                wrapVariableWithTestSession(wRName));

        assertThat(getActualActivities(), shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
    }

    @Then("{I |}'$condition' see activity where user '$senderEmail' shared work request '$objectName' to user '$recipientEmail' on work request Overview page")
    public void checkSharedPWRActivity(String condition, String senderEmail, String objectName, String recipientEmail) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String senderFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(senderEmail)).getFullName();
        String recipientFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(recipientEmail)).getFullName();
        objectName = wrapPathWithTestSession(objectName);
        String expectedActivity = String.format("%s has shared project to %s (%s) %s",
                senderFullName,
                recipientFullName,
                wrapUserEmailWithTestSession(recipientEmail),
                wrapVariableWithTestSession(objectName));

        assertThat(getActualActivities(), shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
    }

    @Then("I '$condition' see the link '$linkName' on work request '$templateName' overview page")
    public void checkLinksVisibilityWorkRequest(String condition, String linkName, String templateName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AdbankWorkRequestOverviewPage overviewPage = getSut().getPageCreator().getWorkRequestOverviewPage();
        assertThat(overviewPage.isLinkDisplayedByLinktext(linkName), equalTo(shouldState));
    }

}