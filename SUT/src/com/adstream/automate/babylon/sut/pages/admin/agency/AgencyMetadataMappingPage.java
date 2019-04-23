package com.adstream.automate.babylon.sut.pages.admin.agency;

import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.babylon.sut.pages.admin.agency.elements.NewMetadataMapPopup;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
  * User: lynda-k
 * Date: 25.02.14
 * Time: 12:07
 */
public class AgencyMetadataMappingPage extends BaseAdminPage<AgencyMetadataMappingPage> {
    public AgencyMetadataMappingPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void init() {
        super.init();
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(By.cssSelector("[ng-click*='NewMapping']"));
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementPresent(By.cssSelector("[ng-click*='NewMapping']")));
    }

    public NewMetadataMapPopup clickNewMetadataMapButton() {
        web.click(getNewMetadataMapButtonLocator());
        return new NewMetadataMapPopup(this);
    }

    private By getNewMetadataMapButtonLocator() {
        return By.cssSelector("[ng-click*='NewMapping']");
    }
}
