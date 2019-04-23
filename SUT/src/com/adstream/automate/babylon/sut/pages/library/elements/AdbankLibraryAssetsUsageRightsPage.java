package com.adstream.automate.babylon.sut.pages.library.elements;

import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AdbankFileUsageRightsPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

public class AdbankLibraryAssetsUsageRightsPage extends AdbankFileUsageRightsPage {
    public AdbankLibraryAssetsUsageRightsPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        web.waitUntilElementAppearVisible(
                By.cssSelector("[data-dojo-type=\"adbank.usageRights.add_usage_rights_control\"]"));
    }

    @Override
    public void isLoaded() throws Error {
        assertTrue(web.isElementVisible(
                By.cssSelector("[data-dojo-type=\"adbank.usageRights.add_usage_rights_control\"]")));
    }

    public AdbankLibraryAssetsUsageRightsPage clickEditUsageLink(String usageName) {
        web.click(getEditLinkLocator(usageName));
        Common.sleep(1000);
        return this;
    }

    public AdbankLibraryAssetsUsageRightsPage clickSaveButton(String usageName) {
        web.click(getSaveButtonLocator(usageName));
        Common.sleep(1000);
        return this;
    }

    public boolean isEditLinkPresentForUsageType(String usageName) {
        return web.isElementVisible(getEditLinkLocator(usageName));
    }

    private By getEditLinkLocator(String usageName) {
        return By.cssSelector(String.format("[data-usagetype='%s'] [data-role='editButton']", usageName));
    }

    private By getSaveButtonLocator(String usageName) {
        return By.cssSelector(String.format("[data-usagetype='%s'] [name='Save']", usageName));
    }
}
