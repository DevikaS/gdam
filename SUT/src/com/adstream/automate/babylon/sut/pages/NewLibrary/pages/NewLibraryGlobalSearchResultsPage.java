package com.adstream.automate.babylon.sut.pages.NewLibrary.pages;

import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibraryWalkMePopup;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;

import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;


public class NewLibraryGlobalSearchResultsPage extends LibraryAsset<NewAdbankLibraryPage> {
    private static final By CHECK_ON_LOAD=By.xpath("//assets-list");
    public NewLibraryGlobalSearchResultsPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppear(CHECK_ON_LOAD);
        Common.sleep(1000);
    }

    @Override
    public void isLoaded() throws Error {
        Common.sleep(2000);
       // new LibraryWalkMePopup(this).clickClose();
        assertTrue(web.isElementPresent(CHECK_ON_LOAD));
    }

    public List<String> getListResultAssetFromGlobalSearch() {
        return web.findElementsToStrings(By.xpath("//datatable-body-cell//div[contains(@class,'title')]/a"));
    }



}
