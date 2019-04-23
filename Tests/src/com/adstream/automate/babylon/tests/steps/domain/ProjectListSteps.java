package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.SearchResult;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.JsonObjects.comparator.ComparatorLastActivity;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.middleware.BabylonSendplusMiddleTierService;
import com.adstream.automate.babylon.sut.pages.adbank.AdbankPaginator;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankProjectOverviewPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankProjectSettingsPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankProjectsListPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AddColumnsProjectWindow;
import com.adstream.automate.babylon.tests.steps.core.GenericSteps;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Named;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.junit.Assert;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.interactions.Actions;

import java.util.*;

import static java.util.Arrays.asList;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created by IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 24.01.12
 * Time: 15:54
 */
public class ProjectListSteps extends AbstractProjectSteps {
    @Given("{I |}am on Project list page")
    @When("{I |}go to {P|p}roject list page")
    @Then("{I |}go to {P|p}roject list page")
    public AdbankProjectsListPage openObjectListPageprojects() {
        return openObjectListPage();
    }

     //jbehave throws error for dupes hence rewriting this as new method
    public AdbankProjectsListPage openObjectListPage() {
        return getSut().getPageNavigator().getProjectListPage();
    }

    public AdbankProjectOverviewPage openProjectOverviewPage(String objectId) {
        return getSut().getPageNavigator().getProjectOverviewPage(objectId);
    }

    public AdbankProjectSettingsPage openObjectSettingsPage(String objectId) {
        return openProjectOverviewPage(objectId).clickEdit();
    }

    public AdbankProjectsListPage getCurrentObjectListPage() {
        return getSut().getPageCreator().getProjectListPage();
    }

    public Project getObjectByName(String objectName) {
        return getCoreApi().getProjectByName(objectName);
    }

    @When("I select '$projectsCount' projects per page")
    public void selectProjectsCountOnPage(String projectsCount) {
        selectObjectsCountOnPage(projectsCount);
    }

    @When("{I |}click by project name '$projectName'")
    public void clickByProjectName(String name) {
        openObjectListPage().clickProjectName(wrapVariableWithTestSession(name));
    }

    @Then("the project loading time should be '$loadingTime' seconds after clicking on project '$projectName'")
    public void checkLoadingTime(String loadingTime, String projectName){
        Long actualLoadingTime = getCurrentObjectListPage().getProjectLoadingTime(projectName);
        Long expectedLoadingTime = Long.parseLong(loadingTime);
        assertThat(actualLoadingTime, is(lessThanOrEqualTo(expectedLoadingTime)));
    }

    @When("{I |}select '$projectName' project in Project list page")
    public void selectProjectByName(String projectName) {
        projectName = wrapVariableWithTestSession(projectName);
        openObjectListPage();
        sortingProjectsByNameAndOrder("lastActivity.dateTime", "desc");
        selectObjectByName(projectName);
    }

    @When("{I |}select '$projectName' project in Project list page without Sorting")
    public void selectProjectByNameWithoutSorting(String projectName) {
        projectName = wrapVariableWithTestSession(projectName);
        openObjectListPage();
        selectObjectByName(projectName);
    }

    @When("I select '$count' projects in project list")
    public void selectProjects(int count) {
        AdbankPaginator page = openObjectListPage();
        page.getDriver().navigate().refresh();
        selectObjects(count);
    }

    @When("I select filtering by view '$filtersValue'")
    public void selectViewFilter(String filterValue) {
        AdbankProjectsListPage adbankProjectsListPage = getSut().getPageCreator().getProjectListPage();
        adbankProjectsListPage.selectViewFilter(filterValue);
    }

    @Given("{I |}clicked following activity '$activity' on opened Project list page")
    @When("{I |}click following activity '$activity' on opened Project list page")
    public void clickOnActivity(String activity) {
        getSut().getPageCreator().getProjectListPage().clickLinkActivity(wrapVariableWithTestSession(activity));
        Common.sleep(1000);
    }

    @Given("{I |}scrolled down to footer '$times' times on opened Project page")
    @When("{I |}scroll down to footer '$times' times on opened Project page")
    public void scrollDownToFooter(int times) {
        for (int i = 0; i < times; i++) getSut().getPageCreator().getProjectListPage().scrollDownToFooter();
    }

    @When("{I |}sorting projects by field '$fieldName' in order '$order'")
    public void sortingProjectsByNameAndOrder(String fieldName, String order) {
        AdbankProjectsListPage adbankProjectsListPage = getSut().getPageCreator().getProjectListPage_withOutDelay();
        if (!adbankProjectsListPage.getClassOfSortField(fieldName).contains(order)) {
            adbankProjectsListPage.clickSortField(fieldName);
            Common.sleep(3000);
            if (!adbankProjectsListPage.getClassOfSortField(fieldName).contains(order)) {
                adbankProjectsListPage.clickSortField(fieldName);
            }
        }
    }

    @Given("{I |}'$state' following project column '$columns' on opened Project list page")
    @When("{I |}'$state' following project column '$columns' on opened Project list page")
    public void setFollowingProjectColumns(String state, String columns) {
        AdbankProjectsListPage adbankProjectsListPage = getSut().getPageCreator().getProjectListPage_withOutDelay();
        AddColumnsProjectWindow addColumnsProjectWindow = new AddColumnsProjectWindow(this.openObjectListPage());
        for (String column : columns.split(",")) {
            if ((state.equals("add")) && !adbankProjectsListPage.clickByAddColumnProjectListButton().isNotChecked(column))
                addColumnsProjectWindow.checkColumn(column);
            else if ((state.equals("delete")) && adbankProjectsListPage.clickByAddColumnProjectListButton().isNotChecked(column)) {
                addColumnsProjectWindow.checkColumn(column);
            }
        }
    }

    @When("{I |}click 'Select all' checkbox on project list")
    public void selectAllProjects() {
        selectAllObjects();
    }

    @When("{I |}select filtering by media type '$mediaType'")
    public void selectMediaTypeFilterProjectList(String mediaType) {
        selectMediaTypeFilter(mediaType);
    }

    // | FieldName |
    @When("{I |}select additional columns on project list page: $data")
    public void selectAdditionalColumnsForProjectList(ExamplesTable data) {
        AdbankProjectsListPage page = getSut().getPageNavigator().getProjectListPage();
        page.clickProjectsColumnsDropdownButton();
        for (Map<String,String> row : parametrizeTableRows(data)) page.selectProjectsColumnCheckboxByName(row.get("FieldName"));
        page.clickProjectsColumnsDropdownButton();
    }

    @When("{I |}sort project list by field '$field' with order '$order' on project list page")
    public void sortProjectListByField(String field, String order) {
        getSut().getPageNavigator().getProjectListPage().sortProjectListByFieldWithOrder(field, order);
    }

    // | FieldName |
    @When("{I |}deselect additional columns on project list page: $data")
    public void deselectAdditionalColumnsForProjectList(ExamplesTable data) {
        AdbankProjectsListPage page = getSut().getPageNavigator().getProjectListPage();
        page.clickProjectsColumnsDropdownButton();
        for (Map<String,String> row : parametrizeTableRows(data)) {
            Common.sleep(3000);
            page.deselectProjectsColumnCheckboxByName(row.get("FieldName"));
        }

        page.clickProjectsColumnsDropdownButton();
    }

    @Then("{I |}'$condition' see following project fields on project list page: $data")
    public void checkVisibleProjectsFields(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<Map<String, String>> actualFields = getSut().getPageNavigator().getProjectListPage().getProjectsFields(data.getHeaders());

        for (Map<String,String> expectedField : parametrizeTableRows(data)) {
            for (String fieldName : expectedField.keySet()) {
                if (FIELDS_TO_WRAP.contains(fieldName)) expectedField.put(fieldName, wrapVariableWithTestSession(expectedField.get(fieldName)));

                if (asList("Start date", "End date").contains(fieldName)) {
                    String date = parseDateTime(expectedField.get(fieldName), getCurrentUserDateTimeFormat()).toString(getCurrentUserDateTimeFormat());
                    expectedField.put(fieldName, date);
                }
            }

            assertThat(actualFields, shouldState ? hasItem(expectedField) : not(hasItem(expectedField)));
        }
    }

    @Then("{I |}'$condition' see following project fields on project list page with '$OrderCriteria': $data")
    public void checkVisibleProjectsFields(String condition,String orderCriteria, ExamplesTable data)
    {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualFields = getSut().getPageNavigator().getProjectListPage().getProjectsFieldsasList(data.getHeaders());
        List<String> expectedFields = new ArrayList<>();

        for (Map<String,String> expectedField : parametrizeTableRows(data)) {
            for (String fieldName : expectedField.keySet()) {
                if (FIELDS_TO_WRAP.contains(fieldName)) expectedField.put(fieldName, wrapVariableWithTestSession(expectedField.get(fieldName)));

                if (asList("Start date", "End date").contains(fieldName)) {
                    String date = parseDateTime(expectedField.get(fieldName), getCurrentUserDateTimeFormat()).toString(getCurrentUserDateTimeFormat());
                    expectedField.put(fieldName, date);
                }
                expectedFields.add(expectedField.get(fieldName));
            }

            Collections.sort(expectedFields);
            if(orderCriteria.equalsIgnoreCase("desc")){
                Collections.reverse(expectedFields);
            }
        }
           Assert.assertTrue(expectedFields.equals(actualFields));
    }

    // | FieldName |
    @Then("{I |}'$condition' see following project fields in the following order on project list page: $data")
    public void checkOrderOfProjectsFields(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualFieldNames = getSut().getPageNavigator().getProjectListPage().getProjectFieldNames();
        actualFieldNames.remove("");
        List<String> expectedFieldNames = new ArrayList<>();

        for (Map<String,String> row : parametrizeTableRows(data))
            expectedFieldNames.add(row.get("FieldName"));

        for (int i = 0; i < actualFieldNames.size(); i++)
            assertThat(actualFieldNames.get(i), shouldState ? equalTo(expectedFieldNames.get(i)) : not(equalTo(expectedFieldNames.get(i))));
    }

    @Then("{I |}should see following count '$count' of total projects")
    public void checkCountOfTotalProjects(int count) {
        int actualState = getSut().getPageCreator().getProjectListPage().getCountOfTotalProject();
        assertThat(String.format("Wrong number of total projects: %d, but should be %d", actualState, count), count == actualState);
    }

    @Then("{I should see |}'$projectNames' project in project list")
    public void checkPresenceInProjectList(@Named("Project Name") String projectNames) {
        GenericSteps.refreshPage();
        projectNames = projectNames.replace("\\\\", "\\").replace("\\$", "$");
        for (String projectName : projectNames.split(",")) {
            boolean existInList = openObjectListPage().isObjectExistInList(wrapVariableWithTestSession(projectName));
            assertThat("is project exist " + wrapVariableWithTestSession(projectName), existInList, is(true));
        }
    }

    @Then("I shouldn't see '$projectNames' project in project list") // todo resolve invert cases
    public void checkThatProjectIsNotInProjectList(String projectNames) {
        for (String projectName : projectNames.split(",")) {
            projectName = wrapVariableWithTestSession(projectName);
            assertThat("is project exist " + wrapVariableWithTestSession(projectName),
                    openObjectListPage().isObjectExistInList(projectName), is(false));
        }
    }

    @Then("{I should see |}that '$projectName' project first in project list")
    public void checkProjectInProjectList(String projectName) {
        projectName = wrapVariableWithTestSession(projectName);
        String firstProjectName = openObjectListPage().getFistProjectName();
        assertThat(firstProjectName, equalToIgnoringCase(projectName));
    }

    @Then("{I |}'$condition' see '$projectNames' project in project list page")
    public void checkThatProjectAppearsInProjectList(String condition,String projectNames) {
        System.out.println("getting into method............");
        System.out.println("condition............" + condition);
        if (condition.equals("should")) {
            System.out.println("getting into............");
            GenericSteps.refreshPage();
            projectNames = projectNames.replace("\\\\", "\\").replace("\\$", "$");
            for (String projectName : projectNames.split(",")) {
                boolean existInList = openObjectListPage().isObjectExistInList(wrapVariableWithTestSession(projectName));
                assertThat("is project exist " + wrapVariableWithTestSession(projectName), existInList, is(true));
            }
         }

        else
        {
            System.out.println("getting into else............");
            for (String projectName : projectNames.split(",")) {
                projectName = wrapVariableWithTestSession(projectName);
                assertThat("is project exist " + wrapVariableWithTestSession(projectName),
                        openObjectListPage().isObjectExistInList(projectName), is(false));
            }
        }

    }

    @Then("{I should see |}project '$projectName' with logo '$logo' in project list")
    public void checkProjectLogoInProjectList(String projectName,String logo) {
        projectName = wrapVariableWithTestSession(projectName);

        byte[] projectLogo = openObjectListPage().getLogo(projectName);
        if (logo.equals("EMPTY")) {
            assertThat("Logo size", projectLogo.length, equalTo(1457));
        } else {
            assertThat("Logo size", projectLogo.length, not(equalTo(1457)));
        }
    }

    @Then("{I should see |}'$projectsCount' projects counter above project list")
    public void checkProjectsCounter(String projectsCount) {
        checkObjectsCounter(projectsCount);
    }

    @Then("{I should see |}'$projectsCount' projects in project list")
    public void checkProjectsCount(String projectsCount) {
        checkObjectsCount(projectsCount);
    }

    @Then("I should see '$projectName' project in project list using nverge api")
    public void checkProjectNVerge(String projectName) {
        projectName = wrapVariableWithTestSession(projectName);
        List<Project> projects = new ArrayList<>();
        List<Project> projectsOnPage;
        int page = 1;
        do {
            projectsOnPage = ((BabylonSendplusMiddleTierService) getNVergeApi().getWrappedService()).getProjects(page++, 50);
            if (projectsOnPage.size() > 0) {
                projects.addAll(projectsOnPage);
            }
        } while(projectsOnPage.size() > 0);

        boolean found = false;
        String projectId = null;
        for (Project project : projects) {
            if (project.getName().equals(projectName)) {
                found = true;
                projectId = project.getId();
                break;
            }
        }
        assertThat("Project " + projectName + " is present", found, is(true));

        Project project = getNVergeApi().getProject(projectId);
        assertThat("Project " + projectName + " is available by id", project != null && project.getName().equals(projectName), is(true));
    }

    @Then("{I should see |}'$selectedCount' selected note in projects counter")
    public void checkProjectsSelectedCounter(String selectedCount) {
        checkObjectsSelectedCounter(selectedCount);
    }

    @Then("all projects count '$projectsCount' is '$selectedState' in Project list")
    public void checkProjectsAreSelected(String projectsCount, String selectedState) {
        checkObjectsAreSelected(projectsCount, selectedState);
    }


    @Then("{I |}should see Delete button is '$buttonState' on Project list page")
    public static boolean isDeleteButtonDisabled(String buttonState) {
        boolean isDisabled = getSut().getPageCreator().getProjectListPage().isDeleteButtonDisabled();

        if ("Disabled".equalsIgnoreCase(buttonState)) {
            assertThat("Disabled", isDisabled, equalTo(true));
        } else {
            assertThat("Enabled", isDisabled, not(equalTo(true)));
        }
        return isDisabled;
    }

    @Then("I should see projects sorted by field '$fieldName' in order '$order'")
    public void checkProjectSorting(String fieldName, String order) {
        AdbankProjectsListPage adbankProjectsListPage = getSut().getPageCreator().getProjectListPage();
        List<String> checkSortList = new ArrayList<>();
        List<String> listFromPage = adbankProjectsListPage.getListOfProjectsFields(fieldName);
        checkSortList.addAll(listFromPage);
        if (fieldName.equalsIgnoreCase("title")) {
            Collections.sort(checkSortList, String.CASE_INSENSITIVE_ORDER);
        } else if (fieldName.equalsIgnoreCase("_modified")) {
            Collections.sort(checkSortList, new ComparatorLastActivity());
        } else if (fieldName.equalsIgnoreCase("jobNumber")) {
            Collections.sort(checkSortList, String.CASE_INSENSITIVE_ORDER);
        } else if (fieldName.equalsIgnoreCase("enumsFull__advertiser__name")) {
            Collections.sort(checkSortList, String.CASE_INSENSITIVE_ORDER);
        } else if (fieldName.equalsIgnoreCase("enumsFull__product__name")) {
            Collections.sort(checkSortList, String.CASE_INSENSITIVE_ORDER);
        } else if (fieldName.equalsIgnoreCase("_created")) {
            checkProjectSortingOverApi(fieldName, order);
            return;
        }
        if (order.equalsIgnoreCase("desc")) {
            Collections.reverse(checkSortList);
        }
        assertThat(checkSortList, equalTo(listFromPage));
    }


    public void checkProjectSortingOverApi(String fieldName, String order) {
        AdbankProjectsListPage adbankProjectListPage = getSut().getPageCreator().getProjectListPage();
        LuceneSearchingParams query = new LuceneSearchingParams()
                .setQuery("_subtype:project")
                .setResultsOnPage(10)
                .setSortingField(fieldName)
                .setSortingOrder(order);
        List<Project> result = getCoreApi().findProjects(query).getResult();
        List<String> listFromPage = adbankProjectListPage.getListOfProjectsFields("name").subList(0, adbankProjectListPage.getListOfProjectsFields("name").size());
        int i = 0;
        for (String itemOnPage : listFromPage){
            assertThat(itemOnPage, equalTo(result.get(i++).getName()));
        }
    }

    @Then("{I |}'$condition' see '$expectedValues' available view filrer values")
    public void checkViewFilterValuesOnProjectList(String condition, String expectedValues) {
        checkViewFilterValues(condition, expectedValues);
    }

    @Then("I '$condition' see only project '$project' in project list")
    public void checkProjectsFilteringByMediaType(String condition, String project) {
        checkMediaFilterWork(condition, project);
    }

    @Then("I should see '$viewType' projects on Project list")
    public void checkProjectsView(String viewType) {
        List<String> visibleProjects = new ArrayList<>();
        AdbankProjectsListPage adbankProjectsListPage = getSut().getPageNavigator().getProjectListPage();
        visibleProjects.addAll(adbankProjectsListPage.getObjectsId());

        List<String> projects = new ArrayList<>();
        LuceneSearchingParams query = new LuceneSearchingParams().setResultsOnPage(100);
        if (!viewType.equalsIgnoreCase("All projects")) {
            User user = getCoreApi().getCurrentUser();
            query.setQuery(String.format("createdBy._id:%s", user.getId()));
        }
        SearchResult<Project> result;
        int pageNumber = 1;
        do {
            if (pageNumber > 10) {
                throw new RuntimeException("There is too much projects or infinity loop (NGN-13682)");
            }
            query.setPageNumber(pageNumber++);
            result = getCoreApi().findProjects(query);
            for (Project project : result.getResult()) {
                projects.add(project.getId());
            }
        } while (result.hasMore());
        //by default there is only 10 items on list
        //assertThat(visibleProjects.size(), equalTo(projects.size()));
        for (String templateId : visibleProjects) {
            assertThat(templateId, isIn(projects));
        }
    }

    @Then("{I |}should see Media Type '$mediaType' is selected on Projects list page")
    public void checkSelectedMediaTypeProjectsList(String mediaType) {
        checkSelectedMediaType(mediaType);
    }

    @Then("{I |}'$condition' see delete button on {P|p}rojects list page")
    public void checkThatDeleteButtonIsVisible(String condition) {
        checkVisibilityOfDeleteButton(condition.equalsIgnoreCase("should"));
    }

    @Then("I '$condition' see that last activity for project '$projectName' is '$activityName'")
    public void checkActivityNameForProject(String condition, String projectName, String activityName) {
        AdbankProjectsListPage projectsListPage = getSut().getPageCreator().getProjectListPage();
        String projectId = getCoreApi().getProjectByName(wrapVariableWithTestSession(projectName)).getId();
        if (!activityName.isEmpty()) {
            assertThat(projectsListPage.getProjectsActivityName(projectId), condition.equalsIgnoreCase("should") ? equalTo(activityName) : not(equalTo(activityName)));
        } else {
            assertThat(projectsListPage.isProjectsActivityEmpty(), equalTo(condition.equalsIgnoreCase("should")));
        }
    }

    @Then("{I |}'$should' see data in '$columnName' column sorted in following order on project list page:$data")
    public void checkDataForProjects(String condition,String columnName,ExamplesTable fields){
        AdbankProjectsListPage projectsListPage = getSut().getPageCreator().getProjectListPage_withOutDelay();
        List<String> actual = projectsListPage.loadDataFromColumn(columnName);

        List<String> expectedorder = new ArrayList<>();
        for (int i = 0; i < fields.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fields, i);
            if(row.containsKey("Name"))
                expectedorder.add(wrapVariableWithTestSession(row.get("Name")));
            if(row.containsKey("Last Activity"))
                expectedorder.add(getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(row.get("Last Activity"))).getFullName());
            if(row.containsKey("Media type"))
                expectedorder.add(row.get("Media type"));
        }

        assertThat("Check sort details for "+columnName,actual.equals(expectedorder));
    }

    @Then("{I |}'$condition' see tab '$tab' on project list page")
    public void checkTabOnOpenedProjectPage(String condition, String tab) {
        openObjectListPage();
        AdbankProjectsListPage projectListPage = getSut().getPageCreator().getProjectListPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean actualState = projectListPage.isTabExist(tab);
        assertThat(String.format("Something wrong with tab %s visibilty", tab), shouldState == actualState);
    }

    @Then("{I } '$condition' see '$tab' tab on project list page")
    public void checkTabVisibilityon(String condition, String tab) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AdbankProjectsListPage projectListPage = openObjectListPage();
        boolean actualState=projectListPage.isTabVisible(tab);
        assertThat(shouldState, equalTo(actualState));
    }

    @Then("{I |}'$condition' see an access denied message on project list page")
    public void checkAccessDeniedOnProjectPage(String condition) {
        String directProjectListURL = TestsContext.getInstance().applicationUrl + "/projects#projects/";
        getSut().getWebDriver().navigate().to(directProjectListURL);
        getSut().getWebDriver().waitUntilElementAppear(By.xpath("//div[contains(text(), 'Projects')]"));
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getWebDriver().isElementVisible(By.xpath("//span[text() = 'We are sorry! You do not have permission to access this area.']"));
        assertThat(shouldState, equalTo(actualState));
    }

    @Then("I '$shouldState' see project filters '$filters' on project list page")
    public void checkProjectFilters(String shouldState, String filters) {
        boolean should = shouldState.equalsIgnoreCase("should");
        AdbankProjectsListPage page = openObjectListPage();
        String[] wrappedFilters = filters.split(",");
        for (int i = 0; i < wrappedFilters.length; i++) {
           // wrappedFilters[i] = wrapVariableWithTestSession(wrappedFilters[i].toLowerCase());
            wrappedFilters[i] = wrapVariableWithTestSession(wrappedFilters[i]);
        }
        List<String> expectedFilters = page.getProjectFilters();
        assertThat(page.getProjectFilters(), should ? hasItems(wrappedFilters) : not(hasItems(wrappedFilters)));
    }
    // NGN-16211-QAA: User from multiple BU's should see all Advertiser values in Project Filters code Changes Starts
    @Then("I '$shouldState' see project filter hierarchy '$filters' on project list page")
    public void checkProjectFiltersHierarchy(String shouldState, String filters) {
        boolean should = shouldState.equalsIgnoreCase("should");
        AdbankProjectsListPage page = openObjectListPage();
        String[] wrappedFilters = filters.split(",");
        for (int i = 0; i < wrappedFilters.length; i++) {
            wrappedFilters[i] = wrapVariableWithTestSession(wrappedFilters[i]);
        }
        List<String> actualFilters = page.getProjectFilterHierarchy();
        assertThat(actualFilters, should ? hasItems(wrappedFilters) : not(hasItems(wrappedFilters)));
    }
    @When("I select Project filtering by view '$filtersValue'")
    public void selectProjectFilter(String filterValue) {
        AdbankProjectsListPage adbankProjectsListPage = getSut().getPageCreator().getProjectListPage();
        adbankProjectsListPage.selectProjectFilter(filterValue);
    }

    @When("I select clear filter in the Project List Page")
    @Then("I select clear filter in the Project List Page")
    public void selectClearFilter() {
        AdbankProjectsListPage adbankProjectsListPage = getSut().getPageCreator().getProjectListPage();
        adbankProjectsListPage.selectClearFilter();
    }
    // NGN-16211-QAA: User from multiple BU's should see all Advertiser values in Project Filters code Changes Ends
}