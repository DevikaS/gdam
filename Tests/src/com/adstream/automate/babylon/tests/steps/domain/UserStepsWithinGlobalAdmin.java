package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.data.UserDecorator;
import com.adstream.automate.babylon.sut.pages.admin.people.ProfileUserSettingPage;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import java.util.List;
import java.util.Map;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/*
 * Created by demidovskiy-r on 06.04.2015.
 */
public class UserStepsWithinGlobalAdmin extends UserSteps {

    private ProfileUserSettingPage getProfileUserSettingPage() {
        return getSut().getPageCreator().getProfileUserPage();
    }

    private ProfileUserSettingPage openProfileUserSettingPage(String agencyId, String userId) {
        return getSut().getPageNavigator().getProfileUserSettingPage(agencyId, userId);
    }

    private ProfileUserSettingPage.UserProfile getUserProfile() {
        return getProfileUserSettingPage().getUserProfile();
    }

    private Map<String, String> prepareProfileUserData(ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        if (row.containsKey("Primary Business Unit")) row.put("Primary Business Unit", wrapAgencyName(row.get("Primary Business Unit")));
        return row;
    }

    @Given("{I am |}on profile user '$userName' setting page of agency '$agencyName'")
    @When("{I |}go to profile user '$userName' setting page of agency '$agencyName'")
    public void openProfileUserSetting(String userName, String agencyName) {
        openProfileUserSettingPage(getAgencyIdByName(agencyName), wrapNameAndGetUserId(userName));
    }

    // | Primary Business Unit |
    @When("{I |}fill following fields for user Profile Setting: $fieldsTable")
    public void fillProfileUserSetting(ExamplesTable fieldsTable) {
        getUserProfile().fill(prepareProfileUserData(fieldsTable));
    }

    @When("{I |}save user Profile Setting")
    public void saveProfileUserSetting() {
        getProfileUserSettingPage().save();
    }

    // | Primary Business Unit |
    @Then("{I |}should see following data for user Profile Setting: $fieldsTable")
    public void checkProfileUserSetting(ExamplesTable fieldsTable) {
        Map<String, String> row = prepareProfileUserData(fieldsTable);
        ProfileUserSettingPage.UserProfile form = getUserProfile();
        for (Map.Entry<String, String> entry : row.entrySet())
            assertThat("Check field: " + entry.getKey(), form.getFieldValue(entry.getKey()), equalTo(entry.getValue()));
    }

    @Then("{I |}'$shouldState' see available following Primary BUs '$primaryBUsList' for user Profile Setting")
    public void checkPrimaryBUsAvailability(String shouldState, String primaryBUsList) {
        List<String> availablePrimaryBUs = getUserProfile().getAvailablePrimaryBUs();
        for (String primaryBU: primaryBUsList.split(","))
            assertThat("Check availability of Primary BU: " + primaryBU, availablePrimaryBUs, shouldState.equals("should")
                                                                                              ? hasItem(wrapAgencyName(primaryBU))
                                                                                              : not(hasItem(wrapAgencyName(primaryBU))));
    }

    @Given("{I |}edit existing user '$userName' of agency '$agencyName' with following application access fields: $fields")
    @When("{I |}edited existing user '$userName' of agency '$agencyName' with following application access fields: $fields")
    public void createNewAgencyUser(String userName, String agencyName, ExamplesTable fields) {
        ProfileUserSettingPage page = openProfileUserSettingPage(getAgencyIdByName(agencyName), wrapNameAndGetUserId(userName));
        for (int i = 0; i < fields.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fields, i);
            if(row.containsKey("Access")) {
               page.setApplicationAccessCheckboxState(row.get("Access"), Boolean.parseBoolean(row.get("Checkbox")));
            }
        }
        page.clickSave();
    }

    @Then("{I |}see following fields on profile setting page for user '$userName' of agency '$agencyName': $fields")
    public void checkFieldsOnProfileSettingPage(String userName, String agencyName, ExamplesTable fields) {
        ProfileUserSettingPage page = openProfileUserSettingPage(getAgencyIdByName(agencyName), wrapNameAndGetUserId(userName));
        for (int i = 0; i < fields.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fields, i);
            if(row.containsKey("Access")) {
                for (String app : row.get("Access").split(",")) {
                    assertThat("check if application module " + app + " is checked on user setting page", page.isApplicationCheckboxSelected(app), is(row.get("Condition").equalsIgnoreCase("should")));
                }
            }
            if(row.containsKey("Start Up Page")) {
                for (String app1 : row.get("Start Up Page").split(",")) {
                    assertThat("check if application module " + app1 + " is visible under startup page section on user setting page", page.checkStartupPageDropdown(app1), is(row.get("Condition").equalsIgnoreCase("should")));
                }
            }
        }
    }
}