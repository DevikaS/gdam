package com.adstream.automate.babylon.sut.pages.asset.preview;

import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.LibraryAssetsInfoPage;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.NewAdbankLibraryAssetsDestinationPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.flowplayer.FlowPlayerProxy;
import org.openqa.selenium.By;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created by Janaki.Kamat on 27/09/2017.
 */
public class NewAssetPreviewPage extends LibraryAssetsInfoPage {
    private FlowPlayerProxy player;
    private static final String assetNavigationFormat="*//*[contains(@class,\"navigator-item\")][.//div[contains(text(),\"%s\")]]//*[contains(@code,\"chevron-outline\")]";
    private static final By assetTitleSelector=By.cssSelector(".asset-page .icon-size-2.text-limiter.ng-binding");
    public NewAssetPreviewPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        web.waitUntilElementAppearVisible(By.cssSelector(".asset-page"));
    }

    @Override
    public void isLoaded() throws Error {
        assertTrue(web.isElementVisible(By.cssSelector(".asset-page")));
    }

    public NewAdbankLibraryAssetsDestinationPage openDestinationsTab() {
        web.click(generateTabLocator("destinations"));
        return new NewAdbankLibraryAssetsDestinationPage(web);
    }

    protected By generateTabLocator(String tabName) {
        By tablocator=null;
        switch(tabName){
            case "destinations":
                tablocator=By.cssSelector(String.format("ads-md-button[ui-sref=\"%s\"] a","asset-deliveries"));
                break;
            case "attachments":
                tablocator=By.cssSelector(String.format("ads-md-button[ui-sref=\"asset.attachments\"] a", "asset-attachments"));
                break;
            case "activities":
                tablocator=By.cssSelector(String.format("ads-md-button[ui-sref=\"asset.attachments\"] a", "asset-activities"));
                break;
        }
        return tablocator;
    }

    public boolean isVideoPaused(){
        return web.isElementVisible(By.xpath("*//ads-video-player//div[contains(@class,\"jwplayer\")][contains(@class,\"js-state-paused\")]"));
    }

    public void naviagateToAsset(String title){
     //  web.getActions().moveToElement(web.findElement(By.cssSelector(".file-navigator-placeholder"))).build().perform();
        web.getJavascriptExecutor().executeScript("arguments[0].scrollIntoView(true);", web.findElement(By.xpath(String.format(assetNavigationFormat,title))));
     //   if(web.isElementPresent(By.xpath(String.format(assetNavigationFormat,title))))
     //     web.scrollToElement(web.findElement(By.xpath(String.format(assetNavigationFormat,title))));
        web.findElement(By.xpath(String.format(assetNavigationFormat,title))).click();
    }

    public String getTitle(){
        return web.findElement(assetTitleSelector).getText();
    }
}
