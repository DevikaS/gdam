package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.sut.pages.adbank.BaseAdBankPage;
import com.adstream.automate.babylon.sut.pages.flowplayer.FlowAutoPlayer;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.Control;
import com.adstream.automate.page.flowplayer.FlowPlayerProxy;
import com.adstream.automate.utils.Common;
import com.google.common.base.Function;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * User: ruslan.semerenko
 * Date: 18.09.12 17:22
 */
public class FlowPlayerPage extends BaseAdBankPage<FlowPlayerPage> {
    private FlowPlayerProxy player;
    private FlowAutoPlayer autoPlayer;
    public FlowPlayerPage(ExtendedWebDriver web) {
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

    @Override
    public void init() {
        // flow player exist for both projects and library, preview presentation and asset
        container = new Control(this, By.cssSelector(".adbank,.library,.presentation,[data-dojo-type=\"common.fileView\"]"));
    }

    public FlowPlayerProxy getPlayer() {
        if (player == null) {
            player = new FlowPlayerProxy(web);
        }
        return player;
    }

    public boolean isPlayerReady() {
        return getPlayer().isReady();
    }

    //NGN-16214-QAA: Presentations / Reels autoplay code changes starts
    public FlowAutoPlayer getAutoPlayer() {
        if (autoPlayer == null) {
            autoPlayer = new FlowAutoPlayer(web);
        }
        return autoPlayer;
    }
    public boolean isPlaying() {
         {
             return getAutoPlayer().isPlaying();
        }
    }
    //NGN-16214-QAA: Presentations / Reels autoplay code changes Ends
}