package com.adstream.automate.babylon.sut.pages.ordering.elements.popup;

import com.adstream.automate.babylon.sut.pages.ordering.elements.lists.FailedOrderList;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Link;
import com.adstream.automate.page.controls.Span;
import org.openqa.selenium.By;

/*
 * Created by demidovskiy-r on 29.04.14.
 */
public class DeleteFailedOrderPopUp extends AbstractPopUp {
    public final static String TITLE = "Delete order";
    public final static String TITLE_CompletionQueue = "Delete transaction";
    public final static String TITLE_NODE = generateTitleNode(TITLE);

    public DeleteFailedOrderPopUp(FailedOrderList parentPage, String title) {
        super(parentPage, title);
        this.parentElement = generatePopUpElement("> .windowHead", true);
        this.action = new Button(parentPage, generateLocator("+ * .button"));
        this.cancel = new Link(parentPage, generateLocator("+ * [data-id='cancelBtn']"));
        this.close = new Span(parentPage, generateLocator(".close"));
    }

    @Override
    protected void loadPopUp() {
        web.waitUntilElementAppearVisible(By.xpath("//*[contains(@class,'popupWindow')]//*[contains(@id,'title') and (contains(.,'Delete transaction') or contains(.,'Delete order'))]"));    }

    @Override
    protected void unloadPopUp() {
        web.waitUntilElementDisappear(getPopUpLocator());
    }

    protected By getPopUpLocator() {
        return By.xpath(TITLE_NODE);
    }
}