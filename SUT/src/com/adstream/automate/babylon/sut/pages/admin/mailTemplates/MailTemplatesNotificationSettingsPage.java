package com.adstream.automate.babylon.sut.pages.admin.mailTemplates;

import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.DojoCombo;
import com.adstream.automate.page.controls.DojoSelect;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Edit;

import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.Select;

import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

public class MailTemplatesNotificationSettingsPage extends BaseAdminPage {
    public Edit roleName;
    public Button save;
    public DojoCombo advertiser;

    private By businessUnitLocator = By.cssSelector(".select2-chosen");
    private By businessUnitsearchLocator = By.cssSelector("#s2id_autogen1_search");
    private By selectBusinessUnit = By.xpath("//ul[@class='select2-results']/li/div");
    private String notificationStatus = "//span[@class='plm p vmiddle ng-binding'][contains(text(), '%s')]/../following-sibling::div//span";


    public  MailTemplatesNotificationSettingsPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        web.waitUntilElementAppear(By.cssSelector("#s2id_businessUnitSelector"));
    }

    @Override
    public void isLoaded() throws Error {
        assertTrue(web.isElementPresent(By.cssSelector("#s2id_businessUnitSelector")));
    }

    public void selectAdvertiser(String advertiserName) {
        List<WebElement> allBusinessUnits = web.findElements(selectBusinessUnit);
            for (int i = 0; i < allBusinessUnits.size(); i++) {
                if (allBusinessUnits.get(i).getText().contentEquals(advertiserName)) {
                    allBusinessUnits.get(i).click();
                    break;
                }
            }
    }

    public void searchAdvertiser(String advertiserName) {
        web.findElement(businessUnitLocator).click();
        web.findElement(businessUnitsearchLocator).sendKeys(advertiserName);
    }

    public void setNotificationState(String event, boolean enabled) {
        By locator = By.xpath(String.format("//*[contains(@class, 'pbs')][descendant::*[text()='%s']]//table", event));
        String value = enabled ? "Immediately" : "Off";
        new DojoSelect(this, locator).selectByVisibleText(value);
    }

    public List<String> getAllNotifications(){

        List<String> keys = web.findElementsToStrings(By.cssSelector(".ptm  span.plm"));
        return keys;
    }

    public String getNotificationStatus(String event) {
    By locator = By.xpath(String.format(notificationStatus, event));
    return web.findElement(locator).getText();
    }


    public void clickSaveButton() {
        web.click(By.name("Save"));
        Common.sleep(2000);
    }

    public MailTemplatesTab selectMailTemapltesTab(){
        web.findElement(By.linkText("Mail Templates")).click();
        return new MailTemplatesTab();
    }


    public class MailTemplatesTab {
        private String fieldNameLocatorFormat = "s2id_%s";
        private String searchFieldLocatorFormat = "//div[@class='select2-search']//label[.='%s']";
        private String editableFieldLocFormat = "(//span[.='%s'])[1]";
        private String buttonFormat = "//button[contains(text(),'%s')]";

        public void selectValueInDropDownByFieldName(String fieldName, String searchField, String searchText) {
            String searchFieldLocator = String.format(searchFieldLocatorFormat, searchField);
            By by = By.xpath(searchFieldLocator);
            web.findElement(By.id(String.format(fieldNameLocatorFormat, fieldName))).click();
            web.findElement(by).sendKeys(searchText);
            web.sleep(1500);
            web.findElement(by).sendKeys(Keys.ENTER);
        }



        public void selectButtonByName(String btnName) {
            String btnLoc = String.format(buttonFormat, btnName);
            web.findElement(By.xpath(btnLoc)).click();
        }

        public void selectDefaultNotificationType(String fieldName,String searchText) {
            Select select = new Select(web.findElement(By.xpath("//select[@ng-model=\"vm.defaultNotification.NotificationType\"]")));
            select.selectByVisibleText(searchText);
        }
    }


}
