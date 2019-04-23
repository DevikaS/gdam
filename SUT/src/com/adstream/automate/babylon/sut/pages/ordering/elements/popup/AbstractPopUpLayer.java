package com.adstream.automate.babylon.sut.pages.ordering.elements.popup;

import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.AbstractForm;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Link;
import com.adstream.automate.page.controls.Span;
import org.openqa.selenium.By;

/*
 * Created by demidovskiy-r on 19.03.14.
 */
public abstract class AbstractPopUpLayer extends AbstractForm {
    protected Span close;
    protected Button action;
    protected Link cancel;
    private String parentElement;
    protected final static String POPUP_ROOT_NODE = ".popupWindow.dijitDialog:not([style*='display: none'])";

    protected AbstractPopUpLayer(BasePage parent) {
        super(parent);
        this.parentElement = generatePopUpElement("> .windowHead");
        this.action = new Button(parent, generatePopUpElementLocator("+ * .button"));
        this.close = new Span(parent, generatePopUpElementLocator(".close"));
        this.cancel = new Link(parent, generatePopUpElementLocator("+ * .cancel"));
    }

    public void clickOkBtn() {
        action.isEnabled();
        action.click();
        unloadForm();
        waitUntilLoadSpinnerDisappears();
    }

    public void cancel() {
        cancel.click();
        unloadForm();
    }

    public void close() {
        close.click();
        unloadForm();
    }

    private String generatePopUpElement(String partialLocator) {
        return String.format("%s %s", getPopupRootNode(), partialLocator);
    }

    protected String getPopupRootNode() {
        return POPUP_ROOT_NODE;
    }

    protected By generatePopUpElementLocator(String particalLocator) {
        return By.cssSelector(String.format("%s %s", parentElement, particalLocator));
    }
}