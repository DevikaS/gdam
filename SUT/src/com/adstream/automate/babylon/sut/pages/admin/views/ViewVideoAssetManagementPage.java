package com.adstream.automate.babylon.sut.pages.admin.views;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/*
 * Created by demidovskiy-r on 17.06.2015.
 */
public class ViewVideoAssetManagementPage extends ViewAssetManagementPage {
    public ViewVideoAssetManagementPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(getPageLocator());
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementVisible(getPageLocator()));
    }

    private By getPageLocator() {
        return generatePageLocator("[data-dojo-props*='video']");
    }
}