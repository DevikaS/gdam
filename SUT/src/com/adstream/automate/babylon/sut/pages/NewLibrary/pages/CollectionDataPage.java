package com.adstream.automate.babylon.sut.pages.NewLibrary.pages;

import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibraryWalkMePopup;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created by Janaki.Kamat on 11/09/2017.
 */
public class CollectionDataPage extends CollectionPage {
    private static final By CHECK_ON_LOAD = By.cssSelector("collections-list");

    public CollectionDataPage(ExtendedWebDriver web){
        super(web);
    }

    public void load() {
       web.waitUntilElementAppearVisible(CHECK_ON_LOAD);
    }
    public void isLoaded() throws Error {
      assertTrue(web.isElementVisible(CHECK_ON_LOAD));
      new LibraryWalkMePopup(this).clickClose();
    }

    public List<String> getBreadCrum() {
        return web.findElementsToStrings(breadCrumLocator);
    }
}

