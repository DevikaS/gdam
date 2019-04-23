package com.adstream.automate.babylon.sut.pages.admin.approvals.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import org.openqa.selenium.By;

/**
 * Created with IntelliJ IDEA.
 * User: lynda-k
 * Date: 13.09.13
 * Time: 19:03
 */
public class ApprovalTemplatePopup extends PopUpWindow {

    public ApprovalTemplatePopup(Page parentPage) {
        super(parentPage);
    }

    public ApprovalTemplatePopup typeName(String value) {
        web.typeClean(By.name("templateName"), value);
        return this;
    }

    public ApprovalTemplatePopup typeDescription(String value) {
        web.typeClean(By.name("templateDesc"), value);
        return this;
    }
}