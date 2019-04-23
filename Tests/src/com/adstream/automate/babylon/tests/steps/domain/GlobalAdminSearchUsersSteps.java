package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.sut.pages.admin.people.search.GlobalAdminSearchUsersPage;
import com.adstream.automate.babylon.sut.pages.admin.people.search.SearchModelForm;
import com.adstream.automate.babylon.sut.pages.admin.people.search.UsersList;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import java.util.List;
import java.util.Map;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/*
 * Created by demidovskiy-r on 29.04.2015.
 */
public class GlobalAdminSearchUsersSteps extends UserSteps {

    private GlobalAdminSearchUsersPage openGlobalAdminSearchUsersPage() {
        return getSut().getPageNavigator().getGlobalAdminSearchUsersPage();
    }

    private GlobalAdminSearchUsersPage getGlobalAdminSearchUsersPage() {
        return getSut().getPageCreator().getGlobalAdminSearchUsersPage();
    }

    private SearchModelForm getSearchModelForm() {
        return getGlobalAdminSearchUsersPage().getSearchModelForm();
    }

    private UsersList getUsersList() {
        return getGlobalAdminSearchUsersPage().getUsersList();
    }

    private Map<String, String> prepareSearchUsersFormData(ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        if (row.containsKey("Email") && !row.get("Email").isEmpty()) row.put("Email", wrapUserEmailWithTestSession(row.get("Email")));
        if (row.containsKey("Business Unit") && !row.get("Business Unit").isEmpty()) row.put("Business Unit", wrapAgencyName(row.get("Business Unit")));
        return row;
    }

    @Given("{I am |}on the global search users page")
    @When("{I |}go to the global search users page")
    public GlobalAdminSearchUsersPage goToGlobalAdminSearchUsersPage() {
        return openGlobalAdminSearchUsersPage();
    }

    // | First Name | Last Name | Email | Business Unit |
    @When("{I |}fill following fields on the global search users page: $fieldsTable")
    public void fillGlobalSearchUsersForm(ExamplesTable fieldsTable) {
        getSearchModelForm().fill(prepareSearchUsersFormData(fieldsTable));
    }

    @When("{I |}clear chosen Business Unit on the global search users page")
    public void clearChosenBU() {
        getSearchModelForm().clearChosenBusinessUnit();
    }

    @When("{I |}do searching on the global search users page")
    public void searchUsers() {
        getSearchModelForm().search();
    }

    // | First Name | Last Name | Email | Business Unit |
    @Then("{I |}should see following data on the global search users page: $fieldsTable")
    public void checkGlobalSearchUsersFormData(ExamplesTable fieldsTable) {
        Map<String, String> row = prepareSearchUsersFormData(fieldsTable);
        SearchModelForm form = getSearchModelForm();
        for (Map.Entry<String, String> entry : row.entrySet())
            assertThat("Check field: " + entry.getKey(), form.getFieldValue(entry.getKey()), equalTo(entry.getValue()));
    }

    // fieldNamesList: Email, etc
    @Then("{I |}'$shouldState' see validation error for following fields '$fieldNamesList' on the global search users page")
    public void checkGlobalSearchUsersFormFieldsValidation(String shouldState, String fieldNamesList) {
        SearchModelForm form = getSearchModelForm();
        for (String fieldName: fieldNamesList.split(","))
            assertThat("Check validation for field: " + fieldName, form.isValidationFieldErrorVisible(fieldName), is(shouldState.equals("should")));
    }

    // | User | Business Unit |
    @Then("{I |}should see following users on the global search users page: $fieldsTable")
    public void checkUsersList(ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        if (row.containsKey("User")) row.put("User", wrapNameAndGetUser(row.get("User")).getFullName());
        if (row.containsKey("Business Unit")) row.put("Business Unit", wrapAgencyName(row.get("Business Unit")));
        UsersList.User user = getUsersList().getUserByName(row.get("User"));
        assertThat("Check user name: ", user.getUserName(), equalTo(row.get("User")));
        assertThat("Check business unit: ", user.getBusinessUnit(), equalTo(row.get("Business Unit")));
    }

    @Then("{I |}'$shouldState' see following users '$userEmailsList' on the global search users page")
    public void checkUserNamesVisibility(String shouldState, String userEmailsList) {
        List<String> visibleUserNames = getUsersList().getVisibleUserNames();
        for (String userEmail: userEmailsList.split(","))
            assertThat("Check visibility user: " + userEmail, visibleUserNames, shouldState.equals("should")
                                                                               ? hasItem(wrapNameAndGetUser(userEmail).getFullName())
                                                                               : not(hasItem(wrapNameAndGetUser(userEmail).getFullName())));
    }

    @Then("{I |}'$shouldState' see noone user on the global search users page")
    public void checkNoOneUserVisibility(String shouldState) {
        assertThat("Check noone user visibility: ", getUsersList().getVisibleUserNames(), shouldState.equals("should") ? is(empty()) : not(is(empty())));
    }
}