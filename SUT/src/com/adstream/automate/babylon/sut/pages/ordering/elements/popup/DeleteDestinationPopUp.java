package com.adstream.automate.babylon.sut.pages.ordering.elements.popup;

import com.adstream.automate.babylon.sut.pages.ordering.OrderItemPage;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Link;
import com.adstream.automate.page.controls.Span;
import org.openqa.selenium.By;

/*
 * Created by demidovskiy-r on 21.02.14.
 */
public class DeleteDestinationPopUp extends AbstractPopUp {
    public final static String TITLE = "Delete destination";
    public final static String TITLE_NODE = generateTitleNode(TITLE);

    public DeleteDestinationPopUp(OrderItemPage parentPage, String title) {
        super(parentPage, title);
        this.parentElement = generatePopUpElement("> .windowHead", true);
        this.action = new Button(parentPage, generateLocator("+ * .button"));
        this.cancel = new Link(parentPage, generateLocator("+ * [data-id='cancel']"));
        this.close = new Span(parentPage, generateLocator("[data-id='close-dialog']"));
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