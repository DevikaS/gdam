package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Link;
import com.adstream.automate.page.controls.Span;
import org.openqa.selenium.By;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 07.09.12
 * Time: 17:43
 */
public class ResetPasswordPopUpWindow extends PopUpWindow {
    public ResetPasswordPopUpWindow(Page parentPage) {
        super(parentPage);
        this.parentElement = ".popupWindow:not([style*='display: none'])";
        this.close = new Span(parentPage, generateLocator(".close"));
        this.action = new Button(parentPage, generateLocator(".resetPass"));
        this.cancel = new Link(parentPage, generateLocator(".cancel"));
    }

    public String getNotificationErrorMessage() {
        return web.waitUntilElementAppearVisible(By.cssSelector(".message-block.error")).getText();
    }
    public void typeEmail(String email) {
        web.typeClean(getEmailFieldLocator(), email);
    }

    private By getEmailFieldLocator() {
        return By.name("email");
    }

    @Override
    public void clickAction() {
        action.click();
        web.waitUntilElementDisappear(generateLocator());
    }
}
