package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.sut.pages.admin.passwords.GlobalPasswordsPage;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.is;
/**
 * Created by sobolev-a on 18.04.2014.
 */
public class GlobalAdminPasswordsSteps extends BaseStep {

    @Given("{I am |}on {the|} global admin passwords page")
    @When("{I go |}to the global admin passwords page")
    public GlobalPasswordsPage onPasswordsPage() {
        return getSut().getPageNavigator().getGlobalPasswordsPage();
    }

    @Given("{I |}changed password for user '$userEmail' with password '$password' and repeat password '$repeatPassword'")
    @When("{I |}change password for user '$userEmail' with password '$password' and repeat password '$repeatPassword'")
    public void changePassword(String userEmail, String password, String repeatPassword) {
        getSut().getPageCreator().getGlobalPasswordsPage().changePassword(wrapUserEmailWithTestSession(userEmail), password, repeatPassword);
    }

    @Then("{I |}should see warning message '$message' on global admin passwords page")
    public void checkWarningMessage(String message) {
        boolean actualState = getSut().getPageCreator().getGlobalPasswordsPage().isWarningPasswordMessageExist(message);
        assertThat(true, is(actualState));
    }
}
