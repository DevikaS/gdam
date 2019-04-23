package com.adstream.automate.babylon.sut.pages.admin;

import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 24.01.12
 * Time: 15:57
 */
public class BaseAdminPage<T> extends BasePage<T> {
    public BaseAdminPage(ExtendedWebDriver web) {
        super(web);
    }

    public void load() {
        web.sleep(4000);
//        web.waitUntilElementAppearVisible(By.cssSelector(".admin"));
    }

    public void isLoaded() throws Error {
        web.sleep(4000);
//        assertTrue(web.isElementVisible(By.cssSelector(".admin")));
    }

    public List<String> getAppMenuItems() {
        return web.findElementsToStrings(By.cssSelector(".app-menu.nav li"));
    }
}