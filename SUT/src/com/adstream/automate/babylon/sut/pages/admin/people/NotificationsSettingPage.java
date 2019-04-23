package com.adstream.automate.babylon.sut.pages.admin.people;

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
 * User: solomin-y
 * Date: 18.12.12
 * Time: 11:29
 */
public class NotificationsSettingPage extends BaseAdminPage {
    public  NotificationsSettingPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        web.waitUntilElementAppear(By.cssSelector("[name*='subscriptions']"));
    }

    @Override
    public void isLoaded() throws Error {
        assertTrue(web.isElementPresent(By.cssSelector("[name*='subscriptions']")));
    }

    public void setNotificationState(String event, boolean enabled) {
        By locator = By.xpath(String.format("//*[contains(@class, 'pbs')][descendant::*[text()='%s']]//table", event));
        String value = enabled ? "Immediately" : "Off";
        new DojoSelect(this, locator).selectByVisibleText(value);
    }

    public void clickSaveButton() {
        web.click(By.name("Save"));
        Common.sleep(2000);
    }

    public List<String> getAllNotifications(){

        List<String> keys = web.findElementsToStrings(By.cssSelector(".lastUnit .pbs:not(.border-bottom) .p"));

        return keys;
    }

    public Map<String, Boolean> getNotificationStatus(){
        Map<String, Boolean> map = new HashMap<>();
        List<String> keys = web.findElementsToStrings(By.cssSelector(".lastUnit .pbs:not(.border-bottom) .p"));
        List<String> values = web.findElementsToStrings(By.cssSelector(".pbs:not(.border-bottom) .dijitSelectLabel"));
        for (int i = 0; i < keys.size(); i++) {
            map.put(keys.get(i), values.get(i).equals("Immediately"));
        }
        return map;
    }

    public String getStatusForNotification(String notification) {
        By locator = By.xpath(String.format("//div[contains(@class,'clearfix')]//span[.='%s']/parent::div/following-sibling::div//span", notification));
        return web.findElement(locator).getText();
    }

    public boolean isNotificationDisplayed(String notification) {
        By locator = By.xpath(String.format("//div[contains(@class,'clearfix')]//span[.='%s']", notification));
        return web.isElementVisible(locator);
    }
}
