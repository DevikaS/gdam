package com.adstream.automate.babylon.sut.pages.adbank.myprofile;

import com.adstream.automate.babylon.sut.pages.admin.people.AccountSettingPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 03.10.12
 * Time: 13:07
 */
public class MyAccountSettingPage extends AccountSettingPage {
    public MyAccountSettingPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        web.waitUntilElementAppearVisible(By.cssSelector("[data-dojo-type='admin.people.reset_password']"));
    }

    @Override
    public void isLoaded() throws Error {
        assertTrue(web.isElementVisible(By.cssSelector(("[data-dojo-type='admin.people.reset_password']"))));
    }

    public String getPasswordQualityText() {
        return web.findElement(By.xpath("//*[contains(text(),'Your password must have')]")).getText().trim();
    }
}
