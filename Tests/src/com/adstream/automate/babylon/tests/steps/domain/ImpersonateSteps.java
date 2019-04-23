package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.babylon.sut.pages.elements.ImpersonateMePopup;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.util.List;
import java.util.Map;

import static org.hamcrest.CoreMatchers.equalTo;
import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * User: lynda-k
 * Date: 04.03.14
 * Time: 13:00
 */
public class ImpersonateSteps extends BaseStep {

    @When("{I |}select item '$itemName' from account menu")
    public void selectImpersonateFromUserMenu(String itemName) {
        BasePage page = getSut().getPageCreator().getBasePage();
        page.expandAccountMenu();
        page.selectAccountMenuItemByName(itemName);
        page.collapseAccountMenu();
    }

    @When("{I |}type user full name '$userFullName' on opened Impersonate me popup")
    public void typeUserFullName(String userFullName) {
        new ImpersonateMePopup(getSut().getPageCreator().getBasePage()).fillUserTextbox(userFullName);
    }

    @When("{I |}type user '$userName' email on opened Impersonate me popup")
    public void typeUserEmail(String userName) {
        User user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userName));
        new ImpersonateMePopup(getSut().getPageCreator().getBasePage()).fillUserTextbox(user.getEmail());
    }

    @When("{I |}type user '$userName' email and fill '$commets' comments on opened Impersonate me popup")
    public void typeUserEmail(String userName, String comments) {
        User user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userName));
        BasePage page = getSut().getPageCreator().getBasePage();
        ImpersonateMePopup popup = new ImpersonateMePopup(page);
        popup.fillUserTextbox(user.getEmail());
        popup.typeComment(comments);
    }

    @Given("{I |}impersonated as user '$userName' on opened page")
    @When("{I |}impersonate me as user '$userName' on opened page")
    public void impersonateMeAsUser(String userName) {
        User user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userName));
        BasePage page = getSut().getPageCreator().getBasePage();
        page.expandAccountMenu();
        page.selectAccountMenuItemByName("Impersonate");
        ImpersonateMePopup popup = new ImpersonateMePopup(page);
        popup.typeEmail(user.getEmail());
        popup.typeComment("automated test");
        popup.clickAction();
    }

    // | ItemName |
    @Then("{I |}'$condition' see following account menu items: $data")
    public void checkUserMenuItems(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");

        BasePage page = getSut().getPageCreator().getBasePage();
        page.expandAccountMenu();
        List<String> actualItems = page.getAccountMenuItems();
        page.collapseAccountMenu();

        for (Map<String,String> row : parametrizeTableRows(data))
            assertThat(actualItems, shouldState ? hasItem(row.get("ItemName")) : not(hasItem(row.get("ItemName"))));
    }

    @Then("{I |}'$condition' see users '$users' on opened user dropdown list on Impersonate me popup")
    public void checkUsers(String condition, String userNames) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualUsers = new ImpersonateMePopup(getSut().getPageCreator().getBasePage()).getAvailableUserEmailsList();

        if (userNames.isEmpty()) {
            assertThat(actualUsers.isEmpty(), is(shouldState));
            return;
        }

        for (String userName : userNames.split(","))
            assertThat(actualUsers, shouldState ? hasItem(wrapUserEmailWithTestSession(userName)) : not(hasItem(wrapUserEmailWithTestSession(userName))));
    }

    @Then("{I |}'$condition' be logged in as user '$userName'")
    public void checkCurrentlyLoggedUser(String condition, String userName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String expectedEmail = wrapUserEmailWithTestSession(userName);
        String actualEmail = getSut().getPageCreator().getBasePage().getCurrentUserEmail();
        assertThat(actualEmail, shouldState ? equalTo(expectedEmail) : not(equalTo(expectedEmail)));
    }
}