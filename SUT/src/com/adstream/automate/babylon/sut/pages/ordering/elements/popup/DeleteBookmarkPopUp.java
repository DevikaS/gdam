package com.adstream.automate.babylon.sut.pages.ordering.elements.popup;

import com.adstream.automate.babylon.sut.pages.ordering.OrderItemPage;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Link;
import com.adstream.automate.page.controls.Span;
import org.openqa.selenium.By;

/*
 * Created by demidovskiy-r on 12.05.14.
 */
public class DeleteBookmarkPopUp extends AbstractPopUp {
    public final static String TITLE = "Delete bookmark";
    public final static String TITLE_NODE = generateTitleNode(TITLE);

    // some locators are overwritten by Load Bookmark form
    public DeleteBookmarkPopUp(OrderItemPage parentPage, String title) {
        super(parentPage, title);
        this.parentElement = generatePopUpElement("> .windowHead", true);
        this.action = new Button(parentPage, generateLocator("+ * .button[name='Ok']"));
        this.cancel = new Link(parentPage, generateLocator("+ * .cancel"));
        this.close = new Span(parentPage, generateLocator(".close"));
    }

    @Override
    protected void loadPopUp() {
        web.waitUntilElementAppearVisible(getPopUpLocator());
    }

    @Override
    protected void unloadPopUp() {
        web.waitUntilElementDisappear(getPopUpLocator());
    }

    protected By getPopUpLocator() {
        return By.xpath(TITLE_NODE);
    }
}