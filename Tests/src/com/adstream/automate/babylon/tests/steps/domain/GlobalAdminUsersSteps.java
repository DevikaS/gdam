package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.admin.people.GlobalAdminUsersPage;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;

import static com.adstream.automate.babylon.tests.steps.domain.UserSteps.wrapNameAndGetUser;
import static org.hamcrest.MatcherAssert.assertThat;

public class GlobalAdminUsersSteps extends BaseStep{

    public GlobalAdminUsersPage openUsersPage() {
        return getSut().getPageNavigator().getGlobalAdminUsersPage();
    }

    @When("{I |}search user by email '$userName'")
    public GlobalAdminUsersPage searchUserByEmail(String userName) {
        GlobalAdminUsersPage usersPage = openUsersPage();
        usersPage.searchUser(userName.isEmpty() ? userName : wrapUserEmailWithTestSession(userName));
        return usersPage;
    }

    @Then("{I |}should see '$userName' on global admin users list page")
    public void checkUserIsPresent(String userName){
        GlobalAdminUsersPage page = searchUserByEmail(userName);
        User user = wrapNameAndGetUser(userName);
        String expected = user.getFirstName().concat(" ").concat(user.getLastName());
        String actual = page.getUserName();

        assertThat("I should see user in User list", actual.equalsIgnoreCase(expected));
    }

}
