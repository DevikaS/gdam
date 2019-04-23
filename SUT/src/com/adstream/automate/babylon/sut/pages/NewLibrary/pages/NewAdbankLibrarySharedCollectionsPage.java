package com.adstream.automate.babylon.sut.pages.NewLibrary.pages;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created by Janaki.Kamat on 22/09/2017.
 */
public class NewAdbankLibrarySharedCollectionsPage extends LibraryAsset {
    public NewAdbankLibrarySharedCollectionsPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppear(getPageLocator());
        Common.sleep(1000);
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementPresent(getPageLocator()));
    }


    public By getPageLocator() {
        return By.xpath("//assets-view[@collection='store.collection']");
    }

}
