package com.adstream.automate.babylon.sut.pages.library.inbox;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.*;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Checkbox;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * User: lynda-k
 * Date: 20.12.13 10:00
 */
public class AdbankSharedCollectionsPage extends AdbankFilesPage {
    public AdbankSharedCollectionsPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        web.waitUntilElementAppearVisible(By.cssSelector("[data-dojo-type='library.inbox.actionAssets']"));
        web.waitUntilElementAppearVisible(By.cssSelector("[data-role='partnersList']"));
    }

    @Override
    public void isLoaded() throws Error {
        assertTrue(web.isElementVisible(By.cssSelector("[data-dojo-type='library.inbox.actionAssets']")));
        assertTrue(web.isElementVisible(By.cssSelector("[data-role='partnersList']")));
    }

    public List<String> getAgencyNames() {
        return web.findElementsToStrings(By.cssSelector(".title.agency-icon a"));
    }

    public List<String> getCollectionNames() {
        return web.findElementsToStrings(By.cssSelector(".title.category-icon a"));
    }

    public List<String> getAssetNames() {
        return web.findElementsToStrings(By.cssSelector(".file-info a[title]"));
    }

    public List<String> getMenuChildItems(String parentName) {
        String xpath = String.format("//li[*[contains(@class,'title')]//a[normalize-space()='%s']]", parentName);
        web.click(By.xpath(String.format("%s/*[contains(@data-role,'expanding-arrow')]", xpath)));
        return web.findElementsToStrings(By.xpath(String.format("%s//*[contains(@class,'category')]//a", xpath)));
    }

    public void expandAgencyItemByName(String agencyName) {
        web.click(By.xpath(String.format("//li[.//a[normalize-space()='%s']]/*[@data-role='expanding-arrow']", agencyName)));
    }

    public void selectSelectAllCheckbox() {
        new Checkbox(this, By.id("total_selector")).select();
    }

    public void clickAssetTitleLink(String assetName) {
        web.click(By.cssSelector(String.format(".file-info a[title='%s']", assetName)));
    }

    public PopUpWindow clickAcceptButton() {
        web.click(By.xpath("//*[@data-dojo-type='library.inbox.actionAssets' and normalize-space()='Accept']"));
        return new PopUpWindow(this);
    }

    public PopUpWindow clickRejectButton() {
        web.click(By.xpath("//*[@data-dojo-type='library.inbox.actionAssets' and normalize-space()='Reject']"));
        return new PopUpWindow(this);
    }

    private By getCategoryNameLocator(String category) {
        return By.xpath(String.format(String.format("//*[normalize-space(text())='%s']", category)));
    }

    public boolean isCategoryExist(String category) {
        By cat = getCategoryNameLocator(category);
        By collapseCategoryIcon = By.xpath(String.format("//*[normalize-space(text())='%s']/../../../*[@class='arrow']", category));
        if (web.isElementPresent(cat) && web.isElementVisible(cat)) {
            if (web.isElementPresent(collapseCategoryIcon) && web.isElementVisible(collapseCategoryIcon))
                web.click(collapseCategoryIcon);
            return true;
        } else {
            return false;
        }
    }

    public void sortListViewByColumn(String columnName, String order) {
        String locator = String.format("//div[@data-dojo-type='common.table.headerColumn2' and div[text()='%s']]", columnName);
        By filesContainerLocator = By.cssSelector(".itemsList");
        WebElement element = web.findElement(By.xpath(locator));
        if (!element.getAttribute("class").contains(order)) {
            WebElement filesContainer = web.findElement(filesContainerLocator);
            element.click();
            web.waitUntilElementChanged(filesContainer);
            element = web.findElement(By.xpath(locator));
            if (!element.getAttribute("class").contains(order)) {
                filesContainer = web.findElement(filesContainerLocator);
                element.click();
                web.waitUntilElementChanged(filesContainer);
            }
        }
    }

    public String getAssetsTitleById(String id) {
        return web.findElement(By.cssSelector(String.format("[data-role='fileCard'] .ptxs a[href*='%s']", id))).getAttribute("title").trim();
    }

    public String getAssetTitleTextByAssetId(String id) {
        return web.findElement(By.cssSelector(String.format("[data-role='fileCard'] .ptxs a[href*='%s']", id))).getText();
    }

    public int getAssetsCount() {
        By locator = By.className("lib-file-list-item");
        if (web.isElementPresent(locator)) {
            return web.findElements(locator).size();
        } else {
            return 0;
        }
    }
}