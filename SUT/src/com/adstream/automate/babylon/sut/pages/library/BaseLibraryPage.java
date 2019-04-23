package com.adstream.automate.babylon.sut.pages.library;

import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.*;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.LibMultiEditAssetMetadataPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.Control;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;


public class BaseLibraryPage<T> extends BasePage<T> {
    protected Control container;
    protected static final By libraryAssetTabLocator = By.xpath("//md-tabs-canvas//md-tab-item//span[contains(text(),\"Library\")][contains(@class,\"ng-binding\")]");
    protected static final By collectionTabLocator = By.xpath(".//md-tab-item/a/span[contains(text(),\"Collections\")]");
    protected static final By unselectAllLocator = By.cssSelector("a[ng-click=\"$ctrl.unselectAll()\"]");
    protected static final By selectAllLocator = By.cssSelector("a[ng-click=\"$ctrl.selectAll()\"]");
    protected static final By showOnPageLocator = By.cssSelector("div[class*=\"ads-paginator-page-size\"]");
    protected static final By uploadButtonLocator = By.cssSelector("ads-md-button[click=\"::$ctrl.openUploadWindow()\"] button span[class=\"valign-middle ng-scope\"]");
    protected static final By newCollectionPopupLocator = By.xpath("//*[contains(text(),\"New collection\")]");
    protected static final By newSubCollectionPopupLocator = By.xpath("//*[contains(text(),\"New sub-collection\")]");
    protected static final By downloadButtonLocator = By.cssSelector("ads-md-button[click=\"::$ctrl.openDownload()\"] button");
    protected static final By UsingItemLocator = By.xpath("//*[@ng-click=\"$ctrl.onCreateFromAssets()\"]//ads-md-button/*//*");
    protected static final By UsingFiltersLocator= By.xpath("//*[@ng-click=\"$ctrl.onCreateFromFilters()\"]//ads-md-button/*//*");

    public BaseLibraryPage(ExtendedWebDriver web) {
        super(web);
    }

    public void load() {
        super.load();
        container.visible();
    }

    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(container.isVisible());
    }

    @Override
    public void init() {
        container = new Control(this, By.cssSelector(".library"));
    }

    public BaseLibraryPage<T> openPopup(){
        if(web.isElementPresent(By.cssSelector("ads-md-button[id=\"assets-menu-button\"] button")))
            web.findElement(By.cssSelector("ads-md-button[id=\"assets-menu-button\"] button")).click();
        Common.sleep(2000);
        return this;
    }

    public BaseLibraryPage<T> openPopupOnAssetInfoPage(){
        if(web.isElementPresent(By.cssSelector("ads-md-button[id=\"asset-preview-more-options\"] button")))
            web.findElement(By.cssSelector("ads-md-button[id=\"asset-preview-more-options\"] button")).click();
        Common.sleep(2000);
        return this;
    }
    public boolean isMenuExist()
    {
        return web.isElementVisible(By.cssSelector("ads-md-button[id=\"assets-menu-button\"] button"));
    }

    public boolean isAddToWorkRequestOptionVisible() {
        return web.isElementVisible(getAddToWorkRequestOptionLocator());
    }


    public boolean isSendToDeliveryOptionVisible()
    {
        return web.isElementVisible(getSendToDeliveryButtonLocator());

    }

    public boolean isUsageRightsOptionVisible()
    {
        return web.isElementVisible(getAddUsageRightsButtonLocator());

    }
    public boolean isRemoveOptionVisible() {
        return web.isElementVisible(getRemoveButtonLocator());
    }


    public boolean isRemoveFromCollectionOptionVisible() {
        return web.isElementVisible(getRemoveFromCollectionButtonLocator());
    }


    public boolean isMenuOptionVisible()
    {
        return web.isElementVisible(By.cssSelector("md-menu:not(.md-open) [click=\"::$mdOpenMenu($event)\"]"));
    }


    public LibShareFilesPopup clickShareFilesButton(){
        web.click(getShareButtonLocator());
        Common.sleep(1000);
        return new LibShareFilesPopup(this);
    }

    public LibDownLoadPopup clickDownloadOnLibrary() {
        if(!web.isElementPresent(By.cssSelector("ads-ui-download")))
          web.click(getDownloadButtonLocator());
        return new LibDownLoadPopup(this);
    }

    public LibChangeMediaPopup clickChangeMediaButton(){
        web.click(getChangeMediaLocator());
        Common.sleep(2000);
        return new LibChangeMediaPopup(this);
    }


    public LibImpersonatePopup clickImpersonateButton(){
        web.click(By.cssSelector("ads-image-circle"));
        Common.sleep(1000);
        web.click(By.cssSelector("ads-md-button[ng-click=\"$ctrl.onImpersonateClick($event)\"]"));
        return new LibImpersonatePopup(this);
    }

    public LibRemovePopup clickRemoveButton(){
        web.click(getRemoveButtonLocator());
        Common.sleep(1000);
        return new LibRemovePopup(this);
    }

    public LibAddUsageRightsPopup clickUsageRightsButton(){
        web.click(getAddUsageRightsButtonLocator());
        Common.sleep(1000);
        return new LibAddUsageRightsPopup(this);
    }



    public void clickSendToDelivery()
    {
        web.click(getSendToDeliveryButtonLocator());
    }

    public boolean verifyWarningMessage(String message)
    {
        return web.isElementPresent(By.xpath(String.format("//*[contains(.,'%s')]", message)));
    }

    public boolean verifyCollectionView(String viewType)
    {
        boolean flag=false;
        if(viewType.equalsIgnoreCase("tree view"))
        {
           flag= web.isElementPresent(By.xpath("//collection-nav-buttons//ads-md-button[@id='collections-tree-button']//span[contains(@class,'icon-active')]"));
        }
      return flag;
    }

    public boolean isElementVisibleOnDropdown(String element)
    {

        return web.isElementVisible(By.xpath("//button[@type='button']//span[contains(text(),'" + element + "')]"));
    }

    public LibRemoveFromCollectionPopup clickRemoveFromCollectionButton(){
        web.click(getRemoveFromCollectionButtonLocator());
        Common.sleep(1000);
        return new LibRemoveFromCollectionPopup(this);
    }

    public LibWorkRequestPopup clickNewWorkRequestButton(){
        web.click(getWorkflowRequestLocator());
        Common.sleep(1000);
        return new LibWorkRequestPopup(this);
    }


    public AddToProjectPopUp clickAddToProject(){

        //commented below code for now
      //web.waitUntilElementAppear(getCopyToOptionLocator());
       //WebElement element = web.findElement(getCopyToOptionLocator());
       // web.getActions().moveToElement(element).build().perform();
        //web.waitUntilElementAppear(getCopyToProjectLocator());
       // web.click(getCopyToProjectLocator());
        web.clickThroughJavascript(getCopyToProjectLocator());
        return new AddToProjectPopUp(this);
    }

    public boolean isAddToProjectVisible() {
        WebElement element = web.findElement(getCopyToOptionLocator());
        web.getActions().moveToElement(element).build().perform();
        return web.isElementVisible(getCopyToProjectLocator());
    }


    public AddToPresentationPopUp clickAddToPresentation(){
        //commented below code for now
      //  WebElement element = web.findElement(getCopyToOptionLocator());
       // web.getActions().moveToElement(element).build().perform();
      //  web.click(getCopyToPrsentationLocator());
        web.clickThroughJavascript(getCopyToPrsentationLocator());
        return new AddToPresentationPopUp(this);
    }

    public boolean isAddToPresentationVisible() {
        WebElement element = web.findElement(getCopyToOptionLocator());
        web.getActions().moveToElement(element).build().perform();
        return web.isElementVisible(getCopyToPrsentationLocator());
    }

    public LibAddToCollectionPopup clickCopyCollectionButton(){
        web.clickThroughJavascript(getAddtoCollectionLocator());
        Common.sleep(2000);
        return new LibAddToCollectionPopup(this);
    }

    protected By getDownloadButtonLocator(){
        return By.cssSelector("ads-md-button[click=\"::$ctrl.openDownload()\"] button");
    }

    protected By getEditAssetMetadatLocator(){
        return By.cssSelector("ads-md-button[click=\"::$ctrl.openEditAssets($event)\"] button");
    }

    public By getAddToWorkRequestOptionLocator()
    {
        return By.cssSelector("#assets-add-to-work-request-button");
    }

    public By getCopyToOptionLocator()
    {
        return By.cssSelector("#assets-copy-to-button");
    }


    public By getCopyToProjectLocator()
    {
       // return By.cssSelector("#assets-copy-to-project-button");
        return By.cssSelector("ads-md-button[click=\"$ctrl.openCopyToProject($event)\"] button");
    }

    public By getCopyToPrsentationLocator()

    {
       // return By.cssSelector("#assets-copy-to-presentation-button");
        return By.cssSelector("ads-md-button[click=\"$ctrl.openCopyToPresentation($event)\"] button");
    }

    public boolean isUploadButtonVisible() {
        return web.isElementVisible(By.cssSelector("ads-md-button[click=\"::$ctrl.openUploadWindow()\"] button"));
    }

    protected By getRemoveButtonLocator(){
        return By.cssSelector("[click=\"$ctrl.openAssetsRemove($event)\"] button");
    }

    protected By getSendToDeliveryButtonLocator(){
        return By.cssSelector("[click=\"$ctrl.sendToDelivery($event)\"] button");
    }

    protected By getRemoveFromCollectionButtonLocator(){
        return By.cssSelector("ads-md-button[click=\"$ctrl.removePinnedAssets($event)\"] button");
    }

    protected By getAddUsageRightsButtonLocator(){
        return By.cssSelector("#assets-add-usage-rights-button");
    }

    protected By getChangeMediaLocator(){
        return By.cssSelector("[click=\"::$ctrl.openChangeMediaType($event)\"] button");
    }

    protected By getAddtoCollectionLocator(){
       return By.cssSelector("ads-md-button[click=\"$ctrl.openCopyToCollection($event)\"] button");
    }

    protected By getWorkflowRequestLocator(){
        return By.cssSelector("[click=\"::$ctrl.openAddToWorkRequest($event)\"] button");
    }

    protected By getAddUsageRightsButtonLocatorOnAssetInfoPage(){
        return By.cssSelector("#asset-tab-usage-rights");
    }

    protected By getAttachmentsIconLocator(){
        return By.cssSelector("[data-role=\"asset-tab-attachments\"]");
    }

    protected By getDeliveriesIconLocator(){
        return By.cssSelector("[data-role=\"asset-deliveries-tab\"]");
    }


    protected By getProjectsIconLocator(){
        return By.cssSelector("[data-role=\"asset-related-projects-tab\"]");
    }

    protected By getActivitiesIconLocator(){
        return By.cssSelector("[data-role=\"asset-activities-tab\"]");
    }

    protected By getInfoIconLocator(){
        return By.cssSelector("[data-role=\"asset-tab-info\"]");
    }

    protected By getShareButtonLocator(){
        return By.cssSelector("[click=\"::$ctrl.openShare($event)\"] button");
    }

    public String getLibraryAsset_Field(){
        return web.findElement(libraryAssetTabLocator).getText();
    }

    public String getSelectAll_Value(){
        return web.findElement(selectAllLocator).getText();
    }

    public String getUnselectAll_Value(){
        return web.findElement(unselectAllLocator).getText();
    }

    public String getShowOnPage_Value(){ return web.findElement(showOnPageLocator).findElement(By.cssSelector(".padding-right-10")).getText() + web.findElement(showOnPageLocator).findElement(By.cssSelector(".padding-left-10")).getText();}

    public String getUploadButton_Value(){ return web.findElement(uploadButtonLocator).getText();}

    public String getNewCollectionButton_Value(){ return web.findElement(By.cssSelector("ads-md-button[data-role=\"create-collection-dropdown\"] button")).findElement(By.cssSelector("[class=\"ng-binding ng-scope\"]")).getText();}

    public String getDownloadButton_Value(){ return web.findElement(downloadButtonLocator).findElement(By.cssSelector("[class=\"valign-middle ng-scope\"]")).getText();}

    public String getSelectUsingItems_Value(){ return web.findElement(UsingItemLocator).getText();}
    public String getSelectUsingFilters_Value(){ return web.findElement(UsingFiltersLocator).getText();}
    public void clickClosePopup(){
        web.click(By.cssSelector(".md-menu-backdrop.md-click-catcher"));
        Common.sleep(1000);
    }

    public List<String> getMenuOptionsInLibrary() {
        Common.sleep(2000);
        return web.findElementsToStrings(By.cssSelector("ads-md-menu-item md-menu-item ads-md-button button span[class=\"caption ng-scope\"]"));
    }

    public LibMultiEditAssetMetadataPage clickEditAssetMetadata() {
        web.click(getEditAssetMetadatLocator());
        Common.sleep(1000);
        return new LibMultiEditAssetMetadataPage(web);
    }


    public static class LibraryFileMetadata {
        public String getBusinessUnit() {
            return businessUnit;
        }

        private String businessUnit;

        public String getName() {
            return name;
        }

        private String name;

        public String getType() {
            return type;
        }

        private String type;

        public String getFileSize() {
            return fileSize;
        }

        private String fileSize;

        public LibraryFileMetadata(ExtendedWebDriver web, String fileName) {
            String baseLocator = String.format("//*[contains(@class,'assetCard__details')][.//a[@title=\"%s\"]]", fileName);
            businessUnit = web.findElement(By.xpath(String.format("%s/span[contains(@class,'assetCard__agency')]", baseLocator))).getText();
            name = web.findElement(By.xpath(String.format("%s//*[contains(@class,'assetCard__title')]", baseLocator))).getText();
            type = web.findElement(By.xpath(String.format("%s//*[contains(@ng-if,'::$ctrl.metadata.fileType')]", baseLocator))).getText();
            fileSize = web.findElement(By.xpath(String.format("%s//*[contains(@ng-if,'::$ctrl.fileSize')]", baseLocator))).getText();
        }

    }


    public void clickLibraryAssetTab(){
        web.click(libraryAssetTabLocator);
    }

    public void clickCollectionTab(){
        web.waitUntilElementAppear(collectionTabLocator);
        web.click(collectionTabLocator);
    }

    public void waitForMessage(String message){
        web.waitUntilElementAppear(By.xpath(String.format("*//*[contains(text(),\"%s\")]",message)));
    }

}
