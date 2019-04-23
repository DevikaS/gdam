package com.adstream.automate.babylon.sut.pages.library.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.library.presentations.AdbankLibraryPresentationsPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.apache.commons.lang3.StringEscapeUtils;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 11.10.12
 * Time: 18:27
 */
public class AdbankLibraryPresentationsAssetsPage extends AdbankLibraryPresentationsPage {

    public AdbankLibraryPresentationsAssetsPage(ExtendedWebDriver web) {
        super(web);
    }

    public void load() {
        web.waitUntilElementAppearVisible(By.cssSelector(".tree-block"));
        web.waitUntilElementAppear(By.cssSelector("#reel-card-content"));
    }

    public void isLoaded() throws Error {
        web.sleep(3000);
        assertTrue(web.isElementVisible(By.cssSelector(".tree-block")));
        web.sleep(3000);
        assertTrue(web.isElementPresent(By.cssSelector("#reel-card-content")));
    }

    public boolean isFilesPresent(String fileName) {
        return getFilesCountByFileName(fileName) > 0;
    }

    public int getFilesCountByFileName(String fileName) {
        String locator = String.format("//*[@class='file-info']//a[normalize-space(text())=normalize-space('%s')]", fileName);
        return web.isElementPresent(By.xpath(locator)) ? web.findElements(By.xpath(locator)).size() : 0;
    }

    public Map<String, String> getAssetMetadataFields(String fileName) {
        Map<String, String> metadataFields = new HashMap<>();
        List<String> meta = web.findElementsToStrings(By.xpath(String.format(
                "//*[contains(@class, 'parameters')][div/*[normalize-space(@title)='%s']]//*[contains(@class, 'file-detail')]/*", fileName)));

        metadataFields.put("Type", meta.get(0));
        metadataFields.put("AspectRatio", meta.get(1));

        return metadataFields;
    }

    public boolean isPreviewForAssetAvailable(String name) {
        By locator = By.xpath("//a[normalize-space(@title)='" + name + "']/ancestor::div[contains(@class,'file-info')]/preceding-sibling::div//img[@data-dojo-type='common.imageResizer']");
        return web.isElementPresent(locator);
    }

    public int getPreviewCountOnThePage() {
        return web.findElements(By.cssSelector("img[src*='/media/thumbnail']")).size();
    }

    public String getClassOfAssetByFileName(String fileName) {
        fileName = prepareAssetFileName(fileName);
        String xpath = String.format("//a[starts-with(normalize-space(text()), normalize-space('%s'))]//ancestor::*[contains(@class,'asset_list_item')]", fileName);
        WebElement webElement = web.findElement(By.xpath(xpath));
        return webElement.getAttribute("class") == null ? "" : webElement.getAttribute("class");
    }

    public String getAssetOrderNumber(String fileName) {
        fileName = prepareAssetFileName(fileName);
        String xpath = String.format("//a[starts-with(@title, '%s')]//ancestor::*[contains(@class,'asset_list_item')]//*[@class='asset_order']", fileName);
        WebElement webElement = web.findElement(By.xpath(xpath));
        return webElement.getText().trim();
    }

    public void clickAssetByFileName(String fileName) {
        fileName = prepareAssetFileName(fileName);
        web.click(By.xpath(String.format("//div[@class='file-info' and descendant::a[starts-with(normalize-space(text()), normalize-space('%s'))]]", fileName)));
        web.sleep(500);
    }

    public PopUpWindow clickDeleteButton() {
        web.click(By.cssSelector(".button[data-role='delete']"));
        return new PopUpWindow(this);
    }

    public Map<String, String> getAssetInfo(String assetName) {
        Map<String, String> assetInfo = new HashMap<String, String>();
        By locator = By.xpath(String.format("//*[contains(@class,'file-info')][.//a[normalize-space(@title)='%s']]//*[contains(@class,'lib-tooltip')]//p", assetName));

        for (WebElement dataRowElement : web.findElements(locator)) {
            Matcher mather = Pattern.compile("(Uploaded at|Uploaded by|.+?):?\\s+<.+>(.+)<.+>").matcher(dataRowElement.getAttribute("innerHTML"));

            if (mather.find()){
                String parameter = mather.group(1).replace("<span>", "").replace("</span>", "");
                assetInfo.put(parameter, mather.group(2));}
        }

        return assetInfo;
    }

    public void clickOpenFileLink(String fileName) {
        String locator = String.format("//div[@class='file-info' and //a[normalize-space()='%s']]/preceding-sibling::div//div[contains(@class, 'lib-tooltip')]", fileName);
        web.clickThroughJavascript(By.xpath(locator));
        Common.sleep(1000);
    }

    public String getPresentationAssetsCounter() {
        return web.findElement(By.cssSelector(".select-counter")).getText().trim();
    }

    public int getSelectedPresentationAssetsCount() {
        return web.findElements(By.cssSelector(".asset_list_item.selected")).size();
    }

    public int getPresentationAssetsCount() {
        return web.findElements(By.cssSelector(".asset_list_item")).size();
    }

    public void moveAssetToAnotherAssetPlace(String assetsName, String destinationAssetName) {
        for (String assetName : assetsName.split(",")) {
            if (!getClassOfAssetByFileName(assetName).contains("selected")) {
                clickAssetByFileName(assetName);
            }
        }

        String assetLocatorFormat = "//a[arts-with(normalize-space(@title), '%s')]//ancestor::*[contains(@class,'asset_list_item')]//*[contains(@class,'mbxs')]";
        WebElement asset = web.findElement(By.xpath(String.format(assetLocatorFormat, assetsName.split(",")[0])));
        WebElement destinationAsset = web.findElement(By.xpath(String.format(assetLocatorFormat, destinationAssetName)));

        web.getActions().dragAndDrop(asset, destinationAsset).perform();
        web.sleep(1000);
    }

    public void clickSelectAllCheckbox() {
        web.click(By.id("asset-total-selector"));
    }

    private String prepareAssetFileName(String fileName) {
        fileName = StringEscapeUtils.escapeXml10(fileName);
        int dotPosition = fileName.lastIndexOf(".");
        return dotPosition != -1 ? fileName.substring(0, dotPosition) : fileName;
    }

}
