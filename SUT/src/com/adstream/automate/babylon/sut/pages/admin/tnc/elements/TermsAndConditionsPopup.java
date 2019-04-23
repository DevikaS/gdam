package com.adstream.automate.babylon.sut.pages.admin.tnc.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;

/**
 * User: lynda-k
 * Date: 28.02.14
 * Time: 09:03
 */
public class TermsAndConditionsPopup extends PopUpWindow {

    public TermsAndConditionsPopup(Page parentPage) {
        super(parentPage);
        web.waitUntilElementAppear(generateLocator());
    }

    public String getEntryTextBoxValue() {
        return web.findElement(generateLocator("textarea")).getAttribute("value").trim();
    }

    public void clickAcceptButton() {
        web.click(generateLocator("[data-role='tnc_accept']"));
        web.waitUntilElementDisappear(generateLocator());
    }

    public void clickDeclineLink() {
        web.click(generateLocator("a"));
        web.waitUntilElementDisappear(generateLocator());
    }
}