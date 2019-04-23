package com.adstream.automate.babylon.sut.pages.file.preview;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

/**
 * User: lynda-k
 * Date: 25.12.13
 * Time: 12:00
 */
public class FilePreviewInfoPage extends FilePreviewPage {

    public FilePreviewInfoPage(ExtendedWebDriver web) {
        super(web);
    }

    public boolean isEditButtonVisible() {
        return web.isElementPresent(getEditButtonLocator()) && web.isElementPresent(getEditButtonLocator());
    }

    private By getEditButtonLocator() {
        return By.className("editButton");
    }
}
