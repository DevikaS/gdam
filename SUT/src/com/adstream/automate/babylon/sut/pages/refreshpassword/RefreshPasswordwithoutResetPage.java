package com.adstream.automate.babylon.sut.pages.refreshpassword;

import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * User: lynda-k
 * Date: 10.02.14
 * Time: 12:00
 */
public class RefreshPasswordwithoutResetPage extends BasePage {
    public RefreshPasswordwithoutResetPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void init() {
        super.init();
    }

    @Override
    public void load() {
        web.waitUntilElementAppearVisible(By.cssSelector("[ng-app='refreshPassword']"));
    }

    @Override
    public void isLoaded() throws Error {
        assertTrue(web.isElementPresent(By.cssSelector("[ng-app='refreshPassword']")));
    }

    public String getBodyText() {
        return web.findElement(By.cssSelector("[translate-values]")).getText().trim();
    }

    public void fillOldPasswordField(String value) {
        web.click(getOldPasswordFieldLocator());
        web.typeClean(getOldPasswordFieldLocator(), value);
    }

    public void fillNewPasswordField(String value) {
        web.click(getNewPasswordFieldLocator());
        web.typeClean(getNewPasswordFieldLocator(), value);
    }

    public void fillConfirmPasswordField(String value) {
        web.click(getConfirmPasswordFieldLocator());
        web.typeClean(getConfirmPasswordFieldLocator(), value);
    }

    public boolean isRefreshButtonActive() {
        return web.isElementPresent(getRefreshButtonLocator());
    }

    public List<String> getListOfErrorMessages() {
        return web.findElementsToStrings(By.cssSelector(".messenger.error"));
    }

    public void clickRefreshButton() {
        web.click(getRefreshButtonLocator());
      //  web.waitUntilElementAppearVisible(By.cssSelector(".adbank, .library, .error"));
    }

    private By getOldPasswordFieldLocator() {
        return By.cssSelector("[ng-model='user.oldPassword']");
    }


    private By getNewPasswordFieldLocator() {
        return By.cssSelector("[ng-model='user.password']");
    }

    private By getConfirmPasswordFieldLocator() {
        //return By.cssSelector("[ng-model='passwordConfirm']");
        return By.cssSelector("[ng-model='form.passwordConfirm']");
    }

    private By getRefreshButtonLocator() {
        return By.cssSelector(".button:not([disabled])");
    }
}