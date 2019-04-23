package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import org.openqa.selenium.By;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 11.10.12
 * Time: 17:46

 */
public class AddNewPresentationPopUpWindow extends PopUpWindow {

    public AddNewPresentationPopUpWindow(Page parentPage) {
        super(parentPage);
    }

    public void setName(String value) {
        web.typeClean(By.cssSelector(".popupWindow .ui-input[name='name']"), value);
    }

    public void setDescription(String value) {
        web.typeClean(By.cssSelector(".popupWindow .ui-input[name='description']"), value);
    }

    public void save() {
        action.click();
        web.waitUntilElementDisappear(getPopUpWindowLocator());
    }

    private By getPopUpWindowLocator() {
        return generateLocator("div[title='New Presentation']");
    }
}