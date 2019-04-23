package com.adstream.automate.babylon.sut.pages.library.presentations;

import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.Control;
import org.openqa.selenium.By;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 26.11.12
 * Time: 13:26
 */
public class BasePresentationPreviewPage<T> extends BasePage<T> {
    protected Control container;

    public BasePresentationPreviewPage(ExtendedWebDriver web) {
        super(web);
    }

    public void load() {
        super.load();
        container.visible();
    }

    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(container.isVisible());
    }

    @Override
    public void init() {
        container = new Control(this, By.cssSelector(".reel-container"));
    }
}
