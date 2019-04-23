package com.adstream.automate.babylon.performance.tests;

/**
 * User: ruslan.semerenko
 * Date: 15.06.12 18:17
 */
public class AuthenticationTest extends AbstractPerformanceTestServiceWrapper {
    @Override
    public void runOnce() {
        if (logIn(getParam("login"), getParam("password")) == null)
            fail(String.format("Unable to login as '%s' with password '%s'", getParam("login"), getParam("password")));
    }

    @Override
    public void beforeStart() {
    }

    @Override
    public void start() {
        logIn(getParam("login"), getParam("password"));
    }

    @Override
    public void afterRun() {
    }
}
