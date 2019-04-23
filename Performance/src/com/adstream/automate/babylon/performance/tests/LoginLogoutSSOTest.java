package com.adstream.automate.babylon.performance.tests;

/**
 * User: ruslan.semerenko
 * Date: 24.10.12 14:42
 */
public class LoginLogoutSSOTest extends AbstractPerformanceTestServiceWrapper {
    @Override
    public void runOnce() {
        if (getService().authSSO(getParam("login"), getParam("password")) == null) fail(String.format("Unable to login as '%s' with password '%s'", getParam("login"), getParam("password")));
    }

    @Override
    public void beforeStart() {
    }

    @Override
    public void start() {
        getService().authSSO(getParam("login"), getParam("password"));
        if (getParamBoolean("logout"))
            getService().logoutSSO();
    }

    @Override
    public void afterRun() {
    }
}
