package com.adstream.automate.babylon.sut.pages.library.elements;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created by sobolev-a on 17.07.2014.
 */
public class AdbankLibraryRelatedAssetsPage extends AdbankLibraryAssetsInfoPage {

    private LibraryRelatedAssetsPopUp projectRelatedFilesPopUp;

    public AdbankLibraryRelatedAssetsPage(ExtendedWebDriver web) {
        super(web);
        projectRelatedFilesPopUp = new LibraryRelatedAssetsPopUp(this);
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppear(By.id("relatedFiles"));
        Common.sleep(1000);
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementPresent(By.id("relatedFiles")));
    }

    public LibraryRelatedAssetsPopUp clickLinkToExistingButton() {
        web.click(getLinkToExistButtonLocator());
        return new LibraryRelatedAssetsPopUp(this);
    }

    public void typeRelatedFileName(String fileName) {
        projectRelatedFilesPopUp.typeRelatedFileName(fileName);
        Common.sleep(1000);
    }

    public void selectRelatedAssets(String file) {
        projectRelatedFilesPopUp.selectFollowingRelatedAssets(file);
    }

    public int getCountOfRelatedAssets() {
        return web.findElements(By.cssSelector(".ptm .rows-content .pointer")).size();
    }

    public void clickSaveButton() {
        projectRelatedFilesPopUp.clickSaveButton();
    }

    public boolean isLinkToExistButtonExist() {
        return web.isElementPresent(getLinkToExistButtonLocator()) && web.isElementVisible(getLinkToExistButtonLocator());
    }

    public void deleteRelatedFile(String file) {
        web.click(getRelatedFileDeleteButtonLocator(file));
        new ConfirmRemovePopUp(this).clickAction();
    }

    public boolean isRelatedFileDeleteButtonExist(String file) {
        return web.isElementPresent(getRelatedFileDeleteButtonLocator(file)) && web.isElementVisible(getRelatedFileDeleteButtonLocator(file));
    }

    private By getLinkToExistButtonLocator() {
        return By.cssSelector("[data-dojo-type='common.buttonlinkToExisting'] button");
    }

    public boolean isRelatedFileNotExist(String fileName) {
        return web.isElementPresent(getRelatedFileLocator(fileName)) && web.isElementVisible(getRelatedFileLocator(fileName));
    }

    private By getRelatedFileDeleteButtonLocator(String fileName) {
        return By.xpath(String.format("//div[contains(class, rows-content)]//span[normalize-space(text())='%s']/ancestor::div[3]//span[@class='icon-remove row-remove ng-scope']", fileName));
    }

    private By getRelatedFileLocator(String fileName) {
        return By.xpath(String.format("//div[contains(class, rows-content)]//span[normalize-space(text())='%s']/ancestor::div[3]", fileName));
    }
    
}
