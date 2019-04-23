package com.adstream.automate.babylon.sut.pages.NewLibrary.pages;

import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibraryWalkMePopup;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created by Devika on 27/04/2017.
 */
public class NewAdbankLibraryAssetsPage extends LibraryAsset<NewAdbankLibraryAssetsPage> {
    public NewAdbankLibraryAssetsPage(ExtendedWebDriver web) {
        super(web);
    }

    public void load() {
        web.waitUntilElementAppear(By.cssSelector("assets-filter"));
    }

    public void isLoaded() throws Error {
        Common.sleep(2000);
        new LibraryWalkMePopup(this).clickClose();
        assertTrue(web.isElementVisible(By.cssSelector("assets-filter")));

    }

    public String getCurrentNewLibraryUrl() {
        return getDriver().getCurrentUrl();
    }

     public void clickTopMenu(String menu)
     {
        web.findElement(By.xpath("//span[.='"+menu+"']")).click();
     }

    public boolean isMenuExist(String menu)
    {
        return web.isElementPresent(By.xpath("//span[.='"+menu+"']"));
    }

}
