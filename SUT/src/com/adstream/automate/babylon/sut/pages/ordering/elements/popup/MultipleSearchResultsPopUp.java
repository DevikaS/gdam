package com.adstream.automate.babylon.sut.pages.ordering.elements.popup;

import com.adstream.automate.babylon.sut.pages.ordering.OrderItemPage;
import com.adstream.automate.babylon.sut.pages.ordering.elements.lists.MultipleSearchResultsList;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;

/*
 * Created by demidovskiy-r on 15.05.14.
 */
public class MultipleSearchResultsPopUp extends AbstractPopUp {
    public final static String TITLE = "Your multiple search results";
    public final static String TITLE_NODE = generateTitleNode(TITLE);

    public MultipleSearchResultsPopUp(OrderItemPage parentPage, String title) {
        super(parentPage, title);
    }

    public MultipleSearchResultsList getMultipleSearchResultsList() {
        if (!web.isElementVisible(By.cssSelector(MultipleSearchResultsList.ROOT_NODE)))
            throw new NoSuchElementException("There is no multiple search results on the popup!");
        return new MultipleSearchResultsList(web);
    }

    @Override
    protected void loadPopUp() {
        waitUntilLoadSpinnerDisappears();
        web.waitUntilElementAppearVisible(getPopUpLocator());
    }

    @Override
    protected void unloadPopUp() {
        web.waitUntilElementDisappear(getPopUpLocator());
    }

    public void apply() {
        clickOkBtn();
    }
}