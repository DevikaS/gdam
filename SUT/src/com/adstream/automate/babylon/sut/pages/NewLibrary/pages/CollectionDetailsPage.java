package com.adstream.automate.babylon.sut.pages.NewLibrary.pages;

import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibCollectionPopUp;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibEditCollectionPopup;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibraryWalkMePopup;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibRemoveCollectionPopup;
import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created by Janaki.Kamat on 24/04/2017.
 */
public class CollectionDetailsPage extends LibraryAsset {
    private static final By editLinkLocator = By.xpath("//ads-md-menu-item[@id='collection-edit-details']/md-menu-item/ads-md-button/button//span[.='Edit details']");
    private static final By CHECK_ON_LOAD = By.cssSelector("collection-details");

    public CollectionDetailsPage(ExtendedWebDriver web) {
        super(web);
    }

    public void load() {
        web.waitUntilElementAppearVisible(CHECK_ON_LOAD);
    }

    public void isLoaded() throws Error {
        Common.sleep(2000);
        assertTrue(web.isElementVisible(CHECK_ON_LOAD));
        new LibraryWalkMePopup(this).clickClose();
    }

    public LibCollectionPopUp clickEditCollectionDetails() {

        web.findElement(By.xpath("//ads-md-button[@ng-click='$ctrl.menuClick()']")).click();
        WebElement element = web.findElement(editLinkLocator);
        web.getJavascriptExecutor().executeScript("arguments[0].click();",element);
        return new LibCollectionPopUp(this, "Edit Details");
    }


    public boolean isCollectionCreatedMessageVisible(String message) {
        web.waitUntilElementAppear(By.xpath(String.format(".//*[contains(text(),\"%s\")]", message)));
        return web.isElementVisible(By.xpath(String.format(".//*[contains(text(),\"%s\")]", message)));
    }

    public void selectUsingBreadCrum(String collection) {
        for (WebElement elem : web.findElements(breadCrumLocator)) {
            if (elem.getText().equalsIgnoreCase(collection)) {
                elem.click();
                break;
            }
        }
    }

    public List<String> getBreadCrum() {
        return web.findElementsToStrings(breadCrumLocator);
    }

    public void setAsHomeCollection(String collectionName){
        web.getJavascriptExecutor().executeScript("arguments[0].click();",web.findElement(By.xpath(String.format("//tree-item-menu/ads-md-menu//ads-md-button[@ng-click=\"$ctrl.menuClick()\"]/button",collectionName))));
        web.waitUntilElementAppear(By.xpath("*//span[contains(text(),\"Set as collection home\")]"));
        web.getJavascriptExecutor().executeScript("arguments[0].click();",web.findElement(By.xpath(".//md-menu-item/ads-md-button//button[..//span[contains(text(),\"Set as collection home\")]]")));
    }

    public void removeAsHomeCollection(String collectionName){
        web.getJavascriptExecutor().executeScript("arguments[0].click();",web.findElement(By.xpath(String.format("//tree-item-menu/ads-md-menu//ads-md-button[@ng-click=\"$ctrl.menuClick()\"]/button",collectionName))));
        web.waitUntilElementAppear(By.xpath("*//span[contains(text(),\"Remove as collection home\")]"));
        web.getJavascriptExecutor().executeScript("arguments[0].click();",web.findElement(By.xpath(".//md-menu-item/ads-md-button//button[..//span[contains(text(),\"Remove as collection home\")]]")));
    }

    public CollectionDetailsPage openMenuPopup(){
        if(web.isElementPresent(By.cssSelector("ads-md-button[ng-click=\"$ctrl.menuClick()\"] button")));
        web.getJavascriptExecutor().executeScript("arguments[0].click();", web.findElement(By.cssSelector("ads-md-button[ng-click=\"$ctrl.menuClick()\"] button")));
        Common.sleep(2000);
        return this;
    }

    public void scrollDownToFooterOnCollectionDetailsPage() {
        web.scrollToElement(web.findElement(By.xpath("//ads-ui-paginator[@page-sizes='$ctrl.appConfig.application.pageSizes']")));
        web.sleep(2000);
    }

    public LibRemoveCollectionPopup clickRemoveCollection() {
        web.findElement(By.xpath("//ads-md-button[@ng-click='$ctrl.menuClick()']/button")).click();
        WebElement element = web.findElement(By.xpath("//div[contains(@id,'menu_container')]//ads-md-content/ads-md-menu-item[@ng-repeat='menuAction in ::$ctrl.menuActions'][1]//button"));
        web.getJavascriptExecutor().executeScript("arguments[0].click();", element);
        return new LibRemoveCollectionPopup(this);
    }

    public void clickInfoButton()
    {
        WebElement element = web.findElement(By.xpath("//ads-md-button[@id='collection-info-button']/button"));
        web.getJavascriptExecutor().executeScript("arguments[0].click();",element);

    }

    public LibRemoveCollectionPopup removeCollection(){
        web.waitUntilElementAppear(By.xpath("*//span[contains(text(),\"Remove collection\")]"));
        web.getJavascriptExecutor().executeScript("arguments[0].click();",web.findElement(By.xpath(".//button[..//span[contains(text(),\"Remove collection\")]]")));
        return new LibRemoveCollectionPopup(this);
    }

    public LibEditCollectionPopup editCollection(){
        web.waitUntilElementAppear(By.xpath("*//span[contains(text(),\"Edit details\")]"));
        web.getJavascriptExecutor().executeScript("arguments[0].click();",web.findElement(By.xpath(".//button[..//span[contains(text(),\"Edit details\")]]")));
        return new LibEditCollectionPopup(this);
    }

    public void clickAssetFilter() {
        if(web.isElementPresent(By.xpath("*//*[@ng-repeat=\"button in $ctrl.buttons track by button.name\"]/button[.//span[@code=\"filters\"]]")))
            web.getJavascriptExecutor().executeScript("arguments[0].click();",web.findElement(By.xpath("*//*[@ng-repeat=\"button in $ctrl.buttons track by button.name\"]/button[.//span[@code=\"filters\"]]")));
        Common.sleep(2000);
    }
}