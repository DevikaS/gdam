package com.adstream.automate.hamcrest;

import org.hamcrest.Description;
import org.hamcrest.Factory;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;

/**
 * User: ruslan.semerenko
 * Date: 09.07.12 18:01
 */
public class StringByRegExpCheck extends TypeSafeMatcher<String> {
    private String pattern;

    public StringByRegExpCheck(String pattern) {
        this.pattern = pattern;
    }

    @Factory
    public static Matcher<String> matches(String pattern) {
        return new StringByRegExpCheck(pattern);
    }

    @Override
    public boolean matchesSafely(String item) {
        return item.matches(pattern);
    }

    @Override
    public void describeTo(Description description) {
        description.appendText("String matches reg exp pattern '" + pattern + "'");
    }
}
