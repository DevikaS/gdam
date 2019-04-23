package com.adstream.automate.babylon.sut.pages.adbank.myprofile;

import com.adstream.automate.babylon.sut.pages.admin.people.NotificationsSettingPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: melnik-s
 * Date: 07.05.13
 * Time: 18:41
 */
public class MyNotificationsSettingPage extends NotificationsSettingPage {
    public MyNotificationsSettingPage(ExtendedWebDriver web) {
        super(web);
    }


    public List<String> getAllNotifications(){

        List<String> keys = web.findElementsToStrings(By.xpath("//div[contains(@class, 'ptm') and not(contains(@class, 'pbm'))]//span[contains(@class, 'plm')]"));
        return keys;
    }

    public String getNotificationStatus(String event) {
        String notificationStatus = "//span[@class='plm p'][contains(text(), '%s')]/../following-sibling::div//span";
        By locator = By.xpath(String.format(notificationStatus, event));
        return web.findElement(locator).getText();
    }
}
