package com.adstream.automate.babylon.sut.pages.NewLibrary.pages;

import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibraryWalkMePopup;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created by Janaki.Kamat on 27/04/2017.
 */
public class CollectionFilterPage extends LibraryAsset<CollectionFilterPage> {

    protected static final String collectionTabsLocator = "//ads-md-button[@css-class=\"module-navigation-tab\"]//span[text()='%s']";

    public CollectionFilterPage(ExtendedWebDriver web) {
        super(web);
    }

    public void load() {
        web.waitUntilElementDisappear(By.cssSelector("assets-view"));
    }

    public void isLoaded() throws Error {
        Common.sleep(2000);
        new LibraryWalkMePopup(this).clickClose();
        assertTrue(web.isElementVisible(By.cssSelector("assets-view")));

    }

    public CollectionFilterPage clickCollectionTab(String tabName) {
        web.findElement(By.xpath(String.format(collectionTabsLocator,tabName))).click();
        return this;
    }

    public void clickFilter()
    {
        web.findElement(By.xpath("//collection-nav-buttons[@on-click='$ctrl.sidebarClickAction()']//span[@code='filters']")).click();
    }

    public void clickSaveChanges()
    {
        web.findElement(By.xpath("//ads-md-button[@ng-click='$ctrl.updateCollection()']")).click();
    }


    public boolean getFiltersState(String filterName) {
        web.waitUntilElementAppear(By.xpath("//ads-md-button[contains(@id,'Media-filters')]"));
        Common.sleep(3000);
        return web.isElementVisible(By.xpath("//media-filter[@type='" + filterName + "']//md-checkbox[@checked='checked']"));



     }

}
