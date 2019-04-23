package com.adstream.automate.babylon.sut.pages;

import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.DojoSelect;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User:Geethanjali
 */
public class NotificationsSettingPageForGA extends BaseAdminPage {
    public NotificationsSettingPageForGA(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        web.waitUntilElementAppear(By.cssSelector(".clearfix.ptm.pbs.pbm.border-bottom"));
    }

    @Override
    public void isLoaded() throws Error {
        assertTrue(web.isElementPresent(By.cssSelector(".clearfix.ptm.pbs.pbm.border-bottom")));
    }

    public void setNotificationState(String event, boolean enabled) {
        By locator = By.xpath(String.format("//*[contains(@class, 'pbs')][descendant::*[text()='%s']]//table", event));
        String value = enabled ? "Immediately" : "Off";
        new DojoSelect(this, locator).selectByVisibleText(value);
    }

    public List<String> getAllNotifications(){

        List<String> keys = web.findElementsToStrings(By.cssSelector(".ptm .plm.ng-binding"));
        return keys;
    }

    public void clickSaveButton() {
        web.click(By.name("Save"));
        Common.sleep(2000);
    }

    public Map<String, Boolean> getNotificationStatus(){
        Map<String, Boolean> map = new HashMap<>();
        List<String> keys = web.findElementsToStrings(By.cssSelector(".pbs:not(.border-bottom) .p"));
        List<String>  values = web.findElementsToStrings(By.cssSelector(".select2-chosen")) ;
        for (int i = 0; i < keys.size(); i++) {
            map.put(keys.get(i), values.get(i).equals("Immediately"));
        }
        return map;
    }

    public String getNotificationStatus(String event) {
        String notificationStatus = "//span[@class='plm p ng-binding'][contains(text(), '%s')]/../following-sibling::div//span";
        By locator = By.xpath(String.format(notificationStatus, event));
        return web.findElement(locator).getText();
    }
}
