package com.adstream.automate.babylon.tests.steps;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.data.Logo;
import com.adstream.automate.babylon.sut.data.UserDecorator;
import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.NotificationsSettingPageForGA;
import com.adstream.automate.babylon.sut.pages.adbank.addressbook.AdbankAddressbookPage;
import com.adstream.automate.babylon.sut.pages.adbank.addressbook.InviteUserPopup;
import com.adstream.automate.babylon.sut.pages.adbank.myprofile.MyNotificationsSettingPage;
import com.adstream.automate.babylon.sut.pages.admin.people.*;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.babylon.tests.steps.core.GenericSteps;
import com.adstream.automate.babylon.tests.steps.domain.BabylonSteps;
import com.adstream.automate.babylon.tests.steps.domain.EmailSteps;
import com.adstream.automate.babylon.tests.steps.domain.RolesSteps;
import com.adstream.automate.babylon.tests.steps.domain.adcost.AdCostsHelperSteps;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.EmailMessage;
import org.jbehave.core.annotations.Alias;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.junit.Assert;
import org.openqa.selenium.Keys;

import java.util.*;

import static com.adstream.automate.hamcrest.SortingCheck.sortedAlphabetically;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created by Arti Sharma
 * Date: 25.10.18
 */
public class GlobalAdminUserSteps extends BaseStep {

    @Given("{I am |}on global admin '$agencyName' create user page")
    @When("{I |}go to global admin '$agencyName' create user page")
    public GlobalAdminCreateUserPage openGlobalAdminCreateUserPage(Agency agency) {
        return getSut().getPageNavigator().getGlobalAdminCreateUserPage(agency.getId());
    }

//  | FirstName | LastName | Agency | Email | Telephone | Password | Notifications | Logo | Access | Role |
    @When("{I |}created new user with following fields: $fields")
    public void createNewAgencyUser(ExamplesTable fields) {
        GlobalAdminCreateUserPage page = getSut().getPageCreator().getGlobalAdminCreateUserPage();
        for (int i = 0; i < fields.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fields, i);
            if (row.get("Email") != null) {
                String email = wrapUserEmailWithTestSession(row.get("Email"));
                row.put("Email", email);
            }
            if (row.get("Role") != null && !new RolesSteps().isDefaultRole(row.get("Role"))) {
                row.put("Role", wrapVariableWithTestSession(row.get("Role")));
            }
            if ((row.get("Agency")!= null) && (!row.get("Agency").isEmpty())) {
                row.put("Agency", wrapVariableWithTestSession(row.get("Agency")));
            }
            User user = getUserBuilder().getUserForExistingBU(row, false);
            page = page.fillFieldsToCreateUser(new UserDecorator(user));
            page.clickSave();
        }
    }
}