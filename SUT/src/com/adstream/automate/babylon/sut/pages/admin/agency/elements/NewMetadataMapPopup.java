package com.adstream.automate.babylon.sut.pages.admin.agency.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.DojoCombo;
import org.openqa.selenium.By;

/**
 * User: lynda-k
 * Date: 25.02.14
 * Time: 12:33
 */
public class NewMetadataMapPopup extends PopUpWindow {
    public NewMetadataMapPopup(Page parentPage) {
        super(parentPage);
        web.waitUntilElementAppearVisible(getBusinessUnitComboboxLocator());
    }

    public void selectBusinessUnit(String businessUnit) {
        web.typeClean(generateLocator("[data-role='agency-selector']"), businessUnit);
        web.waitUntilElementAppearVisible(By.cssSelector(".dijitComboBoxHighlightMatch, .dijitComboBoxError"));
        new DojoCombo(parentPage, getBusinessUnitComboboxLocator()).selectByVisibleText(businessUnit);
    }

    private By getBusinessUnitComboboxLocator() {
        return generateLocator("[role='combobox']");
    }
}