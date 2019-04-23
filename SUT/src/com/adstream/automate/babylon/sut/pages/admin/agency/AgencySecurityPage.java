package com.adstream.automate.babylon.sut.pages.admin.agency;

import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
  * User: lynda-k
 * Date: 25.02.14
 * Time: 12:07
 */
public class AgencySecurityPage extends BaseAdminPage<AgencySecurityPage> {
    public AgencySecurityPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void init() {
        super.init();
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(By.xpath("//*[contains(@class,'h5') and normalize-space()='Security']"));
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementPresent(By.xpath("//*[contains(@class,'h5') and normalize-space()='Security']")));
    }

    public void setPasswordStrengthForm(String minLength, String upperCaseCount, String numbersCount, String expirationInDays) {
        fillMinimumLengthOfPasswordField(minLength);
        fillMinimumUppercaseCharsField(upperCaseCount);
        fillMinimumNumbersField(numbersCount);
        fillPasswordExpirationPeriodField(expirationInDays);
        web.click(getSaveButtonLocator());
    }

    public String getMinimumLengthOfPasswordFieldValue() {
        return web.findElement(getMinimumLengthOfPasswordFieldLocator()).getAttribute("value");
    }

    public String getMinimumUppercaseCharsFieldValue() {
        return web.findElement(getMinimumUppercaseCharsFieldLocator()).getAttribute("value");
    }

    public String getMinimumNumbersFieldValue() {
        return web.findElement(getMinimumNumbersFieldLocator()).getAttribute("value");
    }

    public String getPasswordExpirationPeriodFieldValue() {
        return web.findElement(getPasswordExpirationPeriodFieldLocator()).getAttribute("value");
    }

    public void fillMinimumLengthOfPasswordField(String value) {
        web.typeClean(getMinimumLengthOfPasswordFieldLocator(), value);
    }

    public void fillMinimumUppercaseCharsField(String value) {
        web.typeClean(getMinimumUppercaseCharsFieldLocator(), value);
    }

    public void fillMinimumNumbersField(String value) {
        web.typeClean(getMinimumNumbersFieldLocator(), value);
    }

    public void fillPasswordExpirationPeriodField(String value) {
        web.typeClean(getPasswordExpirationPeriodFieldLocator(), value);
    }

    public void clickSaveButton() {
        web.click(getSaveButtonLocator());
    }

    private By getMinimumLengthOfPasswordFieldLocator() {
        return By.cssSelector("[ng-model='passParams.minTotalLengthOfPassword']");
    }

    private By getMinimumUppercaseCharsFieldLocator() {
        return By.cssSelector("[ng-model='passParams.minIncludingUppercase']");
    }

    private By getMinimumNumbersFieldLocator() {
        return By.cssSelector("[ng-model='passParams.minimumIncludingNumbers']");
    }

    private By getPasswordExpirationPeriodFieldLocator() {
        return By.cssSelector("[ng-model='agency._cm.passwordSettings.passwordExpirationInDays']");
    }

    private By getSaveButtonLocator() {
        return By.cssSelector("[ng-disabled*='unitSecurityForm']");
    }
}
