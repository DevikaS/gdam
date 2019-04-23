package com.adstream.automate.babylon.sut.pages.ordering.elements.popup;

import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Link;
import com.adstream.automate.page.controls.Span;
import org.openqa.selenium.By;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 13.11.13
 * Time: 15:42
 */
public class ApprovalConfirmationPopUp extends AbstractPopUp {
    public final static String TITLE = "Approval Confirmation";
    public final static String TITLE_NODE = generateTitleNode(TITLE);

    public ApprovalConfirmationPopUp(Page parentPage, String title) {
        super(parentPage, title);
        this.parentElement = generatePopUpElement("> .windowHead", true);
        this.action = new Button(parentPage, generateLocator("+ * .button"));
        this.cancel = new Link(parentPage, generateLocator("+ * [data-id='cancelBtn']"));
        this.close = new Span(parentPage, generateLocator("[data-id='close-dialog']"));
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

    protected By getPopUpLocator() {
        return By.xpath(TITLE_NODE);
    }
}