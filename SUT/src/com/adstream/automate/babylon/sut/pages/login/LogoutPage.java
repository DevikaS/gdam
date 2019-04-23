package com.adstream.automate.babylon.sut.pages.login;

import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;

import static com.thoughtworks.selenium.SeleneseTestBase.assertFalse;


/**
 * Created by IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 24.01.12
 * Time: 13:21
 */
public class LogoutPage extends BasePage {
    public LogoutPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        web.waitUntilElementDisappear(applicationBodyLocator);
    }

    @Override
    public void isLoaded() throws Error {
        assertFalse(web.isElementVisible(applicationBodyLocator));
    }
}
