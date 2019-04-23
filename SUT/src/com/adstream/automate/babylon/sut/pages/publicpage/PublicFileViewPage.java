package com.adstream.automate.babylon.sut.pages.publicpage;

import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import scala.tools.nsc.settings.Final;

import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * User: lynda-k
 * Date: 16.12.13
 * Time: 12:00
 */
public class PublicFileViewPage extends BasePage {
    private static final String PAGE_LOAD_LOCATOR = ".public .file-view,.public .pdf-preview";
    private static final By DOWNLOAD_BUTTON_LOCATOR = By.cssSelector("[data-dojo-type='common.downloadDialog']");
    public PublicFileViewPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        web.waitUntilElementAppearVisible(By.cssSelector(PAGE_LOAD_LOCATOR));
    }

    @Override
    public void isLoaded() throws Error {
        assertTrue(web.isElementVisible(By.cssSelector(PAGE_LOAD_LOCATOR)));
    }

    public void clickDownloadButton(){
       web.click(DOWNLOAD_BUTTON_LOCATOR);
    }

    public List<String> getTabNames() {
        return web.findElementsToStrings(By.cssSelector(".nav-tabs a:not(.none)"));
    }
}
