package com.adstream.automate.babylon.sut.pages.library.presentations;

import com.adstream.automate.babylon.sut.data.MetadataItem;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.FlowPlayerPage;
import com.adstream.automate.babylon.sut.pages.library.elements.DownloadPresentationPopUpWindow;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 05.11.12
 * Time: 10:30

 */
public class AdbankPresentationPreviewPage extends BasePresentationPreviewPage<AdbankPresentationPreviewPage> {

    public AdbankPresentationPreviewPage(ExtendedWebDriver web) {
        super(web);
    }

    public List<String> getAllAssetsPreviewIds() {
        List<String> resultList = new ArrayList<>();
        for (WebElement preview : web.findElements(By.cssSelector(".preview"))) {
            String regexp = "([\\w]{24})\"\\);";
            Matcher mather = Pattern.compile(regexp, Pattern.CASE_INSENSITIVE).matcher(preview.getAttribute("Style"));
            resultList.add(mather.find() ? mather.group(1) : "");
        }
        return resultList;
    }

    public List<String> getAvailableToPreviewPresentationList() {
        clickLeftBottomCornerDropDownMenu();
        web.sleep(200);
        return web.findElementsToStrings(By.cssSelector(".drop-down .list-item"));
    }

    public void clickLeftBottomCornerDropDownMenu() {
        web.click(By.cssSelector(".reels-list"));
    }

    public void clickOnAssetById(String id) {
        web.click(By.cssSelector(String.format(".preview[style*='%s']", id)));
    }

    public boolean isAssetVisible(String fileId) {
        By elementLocator = By.cssSelector(String.format(".preview[style*='%s']", fileId));
        return web.isElementPresent(elementLocator);
    }

    public int countAssets() {
        return web.findElements(By.cssSelector(".line .item")).size();
    }

    public boolean isPreviewAssetVisible() {

        return web.isElementVisible(By.className("main-info"));
    }

    public void nextItem() {
        web.click(By.cssSelector(".next-item .blackpoint"));
    }

    public List<MetadataItem> getMetadataFieldsMapByPreviewId(String fileId) {
        clickOnAssetById(fileId);

        List<MetadataItem> fieldsMap = new ArrayList<>();

        web.findElements(By.cssSelector("[data-dojo-type*='infoBlockContent']>:not([class]) .bold"));

        for (WebElement element : web.findElements(By.cssSelector("[data-dojo-type*='infoBlockContent']>:not([class])"))) {
            String key = element.findElement(By.className("bold")).getText().trim();
            String value = element.getText().replaceAll("\\s*" + key + "\\s*:\\s*(.*)\\s*", "$1");
            fieldsMap.add(new MetadataItem(key, value));
        }

        return fieldsMap;
    }

    public boolean isGridIconsVisible() {
        return web.isElementVisible(By.cssSelector(".icons"));
    }

    public boolean isNextItemArrowVisible() {
        return web.isElementVisible(By.cssSelector(".next-item .blackpoint"));
    }

    public boolean isAssetsLineVisible() {
        return web.isElementVisible(By.cssSelector(".line"));
    }

    public boolean isDownloadButtonVisible() {
        return web.isElementVisible(getDownloadButtonLocator());
    }

    public boolean isDownloadPresentationPopupVisible() {
        return web.isElementVisible(getDownloadPresentationPopupLocator());
    }

    public DownloadPresentationPopUpWindow openDownloadPresentationPopUp() {
        web.sleep(1000);
        if (!isDownloadPresentationPopupVisible()) {
            web.click(getDownloadButtonLocator());
        }
        return new DownloadPresentationPopUpWindow(this);
    }

    public List<String> getInfoAboutAssets() {
        return web.findElementsToStrings(By.cssSelector(".info-block.asset-info"));
    }

    public boolean isLightTheme() {
        return web.findElement(By.cssSelector("body")).getAttribute("class").contains("light");
    }

    public boolean isDarkTheme() {
        return web.findElement(By.cssSelector("body")).getAttribute("class").contains("dark");
    }

    public boolean isBackgroundDefault() {
        return web.findElement(By.id("app-main")).getAttribute("style").contains("url(\"/binaries/\")");
    }

    public boolean isBackgroundScaleToFit() {
        return web.findElement(By.id("app-main")).getAttribute("class").endsWith("-scale");
    }

    public boolean isBackgroundTile() {
        return web.findElement(By.id("app-main")).getAttribute("class").endsWith("-tile");
    }

    public boolean isNoneDefaultBackground() {
        return !isBackgroundDefault();
    }

    public boolean isLogoDefault() {
        return web.findElement(By.cssSelector("[data-dojo-type='presentation.preview.controller'] .inline-display"))
                .getAttribute("style").contains("url(\"/binaries/\")");
    }

    public boolean isPlayerAvailable() {
        return new FlowPlayerPage(web).isPlayerReady();
    }
    //NGN-16214-QAA: Presentations / Reels autoplay code changes starts
    public boolean isAutoPlayable() {
        web.navigate().refresh();
        web.sleep(1000);
        return new FlowPlayerPage(web).isPlaying();
    }
    //NGN-16214-QAA: Presentations / Reels autoplay code changes Ends
    public boolean isNoneDefaultLogo() {
        return !isLogoDefault();
    }

    public String getPresentationId() {
        String url = getDriver().getCurrentUrl();
        return url.substring(url.lastIndexOf("/") + 1);
    }

    private By getDownloadButtonLocator() {
        return By.cssSelector(".download");
    }

    private By getDownloadPresentationPopupLocator() {
        return By.xpath("//*[contains(@class,'popupWindow')][*[contains(@class,'windowHead')]//*[contains(text(),'Download')]]");
    }
}