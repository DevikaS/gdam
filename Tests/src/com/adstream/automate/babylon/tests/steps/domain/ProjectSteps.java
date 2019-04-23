package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.JsonObjects.CustomMetadata;
import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.JsonObjects.schema.Schema;
import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.data.CustomMetadataSchemaName;
import com.adstream.automate.babylon.data.Logo;
import com.adstream.automate.babylon.sut.data.MetadataItem;
import com.adstream.automate.babylon.sut.pages.PageCreator;
import com.adstream.automate.babylon.sut.pages.adbank.projects.*;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AdbankFilesPage;
import com.adstream.automate.babylon.tests.steps.domain.adcost.AdCostsHelperSteps;
import com.adstream.automate.hamcrest.StringByRegExpCheck;
import com.adstream.automate.utils.Common;

import org.codehaus.plexus.util.FileUtils;
import org.jbehave.core.annotations.Alias;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;
import org.joda.time.DateTimeZone;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.TimeoutException;

import java.awt.*;
import java.awt.event.KeyEvent;
import java.io.*;
import java.lang.reflect.Method;
import java.util.*;
import java.util.List;

import static com.adstream.automate.hamcrest.StringByRegExpCheck.matches;
import static java.util.Arrays.asList;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created by IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 24.01.12
 * Time: 15:54
 */
public class ProjectSteps extends AbstractProjectSteps implements ProjectActivity {
    public AdbankProjectsListPage openObjectListPage() {
        return getSut().getPageNavigator().getProjectListPage();
    }

    public AdbankProjectOverviewPage openProjectOverviewPage(String objectId) {
        return getSut().getPageNavigator().getProjectOverviewPage(objectId);
    }

    public AdbankProjectSettingsPage openObjectSettingsPage(String objectId) {
        AdbankProjectOverviewPage page = openProjectOverviewPage(objectId);
        if (page.isEditProjectPopUpVisible())
            return new AdbankProjectSettingsPage(getSut().getWebDriver());
        else
            return page.clickEdit();
    }

    public AdbankProjectFilesPage openObjectFilesPage(String objectId) {
        return getSut().getPageNavigator().getProjectFilesPage(objectId, "");
    }

    public AdbankProjectsListPage getCurrentObjectListPage() {
        return getSut().getPageCreator().getProjectListPage();
    }

    public Project getObjectByName(String objectName) {
        return getCoreApi().getProjectByName(objectName);
    }

    @Given("{I am |}on Create New Project page")
    @When("{I |}go to Create New Project page")
    @Alias("{I |}open Create New Project popup")
    public AdbankProjectsCreatePage openCreateProjectPage() {
        AdbankProjectsListPage page = getSut().getPageNavigator().getProjectListPage();
        if (page.isCreateNewProjectPopUpVisible())
            return new AdbankProjectsCreatePage(getSut().getWebDriver());
        else
            return page.clickNewProject();
    }

    @Given("{I am |}on Create New Project page without delay")
    @When("{I |}go to Create New Project page without delay")
    @Alias("{I |}open Create New Project popup without delay")
    public AdbankProjectsCreatePage openCreateProjectPage_withOutDelay() {
        AdbankProjectsListPage page = getSut().getPageNavigator().getProjectListPage_withOutDelay();
        if (page.isCreateNewProjectPopUpVisible())
            return new AdbankProjectsCreatePage(getSut().getWebDriver());
        else
            return page.clickNewProject();
    }

    @Given("{I |}created '$projectName' project with '$fields'")
    public void createProjectOverCoreApi(String projectName, String fields) {
        projectName = wrapVariableWithTestSession(projectName);
        Project project = getProjectBuilder().getProject(projectName, fields);
        if (getCoreApi().getProjectByName(projectName, 0) == null) {
            getCoreApi().createProject(project);
            getCoreApi().getProjectByName(projectName);  //slow down, be sure that project available for search
        }
    }

    // Step specific to UAT env's, so don't use this step for QA env's
    @Given("{I |}created '$projectName' project with '$fields' with Delay")
    public void createProjectOverCoreApiWithDelay(String projectName, String fields) {
        projectName = wrapVariableWithTestSession(projectName);
        Project project = getProjectBuilder().getProject(projectName, fields);
        if (getCoreApi().getProjectByName(projectName, 0) == null) {
            Common.sleep(3000);
            getCoreApi().createProject(project);
            getCoreApi().getProjectByName(projectName);  //slow down, be sure that project available for search
        }
    }

    @Given("{I |}created '$projectName' project")
    @When("{I |}created '$projectName' project")
    public void createDefaultProjectOverCoreApi(String projectName) {
         createProjectOverCoreApi(projectName, null);
    }

    @Given("{I |}deleted '$projectName' project")
    @When("{I |}delete '$projectName' project")
    public void deleteProjectOverCoreApi(String projectName){
        projectName = wrapVariableWithTestSession(projectName);
        Project project = getCoreApi().getProjectByName(projectName, 0);
        getCoreApi().deleteProject(project.getId());
    }

    // | Name | Job Number | Advertiser | Product/Brand | Campaign | Media Type | Start Date | End Date | Logo | Administrators | AdvertiserUnique | Business Unit | Custom Code
    @Given("the following projects were created: $projectsTable")
    @Alias("{I |}created following projects: $projectsTable")
    @When("{I |}create following projects: $projectsTable")
    public void createProjectOverCoreApiUsingTable(ExamplesTable projectsTable) {
        for (int i = 0; i < projectsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(projectsTable, i);
            if (row.get("AdvertiserUnique") != null) {
                row.put("Advertiser", wrapVariableWithTestSession(row.get("AdvertiserUnique")));
            }
            if (row.get("Product/BrandUnique") != null) {
                row.put("Product/Brand", wrapVariableWithTestSession(row.get("Product/BrandUnique")));
            }
            if (row.get("Business Unit") != null) {
                row.put("Business Unit", wrapAgencyName(row.get("Business Unit")));
            }
            Project project = getProjectBuilder().getProject(row);
            Project projectApi = getCoreApi().getProjectByName(project.getName(), 0);
            if (projectApi == null) {
                getCoreApi().createProject(project);
                getCoreApi().getProjectByName(project.getName()); //slow down, be sure that project available for search
            }
            log.debug("I created new project with name: " + project.getName());
        }
    }

    // Method specific to Adcost due to CustomCode requirement
    @Given("{I |}created a project in agency '$agencyName' with following fileds: $fields")
    public void createProject(String agencyName,ExamplesTable fields){
        String agencyId = getAgencyIdByName(agencyName);
        String sName = CustomMetadataSchemaName.findByName("project");
        Schema schema_common = new MetadataSteps().getSchemaByName("common", agencyId);
        Schema schema = new MetadataSteps().getSchemaByName(sName, agencyId);
        Agency agency = getAgencyByName(agencyName);
        Map<String,String> customFields = new HashMap<>();

        String[] customData = new String[2];
        for (int i = 0; i < fields.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fields, i);
            if (row.get("Advertiser") != null) {
                row.put("Advertiser", wrapVariableWithTestSession(row.get("Advertiser")));
            }
            String sectorData=null;
            if (row.containsKey("Sector")) {
                String sector = "Sector".concat("_");
                CustomMetadata data = schema_common.getCmSectionProperties("common");
                String s = data.toString();
                String randomNumber = s.split(sector)[1].split("=")[0];
                String sectorName = sector.concat(randomNumber);
                customFields.put(sectorName,wrapVariableWithTestSession(row.get("Sector")));
                row.remove("Sector");
            }
            String brandData=null;
            if (row.containsKey("Brand")) {
                String brand = "Brand".concat("_");
                CustomMetadata data = schema_common.getCmSectionProperties("common");
                String s = data.toString();
                String randomNumber = s.split(brand)[1].split("=")[0];
                String brandName = brand.concat(randomNumber);
                customFields.put(brandName,wrapVariableWithTestSession(row.get("Brand")));
                row.remove("Brand");
            }
            String customCodeName=null;
            if (row.containsKey("Custom Code")) {
                String customCodeFieldName = row.get("Custom Code").concat("_");
                CustomMetadata data = schema.getCmSectionProperties("common");
                String s = data.toString();
                String randomNumber = s.split(customCodeFieldName)[1].split("=")[0];
                customCodeName = customCodeFieldName.concat(randomNumber);
                String customCodeValue = getCoreApi().generateCustomCode(agency.getId(),customCodeName);
                customData[0] = customCodeName;
                customData[1] = customCodeValue;
                row.remove("Custom Code");
            }

            Project project = getProjectBuilder().getProject(row);

            project.setAgency(agency);
            Project projectApi = getCoreApi().getProjectByName(project.getName(), 0);
            project.buildCustomFieldsAsArray(customFields);
            project.buildCustomFieldsAsString(customData[0],customData[1]);
            if (projectApi == null) {
                getCoreApi().createProject(project);
                getCoreApi().getProjectByName(project.getName()); //slow down, be sure that project available for search
            }
        }
        AdCostsHelperSteps adCostsHelperSteps = new AdCostsHelperSteps();
        adCostsHelperSteps.waitUntilReplicationToCostModule("Projects", fields);
    }


    // Method specific to Adcost due to CustomCode requirement
    @Given("{I |}created a project in agency '$agencyName' without session wrap with following fileds: $fields")
    @When("{I |}create a project in agency '$agencyName' without session wrap with following fileds: $fields")
    public void createProjectWithOutSession(String agencyName,ExamplesTable fields){
        String agencyId = getAgencyIdByName(agencyName);
        String sName = CustomMetadataSchemaName.findByName("project");
        Schema schema_common = new MetadataSteps().getSchemaByName("common", agencyId);
        Schema schema = new MetadataSteps().getSchemaByName(sName, agencyId);
        Agency agency = getAgencyByName(agencyName);
        Map<String,String> customFields = new HashMap<>();

        String[] customData = new String[2];
        for (int i = 0; i < fields.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fields, i);
            if (row.get("Advertiser") != null) {
                row.put("Advertiser", (row.get("Advertiser")));
            }
            String sectorData=null;
            if (row.containsKey("Sector")) {
                String sector = "Sector".concat("_");
                CustomMetadata data = schema_common.getCmSectionProperties("common");
                String s = data.toString();
                String randomNumber = s.split(sector)[1].split("=")[0];
                String sectorName = sector.concat(randomNumber);
                customFields.put(sectorName,(row.get("Sector")));
                row.remove("Sector");
            }
            String brandData=null;
            if (row.containsKey("Brand")) {
                String brand = "Brand".concat("_");
                CustomMetadata data = schema_common.getCmSectionProperties("common");
                String s = data.toString();
                String randomNumber = s.split(brand)[1].split("=")[0];
                String brandName = brand.concat(randomNumber);
                customFields.put(brandName,(row.get("Brand")));
                row.remove("Brand");
            }
            String customCodeName=null;
            if (row.containsKey("Custom Code")) {
                String customCodeFieldName = row.get("Custom Code").concat("_");
                CustomMetadata data = schema.getCmSectionProperties("common");
                String s = data.toString();
                String randomNumber = s.split(customCodeFieldName)[1].split("=")[0];
                customCodeName = customCodeFieldName.concat(randomNumber);
                String customCodeValue = getCoreApi().generateCustomCode(agency.getId(),customCodeName);
                customData[0] = customCodeName;
                customData[1] = customCodeValue;
                row.remove("Custom Code");
            }

            Project project = getProjectBuilder().getProject(row);

            project.setAgency(agency);
            Project projectApi = getCoreApi().getProjectByName(project.getName(), 0);
            project.buildCustomFieldsAsArray(customFields);
            project.buildCustomFieldsAsString(customData[0],customData[1]);
            if (projectApi == null) {
                getCoreApi().createProject(project);
                getCoreApi().getProjectByName(project.getName()); //slow down, be sure that project available for search
            }
        }
        AdCostsHelperSteps adCostsHelperSteps = new AdCostsHelperSteps();
        adCostsHelperSteps.waitUntilReplicationToCostModule("Projects", fields);
    }

    // NGN-16211-QAA: User from multiple BU's should see all Advertiser values in Project Filters code Changes Starts
        @Given("the following projects were created with Advertiser hierarchy: $projectsTable")
        @Alias("{I |}created following projects with Advertiser hierarchy: $projectsTable")
        @When("{I |}create following projects with Advertiser hierarchy: $projectsTable")
        public void createProjectOverCoreApiwithAdvertiserHierUsingTable(ExamplesTable projectsTable) {
       for (int i = 0; i < projectsTable.getRowCount(); i++) {
        Map<String, String> row = parametrizeTabularRow(projectsTable, i);
        if (row.get("AdvertiserUnique") != null && !row.get("AdvertiserUnique").isEmpty()) {
            row.put("Advertiser", wrapVariableWithTestSession(row.get("AdvertiserUnique")));
        }
        if (row.get("Product/BrandUnique") != null && !row.get("Product/BrandUnique").isEmpty() ) {
            row.put("Product/Brand", wrapVariableWithTestSession(row.get("Product/BrandUnique")));
        }
        if (row.get("ProductUnique") != null && !row.get("ProductUnique").isEmpty()) {
            row.put("Product", wrapVariableWithTestSession(row.get("ProductUnique")));
        }
        if (row.get("SubBrandUnique") != null  && !row.get("SubBrandUnique").isEmpty()) {
            row.put("SubBrand", wrapVariableWithTestSession(row.get("SubBrandUnique")));
        }
        if (row.get("Business Unit") != null) {
            row.put("Business Unit", wrapAgencyName(row.get("Business Unit")));
        }
        Project project = getProjectBuilder().getProjectwithAdvertiserHier(row);
        Project projectApi = getCoreApi().getProjectByName(project.getName(), 0);
        if (projectApi == null) {
            getCoreApi().createProject(project);
            getCoreApi().getProjectByName(project.getName()); //slow down, be sure that project available for search
        }
        log.debug("I created new project with name: " + project.getName());
    }
}

    // NGN-16211-QAA: User from multiple BU's should see all Advertiser values in Project Filters code Changes Ends
    @Given("{I |}created '$projectsCount' projects with name pattern '$namePattern'")
    public void generateCommonProjects(int projectsCount, String namePattern) {
        for (int i = 1; i <= projectsCount; i++) {
            createDefaultProjectOverCoreApi(String.format("%s_%d", namePattern, i));
        }
    }

    @Then("{I |}should be able to enter the following users in project activity filter: $userTable")
    public void checkUserNameIsAdded(ExamplesTable userTable) {
        for (int i = 0; i < userTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(userTable, i);
            getSut().getPageCreator().getProjectOverviewPage().typeFilterUserName(wrapUserEmailWithTestSession(row.get("UserName")));
            assertThat(wrapUserEmailWithTestSession(row.get("UserName")), equalTo(getSut().getPageCreator().getProjectOverviewPage().getUserName()));
        }

    }

    @Given("{I |}created '$projectNames' projects")
    @When("{I |}created '$projectNames' projects")
    public void createProjects(String projectNames) {
        for (String projectName : projectNames.split(",")) {
            createDefaultProjectOverCoreApi(projectName);
        }
    }

    @Given("{I |}created project with name pattern '$namePattern' while projects count less than '$expectedCount'")
    public void appendProjects(String namePattern, int expectedCount) {
        int actualCount = getCoreApi().getProjectsCount();
        int difCount = expectedCount - actualCount;
        if (difCount > 0) generateCommonProjects(difCount, namePattern + actualCount);
    }

    @Given("{I am |}on project '$projectName' settings page")
    @When("{I |}open project '$projectName' settings page")
    public AdbankProjectSettingsPage openProjectSettingsPage(String projectName) {
        projectName = wrapVariableWithTestSession(projectName);
        Project project = getCoreApi().getProjectByName(projectName);
        return openObjectSettingsPage(project.getId());
    }

    @Given("I click on Delete project on overview page")
    @When("I clicked on Delete project on overview page")
    public void clickDeleteProjectLink(){
        AdbankProjectOverviewPage page = getSut().getPageCreator().getProjectOverviewPage();
        page.clickDeleteProjectLink();
    }

    @When("I open project '$projectName' files page")
    public AdbankProjectFilesPage openProjectFilesPage(String projectName) {
        projectName = wrapVariableWithTestSession(projectName);
        Project project = getCoreApi().getProjectByName(projectName);
        return openObjectFilesPage(project.getId());
    }

    @When("I open client project '$projectName' files page")
    public AdbankProjectFilesPage openProjectFilesPageForClient(String projectName) {
        Project project = getCoreApi().getProjectByName(projectName);
        return openObjectFilesPage(project.getId());
    }

    @When("{I |}upload big logo '$logoName' to project")
    public void uploadLargeLogoToProject(String logoName) {
        openCreateProjectPage().uploadLogo(getFilePath(logoName));
    }


    @When("{I |}create '$projectName' project")
    public void createDefaultProject(String projectName) {
        log.debug("I execute step: createDefaultProject(String projectName)");
        createProjectWithLogo(projectName, "MandatoryFields", Logo.EMPTY.toString());
    }

    @When("I create '$projectName' project with '$fields'")
    public void createProject(String projectName, String fields) {
        createProjectWithLogo(projectName, fields, Logo.EMPTY.toString());
    }

    @When("I create '$projectName' project with '$fields' and '$logo' logo")
    public void createProjectWithLogo(String projectName, String fields, String logo) {
        Project project = getProjectBuilder().getProject(wrapVariableWithTestSession(projectName), fields, Logo.valueOf(logo));
        AdbankProjectsCreatePage page = openCreateProjectPage();
        Map<String, String> prepareObject = prepareObjectFields(project);
        prepareObject.remove("Business Unit");
        page.fill(prepareObject);
        Common.sleep(5000);
        page.saveButton.click();
        getSut().getWebDriver().waitUntilElementAppearVisible(By.cssSelector("[data-dojo-type='adbank.projects.sidebar']")); // wait until folder tree appears instead of sleep
    }

    @When("I create '$projectName' project with '$fields' and '$logo' logo without delay")
    public void createProjectWithLogoWithoutDelay(String projectName, String fields, String logo) {
        Project project = getProjectBuilder().getProject(wrapVariableWithTestSession(projectName), fields, Logo.valueOf(logo));
        AdbankProjectsCreatePage page = openCreateProjectPage();
        Map<String, String> prepareObject = prepareObjectFields(project);
        prepareObject.remove("Business Unit");
        page.fill(prepareObject);
        Common.sleep(5000);
        page.saveButton.click();

    }

    @Then("'$projectName' project should include '$fields'")
    public void checkProjectFields(String projectName, String fields) {
        checkProjectFields(projectName, fields, "EMPTY");
    }

    @Given("{I |}waited while upload revision '$number' for file '$fileName' is finished on project '$projectName' overview page")
    @When("{I |}wait while upload revision '$number' for file '$fileName' is finished on project '$projectName' overview page")
    public void waitForProjectFilesRevisionTranscodingFinished(String revNum, String fileName, String projectName) {
        Project project = getObjectByName(wrapVariableWithTestSession(projectName));
        AdbankProjectOverviewPage overviewPage = openProjectOverviewPage(project.getId());
        long start = System.currentTimeMillis();
        boolean finished;
        do {
            Common.sleep(3000);
            finished = (overviewPage.getFilesWithTheSameNameCount(fileName) == (Integer.parseInt(revNum) + 1));
            if (!finished) {
                Common.sleep(7000);
                getSut().getWebDriver().navigate().refresh();
            }
        } while (System.currentTimeMillis() - start < 120000 && !finished); // wait 2 minutes
        if (!finished) throw new TimeoutException("Timeout while waiting for file revision transcoding");
    }

    @Then("{I |}'$condition' see metadata field '$fieldNames' on New Project popup")
    public void checkThatMetadataFieldPresentsOnNewProjectPopup(String condition, String fieldNames) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualFieldsList = openCreateProjectPage().getAllMetadataFieldsNames();

        for (String expectedFieldName : fieldNames.split(","))
            assertThat(actualFieldsList, shouldState ? hasItem(expectedFieldName) : not(hasItem(expectedFieldName)));
    }

    @Then("on upload big logo '$logoName' I should see message error '$message'on projects page")
    public void uploadLargeLogoToProjectandCheckMessage(String logoName,String message){
        //openCreateProjectPage().uploadLogo(getFilePath(logoName));
        openCreateProjectPage().uploadLogoBig(getFilePath(logoName));
        String actualMessage = getSut().getPageCreator().getBasePage().getErrorMessage();
        assertThat(actualMessage, StringByRegExpCheck.matches(message));
   }


    @Then("{I |}'$condition' see multiline field '$fieldName' with rows count '$expectedRowsCount' on New Project popup")
    public void checkThatMultilineFieldRowsCountOnNewProjectPopup(String condition, String fieldName, String expectedRowsCount) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String actualFieldsList = openCreateProjectPage().getMultilineFieldRowsCount(fieldName);

        assertThat(actualFieldsList, shouldState ? equalTo(expectedRowsCount) : not(equalTo(expectedRowsCount)));
    }

    @Then("{I |}'$condition' see multiline field '$fieldName' with rows count '$expectedRowsCount' on Edit Project '$projectName' popup")
    public void checkThatMultilineFieldRowsCountOnEditProjectPopup(String condition, String fieldName, String expectedRowsCount, String projectName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String actualFieldsList = openProjectSettingsPage(projectName).getMultilineFieldRowsCount(fieldName);

        assertThat(actualFieldsList, shouldState ? equalTo(expectedRowsCount) : not(equalTo(expectedRowsCount)));
    }

    @Then("{I |}'$condition' see metadata field '$fieldNames' marked as required on New Project popup")
    public void checkThatMetadataFieldMarkedAsRequiredOnNewProjectPopup(String condition, String fieldNames) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualFieldsList = openCreateProjectPage().getAllRequiredMetadataFieldsNames();

        for (String expectedFieldName : fieldNames.split(","))
            assertThat(actualFieldsList, shouldState ? hasItem(expectedFieldName) : not(hasItem(expectedFieldName)));
    }

    @Then("{I |}'$condition' see metadata field '$fieldNames' marked as required on opened Edit Project popup")
    public void checkThatMetadataFieldMarkedAsRequiredOnEditProjectPopup(String condition, String fieldNames) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualFieldsList = getSut().getPageCreator().getProjectSettingsPage().getAllRequiredMetadataFieldsNames();

        for (String expectedFieldName : fieldNames.split(","))
            assertThat(actualFieldsList, shouldState ? hasItem(expectedFieldName) : not(hasItem(expectedFieldName)));
    }

    @When("I create new project '$projectName' with '$fields'")
    public void createProjectwithNodelay(String projectName, String fields) {
        //createProjectWithLogo(projectName, fields, Logo.EMPTY.toString());
        Project project = getProjectBuilder().getProject(wrapVariableWithTestSession(projectName), fields, Logo.EMPTY);
        AdbankProjectsCreatePage page = openCreateProjectPage();
        Map<String, String> prepareObject = prepareObjectFields(project);
        prepareObject.remove("Business Unit");
        page.fill(prepareObject);
        Common.sleep(5000);
        page.saveButton.click();
    }

    @Then("{I |}'$condition' see field '$fieldNames' with size '$fieldSize' on New Project popup")
    public void checkFieldSize(String condition, String fieldNames, String fieldSize) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState;
        AdbankProjectsCreatePage popup = openCreateProjectPage();

        for (String fieldName : fieldNames.split(",")) {
            actualState = popup.isFieldHaveSize(fieldName, fieldSize);
            assertThat(actualState, is(expectedState));
        }
    }

    @Then("{I |}'$condition' see disabled field '$fieldNames' on New Project popup")
    public void checkThatFieldDisabled(String condition, String fieldNames) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState;
        AdbankProjectsCreatePage popup = openCreateProjectPage();

        for (String fieldName : fieldNames.split(",")) {
            actualState = popup.isFieldDisabled(fieldName);
            assertThat(actualState, is(expectedState));
        }
    }

    // | Advertiser | Brand | Sub Brand | Product |
    @Then("{I |}'$condition' see following Advertiser chain on Create New Project popup: $data")
    public void checkFieldSize(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AdbankProjectsCreatePage page = openCreateProjectPage();

        Map<String,String> row = parametrizeTabularRow(data);
        if (row.get("Advertiser") != null && !row.get("Advertiser").isEmpty()) {
            String expectedAdvertiser = wrapVariableWithTestSession(row.get("Advertiser"));
            assertThat(page.getComboboxFieldValuesByName("Advertiser"), shouldState ? hasItem(expectedAdvertiser) : not(hasItem(expectedAdvertiser)));
            page.fillFieldByName("Advertiser", expectedAdvertiser);

            if (row.get("Brand") != null && !row.get("Brand").isEmpty()) {
                String expectedBrand = wrapVariableWithTestSession(row.get("Brand"));
                assertThat(page.getComboboxFieldValuesByName("Brand"), shouldState ? hasItem(expectedBrand) : not(hasItem(expectedBrand)));
                page.fillFieldByName("Brand", expectedBrand);

                if (row.get("Sub Brand") != null && !row.get("Sub Brand").isEmpty()) {
                    String expectedSubBrand = wrapVariableWithTestSession(row.get("Sub Brand"));
                    assertThat(page.getComboboxFieldValuesByName("Sub Brand"), shouldState ? hasItem(expectedSubBrand) : not(hasItem(expectedSubBrand)));
                    page.fillFieldByName("Sub Brand", expectedSubBrand);

                    if (row.get("Product") != null && !row.get("Product").isEmpty()) {
                        String expectedProduct = wrapVariableWithTestSession(row.get("Product"));
                        assertThat(page.getComboboxFieldValuesByName("Product"), shouldState ? hasItem(expectedProduct) : not(hasItem(expectedProduct)));
                        page.fillFieldByName("Product", expectedProduct);
                    }
                }
            }
        }
    }

    @Then("'$projectName' project should include '$fields' and '$logo' logo")
    public void checkProjectFields(String projectName, String fields, String logo) {
        projectName = wrapVariableWithTestSession(projectName);
        Project project = getObjectByName(projectName);
        //DateTimeFormatter dateFormatter = DateTimeFormat.forPattern(getData().getCurrentUser().getDateTimeFormatter().getDateFormat());
        DateTimeFormatter dateFormatter = DateTimeFormat.forPattern(getData().getCurrentUser().getDateTimeFormatter().getProjectOverviewDateFormat());

        AdbankProjectOverviewPage overviewPage = openProjectOverviewPage(project.getId());
        assertThat("Name", overviewPage.getName(), equalTo(project.getName()));
        assertThat("Start date", overviewPage.getStartDate(), equalTo(project.getDateStart().toDateTime(DateTimeZone.getDefault()).toString(dateFormatter)));
        //assertThat(overviewPage.getAdministrator(), equalTo(decorator.getAdministrators()[0])); //todo
        assertThat("Job Number", overviewPage.getJobNumber(), equalTo(project.getJobNumber()));
        assertThat("End date", overviewPage.getEndDate(), equalTo(project.getDateEnd().toDateTime(DateTimeZone.getDefault()).toString(dateFormatter)));
        //TODO MEDIATYPE

        byte[] realLogo = Logo.valueOf(logo).getBytes();
        byte[] projectLogo = overviewPage.getLogo();
        if (logo.equals("EMPTY_PROJECT_LOGO")) {
            assertThat("Logo is empty", projectLogo.length, equalTo(realLogo.length));
        } else {
            assertThat("Logo length is not empty", projectLogo.length, not(equalTo(0)));
        }
    }

    // | Name | Job Number | Advertiser | Product/Brand | Campaign | Media Type | Start Date | End Date | Logo | Administrators |
    @Then("Project '$projectName' should include the following fields: $fieldsTable")
    public void checkProjectsFields(String projectName, ExamplesTable fieldsTable) {
        Map<String, String> fields = parametrizeTabularRow(fieldsTable);
        Project project = getProjectBuilder().getProject(fields);
       // DateTimeFormatter dateFormatter = DateTimeFormat.forPattern(getData().getCurrentUser().getDateTimeFormatter().getDateFormat());
        DateTimeFormatter dateFormatter = DateTimeFormat.forPattern(getData().getCurrentUser().getDateTimeFormatter().getProjectOverviewDateFormat());

        projectName = project.getName().replace("\\", "\\\\");
        Project projectFromApi = getObjectByName(projectName);
        AdbankProjectOverviewPage projectOverviewPage = openProjectOverviewPage(projectFromApi.getId());

        if (fields.get("Name") != null)
            assertThat(projectOverviewPage.getName(), equalTo(project.getName()));
        if (fields.get("Media Type") != null)
            assertThat(projectOverviewPage.getMediaType(), equalTo(project.getMediaType()));
        if (fields.get("Start Date") != null)
            assertThat(projectOverviewPage.getStartDate(), equalTo(project.getDateStart().toDateTime(DateTimeZone.getDefault()).toString(dateFormatter)));
        if (fields.get("Job Number") != null)
            assertThat(projectOverviewPage.getJobNumber(), equalTo(project.getJobNumber()));
        if (fields.get("End Date") != null) {
            assertThat(projectOverviewPage.getEndDate(), equalTo(project.getDateEnd().toDateTime(DateTimeZone.getDefault()).toString(dateFormatter)));
        }
        if (fields.get("Logo") != null) {
            byte[] realLogo = Logo.valueOf(fields.get("Logo")).getBytes();
            byte[] projectLogo = projectOverviewPage.getLogo();
            if (fields.get("Logo").equals("EMPTY")) {
                assertThat("Logo length", projectLogo.length, equalTo(realLogo.length));
                for (int i = 0; i < realLogo.length; i++) {
                    assertThat(projectLogo[i], equalTo(realLogo[i]));
                }
            } else {
                assertThat("Logo length", projectLogo.length, not(equalTo(realLogo.length)));
            }
        }
        if (fields.get("Administrators") != null) {
            String administrators = projectOverviewPage.getAdministrator();
            for (String admin : project.getAdministrators()) {
                User user = getCoreApiAdmin().getUserByEmail(admin);
                if (user != null ) {
                    String name = user.isEasyUser() ? user.getEmail() : user.getFullName();
                    if (name == null)
                        name = user.getEmail();
                    assertThat("Administrators", administrators, containsString(name));
                } else {
                    throw new NullPointerException("User wasn't found by following email " + admin + " !");
                }
            }
        }
    }

    @Then("I should see valid generated job number for project '$projectName'")
    public void checkGeneratedJobNumber(String projectName) {
        Project project = getObjectByName(wrapVariableWithTestSession(projectName));
        AdbankProjectOverviewPage projectOverviewPage = openProjectOverviewPage(project.getId());
        String expectedJobNumber = null;
        String jobNumber = projectOverviewPage.getJobNumber();
        assertThat(jobNumber, startsWith(expectedJobNumber));
        assertThat(jobNumber.substring(expectedJobNumber.length()), matches("\\d+"));
    }

    @When("I fill '$fields' and '$logo' logo for '$projectName' project")
    public void fillFields(String fields, String logo, String projectName) {
        projectName = wrapVariableWithTestSession(projectName);
        Project project = getProjectBuilder().getProject(projectName, fields, Logo.valueOf(logo));
        prepareObjectFields(project).remove("Business Unit");
        openCreateProjectPage().fill(prepareObjectFields(project));
    }

    // | Name | Job Number | Advertiser | Product/Brand | Campaign | Media Type | Start Date | End Date | Logo | Administrators |

    @When("{I |}fill the following fields for project: $data")
    public void fillFields(ExamplesTable data) {
        Map<String, String> prepareObject = prepareObjectFields(getProjectBuilder().getProject(parametrizeTabularRow(data)));
        if (!data.getHeaders().contains("Business Unit"))
            prepareObject.remove("Business Unit");
        openCreateProjectPage().fill(prepareObject);
    }

        // | FieldName  | FieldValue |
    // | Start date | End date   |
    // Note: don't give FieldName with symbol '
    @Given("{I |}filled following fields on Create New Project popup: $data")
    @When("{I |}fill following fields on Create New Project popup: $data")
    @Alias("{I |}update following fields on Edit Project popup: $data")
    public void fillProjectFields(ExamplesTable data) {
        for (MetadataItem row : wrapMetadataFields(data, "FieldName", "FieldValue")) {
            if (asList("Start date", "End date", "Date de début", "Date de fin").contains(row.getKey()))
                row.setValue(parseDateTime(row.getValue()).toString(getContext().userDateTimeFormat));
            if (row.getKey().equalsIgnoreCase("Business Init"))
                Common.sleep(1000);
            if (row.getKey().equalsIgnoreCase("Business Unit")) {
                getSut().getPageCreator().getCreateProjectPage().setSelectProjectAgency(row.getValue());
                Common.sleep(1000);
                continue;
            }
            if(row.getKey().equalsIgnoreCase("Publish Immediately")) {
                getSut().getPageCreator().getCreateProjectPage().publishImmediately(row.getValue());
                continue;
            }
            getSut().getPageCreator().getCreateProjectPage().fillFieldByName(row.getKey(), row.getValue());
        }
    }

    // | FieldName  | FieldValue |
    // | Start date | End date   |
    // Note: don't give FieldName with symbol '
    @Given("{I |}filled following fields on Create New Project popup for Client: $data")
    @When("{I |}fill following fields on Create New Project popup for Client: $data")
    @Alias("{I |}update following fields on Edit Project popup for Client: $data")
    public void fillProjectFieldsClient(ExamplesTable data) {
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
            }if(row.getKey().equals("Project Owners")){
                    for (String admin : row.getValue().split(","))
                        getSut().getPageCreator().getCreateProjectPage().addAdministrator(admin);
            }else {
                getSut().getPageCreator().getCreateProjectPage().fillFieldByName(row.getKey(), row.getValue());
            }
        }
    }

    // | FieldName | FieldValue |
    // Note: don't give FieldName with symbol '
    @Given("{I |}created new project with following fields: $data")
    @When("{I |}create new project with following fields: $data")
    public void createProjectThrowsUI(ExamplesTable data) {
        Common.sleep(3000);
        openCreateProjectPage();
        fillProjectFields(data);
        clickSaveBtn();
    }

    // | FieldName | FieldValue |
    // Note: don't give FieldName with symbol '
    @Given("{I |}created new project with following fields for Cost Module: $data")
    @When("{I |}create new project with following fields for Cost Module: $data")
    public void createProjectThrowsUIForCostModule(ExamplesTable data) {
        for (MetadataItem row : wrapMetadataFields(data, "FieldName", "FieldValue")) {
            if (row.getKey().equalsIgnoreCase("Name")) {
                if(getCoreApi().getProjectByName(row.getValue(), 0)==null) {
                    openCreateProjectPage_withOutDelay();
                    fillProjectFields(data);
                    clickSaveBtn();
                    break;
                }
            }
        }
    }

    // | FieldName | FieldValue |
    // Note: don't give FieldName with symbol '
    @Given("{I |}created new project with following fields for Client: $data")
    @When("{I |}create new project with following fields for Client: $data")
    public void createClientProjectThrowsUI(ExamplesTable data) {
        Common.sleep(3000);
        openCreateProjectPage();
        fillProjectFieldsClient(data);
        clickSaveBtn();
    }


    // should || should not
    @Then("{I |}'$condition' see '$fieldName' field as disabled")
    public void checkFieldIsDisabled(String condition,String fieldName)
    {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState;

        openCreateProjectPage();
        actualState=getSut().getPageCreator().getCreateProjectPage().disabledCustomCodeFieldByName(fieldName);
        assertThat(actualState, is(expectedState));
    }


    // | FieldName | FieldValue |
    // Note: don't give FieldName with symbol '
    @When("{I |}update project '$projectName' with following fields on Edit Project popup: $data")
    public void updateProjectFields(String projectName, ExamplesTable data) {
        openProjectSettingsPage(projectName);
        fillProjectFields(data);
        clickSaveBtn();
    }

    @Then("{I |}'$condition' see following fields on opened Project '$projectName' Overview page: $data")
    public void checkFieldsOnProjectOverviewPage(String condition, String projectName, ExamplesTable data) {
        openProjectOverviewPage(getObjectByName(wrapVariableWithTestSession(projectName)).getId());
        checkFieldsOnProjectOverviewPage(condition, data);
    }

    @Then("{I |}'$condition' see following fields on opened Project Overview page: $data")
    public void checkFieldsOnProjectOverviewPage(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<Map<String,String>> actualFieldsList = getSut().getPageCreator().getProjectOverviewPage().getProjectFieldsList();

        for (MetadataItem row : wrapMetadataFields(data, "FieldName", "FieldValue")) {
            if (asList("Start date", "End date", "Date de début", "Date de fin").contains(row.getKey()))
                row.setValue(parseDateTime(row.getValue()).toString(getData().getCurrentUser().getDateTimeFormatter().getDateFormat()));

            Map<String,String> expectedField = new HashMap<>();
            expectedField.put(row.getKey(), row.getValue());

            assertThat(actualFieldsList, shouldState ? hasItem(expectedField) : not(hasItem(expectedField)));
        }
    }

    @Then("{I |}'$condition' see following fields on opened Edit Project popup: $data")
    public void checkFieldsOnProjectSettingsPage(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<Map<String,String>> actualFieldsList = getSut().getPageCreator().getProjectSettingsPage().getProjectFieldsList("all");

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

    @Then("{I |}'$condition' see following fields on opened Create Project popup: $data")
    public void checkFieldsOnProjectCreatePage(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<Map<String,String>> actualFieldsList = getSut().getPageCreator().getCreateProjectPage().getProjectFieldsList("all");

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

    @Then("I should see on the current project popup that following fields contains values: $data")
    public void checkValuesOnCurrentProjectsPopup(ExamplesTable data) {
        for (Map<String,String> row : parametrizeTableRows(data)) {
            List<String> actualFieldsValuesList = getSut().getPageCreator().getCreateProjectPage().getAllRadioButtonsValues(row.get("FieldName"));
            for (String value: row.get("FieldValue").split(",")) {
                assertThat(actualFieldsValuesList, hasItem(value.trim()));
            }

        }

    }

    @Then("{I |}'$condition' see following fields marked as required on opened Edit Project popup: $data")
    public void checkFieldsRequiredOnProjectSettingsPage(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<Map<String,String>> actualFieldsList = getSut().getPageCreator().getProjectSettingsPage().getProjectFieldsList("required");


        for (Map<String,String> row : parametrizeTableRows(data)) {
            if (row.get("FieldName").equals("Name")) {
                row.put("FieldValue", wrapVariableWithTestSession(row.get("FieldValue")));
            }

            Map<String,String> expectedField = new HashMap<>();
            expectedField.put(row.get("FieldName"), row.get("FieldValue"));

            assertThat(actualFieldsList, shouldState ? hasItem(expectedField) : not(hasItem(expectedField)));
        }
    }


    @Then("{I |}'$condition' see field '$fieldNames' with size '$fieldSize' on opened Edit Project popup")
    public void checkFieldSizeOnEditProjectPopup(String condition, String fieldNames, String fieldSize) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState;
        AdbankProjectSettingsPage page = getSut().getPageCreator().getProjectSettingsPage();

        for (String fieldName : fieldNames.split(",")) {
            actualState = page.isFieldHaveSize(fieldName, fieldSize);
            assertThat(actualState, is(expectedState));
        }
    }

    @Then("{I |}'$condition' see field '$fieldName' with size '$fieldSize' on opened Project overview page")
    public void checkFieldSizeOnProjectOverviewPage(String condition, String fieldNames, String fieldSize) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState;
        AdbankProjectOverviewPage page = getSut().getPageCreator().getProjectOverviewPage();

        for (String fieldName : fieldNames.split(",")) {
            actualState = page.isFieldHaveSize(fieldName, fieldSize);
            assertThat(actualState, is(expectedState));
        }
    }

    @Given("{I |}clicked Save button on project popup")
    @When("{I |}click Save button on project popup")
    public void clickSaveBtnProjectPopup() {
        clickSaveBtn();
    }


    @Given("{I |}clicked Save button on project popup without Delay")
    @When("{I |}click Save button on project popup without Delay")
    public void clickSaveBtnProjectPopupWithoutDelay() {
        clickSaveBtnWithoutDelay();
    }


    // | Name | Job Number | Advertiser | Product/Brand | Campaign | Media Type | Start Date | End Date | Logo | Administrators |
    @Given("{I |}edited the following fields for '$projectName' project: $fieldsTable")
    @When("{I |}edit the following fields for '$projectName' project: $fieldsTable")
    public void editFields(String projectName, ExamplesTable fieldsTable) {
        editObjectFields(projectName, fieldsTable);
    }

    @Then("{I |}'$shouldState' see Project Owners section while edit project '$projectName'")
    public void checkVisibilityProjectOwnersSection(String shouldState, String projectName) {
        checkVisibilityOwnersSection(shouldState, projectName);


    }

    @When("{I |}'$state' include '$elementName' for project")
    public void checkElementTrue(String state, String elementName) {
        boolean isChecked = state.equalsIgnoreCase("check");
        checkElement("Include" + elementName, "ProjectsCreateFromTemplate", isChecked);
    }

    private void checkElement(String elementName, String pageName, boolean isChecked) {
        By elementLocator = getSut().getUIMap().getByPageName(pageName, elementName);
        getSut().getWebDriver().setCheckBoxTo(elementLocator, isChecked);
        Common.sleep(1000);
    }

    @Given("{I |}removed administrator '$adminName' from project '$projectName'")
    @When("{I |}remove administrator '$adminName' from project '$projectName'")
    public void removeProjectAdmin(String adminName, String projectName) {
        removeAdmin(adminName, projectName);
    }

    @Then("{I |}'$shouldState' see administrator '$adminName' on project '$projectName' settings tab")
    public void checkProjectAdmin(String shouldState, String adminName, String projectName) {
        checkAdmin(shouldState, adminName, projectName);
    }

    @Then("{I |}'$shouldState' see administrator '$adminName' on create new project page")
    public void checkAdmin(String shouldState, String adminName) {
        checkCreationAdmin(shouldState, adminName);
    }

    @Then("{I |}should see count '$count' of administrators on create new project page")
    public void checkCountAdmin(int  count) {
        checkCountAdministrators(count);
    }

    // users comma-separated
    @Then("I '$shouldState' see delete link for users '$users' on project '$projectName' settings page")
    public void checkDeleteButton(String shouldState, String users, String projectName) {
        for (String user : users.split(",")) {
            checkDeleteAdminLink(projectName, user, shouldState.equalsIgnoreCase("should"));
        }
    }

    @Then("{I |}should see project '$projectName' overview page")
    public void checkProjectOverviewPage(String projectName) {
        Project project = getObjectByName(wrapVariableWithTestSession(projectName));
        assertThat(getSut().getWebDriver().getCurrentUrl(), matches(".*/(adbank|projects)#/projects/projects/" + project.getId() + "/overview.*"));
    }

    @Then("{I |}'$condition' see project overview page")
    public void checkThatProjectOverviewPagePresent(String condition) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AdbankProjectOverviewPage projectOverviewPage = null;

        try {
            projectOverviewPage = getSut().getPageCreator().getProjectOverviewPage();
        } catch (Exception e) {
            log.debug(e.getMessage());
        } finally {
            String assertionMessage = String.format("I %s see project overview page", condition);
            assertThat(assertionMessage, projectOverviewPage, shouldState ? notNullValue() : nullValue());
        }
    }

    @Then("I should not see upload button for project '$projectName'")
    public void checkUploadButtonIsVisible(String projectName) {
        AdbankProjectFilesPage adbankProjectFilesPage = openProjectFilesPage(projectName);
        assertThat("Check that upload button is invisible without folders", adbankProjectFilesPage.isUploadButtonVisible(), equalTo(false));
    }

    @Given("{I |}clicked create template from project for project '$projectName'")
    @When("{I |}click create template from project for project '$projectName'")
    public AdbankTemplateFromProjectCreatePage clickCrateTemplateFromProject(String projectName) {
        Project project = getObjectByName(wrapVariableWithTestSession(projectName));
        AdbankProjectOverviewPage adbankProjectOverviewPage = getSut().getPageNavigator().getProjectOverviewPage(project.getId());
        return adbankProjectOverviewPage.clickCreateTemplateFromProject();
    }

    @Given("I specifyed template name '$templateName' on Create New Project popup")
    @When("I specify template name '$templateName' on Create New Project popup")
    public void specifyTemplateNameOnCreateProjectPopUp(String templateName) {
        AdbankProjectsCreatePage adbankProjectsCreatePage = getSut().getPageNavigator().getCreateProjectPage();
        adbankProjectsCreatePage.setTemplateName(wrapVariableWithTestSession(templateName));
    }

    @Given("I specifyed template name '$templateName' on Create New Project popup via UI")
    @When("I specify template name '$templateName' on Create New Project popup via UI")
    public void specifyTemplateNameOnCreateProjectPopUpUI(String templateName) {
        AdbankProjectsCreatePage adbankProjectsCreatePage = new AdbankProjectsCreatePage(getSut().getWebDriver()) ;
        adbankProjectsCreatePage.setTemplateName(wrapVariableWithTestSession(templateName));
    }

    @Given("I typed template name '$templateName' on Create New Project popup")
    @When("I type template name '$templateName' on Create New Project popup")
    public void typeTemplateNameOnCreateProjectPopUp(String templateName) {
        AdbankProjectsCreatePage adbankProjectsCreatePage = getSut().getPageNavigator().getCreateProjectPage();
        adbankProjectsCreatePage.typeTemplateName(templateName);
    }

    @Then("{I |}should see in autocomplete popup following search template results '$searchResult'")
    public void checkTemplatesSearchResults(String searchResult) {
        AdbankProjectsCreatePage adbankProjectsCreatePage = getSut().getPageNavigator().getCreateProjectPage();
        String[] results = searchResult.split(",");
        for (String result : results) {
            String templateName = wrapVariableWithTestSession(result);
            assertThat(adbankProjectsCreatePage.templateTextBox.getValues(), hasItem(templateName));
        }
    }

    // | Name | Template | Include Folders | Include Team | Include Files | Job Number | Advertiser | Product/Brand | Campaign | Media Type | Start Date | End Date | Logo | Administrators |
    @Then("I should see the following data for project with specified template name on Create New Project popup: $dataTable")
    public void checkFieldsOnCreateProjectPopUp(ExamplesTable dataTable) {
        Common.sleep(1000);
        Map<String, String> data = parametrizeTabularRow(dataTable);
        Project project = getProjectBuilder().getProject(data);
        AdbankProjectsCreatePage projectsCreatePopUp = new PageCreator(getSut().getWebDriver()).getCreateProjectPage();
        assertThat(projectsCreatePopUp.getMediaType(), equalTo(project.getMediaType()));
        if (data.containsKey("Logo")) {
            byte[] uploadedLogo = Logo.valueOf(data.get("Logo")).getBytes();
            assertThat(projectsCreatePopUp.getLogo().length, equalTo(uploadedLogo.length));
        }
        assertThat(projectsCreatePopUp.getAdministrators().size(), equalTo(project.getAdministrators().length));
        for (int i=0; i < project.getAdministrators().length; i++) {
            User user = getCoreApi().getUserByEmail(project.getAdministrators()[i]);
            assertThat(projectsCreatePopUp.getAdministrators(), hasItem(user.getFullName()));
        }
        if (data.containsKey("Template"))    {
            assertThat(projectsCreatePopUp.getTemplateName(), equalTo(wrapVariableWithTestSession(data.get("Template"))));
        }
        if (data.containsKey("Include Folders"))  {
            assertThat(projectsCreatePopUp.includeFolders.isVisible(), equalTo(true));
            assertThat(projectsCreatePopUp.includeFolders.isSelected(), equalTo(data.get("Include Folders").equals("true")));
        }
        if (data.containsKey("Include Team")) {
            assertThat(projectsCreatePopUp.includeTeam.isVisible(), equalTo(true));
            assertThat(projectsCreatePopUp.includeTeam.isSelected(), equalTo(data.get("Include Team").equals("true")));
        }
        if (data.containsKey("Include Files")) {
            assertThat(projectsCreatePopUp.includeFiles.isVisible(), equalTo(true));
            assertThat(projectsCreatePopUp.includeFiles.isSelected(), equalTo(data.get("Include Files").equals("true")));
        }
    }

    @Then("{I |}'$shouldState' see Create template from project link on project '$projectName' overview page")
    public void checkVisibilityCreateTemplateFromProjectLink(String shouldState, String projectName) {
        boolean should = shouldState.equals("should");
        Project project = getObjectByName(wrapVariableWithTestSession(projectName));
        AdbankProjectOverviewPage adbankProjectOverviewPage = getSut().getPageNavigator().getProjectOverviewPage(project.getId());
        assertThat(adbankProjectOverviewPage.isCreateTemplateFromProjectLinkVisible(), equalTo(should));
    }

    @Then("I '$condition' see delete project link on project '$templateName' overview page")
    public void checkDeleteTemplateLink(String condition, String templateName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        Project project = getCoreApi().getProjectByName(wrapVariableWithTestSession(templateName));
        AdbankProjectOverviewPage projectOverviewPage = getSut().getPageNavigator().getProjectOverviewPage(project.getId());
        assertThat(projectOverviewPage.isDeleteProjectLinkVisible(), equalTo(shouldState));
    }

    @Then("{I |}'$condition' see project '$projectNames' on project list page")
    public void checkProjectVisibleOnProjectListPage(String condition, String projectNames) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> projectsList = openObjectListPage().getProjectsList();

        if (projectNames.isEmpty()) {
            assertThat(projectsList.size(), shouldState ? is(0) : not(is(0)));
        } else {
            for (String projectName : projectNames.split(",")) {
                String expectedProjectName = wrapVariableWithTestSession(projectName);
                assertThat(projectsList, shouldState ? hasItem(expectedProjectName) : not(hasItem(expectedProjectName)));
            }
        }
    }

    @When("I go to project '$projectName' page were link was formed according to agency admin")
    public void openProjectUrl(String projectName) {
        try {
            String projectId = getCoreApiAdmin().getProjectByName(wrapVariableWithTestSession(projectName)).getId();
            getSut().getPageNavigator().getProjectOverviewPage(projectId);
        }
        catch (Exception e) { /**/ }
    }

    @Given("{I |} added agency project team '$aptName' into project '$projectName'")
    @When("{I |} add agency project team '$aptName' into project '$projectName'")
    public void addAPTIntoProject(String aptName, String projectName) {
        addAPTIntoObject(aptName, projectName);
        /*String projectId = getCoreApi().getProjectByName(wrapVariableWithTestSession(projectName)).getId();
        LuceneSearchingParams query = new LuceneSearchingParams();
        query.setQuery("name=" + wrapVariableWithTestSession(aptName) + "*");
        String aptId = getCoreApi().findAgencyProjectTeam(query).get_id();
        getCoreApi().addObjectToAgencyProjectTeam(aptId, projectId);*/
    }

    @When("{I |}select business unit '$businessUnit' on projects list page")
    public void selectBusinessUnit(Agency businessUnit) {
        openObjectListPage().selectBusinessUnit(businessUnit.getName());
    }

    @Then("{I |}'$shouldState' see Projects page")
    public void checkUrlProjectsPage(String shouldState) {
        boolean should = shouldState.equalsIgnoreCase("should");
        assertThat(getSut().getWebDriver().getCurrentUrl(), should ? containsString("projects") : not(containsString("projects")));
    }

    @Then("{I |}'$condition' be on the project overview page")
    public void checkThatOpenedPageIsProjectFilesPage(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState;
        try {
            getSut().getPageNavigator().getProjectOverviewPage() ;
            actualState = true;
        } catch (Exception e) {
            e.printStackTrace();
            actualState = false;
        }
        assertThat("I'm on project overview page", actualState, is(expectedState));
    }

    // | UserName | Message | Value |
    @Then("{I |}'$condition' see following activities in 'Recent Activity' section on Project Overview page: $data")
    public void checkThatActivityPresentOnRecentActivitySectionOnProjectOverview(String condition, ExamplesTable data) {
        getSut().getPageNavigator().getProjectOverviewPage();
        checkThatActivityPresentOnOpenedRecentActivitySectionOnProjectOverview(condition, data);
    }

    @Then("{I |}'$condition' see activity where user '$user' create project '$project' on Project Overview page")
    public void checkCreateProject(String condition, String user, String project) {
        createObject(condition, user, project);
    }

    @Then("{I |}'$condition' see activity where user '$user' create folder '$project' on Project Overview page")
    public void checkCreateFolder(String condition, String user, String project) {
        createFolder(condition, user, project);
    }

    @Then("{I |}'$condition' see activity where user '$senderEmail' shared project '$projectName' to user '$recipientEmail' on Project Overview page")
    public void checkCreateProject(String condition, String senderEmail, String projectName, String recipientEmail) {
        sharedProjectToUserActivity(condition, senderEmail, projectName, recipientEmail);
    }

    @Then("{I |}'$condition' see activity where user '$senderEmail' shared folder '$folderName' to user '$recipientEmail' on Project Overview page")
    public void checkCreateFolder(String condition, String senderEmail, String folderName, String recipientEmail) {
        sharedFolderToUserActivity(condition, senderEmail, folderName, recipientEmail);
    }

    @Then("{I |}'$condition' see activity where user '$user' update project '$project' on Project Overview page")
    public void checkUpdateProject(String condition, String user, String project) {
        updateObject(condition, user, project);
    }

    // | UserName | Message | Value |
    @Then("{I |}'$condition' see following activities in 'Recent Activity' section on opened Project Overview page: $data")
    public void checkThatActivityPresentOnOpenedRecentActivitySectionOnProjectOverview(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualActivities = getSut().getPageCreator().getProjectOverviewPage().getActivityList();
        User user;
        for (Map<String, String> row : parametrizeTableRows(data)) {
            user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(row.get("UserName")));
            String expectedActivity = String.format("%s %s %s", user.getFullName(), row.get("Message"), row.get("Value").contains("/") ? getWrapPathToFile(row.get("Message"),row.get("Value")) : wrapVariableWithTestSession(row.get("Value"))).trim();
            assertThat(actualActivities, shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
        }
    }

    private String getWrapPathToFile(String message, String path) {
        boolean startsWithSlash = path.startsWith("/");
        String[] val = path.split("/");
        int size = val.length;
        path = "";
        for (int i = 0; i < size - 1; i++) {
            if (val[i].isEmpty()) {
                continue;
            }
            path += val[i] + getData().getSessionId() + "/";
        }
        if (message.matches("created file from Library asset|uploaded 1 files")){
            return val[size - 1] + " " + (startsWithSlash ? "/" : "") + path + val[size - 1];
        } else {
            return (startsWithSlash ? "/" : "") + path + val[size - 1];
        }
    }

    @When("{I |}select Publish Immediately checkbox on opened Create Project popup")
    public void selectPublishImmediatelyCheckbox() {
        getSut().getPageCreator().getCreateProjectPage().selectPublishImmediatelyCheckbox();
    }

    @Then("{I |}'$condition' see selected Publish Immediately checkbox on opened Create Project popup")
    public void checkPublishImmediatelyCheckboxState(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getCreateProjectPage().isPublishImmediatelyCheckboxSelected();

        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' see selected Template field on opened Create Project popup")
    public void checkTemplateFieldVisibilityState(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getCreateProjectPage().isTemplateFieldVisible();

        assertThat(actualState, is(expectedState));
    }

    // remove {I |}'$shouldState' see activity for user '$userName' on project '$projectName' overview page with message '$message' and value '$value'
    @Then("{I |}'$condition' see activity where user '$uploaderEmail' upload file '$filePath' in project '$project' on Project Overview page")
    public void checkUploadFileInProjectActivity(String condition, String uploaderEmail, String filePath, String projectName) {
        openProjectOverviewPage(getObjectByName(wrapVariableWithTestSession(projectName)).getId());
        uploadFileActivity(condition, uploaderEmail, projectName + filePath);
    }

    @Then("{I |}'$condition' see activity where user '$userEmail' download file master '$filePath' in project '$project' on Project Overview page")
    public void checkUserDownloadFileInProjectActivity(String condition, String userEmail, String filePath, String projectName) {
        openProjectOverviewPage(getObjectByName(wrapVariableWithTestSession(projectName)).getId());
        downloadMasterFile(condition, userEmail, filePath);
    }


    @Then("{I |}'$condition' see activity where user '$userEmail' download file proxy '$filePath' in project '$project' on Project Overview page")
    public void checkUserDownloadFileProxyInProjectActivity(String condition, String userEmail, String filePath, String projectName) {
        openProjectOverviewPage(getObjectByName(wrapVariableWithTestSession(projectName)).getId());
        downloadProxyFile(condition, userEmail, filePath);
    }

    @Then("{I |}'$condition' see activity where user '$sharedUserEmail' has shared for approval '$fileName' on project '$projectName' Overview page")
    public void checkSharedForApprovalActivity(String condition, String sharedUserEmail, String fileName, String projectName) {
        openProjectOverviewPage(getObjectByName(wrapVariableWithTestSession(projectName)).getId());
        sharedForApproval(condition, sharedUserEmail, fileName);
    }

    @Then("{I |}'$condition' see activity where user '$sharedUserEmail' on project '$projectName' shared file '$fileName' to user '$recipientEmail' on Project Overview page")
    public void checkSharedFileToUserActivity(String condition, String sharedUserEmail, String projectName, String fileName, String recipientEmail) {
        openProjectOverviewPage(getObjectByName(wrapVariableWithTestSession(projectName)).getId());
        sharedFileToUser(condition, sharedUserEmail, fileName, recipientEmail);
    }

    @Then("{I |}'$condition' see activity where user '$userEmail' moved file '$fileName' from folder '$fromFolder' to folder '$toFolder' on project '$projectName' on Overview page")
    public void checkMovedFileFromFolderToFolderActivity(String shouldState, String userEmail, String fileName, String fromFolder, String toFolder, String projectName) {
        openProjectOverviewPage(wrapVariableWithTestSession(projectName));
        movedFileFromFolderToFolder(shouldState, userEmail, fromFolder, toFolder, fileName);
    }

    protected DateTime parseDateTime(String date) {
        if (date.equalsIgnoreCase("Today")) {
            return DateTime.now();
        } else if (date.equalsIgnoreCase("Yesterday")) {
            return DateTime.now().minusDays(1);
        } else if (date.equalsIgnoreCase("Tomorrow")) {
            return DateTime.now().plusDays(1);
        } else {
            return DateTimeFormat.forPattern(TestsContext.getInstance().storiesDateTimeFormat).parseDateTime(date);
        }
    }

    @Override
    public void updateObject(String condition, String author, String objectName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String authorFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(author)).getFullName();
        objectName = wrapVariableWithTestSession(objectName);
        String expectedActivity = String.format("%s updated project %s", authorFullName, objectName);

        assertThat(getActualActivities(), shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
    }

    @Override
    public void createObject(String condition, String author, String objectName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String authorFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(author)).getFullName();
        objectName = wrapVariableWithTestSession(objectName);
        String expectedActivity = String.format("%s created project %s", authorFullName, objectName);

        assertThat(getActualActivities(), shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
    }

    @Override
    public void createFolder(String condition, String author, String folderName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String authorFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(author)).getFullName();
        folderName = wrapPathWithTestSession(folderName);
        String expectedActivity = String.format("%s created folder %s", authorFullName, folderName);

        assertThat(getActualActivities(), shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
    }

    @Override
    public void sharedFolderToUserActivity(String condition, String sender, String folder, String recipient) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String senderFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(sender)).getFullName();
        String recipientFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(recipient)).getFullName();
        folder = wrapPathWithTestSession(folder);
        String expectedActivity = String.format("%s has shared folder to %s (%s) %s",
            senderFullName,
            recipientFullName,
            wrapUserEmailWithTestSession(recipient),
            wrapVariableWithTestSession(folder));

        assertThat(getActualActivities(), shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
    }

    @Override
    public void sharedProjectToUserActivity(String condition, String sender, String project, String recipient) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String senderFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(sender)).getFullName();
        String recipientFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(recipient)).getFullName();
        project = wrapPathWithTestSession(project);
        String expectedActivity = String.format("%s has shared project to %s (%s) %s",
            senderFullName,
            recipientFullName,
            wrapUserEmailWithTestSession(recipient),
            wrapVariableWithTestSession(project));

        assertThat(getActualActivities(), shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
    }

    @Override
    public void uploadFileActivity(String condition, String uploaderEmail, String filePath) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String uploaderFullName = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(uploaderEmail)).getFullName();
        int lastSlashIndex = filePath.lastIndexOf("/");
        String fileName = "";
        if (lastSlashIndex >= 0) {
            String path = filePath.substring(0, lastSlashIndex);
            fileName = filePath.substring(lastSlashIndex + 1);
            filePath = wrapPathWithTestSession(path) + "/" + fileName;
        }
        String expectedActivity = String.format("%s uploaded 1 files %s %s", uploaderFullName, fileName, filePath);

        assertThat(getActualActivities(), shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
    }


    @Override
    public void downloadMasterFile(String condition, String downloaderEmail, String filePath) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String uploaderFullName = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(downloaderEmail)).getFullName();
        filePath = getWrapPathToFile("", filePath);
        String expectedActivity = String.format("%s downloaded file master %s", uploaderFullName, filePath);

        assertThat(getActualActivities(), shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
    }


    public void downloadProxyFile(String condition, String downloaderEmail, String filePath) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String uploaderFullName = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(downloaderEmail)).getFullName();
        filePath = getWrapPathToFile("", filePath);
        String expectedActivity = String.format("%s downloaded file preview %s", uploaderFullName, filePath);

        assertThat(getActualActivities(), shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
    }

    @Override
    public void sharedFileToUser(String condition, String sharedUserEmail, String fileName, String recipientEmail) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String senderFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(sharedUserEmail)).getFullName();
        String recipientFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(recipientEmail)).getFullName();
        String expectedActivity = String.format("%s has shared %s to %s %s",
                senderFullName,
                fileName,
                wrapUserEmailWithTestSession(recipientEmail),
                fileName);

        assertThat(getActualActivities(), shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
    }

    @Override
    public void sharedForApproval(String condition, String sharedUserEmail, String fileName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String sharedUserFullName = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(sharedUserEmail)).getFullName();
        String expectedActivity = String.format("%s has shared for approval %s", sharedUserFullName, fileName);

        assertThat(getActualActivities(), shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
    }

    @Override
    public void viewedActivity(String condition, String viewerFullName) {

    }

    @Override
    public void movedFileFromFolderToFolder(String condition, String movedUserEmail, String folderName, String toFolderName, String fileName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String moveUserFullName = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(movedUserEmail)).getFullName();
        folderName = wrapPathWithTestSession(folderName);
        toFolderName = wrapPathWithTestSession(toFolderName);
        String expectedActivity = String.format("%s moved file from \"%s\" to \"%s\" %s", moveUserFullName, folderName, toFolderName, fileName);

        assertThat(getActualActivities(), shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
    }

    private List<String> getActualActivities() {
        return getSut().getPageCreator().getProjectOverviewPage().getActivityList();
    }

    @Then("{I |}'$condition' see project '$projectName' with logo '$logo' in project overview page")
    public void checkProjectLogoInProjectOverviewPage(String condition, String projectName,String logo) {
        AdbankProjectOverviewPage overviewPage = getSut().getPageCreator().getProjectOverviewPage();
        byte[] projectLogo = overviewPage.getLogo();
        int realLength = getRealLogoLengthFromProjectPopUp(projectName).length;
        assertThat("Logo size", projectLogo.length,condition.equalsIgnoreCase("should")? equalTo(realLength):not(equalTo(realLength)));
    }

    @Then("{I |}'$condition' see activity logo for project '$projectName' overview page with activity '$message' and '$logo' logo")
    public void checkActivityLogoOnProjectOverviewPage(String condition, String projectName, String message, String logo) {
        AdbankProjectOverviewPage overviewPage = getSut().getPageCreator().getProjectOverviewPage();
        byte[] projectLogoSize = overviewPage.getLastActivityLogo(message);
        int realLogoLength = getRealLogoLengthFromProjectPopUp(projectName).length;
        assertThat(projectLogoSize.length,condition.equalsIgnoreCase("should")?equalTo(realLogoLength):not(equalTo(realLogoLength)));
    }

    private byte[] getRealLogoLengthFromProjectPopUp(String projectName){
        AdbankProjectSettingsPage page = openProjectSettingsPage(projectName);
        byte[] realLogo = page.getLogo();
        page.cancelLink.click();
        return realLogo;
    }

}