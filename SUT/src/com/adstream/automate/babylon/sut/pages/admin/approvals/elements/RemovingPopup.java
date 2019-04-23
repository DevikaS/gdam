package com.adstream.automate.babylon.sut.pages.admin.approvals.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Button;

/**
 * Created with IntelliJ IDEA.
 * User: lynda-k
 * Date: 13.09.13
 * Time: 19:03
 */
public class RemovingPopup extends PopUpWindow {
    Button yesButton;
    Button noButton;

    public RemovingPopup(Page parentPage) {
        super(parentPage);
        yesButton = new Button(parentPage, generateLocator("[name='remove']"));
        noButton = new Button(parentPage, generateLocator("[name='cancel']"));
    }

    public void clickYesButton() {
        yesButton.click();
        web.sleep(1000);
    }

    public void clickNoButton() {
        noButton.click();
        web.sleep(1000);
    }
}