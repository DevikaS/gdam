package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.data.Logo;
import com.adstream.automate.babylon.sut.data.MetadataItem;
import com.adstream.automate.babylon.sut.pages.PageCreator;
import com.adstream.automate.babylon.sut.pages.adbank.projects.*;
import com.adstream.automate.hamcrest.StringByRegExpCheck;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.*;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.openqa.selenium.By;

import java.util.Map;

import static com.adstream.automate.hamcrest.StringByRegExpCheck.matches;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * User: ruslan.semerenko
 * Date: 27.04.12 16:53
 */
public class TemplatesSteps extends AbstractProjectSteps {

    public AdbankTemplatesListPage openObjectListPage() {
        return getSut().getPageNavigator().getTemplateListPage();
    }

    public AdbankTemplateListWithSizePage openObjectListPage(String size) {
        return getSut().getPageNavigator().getTemplateListPage(size);
    }

    public AdbankTemplateOverviewPage openObjectOverviewPage(String objectId) {
        return getSut().getPageNavigator().getTemplateOverviewPage(objectId);
    }

    public AdbankTemplateSettingsPage openObjectSettingsPage(String objectId) {
        AdbankTemplateOverviewPage page = openObjectOverviewPage(objectId);
        if (page.isEditTemplatePopUpVisible())
            return new AdbankTemplateSettingsPage(getSut().getWebDriver());
        else
            return page.clickEdit();
    }

    public AdbankTemplateFilesPage openObjectFilesPage(String objectId) {
        return getSut().getPageNavigator().getTemplateFilesPage(objectId);
    }

    public Project getObjectByName(String objectName) {
        return getCoreApi().getTemplateByName(objectName);
    }

    public AdbankTemplatesListPage getCurrentObjectListPage() {
        return getSut().getPageCreator().getTemplateListPage();
    }

    @Given("{I am |}on Create New Template page")
    @When("{I |}go to Create New Template page")
    @Alias("{I |}open Create New Template popup")
    public AdbankTemplatesCreatePage openCreateTemplatePage() {
        AdbankTemplatesListPage page = openObjectListPage();
        if (page.isCreateNewTemplatePopUpVisible())
            return new AdbankTemplatesCreatePage(getSut().getWebDriver());
        else
            return page.clickCreateNewTemplate();
    }

    @Given("I am on template '$templateName' settings page")
    @When("{I |}open template '$templateName' settings page")
    public AdbankTemplateSettingsPage openTemplateSettingPage(String templateName) {
        templateName = wrapVariableWithTestSession(templateName);
        Project template = getCoreApi().getTemplateByName(templateName);
        return openObjectSettingsPage(template.getId());
    }

    @Given("{I |}'$state'-ed include '$elementName' for template")
    @When("{I |}'$state' include '$elementName' for template")
    public void checkElementTrue(String state, String elementName) {
        boolean isChecked = state.equalsIgnoreCase("check");
        checkElement("Include" + elementName, "ProjectsCreateFromTemplate", isChecked);
    }

    @Given("{I |} added agency project team '$aptName' into template '$templateName'")
    @When("{I |} add agency project team '$aptName' into template '$templateName'")
    public void addAPTIntoTemplate(String aptName, String templateName) {
        addAPTIntoObject(aptName, templateName);
    }

    private void checkElement(String elementName, String pageName, boolean isChecked) {
        By elementLocator = getSut().getUIMap().getByPageName(pageName, elementName);
        getSut().getWebDriver().setCheckBoxTo(elementLocator, isChecked);
        Common.sleep(1000);
    }

   // @Pending //NGN-6679 - no more overview page in template
    @Given("I am on template '$templateName' overview page")
    @When("I go to template '$templateName' overview page")
    public void goToTemplateOverviewPage(String templateName) {
        Project template = getCoreApi().getTemplateByName(wrapVariableWithTestSession(templateName));
        openObjectOverviewPage(template.getId());
    }

    @When("I go to template '$templateName' teams page using UI")
    public void goToTemplateTeamsPageUsingUI(){
        AdbankTemplateOverviewPage page = getSut().getPageCreator().getTemplateOverviewPage();
        page.clickTeamtab();
    }

    @Given("{I |}deleted '$projectName' template")
    @When("{I |}delete '$projectName' template")
    public void deleteProjectOverCoreApi(String templateName){
        templateName = wrapVariableWithTestSession(templateName);
        Project template = getCoreApi().getTemplateByName(templateName, 0);
        getCoreApi().deleteProject(template.getId());
    }

    @Given("I click on Delete template on overview page")
    @When("I clicked on Delete template on overview page")
    public void clickDeleteProjectLink(){
        AdbankTemplateOverviewPage page = getSut().getPageCreator().getTemplateOverviewPage();
        page.clickDeleteTemplateLink();
    }

    //@Pending //NGN-6679 - no more overview page in template
    @Then("I '$condition' see edit link for current template")
    public void checkEditLinkVisibilityForTemplate(String condition) {
        AdbankTemplateOverviewPage templateOverviewPage = getSut().getPageCreator().getTemplateOverviewPage();
        assertThat(templateOverviewPage.isEditLinkVisible(), equalTo(condition.equalsIgnoreCase("should")));
    }

    @Given("{I |}created '$template' template with '$fields' and '$logo' logo")
    public void createTemplateOverCoreApi(String templateName, String fields, String logo) {
        templateName = wrapVariableWithTestSession(templateName);
        Project template = getTemplateBuilder().getProject(templateName, fields, Logo.valueOf(logo));
        if (getCoreApi().getTemplateByName(templateName, 0) == null) {
            getCoreApi().createProject(template);
            getCoreApi().getTemplateByName(templateName); //slow down, template should be indexed
        }
    }

    @When("{I |}upload big logo '$logoName' to template")
    public void uploadLargeLogoToProject(String logoName) {
        openCreateTemplatePage().uploadLogo(getFilePath(logoName));
    }

    @Given("{I |}created '$template' template with '$fields'")
    public void createTemplateOverCoreApi(String templateName, String fields) {
        createTemplateOverCoreApi(templateName, fields, Logo.EMPTY.toString());
    }

    @Given("{I |}created '$templateName' template")
    @When("{I |}create '$templateName' template")
    public void createTemplateOverCoreApi(String templateName) {
        createTemplateOverCoreApi(templateName, null);
    }

    @Given("{I |}created '$templatesCount' templates with name pattern '$namePattern'")
    public void generateCommonTemplates(int templatesCount, String namePattern) {
        for (int i = 1; i <= templatesCount; i++) {
            createTemplateOverCoreApi(String.format("%s_%d", namePattern, i));
        }
    }

    @Given("{I |}created template with name pattern '$namePattern' while templates count less than '$expectedCount'")
    public void appendTemplates(String namePattern, int expectedCount) {
        int actualCount = getCoreApi().getTemplatesCount();
        int difCount = expectedCount - actualCount;
        if (difCount > 0) generateCommonTemplates(difCount, namePattern + actualCount);
    }

    // | Name | Advertiser | Product/Brand | Campaign | Media Type | Logo | Administrators |
    @Given("the following templates were created: $templatesTable")
    @Alias("{I |}created following templates: $templatesTable")
    public void createTemplateOverCoreApiUsingTable(ExamplesTable templatesTable) {
        for (int i = 0; i < templatesTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(templatesTable, i);
            if (row.get("AdvertiserUnique") != null) {
                row.put("Advertiser", wrapVariableWithTestSession(row.get("AdvertiserUnique")));
            }
            if (row.get("Product/BrandUnique") != null) {
                row.put("Product/Brand", wrapVariableWithTestSession(row.get("Product/BrandUnique")));
            }
            Project template = getTemplateBuilder().getProject(row);
            if (getCoreApi().getTemplateByName(template.getName(), 0) == null) {
                getCoreApi().createProject(template);
                getCoreApi().getTemplateByName(template.getName());
            }
        }
    }

    // | Name | Advertiser | Product/Brand | Campaign | Media Type | Logo | Administrators |
    @Given("{I |}edited the following fields for '$templateName' template: $fieldsTable")
    @When("{I |}edit the following fields for '$templateName' template: $fieldsTable")
    public void editFields(String templateName, ExamplesTable fieldsTable) {
        editObjectFields(templateName, fieldsTable);
    }

    // | Name | Template | Include Folders | Include Team | Include Files | Job Number | Media Type | Start Date | End Date | Logo | Administrators |
    @Then("I should see the following data for project from template: $dataTable")
    public void checkFieldsOnCreateProjectFromTemplatePage(ExamplesTable dataTable) {
        Common.sleep(1000);
        Map<String, String> data = parametrizeTabularRow(dataTable);
        Project project = getProjectBuilder().getProject(data);

        AdbankProjectFromTemplateCreatePage projectCreatePage = new PageCreator(getSut().getWebDriver()).getCreateProjectFromTemplatePage();
        if (data.get("Media Type") != null) {
            assertThat(projectCreatePage.getMediaType(), equalTo(project.getMediaType()));
        }
        if (data.get("Template") != null)
            assertThat(projectCreatePage.getTemplateName(), equalTo(wrapVariableWithTestSession(data.get("Template"))));
    }

    // | Name | Template | Include Folders | Include Team | Include Files | Job Number | Advertiser | Product/Brand | Campaign | Media Type | Start Date | End Date | Logo | Administrators |
    @When("{I |}fill the following fields for project from template: $fieldsTable")
    public void fillFieldsFroProjectFromTemplate(ExamplesTable fieldsTable) {
        Map<String, String> data = parametrizeTabularRow(fieldsTable);
        Project project = getProjectBuilder().getProject(data);
        AdbankProjectFromTemplateCreatePage projectCreatePage = new PageCreator(getSut().getWebDriver()).getCreateProjectFromTemplatePage();
        Map<String, String> prepareObject = prepareObjectFields(project);
        if (!data.containsKey("Business Unit"))
            prepareObject.remove("Business Unit");

        projectCreatePage.fill(prepareObject);
        if (data.get("Template") != null)
            projectCreatePage.setTemplateName(wrapVariableWithTestSession(data.get("Template")));
        if (data.get("Include Folders") != null)
            projectCreatePage.includeFolders.setSelected(data.get("Include Folders").equals("true"));
        if (data.get("Include Team") != null)
            projectCreatePage.includeTeam.setSelected(data.get("Include Team").equals("true"));
        if (data.get("Include Files") != null)
            projectCreatePage.includeFiles.setSelected(data.get("Include Files").equals("true"));
    }

    @When("{I |}check Publish Immediately checkbox on opened Create Project From Template popup")
    public void fillFieldsFroProjectFromTemplate() {
        getSut().getPageCreator().getCreateProjectFromTemplatePage().selectPublishImmediatelyCheckbox();
    }

    @When("I create '$templateName' template with '$fields'")
    public void createTemplate(String templateName, String fields) {
        createTemplate(templateName, fields, "EMPTY");
    }


    @When("I create '$templateName' template with '$fields' and '$logo' logo")
    public void createTemplate(String templateName, String fields, String logo) {
        openCreateTemplatePage();
        AdbankTemplatesCreatePage page = fillFields(fields, logo, templateName);
        Common.sleep(1000);
        page.saveButton.click();
        Common.sleep(1500);
    }

    @When("I fill '$fields' for '$templateName' template")
    public AdbankTemplatesCreatePage fillFields(String fields, String templateName) {
        return fillFields(fields, "EMPTY", templateName);
    }

    @When("I fill '$fields' and '$logo' logo for '$templateName' template")
    public AdbankTemplatesCreatePage fillFields(String fields, String logo, String templateName) {
        templateName = wrapVariableWithTestSession(templateName);
        Project template = getTemplateBuilder().getProject(templateName, fields, Logo.valueOf(logo));
        Map<String, String> prepareObject = prepareObjectFields(template);
        prepareObject.remove("Business Unit");
        return getSut().getPageCreator().getTemplateCreatePage().fill(prepareObject);
    }

    @Given("I filled following fields on create new template page: $data")
    @When("I fill following fields on create new template page: $data")
    @Alias("{I |}fill following fields on Create New Template popup: $data")
    public void fillTemplatesFields(ExamplesTable data) {
        for (MetadataItem row : wrapMetadataFields(data, "FieldName", "FieldValue")) {
            String fieldName = row.getKey();
            String fieldValue = row.getValue();

            if (fieldName.equals("Logo")) {
                getSut().getPageCreator().getTemplateCreatePage().uploadLogo(Logo.valueOf(fieldValue).getPath());
            } else {
                if (fieldName.equals("Start date") || fieldName.equals("End date")) {
                    DateTimeFormatter dateTimeFormatter = DateTimeFormat.forPattern(getContext().userDateTimeFormat);

                    if (fieldValue.equalsIgnoreCase("Today")) {
                        fieldValue = DateTime.now().toString(dateTimeFormatter);
                    } else if (fieldValue.equalsIgnoreCase("Yesterday")) {
                        fieldValue = DateTime.now().minusDays(1).toString(dateTimeFormatter);
                    } else if (fieldValue.equalsIgnoreCase("Tomorrow")) {
                        fieldValue = DateTime.now().plusDays(1).toString(dateTimeFormatter);
                    } else {
                        fieldValue = DateTimeFormat.forPattern(TestsContext.getInstance().storiesDateTimeFormat)
                                .parseDateTime(fieldValue).toString(dateTimeFormatter);
                    }
                } else if (row.getKey().equals("Business Unit")) {
                    fieldValue = wrapAgencyName(fieldValue);
                }
                getSut().getPageCreator().getTemplateCreatePage().fillFieldByName(fieldName, fieldValue);
            }
        }
    }

    // | FieldName | FieldValue |
    // Note: don't give FieldName with symbol '
    @Given("{I |}created new template with following fields: $data")
    @When("{I |}create new template with following fields: $data")
    public void createProjectThrowsUI(ExamplesTable data) {
        openCreateTemplatePage();
        fillTemplatesFields(data);
        clickSaveBtn();
    }

    // | FieldName | FieldValue |
    // Note: don't give FieldName with symbol '
    @Given("{I |}created new template with following fields for Client: $data")
    @When("{I |}create new template with following fields for Client: $data")
    public void createClientTemplateThroughUI(ExamplesTable data) {
        openCreateTemplatePage();
        fillTemplatesFieldsClient(data);
        clickSaveBtn();
    }

    @Given("I filled following fields on create new template page for Client: $data")
    @When("I fill following fields on create new template page for Client: $data")
    public void fillTemplatesFieldsClient(ExamplesTable data) {
        for (MetadataItem row : wrapMetadataFields(data, "FieldName", "FieldValue")) {
            if(row.getKey().equalsIgnoreCase("Name"))
                row.setKey("Project Name");
            if(row.getKey().equalsIgnoreCase("Brand"))
                //Removing the session id from Brand
                row.setValue(row.getValue().substring(0,row.getValue().length()-5));
            if(row.getKey().equalsIgnoreCase("ProjectID")) {
                if (row.getValue().equalsIgnoreCase("Auto")){
                    row.setKey("adCodeAutoButton");
                }
            }
                getSut().getPageCreator().getTemplateCreatePage().fillFieldByName(row.getKey(), row.getValue());

        }
    }

    @Given("I specifyed template name '$templateName' on create template page")
    @When("I specify template name '$templateName' on create template page")
    public void specifyTemplateNameOnCreateTemplatePage(String templateName) {
        AdbankTemplateFromProjectCreatePage adbankTemplateFromProjectCreatePage = getSut().getPageCreator().getCreateTemplateFromProjectPage();
        adbankTemplateFromProjectCreatePage.setName(wrapVariableWithTestSession(templateName));
    }

    @When("{I |}click Save button on template popup")
    public void clickSaveBtnTemplatePopup() {
       clickSaveBtn();
    }

    @When("{I |}click Save button on template popup without delay")
    public void clickSaveBtnTemplatePopupWithoutDelay() {
        clickSaveBtnWithoutDelay();
    }

    @When("{I |}select Include Team checkbox on Create Template from Project page")
    public void selectIncludeTeam() {
        AdbankTemplateFromProjectCreatePage adbankTemplateFromProjectCreatePage = getSut().getPageCreator().getCreateTemplateFromProjectPage();
        adbankTemplateFromProjectCreatePage.includeTeam.select();
        Common.sleep(500);
    }

    @When("I open template '$templateName' files page")
    public AdbankTemplateFilesPage openProjectFilesPage(String templateName) {
        templateName = wrapVariableWithTestSession(templateName);
        Project project = getCoreApi().getTemplateByName(templateName);
        return openObjectFilesPage(project.getId());
    }

    @When("{I |}remove administrator '$adminName' from template '$templateName'")
    public void removeTemplateAdmin(String adminName, String templateName) {
        removeAdmin(adminName, templateName);
    }

    @Then("{I |}'$shouldState' see administrator '$adminName' on template '$templateName' settings tab")
    public void checkTemplateAdmin(String shouldState, String adminName, String templateName) {
        checkAdmin(shouldState, adminName, templateName);
    }

    // users comma-separated
    @Then("I '$shouldState' see delete link for users '$users' on template '$templateName' settings page")
    public void checkDeleteButton(String shouldState, String users, String templateName) {
        for (String user : users.split(",")) {
            checkDeleteAdminLink(templateName, user, shouldState.equalsIgnoreCase("should"));
        }
    }
//    @Pending //NGN-6679 - no more overview page in template
    @Then("I '$condition' see delete template link on template '$templateName' overview page")
    public void checkDeleteTemplateLink(String condition, String templateName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        Project template = getCoreApi().getTemplateByName(wrapVariableWithTestSession(templateName));
        AdbankTemplateOverviewPage templateOverviewPage = getSut().getPageNavigator().getTemplateOverviewPage(template.getId());
        assertThat(templateOverviewPage.isDeleteTemplateLinkVisible(), equalTo(shouldState));
    }

    @Then("{I |}'$shouldState' see administrator '$adminName' on create new template page")
    public void checkAdmin(String shouldState, String adminName) {
        checkCreationAdmin(shouldState, adminName);
    }

    @Then("{I |}should see count '$count' of administrators on create new template page")
    public void checkCountAdmin(int count) {
        checkCountAdministrators(count);
    }

    @Then("{I |}'$shouldState' see Template Owners section while edit template '$templateName'")
    public void checkVisibilityTemplateOwnersSection(String shouldState, String templateName) {
        checkVisibilityOwnersSection(shouldState, templateName);
    }

    @Then("on upload big logo '$logoName' I should see message error '$message'on templates page")
    public void uploadLargeLogoToTemplateandCheckMessage(String logoName,String message){
        //openCreateProjectPage().uploadLogo(getFilePath(logoName));
        openCreateTemplatePage().uploadLogoBig(getFilePath(logoName));
        String actualMessage = getSut().getPageCreator().getBasePage().getErrorMessage();
        assertThat(actualMessage, StringByRegExpCheck.matches(message));
    }

    // | Name | Media Type | Logo | Administrators | Job Number |
    @Pending //NGN-6679 - no more overview page in template
    @Then("I should see on template overview page '$templateName' the following fields: $fieldsTable")
    public void checkTemplateFieldsOverviewPage(String templateName, ExamplesTable fieldsTable) {
        Map<String, String> fields = parametrizeTabularRow(fieldsTable, 0);
        Project template = getTemplateBuilder().getProject(fields);
        AdbankTemplateOverviewPage adbankTemplateOverviewPage;
        if (template.getId() != null) {
            adbankTemplateOverviewPage = getSut().getPageNavigator().getTemplateOverviewPage(template.getId());
        } else {
            adbankTemplateOverviewPage = getSut().getPageCreator().getTemplateOverviewPage();
        }

        if (fields.get("Name") != null) {
            assertThat("Name", adbankTemplateOverviewPage.getName(), equalTo(template.getName()));
        }

        if (fields.get("Logo") != null) {
            byte[] emptyLogo = Logo.EMPTY.getBytes();
            byte[] templateLogo = adbankTemplateOverviewPage.getLogo();
            if (fields.get("Logo").equals("EMPTY")) {
                assertThat("User logo is not empty!", templateLogo.length, equalTo(emptyLogo.length));
            } else {
                assertThat("User logo " + fields.get("Logo") + " is not loaded!", templateLogo.length, not(equalTo(emptyLogo.length)));
            }
        }
        /*  there is no jobnumber on template page
        if (fields.get("Job Number") != null) {
            assertThat("Job Number",adbankTemplateOverviewPage.getJobNumber(), equalTo(decorator.getJobNumber()));
        } */
        if (fields.get("Administrators") != null) {
            assertThat("Administrators", adbankTemplateOverviewPage.getAdministrator(), containsString(getData().getCurrentUser().getFullName()));
            for (String admin : template.getAdministrators()) {
                User user = getCoreApi().getUserByEmail(admin);
                if (user != null ) {
                    String userName = user.getFullName();
                    if (userName == null)
                        userName = user.getEmail();
                    assertThat("Administrators", adbankTemplateOverviewPage.getAdministrator(), containsString(userName));
                } else {
                    throw new NullPointerException("User wasn't found by following email " + admin + " !");
                }
            }
        }
    }

//    @Pending //NGN-6679 - no more overview page in template
    @Then("{I |}should see template '$templateName' overview page")
    public void checkTemplateOverviewPage(String templateName) {
        Project template = getObjectByName(wrapVariableWithTestSession(templateName));
        assertThat(getSut().getWebDriver().getCurrentUrl(), matches(".*projects/templates/" + template.getId() + "/overview.*"));
    }

    @Then("'$templateName' template should include '$fields'")
    public void checkTemplateFields(String templateName, String fields) {
        checkTemplateFields(templateName, fields, "EMPTY"); //todo NGN-1280
    }

    @Then("'$templateName' template should include '$fields' and '$logo' logo")
    public void checkTemplateFields(String templateName, String fields, String logo) {
        Project template = getObjectByName(wrapVariableWithTestSession(templateName));
        AdbankTemplateSettingsPage settingsPage = openTemplateSettingPage(template.getName());
        assertThat(settingsPage.getName(), equalTo(template.getName()));
        assertThat(settingsPage.getMediaType(), equalTo(template.getMediaType()));

        byte[] realLogo = Logo.valueOf(logo).getBytes(); //not used
        byte[] projectLogo = settingsPage.getLogo();
        if (logo.equals("EMPTY_PROJECT_LOGO")) {
            for (int i = 0; i < realLogo.length; i++) {
                assertThat(projectLogo[i], equalTo(realLogo[i]));
            }
        } else {
            assertThat("Logo length is not empty", projectLogo.length, not(equalTo(0)));
        }
    }

    @Then("{I |}'$condition' option 'Allow other users in my Business Unit to create projects from this template' on create template popup")
    public void isCreateProjectFromTemplate(String condition) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getTemplateCreatePage().isFlagOfPublicTemplate();
        assertThat(shouldState, is(actualState));
    }
}
