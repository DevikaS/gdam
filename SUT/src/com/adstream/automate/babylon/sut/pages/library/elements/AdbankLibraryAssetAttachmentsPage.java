package com.adstream.automate.babylon.sut.pages.library.elements;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import java.util.List;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/*
 * Created by sobolev-a on 23.07.2014.
 */
public class AdbankLibraryAssetAttachmentsPage extends AdbankLibraryAssetsInfoPage  {

    public AdbankLibraryAssetAttachmentsPage(ExtendedWebDriver web) {
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

    public By getAttachmentsButtonLocator() { return By.cssSelector("[ng-controller='attachedFilesTabUploadWindowController']"); }

    public int getCountOfAttachmentFiles() { return web.findElements(By.cssSelector(".rows-content .row")).size(); }

    public boolean isDownloadButtonExist(String fileName) {
        return web.isElementPresent(By.xpath(String.format("//*[normalize-space(text())='%s']/..//../*[contains(@class,'unit')][5]/..//span[1]", fileName)));
    }

    public AdbankDeleteAssetsAttachmentPopUp clickByDeletetButton(String fileName) {
        web.click(By.xpath(String.format("//*[normalize-space(text())='%s']/..//../*[contains(@class,'unit')][5]/..//span[3]", fileName)));
        return new AdbankDeleteAssetsAttachmentPopUp(this, AdbankDeleteAssetsAttachmentPopUp.TITLE);
    }

    public AdbankDeleteAssetsAttachmentPopUp clickByDeletetAllAttachment() {
        return new AdbankDeleteAssetsAttachmentPopUp(this, AdbankDeleteAssetsAttachmentPopUp.TITLE);
    }

    public List<String> getAttachedFilesListName() {
        if (web.isElementPresent(getCheckAttachedFileLocator())) {
            return web.findElementsToStrings(getCheckAttachedFileLocator());
        }
        return null;
    }

    public LibraryAttachmentsList getLibraryAttachmentsList() {
        if (!web.isElementVisible(By.cssSelector(LibraryAttachmentsList.ROOT_NODE)))
            throw new NoSuchElementException("There is no any attachments on Attachments tab!");
        return new LibraryAttachmentsList(web);
    }

    private By getCheckAttachedFileLocator() {
        return By.xpath("//*[contains(@class, 'rows-content')]//div[contains(@class, 'unit')][1]/div[normalize-space(text())]");
    }

    private By getPageLocator() {
        return By.id("attachedFilesTabCtrl");
    }
}