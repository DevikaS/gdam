package com.adstream.automate.babylon.sut.pages.publicpage;

import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.Control;
import org.openqa.selenium.By;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * User: lynda-k
 * Date: 16.12.13
 * Time: 12:00
 */
public class BasePublicPage extends BasePage {
    protected Control container;

    public BasePublicPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        super.load();
        container.visible();
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(container.isVisible());
    }

    @Override
    public void init() {
        container = new Control(this, By.cssSelector(".public"));
    }
}
