package com.adstream.automate.babylon.tests.api.tests;

import com.adstream.automate.babylon.BabylonServiceWrapper;
import com.adstream.automate.babylon.middleware.BabylonMiddlewareService;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * User: ruslan.semerenko
 * Date: 08.01.14 14:59
 */
public class LoginTest extends AbstractTest {

    @Test
    public void loginPositive() {
        doLogin(getDefaultUserEmail(), getDefaultPassword(), true);
    }

    @Test
    public void loginWithWrongPassword() {
        doLogin(getDefaultUserEmail(), "wrongpassword", false);
    }

    @Test
    public void loginWithEmptyPassword() {
        doLogin(getDefaultUserEmail(), "", false);
    }

    @Test
    public void loginWithAbsentUser() {
        doLogin("usernotexists@test.com", "wrongpassword", false);
    }

    private void doLogin(String login, String password, boolean passed) {
        BabylonServiceWrapper restService = new BabylonServiceWrapper(new BabylonMiddlewareService(getApplicationUrl()), null);
        boolean loggedIn = restService.logInSSO(login, password);
        Assert.assertEquals(loggedIn, passed, "User logged in");
    }
}
