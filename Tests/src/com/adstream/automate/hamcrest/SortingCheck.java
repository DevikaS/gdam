package com.adstream.automate.hamcrest;

import org.hamcrest.Description;
import org.hamcrest.Factory;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;

import java.util.*;

/**
 * Created with IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 20.06.12
 * Time: 20:09
 * To change this template use File | Settings | File Templates.
 */
public class SortingCheck extends TypeSafeMatcher<List<String>> {
    private Comparator<String> comparator;
    private String descriptionText;

    public SortingCheck(Comparator<String> comparator) {
        this.comparator = comparator;
    }

    public void describeTo(Description description) {
        description.appendText("<");
        description.appendText(descriptionText);
        description.appendText(">");
    }

    @Factory
    public static <T> Matcher<List<String>> sorted(Comparator<String> comparator) {
        return new SortingCheck(comparator);
    }

    @Factory
    public static <T> Matcher<List<String>> sortedAlphabetically() {
        return new SortingCheck(String.CASE_INSENSITIVE_ORDER);
    }

    @Override
    public boolean matchesSafely(List<String> items) {
        Iterator<String> actualItemsIterator = items.iterator();
        List<String> sortedItems = asSortedList(items);
        Iterator<String> sortedItemsIterator = sortedItems.iterator();

        while (actualItemsIterator.hasNext() && sortedItemsIterator.hasNext()) {
            String actual = actualItemsIterator.next();
            String expected = sortedItemsIterator.next();
            if (!actual.equals(expected)) {
                descriptionText = Arrays.toString(sortedItems.toArray());
                return false;
            }
        }
        return true;
    }

    public List<String> asSortedList(Collection<String> c) {
        List<String> list = new ArrayList<String>(c);
        java.util.Collections.sort(list, comparator);
        return list;
    }

}
