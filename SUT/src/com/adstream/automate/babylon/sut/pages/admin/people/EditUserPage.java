package com.adstream.automate.babylon.sut.pages.admin.people;

import com.adstream.automate.babylon.sut.data.UserDecorator;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.DojoCombo;
import com.adstream.automate.page.controls.Edit;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;
import static com.thoughtworks.selenium.SeleneseTestBase.fail;

/**
 * User: ruslan.semerenko
 * Date: 25.04.12 15:15
 */
public class EditUserPage extends CreateUserPage {
    public DojoCombo timeZoneBox;
    public DojoCombo languageBox;

    public EditUserPage(ExtendedWebDriver web) {
        super(web);
        timeZoneBox = new DojoCombo(this, By.cssSelector("[id *= 'widget_dijit_form_FilteringSelect'].dijitComboBox"));
        languageBox = new DojoCombo(this, By.cssSelector("[data-schema-path='user#_cm.common.language'] .dijitComboBox"));
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(By.cssSelector("[id *= 'widget_dijit_form_FilteringSelect'].dijitComboBox"));
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementVisible(By.cssSelector("[id *= 'widget_dijit_form_FilteringSelect'].dijitComboBox")));
    }


    public void waitForAutoCompletePopUp() {
        WebElement popup = web.waitUntilElementAppear(getAutoCompletePopUpLocatorByCss());
        Common.sleep(1500);
        if (!popup.isDisplayed()) {
            fail("Autocomplete lookup doesn't work on Share window!!!");
        }
    }

    public void typeUserRole(String userRole) {
        web.findElement(getUserRoleListLocatorByCss()).click();
        web.findElement(getUserRoleListLocatorByCss()).clear();
        web.findElement(getUserRoleListLocatorByCss()).sendKeys(userRole);
        Common.sleep(1000);
    }

    public void clearUserRoleComboBox() {
        web.findElement(getUserRoleListLocatorByCss()).click();
        web.findElement(getUserRoleListLocatorByCss()).clear();
        web.findElement(getUserRoleListLocatorByCss()).sendKeys(Keys.BACK_SPACE);
        Common.sleep(1000);
    }


   private By getAutoCompletePopUpLocatorByCss() {
        return By.cssSelector(".dijitComboBoxMenu");
    }

   private By getUserRoleListLocatorByCss() {
        return By.cssSelector("[id^=admin_people_global_roles_list]");
    }

   public boolean isViewPublicTemplate() { return web.findElement(By.cssSelector("[data-role=\"viewPublicTemplatesFlag\"]")).isSelected(); }

    public DojoCombo getLanguageBoxLocator() {
        return languageBox;
    }


    public DojoCombo getTimeZoneBoxLocator() {
        return timeZoneBox;
    }
    public EditUserPage fillFieldsWthTimeZone(String timeZone) {
        getTimeZoneBoxLocator().selectByVisibleText(timeZone);
        return this ;
    }

    public EditUserPage fillFieldsWthLanguage(String language) {
        getLanguageBoxLocator().selectByVisibleText(language);
        return this ;
    }
}
