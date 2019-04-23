package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.adbank.AdbankPaginator;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankTemplatesCreatePage;
import com.adstream.automate.utils.Common;
import org.apache.commons.lang.StringUtils;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTimeZone;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * User: ruslan.semerenko
 * Date: 22.05.12 17:54
 */
public abstract class AbstractProjectSteps extends BabylonSteps {
    public abstract AdbankPaginator openObjectListPage();

    public abstract AdbankTemplatesCreatePage openObjectSettingsPage(String objectId);

    public abstract Project getObjectByName(String objectName);

    public abstract AdbankPaginator getCurrentObjectListPage();

    protected Map<String,String> prepareObjectFields(Project project) {
        DateTimeFormatter startDateFormat = DateTimeFormat.forPattern(getProjectDateFieldFormat("Start date"));
        DateTimeFormatter endDateFormat = DateTimeFormat.forPattern(getProjectDateFieldFormat("End date"));
        DateTimeFormatter publishDateFormat = DateTimeFormat.forPattern(getProjectDateFieldFormat("Publish on (Local date)"));
        Map<String,String> fields = new HashMap<String, String>();
        fields.put("JobNumber", project.getJobNumber() == null ? "" : project.getJobNumber());
        fields.put("StartDate", project.getDateStart().toDateTime(DateTimeZone.getDefault()).toString(startDateFormat));
        fields.put("EndDate", project.getDateEnd().toDateTime(DateTimeZone.getDefault()).toString(endDateFormat));
        fields.put("Name", project.getName());
        fields.put("MediaType", project.getMediaType());
        fields.put("Administrators", project.getAdministrators() == null ? null : StringUtils.join(project.getAdministrators(), ","));
        fields.put("Logo", project.getLogo());
        fields.put("Business Unit", project.getAgency().getName());
        fields.put("Publish Date", project.getPublishDate() == null ? null : project.getPublishDate().toDateTime(DateTimeZone.getDefault()).toString(publishDateFormat));
        return fields;
    }

    protected void selectObjectsCountOnPage(String projectsCount) {
        openObjectListPage().selectObjectsCountOnPage(projectsCount);
    }

    protected void selectAllObjects() {
        openObjectListPage().selectAllObjects();
    }

    protected void selectObjectByName(String name) {
        openObjectListPage().selectObjectByName(name);
    }

    protected void checkObjectsSelectedCounter(String selectedCount) {
        String counter;
        if (Integer.valueOf(selectedCount) < 10) {
            counter = openObjectListPage().getObjectsSelectedCounter();
        } else {
            counter = openObjectListPage().getObjectsSelectedCounter();
        }
        assertThat(counter, equalTo(selectedCount));
    }

    protected void checkObjectsAreSelected(String objectsCount, String selectedState) {
        boolean isSelected = selectedState.equals("selected");
        AdbankPaginator projectsPage = openObjectListPage();
        for (int i = 0; i < projectsPage.getObjectsCount(); i++) {
            assertThat(projectsPage.isObjectSelected(i), equalTo(isSelected));
        }
    }

    protected void checkObjectsCount(String projectsCount) {
        String projectsOnPage = Integer.toString(openObjectListPage().getObjectsCount());
        assertThat(projectsOnPage, equalTo(projectsCount));
    }

    protected void checkObjectsCounter(String objectsCount) {
        String counter = openObjectListPage().getObjectsCounter();
        assertThat(counter, equalTo(objectsCount));
    }

    protected void selectObjects(int count) {
        AdbankPaginator page = openObjectListPage();
        for (int i = 0; i < count; i++) {
            page.selectObject(i);
        }
    }

    protected void editObjectFields(String objectName, ExamplesTable data) {
        objectName = wrapVariableWithTestSession(objectName);
        Project object = getObjectByName(objectName);
        Project newObject = getProjectBuilder().getProject(parametrizeTabularRow(data));
        Map<String, String> prepareObject = prepareObjectFields(newObject);
        if (!data.getHeaders().contains("Business Unit")) prepareObject.remove("Business Unit");
        User user = getCoreApi().getUserByEmail(prepareObject.get("Administrators"));
        if(user!=null){
            prepareObject.put("FullUserName",user.getFullName());
        }
        openObjectSettingsPage(object.getId()).fill(prepareObject);
    }

    protected void editWorkRequestFields(String objectName, ExamplesTable data) {
        objectName = wrapVariableWithTestSession(objectName);
        Project object = getObjectByName(objectName);
        Project newObject = getWorkRequestBuilder().getProject(parametrizeTabularRow(data));
        Map<String, String> prepareObject = prepareObjectFields(newObject);
        if (!data.getHeaders().contains("Business Unit"))
            prepareObject.remove("Business Unit");
        openObjectSettingsPage(object.getId()).fill(prepareObject);
    }

    protected void checkVisibilityOwnersSection(String shouldState, String objectName) {
        boolean should = shouldState.equals("should");
        objectName = wrapVariableWithTestSession(objectName);
        Project object = getObjectByName(objectName);
        assertThat(openObjectSettingsPage(object.getId()).isOwnersSectionVisible(), equalTo(should));
    }

    protected void checkDeleteAdminLink(String objectName, String userName, boolean isVisible) {
        Project object = getObjectByName(wrapVariableWithTestSession(objectName));
        User user;
        if (userName.isEmpty()) user = getCoreApi().getCurrentUser();
        else user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userName));
        AdbankTemplatesCreatePage page = openObjectSettingsPage(object.getId());
        assertThat(page.isDeleteAdminPresent(user), equalTo(isVisible));
    }

    protected void removeAdmin(String adminName, String objectName) {
        User user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(adminName));
        Project object = getObjectByName(wrapVariableWithTestSession(objectName));
        AdbankTemplatesCreatePage page = openObjectSettingsPage(object.getId());
        page.removeAdministrator(user);
    }

    protected void checkAdmin(String shouldState, String adminName, String objectName) {
        String email = wrapUserEmailWithTestSession(adminName);
        User user = getCoreApiAdmin().getUserByEmail(email);
        Project object = getObjectByName(wrapVariableWithTestSession(objectName));
        AdbankTemplatesCreatePage page = openObjectSettingsPage(object.getId());
        Common.sleep(1000);
        if (user!=null) {
            assertThat(page.isAdminPresent(user), equalTo(shouldState.equals("should")));
        }else{
            assertThat(page.isAdminPresentByEmail(email), equalTo(shouldState.equals("should")));
        }

    }

    protected void checkCreationAdmin(String shouldState, String adminName) {
        String email = wrapUserEmailWithTestSession(adminName);
        User user = getCoreApiAdmin().getUserByEmail(email);
        AdbankTemplatesCreatePage page = getSut().getPageNavigator().getCreateProjectPage();
        assertThat(page.isAdminPresent(user), equalTo(shouldState.equals("should")));
    }

    protected void checkCountAdministrators(int count) {
        AdbankTemplatesCreatePage page = getSut().getPageNavigator().getCreateProjectPage();
        assertThat(page.getAdministratorsCount(), equalTo(count));
    }

    protected void checkViewFilterValues(String condition, String expectedValues) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualValues = openObjectListPage().getViewFilterValues();

        for (String expectedValue : expectedValues.split(","))
            assertThat(actualValues, shouldState ? hasItem(expectedValue) : not(hasItem(expectedValue)));
    }

    protected void checkMediaFilterWork(String condition, String objectNames) {
        List<String> visibleObjects = new ArrayList<String>();
        List<String> objects = new ArrayList<String>();
        boolean should = condition.equals("should");
        AdbankPaginator page = getCurrentObjectListPage();
        visibleObjects.addAll(page.getObjectsId());
        String[] arrayObjects = objectNames.split(",");
        for (String objectName: arrayObjects) {
            Project object = getObjectByName(wrapVariableWithTestSession(objectName));
            objects.add(object.getId());
        }
        for (String objectId : objects) {
            org.hamcrest.Matcher matcher = should ? isIn(visibleObjects) : not(isIn(visibleObjects));
            assertThat(objectId, matcher);
        }
    }

    protected void checkSelectedMediaType(String mediaType) {
        AdbankPaginator objectsListPage = getCurrentObjectListPage();
        assertThat(objectsListPage.getSelectedMediaType(), equalTo(mediaType));
    }



    protected void selectMediaTypeFilter(String mediaType) {
        AdbankPaginator objectsListPage = getCurrentObjectListPage();
        objectsListPage.selectMediaTypeFilterValue(mediaType);
        Common.sleep(1000);
    }

    protected void checkVisibilityOfDeleteButton(boolean shouldState) {
        AdbankPaginator objectsListPage = getCurrentObjectListPage();
        assertThat(objectsListPage.isDeleteButtonVisible(), equalTo(shouldState));
    }

    protected void clickSaveBtn() {
        AdbankTemplatesCreatePage templatesCreatePage = getSut().getPageCreator().getTemplateCreatePage();
        templatesCreatePage.save();
        templatesCreatePage.waitUntilPopUpDisappears();
    }

    protected void clickSaveBtnWithoutDelay() {
        AdbankTemplatesCreatePage templatesCreatePage = getSut().getPageCreator().getTemplateCreatePage();
        templatesCreatePage.save();
           }

    protected void addAPTIntoObject(String aptName, String objectName) {
        String objectId = getObjectByName(wrapVariableWithTestSession(objectName)).getId();
        String aptId = getCoreApi().getAgencyProjectTeamByName(wrapVariableWithTestSession(aptName)).getId();
        getCoreApi().addObjectToAgencyProjectTeam(aptId, objectId);
    }

}