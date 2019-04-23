package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import org.openqa.selenium.By;

/**
 * Created with IntelliJ IDEA.
 * User: lynda-k
 * Date: 13.09.13
 * Time: 19:03
 */
public class SaveAsApprovalTemplatePopup extends PopUpWindow {

    public SaveAsApprovalTemplatePopup(Page parentPage) {
        super(parentPage);
    }

    public SaveAsApprovalTemplatePopup typeName(String value) {
        web.typeClean(By.name("templateName"), value);
        return this;
    }

    public SaveAsApprovalTemplatePopup typeDescription(String value) {
        web.typeClean(By.name("templateDesc"), value);
        return this;
    }

    public boolean isInputNameRed() {
        return web.isElementPresent(generateLocator(".dijitTextBoxError")) && web.isElementVisible(generateLocator(".dijitTextBoxError"));
    }


}