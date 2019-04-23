package com.adstream.automate.babylon.monitoring;

/**
 * User: ruslan.semerenko
 * Date: 24.07.13 18:15
 */
public class Action {
    private String method;
    private Argument[] argument;
    private Assertion[] assertion;

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public Argument[] getArgument() {
        return argument;
    }

    public void setArgument(Argument[] argument) {
        this.argument = argument;
    }

    public Assertion[] getAssertion() {
        return assertion;
    }

    public void setAssertion(Assertion[] assertion) {
        this.assertion = assertion;
    }
}
