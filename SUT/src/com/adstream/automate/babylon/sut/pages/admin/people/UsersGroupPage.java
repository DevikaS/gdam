package com.adstream.automate.babylon.sut.pages.admin.people;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

/**
 * User: ruslan.semerenko
 * Date: 23.05.12 13:46
 */
public class UsersGroupPage extends UsersPage {
    public UsersGroupPage(ExtendedWebDriver web) {
        super(web);
    }

    public WebElement getUserElement(String userId) {
        By locator = By.cssSelector(String.format(".avatar [src*='%s']", userId));
        if (!web.isElementPresent(locator)) return null;
        return web.findElement(locator);
    }
}
