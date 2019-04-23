package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.SearchResult;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.sut.pages.adbank.projects.*;
import com.adstream.automate.babylon.tests.steps.core.GenericSteps;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.*;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * User: ruslan.semerenko
 * Date: 27.04.12 16:53
 */
public class TemplateListSteps extends AbstractProjectSteps {
    @Given("I am on Template list page")
    @When("{I |}go to {T|t}emplate list page")
    public AdbankTemplatesListPage openObjectListPagetemplate() {
        return getSut().getPageNavigator().getTemplateListPage();
    }

    //jbehave throws error for dupes hence rewriting this as new method
    public AdbankTemplatesListPage openObjectListPage() {
        return getSut().getPageNavigator().getTemplateListPage();
    }

    public AdbankTemplateListWithSizePage openObjectListPage(String size) {
        return getSut().getPageNavigator().getTemplateListPage(size);
    }

    public AdbankTemplateOverviewPage openTemplateOverviewPage(String objectId) {
        return getSut().getPageNavigator().getTemplateOverviewPage(objectId);
    }

    public AdbankTemplateSettingsPage openObjectSettingsPage(String objectId) {
        return openTemplateOverviewPage(objectId).clickEdit();
    }

    public Project getObjectByName(String objectName) {
        return getCoreApi().getTemplateByName(objectName);
    }

    public AdbankTemplatesListPage getCurrentObjectListPage() {
        return getSut().getPageCreator().getTemplateListPage();
    }

    @When("{I |}use '$templateName' template")
    public AdbankProjectFromTemplateCreatePage openCreateProjectFromTemplatePage(String templateName) {
        AdbankTemplatesListPage page = openObjectListPage();
        Common.sleep(2000);
     //sortingTemplatesByNameAndOrder("createdBy.fullName", "desc");
        return page.clickUseTemplate(wrapVariableWithTestSession(templateName));
    }

    @When("{I |}click use template button next to template '$templateName' on opened templates list page")
    public void clickUseTemplateButton(String templateName) {
        getCurrentObjectListPage().clickUseTemplateButton(wrapVariableWithTestSession(templateName));
    }

    @When("I select '$projectsCount' templates per page")
    public void selectProjectsCountOnPage(String projectsCount) {
        selectObjectsCountOnPage(projectsCount);
    }

    @When("I select '$count' templates in templates list")
    public void selectProjects(int count) {
        selectObjects(count);
    }

    @Then("{I should see |}'$templateName' template in template{s|} list")
    public void checkPresenceInTemplateList(@Named("Template Name") String templateName) {
        GenericSteps.refreshPage();
        templateName = wrapVariableWithTestSession(templateName.replace("\\\\", "\\").replace("\\$", "$"));
        boolean existInList = openObjectListPage().isObjectExistInList(templateName);
        assertThat("exist template with name " + templateName, existInList, is(true));
    }

    @Then("I shouldn't see '$templateName' template in template list") // todo resolve invert cases
    @Alias("{I |} should not see '$templateName' template in template list")
    public void checkThatProjectIsNotInProjectList(String templateName) {
        boolean existInList = openObjectListPage().isObjectExistInList(wrapVariableWithTestSession(templateName));
        assertThat("exist template with name " + templateName, existInList, is(false));
    }

    @Then("{I should see |}'$templatesCount' templates counter above templates list")
    public void checkProjectsCounter(String templatesCount) {
        checkObjectsCounter(templatesCount);
    }

    @Then("{I should see |}'$selectedCount' selected note in templates counter")
    public void checkTemplatesSelectedCounter(String selectedCount) {
        checkObjectsSelectedCounter(selectedCount);
    }

    @Then("{I should see |}template '$templateName' with logo '$logo' in template list")
    public void checkProjectLogoInTemplateList(String templateName, String logo) {
        templateName = wrapVariableWithTestSession(templateName);
        byte[] projectLogo = openObjectListPage().getLogo(templateName);
        if (logo.equals("EMPTY")) {
            assertThat("Logo size", projectLogo.length, equalTo(1457));
        } else {
            assertThat("Logo size", projectLogo.length, not(equalTo(1457)));
        }
    }

    @Then("I should see '$viewType' templates on Template list")
    public void checkTemplatesView(String viewType) {
        List<String> visibleTemplates = new ArrayList<>();
        AdbankTemplatesListPage templatesListPage = getSut().getPageNavigator().getTemplateListPage();
        visibleTemplates.addAll(templatesListPage.getObjectsId());

        List<String> templates = new ArrayList<>();
        LuceneSearchingParams query = new LuceneSearchingParams().setResultsOnPage(100);
        if (!viewType.equals("all")) {
            User user = getCoreApi().getCurrentUser();
            query.setQuery(String.format("createdBy._id:%s", user.getId()));
        }
        SearchResult<Project> result;
        int pageNumber = 1;
        do {
            if (pageNumber > 10) {
                throw new RuntimeException("There is too much templates or infinity loop (NGN-13682)");
            }
            query.setPageNumber(pageNumber++);
            result = getCoreApi().findTemplates(query);
            for (Project project : result.getResult()) {
                templates.add(project.getId());
            }
        } while (result.hasMore());
        // by default there are only 10 items on page
        //assertThat(visibleTemplates.size(), equalTo(templates.size()));
        for (String templateId : visibleTemplates) {
            assertThat(templateId, isIn(templates));
        }
    }

    @When("{I |}click 'Select all' checkbox on template list")
    public void selectAllTemplates() {
        selectAllObjects();
    }

    @Then("all templates count '$templatesCount' is '$selectedState' in Template list")
    public void checkTemplatesAreSelected(String templatesCount, String selectedState) {
        checkObjectsAreSelected(templatesCount, selectedState);
    }

    @Then("I should see view type '$viewType' is selected on Templates list")
    public void checkViewType(String viewType) {
        AdbankTemplatesListPage templatesListPage = getSut().getPageNavigator().getTemplateListPage();
        assertThat(templatesListPage.getSelectedViewType(), equalTo(viewType));
    }

    @Then("{I should see |}'$projectsCount' templates in template list")
    public void checkProjectsCount(String projectsCount) {
        checkObjectsCount(projectsCount);
    }

    @When("I select filtering by media type '$mediaType' for templates")
    public void selectMediaTypeFilterTemplatesList(String mediaType) {
       selectMediaTypeFilter(mediaType);
    }

    @Then("I '$condition' see only template '$template' in template list")
    public void checkTemplatesFilteringByMediaType(String condition, String template) {
        checkMediaFilterWork(condition, template);
    }

    private String getDateToStrForProjectTemplate(Date date) {
        DateFormat df = new SimpleDateFormat(getContext().userDateTimeFormat + " " + getContext().userTimeFormat);
        return df.format(date);
    }

    @When("{I |}select '$templateName' template on templates list page")
    public void selectTemplateByName(String templateName) {
        templateName = wrapVariableWithTestSession(templateName);
        selectObjectByName(templateName);
    }

    @When("{I |}select '$templateName' template on templates list page with sorting")
    public void selectTemplateByNamewithsorting(String templateName) {
        templateName = wrapVariableWithTestSession(templateName);
        sortingTemplatesByNameAndOrder("_cm.common.name", "asc");
        selectObjectByName(templateName);
    }

    @When("I sorting templates by field '$fieldName' in order '$order'")
    public void sortingTemplatesByNameAndOrder(String fieldName, String order) {
        AdbankTemplatesListPage adbankTemplatesListPage = getSut().getPageCreator().getTemplateListPage();
        if (!adbankTemplatesListPage.getClassOfSortField(fieldName).contains(order)) {
            adbankTemplatesListPage.clickSortField(fieldName);
            if (!adbankTemplatesListPage.getClassOfSortField(fieldName).contains(order)) {
                adbankTemplatesListPage.clickSortField(fieldName);
            }
        }
    }

    @Then("I should see templates sorted by field '$fieldName' in order '$order'")
    public void checkTemplatesSorting(String fieldName, String order) {
        AdbankTemplatesListPage adbankTemplatesListPage = getSut().getPageCreator().getTemplateListPage();
        List<DateTime> dtFromPage = new ArrayList<>();
        List<DateTime> dtSortList = new ArrayList<>();
        List<String> listFromPage = adbankTemplatesListPage.getListOfTemplatesFields(fieldName);
        List<String> checkSortListFromPage = new ArrayList<>();
        if (order.equalsIgnoreCase("asc")) {
            if (fieldName.equals("createdBy.fullName")) {
                for (String str: listFromPage) {
                    DateTimeFormatter dt2 = DateTimeFormat.forPattern(TestsContext.getInstance().userDateTimeFormat + " " +TestsContext.getInstance().userTimeFormat);
                    dtFromPage.add(dt2.parseDateTime(str));
                }
                dtSortList.addAll(dtFromPage);
                Collections.sort(dtSortList);

                assertThat(dtFromPage, equalTo(dtSortList));
            }
            else {
                checkSortListFromPage.addAll(listFromPage);
                Collections.sort(checkSortListFromPage, String.CASE_INSENSITIVE_ORDER);
                assertThat(listFromPage, equalTo(checkSortListFromPage));
            }
        }
        else {
            if (fieldName.equals("createdBy.fullName")) {
                for (String str: listFromPage) {
                    DateTimeFormatter dt2 = DateTimeFormat.forPattern(TestsContext.getInstance().userDateTimeFormat + " " +TestsContext.getInstance().userTimeFormat);
                    dtFromPage.add(dt2.parseDateTime(str));
                }
                dtSortList.addAll(dtFromPage);
                Collections.sort(dtSortList, Collections.reverseOrder());
                assertThat(dtFromPage, equalTo(dtSortList));
            }
            else {
                checkSortListFromPage.addAll(listFromPage);
                Collections.sort(checkSortListFromPage, Collections.reverseOrder(String.CASE_INSENSITIVE_ORDER));
                assertThat(listFromPage, equalTo(checkSortListFromPage));
            }
        }
    }

    @Then("{I |}should see Media Type '$mediaType' is selected on Templates list page")
    public void checkSelectedMediaTypeTemplatesList(String mediaType) {
        checkSelectedMediaType(mediaType);
    }

    @Then("{I |}'$condition' see delete button on {T|t}emplates list page")
    public void checkThatDeleteButtonIsVisible(String condition) {
        checkVisibilityOfDeleteButton(condition.equalsIgnoreCase("should"));
    }

    @Then("{I |}'$condition' see template '$templateName' on template list page")
    public void checkProjectVisibleOnProjectListPage(String condition, String templateName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        templateName = wrapVariableWithTestSession(templateName);
        List<String> templateList = openObjectListPage().getListOfTemplatesFields("name");

        assertThat(templateList, shouldState ? hasItem(templateName) : not(hasItem(templateName)));
    }

    @When("I select filtering by view '$filtersValue' on project templates page")
    public void selectViewFilter(String filterValue) {
        AdbankTemplatesListPage adbankTemplateListPage = getSut().getPageCreator().getTemplateListPage();
        adbankTemplateListPage.selectViewFilter(filterValue);
    }

    @When("{I |}select business unit '$businessUnit' on project templates page")
    public void selectBusinessUnitonProjectRequestTemplate(Agency businessUnit) {
        openObjectListPage().selectBusinessUnit(businessUnit.getName());
    }
}