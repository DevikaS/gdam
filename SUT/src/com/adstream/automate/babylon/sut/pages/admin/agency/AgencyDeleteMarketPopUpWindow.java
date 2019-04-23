package com.adstream.automate.babylon.sut.pages.admin.agency;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Link;
import com.adstream.automate.page.controls.Span;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * User: Devika Subramanian
 * Date: 15.02.16
 * Time:
 */
public class AgencyDeleteMarketPopUpWindow extends PopUpWindow {
    public AgencyDeleteMarketPopUpWindow(Page parentPage) {
        super(parentPage);

    }

    @Override
    public void clickAction() {
        web.click(By.xpath("//button[@class='button secondary mrs ng-binding']"));
        web.waitUntilElementDisappear(generateLocator());
    }
}


