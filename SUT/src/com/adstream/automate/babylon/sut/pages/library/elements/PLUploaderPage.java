package com.adstream.automate.babylon.sut.pages.library.elements;

import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

public class PLUploaderPage extends BasePage {
    public PLUploaderPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        web.waitUntilElementAppearVisible(By.cssSelector("#uploader > .plupload_wrapper"));
    }

    @Override
    public void isLoaded() throws Error {
        assertTrue(web.isElementVisible(By.cssSelector("#uploader > .plupload_wrapper")));
    }
}