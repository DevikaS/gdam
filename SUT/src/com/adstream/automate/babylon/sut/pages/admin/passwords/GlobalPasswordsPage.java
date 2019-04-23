package com.adstream.automate.babylon.sut.pages.admin.passwords;

import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Edit;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.ElementNotVisibleException;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created by sobolev-a on 18.04.2014.
 */
public class GlobalPasswordsPage extends BasePage {

    public GlobalPasswordsPage(ExtendedWebDriver web) {
        super(web);
    }

    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(getPasswordFormLocator());
    }

    public void isLoaded() throws ElementNotVisibleException {
        super.isLoaded();
        assertTrue(web.isElementVisible(getPasswordFormLocator()));
    }

    public void changePassword(String email, String newPassword, String repeatPassword) {
        Edit emailEdit = new Edit(this, getFormEmailLocator());
        emailEdit.typeWithInterval(email, 100);
        Common.sleep(1000);
        web.findElement(getFormPasswordLocator()).sendKeys(newPassword);
        web.findElement(getFormRepeatPasswordLocator()).sendKeys(repeatPassword);
        web.findElement(getFormEmailLocator()).click(); //this is a workaround as when we change password the not trusted info message is displayed against password field, So clicking on email field and then clicking on save. Should go off after we move to https
        web.findElement(getFormButtonChangeLocator()).click();
         }

    public boolean isWarningPasswordMessageExist(String message) {
        return web.isElementPresent(getWarningPasswordMessage(message)) && web.isElementVisible(getWarningPasswordMessage(message));
    }

    private By getFormEmailLocator() { return By.cssSelector("[ng-model=\"email\"]"); }

    private By getFormPasswordLocator() { return By.cssSelector("[ng-model=\"password\"]"); }

    private By getFormRepeatPasswordLocator() { return By.cssSelector("[ng-model=\"passwordRepeat\"]"); }

    private By getFormButtonChangeLocator() { return By.xpath("//button[text()='Change']"); }

    private By getPasswordFormLocator() { return By.cssSelector("[ng-controller=\"passwordsCtrl\"]"); }

    private By getWarningPasswordMessage(String message) { return By.xpath(String.format("//span[text()='%s']", message)); }
}
