package com.adstream.automate.babylon.sut.pages.adbank.myprofile;

import com.adstream.automate.babylon.sut.pages.admin.people.EditUserPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * User: ruslan.semerenko
 * Date: 13.06.12 16:05
 */
public class MyProfilePage extends EditUserPage {
    public MyProfilePage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        //super.load();   // there is no .admin locator at the my profile page
        web.waitUntilElementAppearVisible(By.cssSelector("[data-dojo-type='admin.people.UserSettingsForm']"));
    }

    @Override
    public void isLoaded() throws Error {
        //super.isLoaded();   // there is no .admin locator at the my profile page
        assertTrue(web.isElementVisible(By.cssSelector("[data-dojo-type='admin.people.UserSettingsForm']")));
    }

    public byte[] getProfileLogo() {
        WebElement logoProfile=web.findElement(getLogoProfileByCss());
        return getDataByUrl(logoProfile.getAttribute("src"));
    }

    public byte[] getHeaderLogo() {
        WebElement logoHeader=web.findElement(getLogoHeaderByCss());
        return getDataByUrl(logoHeader.getAttribute("src"));
    }

    public boolean isAgencyNameEditable() {
        WebElement agency=web.findElement(getAgencyLocatorByCss());
        return agency.getAttribute("aria-disabled").equals("true") ? false : true;
    }

    public boolean isEmailEditable() {
        WebElement email = web.findElement(By.name("_cm.common.email"));
        if (email.getAttribute("disabled") == null) {
            return true;
        }
        else {
            return !email.getAttribute("disabled").equals("true");
        }
    }

    public String getAgencyName() {
        return web.findElement(getAgencyLocatorByCss()).getAttribute("value");
    }

    private By getAgencyLocatorByCss() {
        return By.cssSelector(".advertiser input.dijitInputInner");
    }

    private By getLogoProfileByCss() {
        return By.cssSelector("#avatar>img");
    }

    private By getLogoHeaderByCss() {
        return By.cssSelector(".unit.mrm");
    }
}