package com.adstream.automate.babylon.sut.pages.NewLibrary.pages;

import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibraryWalkMePopup;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created by Janaki.Kamat on 06/02/2018.
 */
public class LibSingleEditAssetMetadataPage extends LibraryAssetsInfoPage {

    private static final By editMessageLocator = By.cssSelector("[ng-click=\"$ctrl.onEditAll()\"]");

    public LibSingleEditAssetMetadataPage(ExtendedWebDriver web) {
        super(web);
    }

    public void load() {
     //   super.load();
        web.waitUntilElementAppearVisible(By.cssSelector("asset-wrapper-edit asset-content-single-edit"));
    }

    public void isLoaded() throws Error {
        new LibraryWalkMePopup(this).clickClose();
     //   super.isLoaded();
        assertTrue(web.isElementVisible(By.cssSelector("asset-wrapper-edit asset-content-single-edit")));
    }

    public String getEditMessage(){
        return web.findElement(editMessageLocator).getText();
    }

    public void clickEditMessage(String editMessage){
        if(web.isElementVisible(editMessageLocator) && web.findElement(editMessageLocator).getText().equalsIgnoreCase(editMessage))
            web.click(editMessageLocator);
    }
}
