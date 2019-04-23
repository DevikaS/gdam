package com.adstream.automate.babylon.sut.pages.asset.preview;

import com.adstream.automate.babylon.sut.pages.file.preview.FilePreviewInfoPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * User: lynda-k
 * Date: 25.12.13
 * Time: 12:00
 */
public class AssetPreviewInfoPage extends FilePreviewInfoPage {

    public AssetPreviewInfoPage(ExtendedWebDriver web) {
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
}
