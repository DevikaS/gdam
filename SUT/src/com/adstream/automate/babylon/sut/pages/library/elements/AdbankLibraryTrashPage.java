package com.adstream.automate.babylon.sut.pages.library.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AdbankFilesPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Checkbox;
import org.openqa.selenium.By;

import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

public class AdbankLibraryTrashPage extends AdbankFilesPage {

    public AdbankLibraryTrashPage(ExtendedWebDriver web) {
        super(web);
    }

    public void load() {
        web.waitUntilElementAppearVisible(By.cssSelector(".tree-block"));
        web.waitUntilElementAppearVisible(By.cssSelector("#libraryAssetsContainer"));
    }

    public void isLoaded() throws Error {
        web.sleep(1000);
        assertTrue(web.isElementVisible(By.cssSelector(".tree-block")));
        assertTrue(web.isElementVisible(By.cssSelector("#libraryAssetsContainer")));
    }

    public boolean isAddMetadataExist() {
        if (!web.isElementPresent(By.cssSelector(".advancedSearchChooser .icon-plus.valign-middle.mtxs.mhs"))) return false;
        return web.isElementVisible(By.cssSelector(".advancedSearchChooser .icon-plus.valign-middle.mtxs.mhs"));
    }

    public boolean isAddAnotherValueToMetadataButtonPresent() {
        if (!web.isElementPresent(By.cssSelector(".icon-plus.valign-middle.mtxs.mhs"))) return false;
        return web.isElementVisible(By.cssSelector(".icon-plus.valign-middle.mtxs.mhs"));
    }

    public int getCountOfAddAnotherValueToMetadataButton() {
        if (!web.isElementPresent(By.cssSelector(".icon-plus.valign-middle.mtxs.mhs"))) return 0;
        return web.findElements(By.cssSelector(".icon-plus.valign-middle.mtxs.mhs")).size();
    }

    public void clickAddAnotherValueToMetadata() {
        web.click(By.cssSelector(".icon-plus.valign-middle.mtxs.mhs"));
    }

    public void clickAddAnotherValueToMetadata(int num) {
        web.findElements(By.cssSelector(".icon-plus.valign-middle.mtxs.mhs")).get(num).click();
    }

    public String getLabelsValueAboutCountSelectedFiles() {
        return web.findElement(By.cssSelector(".selecteds-counter.bold")).getText();
    }

    public String getCurrentPageNumber() {
        return web.findElement(By.cssSelector(".simple_pager .current")).getText().split("\\s+")[1];
    }

    public List<String> getPresentedAssetsNames() {
        return web.findElementsToStrings(By.cssSelector("a[data-dojo-type='common.trimmedBox']"), "title");
    }

    public PopUpWindow clickRestoreButton() {
        web.click(By.cssSelector("[data-dojo-type='library.library.restoreDeletedAssetBase']"));
        return new PopUpWindow(this);
    }

    public void clickAddOtherMetadataPlus(String key) {
        web.click(By.xpath(String.format("//*[text()='%s']//ancestor::div[@class='vmiddle']//div[contains(@class,'add-more')]", key)));
    }

    public void clickAddFilterButton(String key) {
        web.click(By.xpath(String.format("//*[text()='%s']//ancestor::div[@class='vmiddle']//div[contains(@class,'add-filter')]", key)));
    }

    public boolean isAddOtherMetadataPlusExist(String key) {
        if (!web.isElementPresent(By.xpath(String.format("//*[text()='%s']//ancestor::div[@class='vmiddle']//div[contains(@class,'add-more')]", key)))) return false;
        return web.isElementVisible(By.xpath(String.format("//*[text()='%s']//ancestor::div[@class='vmiddle']//div[contains(@class,'add-more')]", key)));
    }

    public void clickNextButton() {
        web.click(By.cssSelector(".pager-item.next:not(.inactive)"));
    }

    public void clickPrevButton() {
        web.click(By.cssSelector(".pager-item.prev:not(.inactive)"));
    }

    public void selectSelectAllCheckbox() {
        new Checkbox(this, By.cssSelector(".total_selector")).select();
    }

    public void deselectSelectAllCheckbox() {
        new Checkbox(this, By.cssSelector(".total_selector")).deselect();
    }

    public void navigateToAssetInfoPage(String assetName) {
        web.clickThroughJavascript(By.xpath(String.format("//*[contains(@class,'lib-file-list-item')][.//*[normalize-space(.)='%s']]//a//span", assetName)));
    }

}