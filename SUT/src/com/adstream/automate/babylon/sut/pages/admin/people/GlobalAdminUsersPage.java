package com.adstream.automate.babylon.sut.pages.admin.people;

import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.NoSuchElementException;

public class GlobalAdminUsersPage  extends BaseAdminPage {

    public GlobalAdminUsersPage(ExtendedWebDriver web) {
        super(web);
    }

    public void searchUser(String userName) {
        try {
            web.typeClean(By.cssSelector("[class='pvs phs library-content border-right'] >input"), userName + Keys.RETURN);
        } catch (NoSuchElementException e) {
            web.navigate().refresh();
            load();
            web.typeClean(By.cssSelector("[class='pvs phs library-content border-right'] >input"), userName + Keys.RETURN);
        }
        web.sleep(1000);
    }

    public String getUserName(){
        return web.findElement(By.cssSelector("[class='h5'] >a")).getText().trim();
    }
}
