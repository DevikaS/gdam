package com.adstream.automate.babylon.sut.pages.admin.agency;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
  * User: lynda-k
 * Date: 25.02.14
 * Time: 12:07
 */
public class AgencyMetadataMappingEditPage extends AgencyMetadataMappingCreatePage {
    public AgencyMetadataMappingEditPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void init() {
        super.init();
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(By.cssSelector("[ng-click*='saveMapping']"));
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementPresent(By.cssSelector("[ng-click*='saveMapping']")));
    }
}
