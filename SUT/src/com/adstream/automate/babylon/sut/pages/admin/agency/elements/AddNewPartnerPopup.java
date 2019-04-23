package com.adstream.automate.babylon.sut.pages.admin.agency.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import org.openqa.selenium.By;

/**
 * User: lynda-k
 * Date: 25.02.14
 * Time: 12:33
 */
public class AddNewPartnerPopup extends PopUpWindow {
    public AddNewPartnerPopup(Page parentPage) {
        super(parentPage);
    }

    public AddNewPartnerPopup setPartnerName(String name) {
        web.typeClean(generateLocator("[role='textbox']"), name);
        web.sleep(1000);
        web.click(By.xpath(String.format("//*[contains(@id,'Autocomplete')][@role='option'][contains(.,'%s')][last()]", name)));
        return this;
    }
}