package com.adstream.automate.babylon.sut.pages.admin;

import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * User: ruslan.semerenko
 * Date: 19.02.13 13:57
 */
public class AdbankBillingPage extends BasePage {
    public AdbankBillingPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppear(By.xpath("//span[text()='Billing Data']"));
        web.waitUntilElementAppear(By.className("itemsList"));
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementPresent(By.xpath("//span[text()='Billing Data']")));
        assertTrue(web.isElementPresent(By.className("itemsList")));
    }
}
