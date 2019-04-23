package com.adstream.automate.babylon.sut.pages.admin.people.search;

import com.adstream.automate.babylon.sut.pages.ordering.PageElement;
import com.adstream.automate.babylon.sut.pages.ordering.elements.lists.AbstractList;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import java.util.ArrayList;
import java.util.List;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/*
 * Created by demidovskiy-r on 29.04.2015.
 */
public class UsersList extends AbstractList {
    public UsersList(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        web.waitUntilElementAppearVisible(getListLocator());
    }

    @Override
    public void isLoaded() throws Error {
        assertTrue(web.isElementVisible(getListLocator()));
    }

    public static class User extends PageElement<UsersList> {
        private String userName;
        private String businessUnit;

        public User(ExtendedWebDriver web, UsersList parent, WebElement row) {
            super(web, parent);
            List<WebElement> cells = row.findElements(By.className("cell"));
            userName = cells.get(0).findElement(By.tagName("a")).getText();
            businessUnit = cells.get(1).findElement(By.className("ng-binding")).getText();
        }

        public String getUserName() {
            return userName;
        }

        public String getBusinessUnit() {
            return businessUnit;
        }
    }

    public User getUserByName(String userName) {
        for (User user: getUsers())
            if (user.getUserName().equals(userName))
                return user;
        return null;
    }

    public List<String> getVisibleUserNames() {
        List<String> userNames = new ArrayList<>();
        List<User> users = getUsers();
        if (users == null) return userNames;
        for (User user: users)
            userNames.add(user.getUserName());
        return userNames;
    }

    private List<User> getUsers() {
        if (!web.isElementPresent(getUserRowLocator())) return null;
        List<WebElement> usersElements = web.findElements(getUserRowLocator());
        List<User> users = new ArrayList<>();
        for (WebElement element: usersElements)
            users.add(new User(web, this, element));
        return users;
    }

    private By getUserRowLocator() {
        return generateListLocator(".row");
    }
}