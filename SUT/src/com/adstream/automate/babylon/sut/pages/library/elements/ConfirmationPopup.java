package com.adstream.automate.babylon.sut.pages.library.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;

/**
 * User: lynda-k
 * Date: 06.02.14
 * Time: 12:00
 */
public class ConfirmationPopup extends PopUpWindow {
    private Button yesButton;
    private Button noButton;

    public ConfirmationPopup(Page parentPage) {
        super(parentPage);
        action = new Button(parentPage, generateLocator("[name='Ok']"));
        yesButton = new Button(parentPage, generateLocator("[data-role='yesBtn']"));
        noButton = new Button(parentPage, generateLocator("[data-role='noBtn']"));
    }

    public boolean isPresentOnPage() {
        return web.isElementPresent(By.cssSelector(parentElement));
    }

    public void clickYesButton() {
        yesButton.click();
        Common.sleep(1000);
    }

    public boolean isClickYesButtonVisible() {
        return yesButton.isVisible();
    }

    public void clickNoButton() {
        noButton.click();
        Common.sleep(1000);
    }
}
