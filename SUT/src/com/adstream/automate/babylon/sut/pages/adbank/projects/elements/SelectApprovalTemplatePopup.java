package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.DojoCombo;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: lynda-k
 * Date: 13.09.13
 * Time: 19:05
 */
public class SelectApprovalTemplatePopup extends PopUpWindow {

    public SelectApprovalTemplatePopup(Page parentPage) {
        super(parentPage);
    }

    public SelectApprovalTemplatePopup selectTemplate(String value) {
        new DojoCombo(parentPage, generateLocator("[role='combobox']")).selectByVisibleText(value);
        return this;
    }

    public List<String> getAvailableTemplates() {
        return new DojoCombo(parentPage, generateLocator("[role='combobox']")).getValues();
    }
}