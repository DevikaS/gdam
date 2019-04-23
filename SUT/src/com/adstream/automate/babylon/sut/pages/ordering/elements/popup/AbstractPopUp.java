package com.adstream.automate.babylon.sut.pages.ordering.elements.popup;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Link;
import com.adstream.automate.page.controls.Span;
import org.openqa.selenium.By;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 02.09.13
 * Time: 19:04
 */
public abstract class AbstractPopUp extends PopUpWindow {
    protected abstract void loadPopUp();
    protected abstract void unloadPopUp();
    private final static String POPUP_ROOT_NODE = ".popupWindow.dijitDialog:not([style*='display: none'])";
    private final static String POPUP_FIXED_ROOT_NODE = ".popupWindow.dijitDialogFixed:not([style*='display: none'])";

    public AbstractPopUp(Page parentPage, String title) {
        super(parentPage, title);
        this.parentElement = generatePopUpElement("> .windowHead", false);
        this.action = new Button(parentPage, generateLocator("+ * .button"));
        this.close = new Span(parentPage, generateLocator(".close"));
        this.cancel = new Link(parentPage, generateLocator("+ * .cancel"));
        loadPopUp();
    }

    public void clickOkBtn() {
        action.click();
        unloadPopUp();
        waitUntilLoadSpinnerDisappears();
    }

    // To handle QA-287
    public void clickOkBtn_new() {
        action.click();
        unloadPopUp();
    }

    public void cancel() {
        cancel.click();
        unloadPopUp();
    }

    public void close() {
        close.click();
        unloadPopUp();
    }

    protected void waitUntilLoadSpinnerDisappears() {
        web.waitUntilElementDisappear(By.className("orders-spinner"));
    }

    protected By getPopUpLocator() {
        return generateLocator();
    }

    protected String getPopupRootNode() {
        return POPUP_ROOT_NODE;
    }

    protected String getPopupFixedRootNode() {
        return POPUP_FIXED_ROOT_NODE;
    }

    protected static String generateTitleNode(String partialLocator) {
        return "//*[contains(@class,'popupWindow')]//*[contains(@id,'title') and contains(.,'" + partialLocator + "')]";
    }

    protected String generatePopUpElement(String partialLocator, boolean isPopUpParentNodeFixed) {
        return String.format("%s %s", isPopUpParentNodeFixed ? getPopupFixedRootNode() : getPopupRootNode(), partialLocator);
    }
}