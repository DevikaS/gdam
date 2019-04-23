package com.adstream.automate.babylon.sut.pages.asset.preview;

import com.adstream.automate.babylon.sut.pages.file.preview.FilePreviewPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryAssetsDestinationPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.flowplayer.FlowPlayerProxy;
import org.openqa.selenium.By;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * User: lynda-k
 * Date: 25.12.13
 * Time: 12:00
 */
public class AssetPreviewPage extends FilePreviewPage {
    private FlowPlayerProxy player;

    public AssetPreviewPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        web.waitUntilElementAppearVisible(By.cssSelector("body.asset .file-view,body.asset .pdf-preview"));
    }

    @Override
    public void isLoaded() throws Error {
        assertTrue(web.isElementVisible(By.cssSelector("body.asset .file-view,body.asset .pdf-preview")));
    }

    public AdbankLibraryAssetsDestinationPage openDestinationsTab() {
        web.click(generateTabLocator("destinations"));
        return new AdbankLibraryAssetsDestinationPage(web);
    }
    public FlowPlayerProxy getFlowPlayer() {
        if (player == null) {
            player = new FlowPlayerProxy(web);
        }
        return player;
    }
}