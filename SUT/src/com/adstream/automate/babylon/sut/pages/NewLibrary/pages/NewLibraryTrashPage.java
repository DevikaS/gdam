package com.adstream.automate.babylon.sut.pages.NewLibrary.pages;

import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.RestorePopUp;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;


public class NewLibraryTrashPage extends LibraryAsset {
    private static final By CHECK_ON_LOAD=By.cssSelector("collections-list");
    public NewLibraryTrashPage(ExtendedWebDriver web) {
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
        super.isLoaded();
        assertTrue(web.isElementPresent(CHECK_ON_LOAD));
    }

    public RestorePopUp clickRestore()
    {
        web.findElement(By.xpath("//ads-md-button[@id='trash-restore-button']/button")).click();
        return new RestorePopUp(this);
    }

    public void navigateToAssetInfoPage(String assetName) {

        web.findElement(By.xpath("//a[contains(@href,'collections/trash/assets')][@title='"+assetName+"']/span")).click();

    }





}
