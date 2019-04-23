package com.adstream.automate.babylon.sut.pages.library.presentations;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.flowplayer.FlowPlayerProxy;
import com.google.common.base.Function;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 29.10.12
 * Time: 18:20
 */
public class AdbankPresentationViewPage extends AdbankPresentationPreviewPage {
    private FlowPlayerProxy player;

    public AdbankPresentationViewPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(By.id("player"));
        web.waitUntil(new Function<WebDriver, Object>() {
            @Override
            public Object apply(WebDriver webDriver) {
                return isPlayerReady();
            }
        });
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementPresent(By.id("player")));
        assertTrue(isPlayerReady());
    }

    public String getPresentationName() {
        return web.findElement(By.cssSelector(".reel-head > span")).getText();
    }

    public int getCountOfAssets() {
        return web.findElements(By.cssSelector(".line .item .preview")).size();
    }

    public void clickOnAssetByNum(int num) {
        web.findElements(By.cssSelector(".line .item .preview")).get(num).click();
    }

    public int getCountOfStandardAudioThumbnails() {
        return web.findElements(By.cssSelector(".preview[style*='/images/thumbnails/audio.png']")).size();
    }

    public FlowPlayerProxy getFlowPlayer() {
        if (player == null) {
            player = new FlowPlayerProxy(web);
        }
        return player;
    }

    public boolean isPlayerReady() {
        return getFlowPlayer().isReady();
    }
}
