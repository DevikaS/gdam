package com.adstream.automate.babylon.sut.pages.NewLibrary.pages;

import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.CollectionType;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibEditAttachmentPopup;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibRemoveAttachmentPopup;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;

import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created by Janaki.Kamat on 22/09/2017.
 */
public class NewAdbankLibraryAssetAttachmentsPage extends LibraryAssetsInfoPage {
    public NewAdbankLibraryAssetAttachmentsPage(ExtendedWebDriver web) {
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

    public By getAttachmentsButtonLocator() {
        return By.cssSelector("ads-md-button.attachments-upload");
    }

    public int getAttachmentCount() {
        return Integer.valueOf(web.findElement(By.cssSelector(".asset-tab-attachments [translate=\"ASSET_ATTACHMENTS_LABEL\"]")).getAttribute("translate-value-count"));
    }

    public List<String> getAttachmentsList() {
        if (!web.isElementVisible(By.cssSelector(".attachments-list")))
            throw new NoSuchElementException("There is no any attachments on Attachments tab!");
        return web.findElementsToStrings(By.cssSelector(".attachment-description div.h6.margin-0-0.ng-binding"));
    }

    public CollectionType.AttachmentsList geListOfAttachments() {
        if (!web.isElementVisible(By.cssSelector(CollectionType.AttachmentsList.ROOT_NODE)))
            throw new NoSuchElementException("There is no any attachments on Attachments tab!");
        return new CollectionType.AttachmentsList(web);
    }


    public By getPageLocator() {
        return By.tagName("asset-tab-attachments");
    }

    public NewAdbankLibraryAssetAttachmentsPage openMenuPopup(String attachment) {
        if (web.isElementPresent(By.xpath(String.format("//div[contains(@class,\"attachment-row\")][..//div[contains(text(), \"%s\")]]//*[@ng-click=\"$mdOpenMenu($event)\"]//button", attachment))))
            web.getJavascriptExecutor().executeScript("arguments[0].click();", web.findElement(By.xpath(String.format("//div[contains(@class,\"attachment-row\")][..//div[contains(text(), \"%s\")]]//*[@ng-click=\"$mdOpenMenu($event)\"]//button", attachment))));
        Common.sleep(2000);
        return this;
    }


    public LibEditAttachmentPopup openEditAttachmentPopup() {
        web.click(By.cssSelector("ads-md-button[click=\"$ctrl.openEditAttachmentModal(attachment)\"] button"));
        Common.sleep(1000);
        return new LibEditAttachmentPopup(this);
    }

    public LibRemoveAttachmentPopup openRemoveAttachmentPopup() {
        web.click(By.cssSelector("ads-md-button[click=\"$ctrl.removeAttachment($event, attachment)\"] button"));
        Common.sleep(1000);
        return new LibRemoveAttachmentPopup(this);
    }

    public String getAssetAttachmentsLabel(){
        return web.findElement(By.cssSelector("span[translate=\"ASSET_ATTACHMENTS_LABEL\"]")).getText();
    }

    public String getUploadAttachmentsLabel(){
        return web.findElement(By.cssSelector("ads-md-button[click=\"$ctrl.openUploader()\"] button span[translate=\"ASSET_ATTACHMENTS_UPLOAD_LABEL\"]")).getText();
    }

}