package com.adstream.automate.babylon.sut.pages.admin.people;

import com.adstream.automate.babylon.JsonObjects.ApplicationAccess;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Checkbox;
import org.openqa.selenium.By;

import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * User: lynda-k
 * Date: 17.04.14
 * Time: 13:03
 */
public class UserApplicationsPage extends UsersPage {
    private static final By APPLICATIONS_LIST_CONTAINER = By.cssSelector("[data-dojo-type='admin.people.peopleApplicationsForm']");

    public UserApplicationsPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(APPLICATIONS_LIST_CONTAINER);
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementVisible(APPLICATIONS_LIST_CONTAINER));
    }

    public List<String> getCheckedApplications() {
        return web.findElementsToStrings(By.cssSelector("#selectedUser .permissions [checked] + *"));
    }

    public void checkApplication(ApplicationAccess application) {
        new Checkbox(this, By.cssSelector(String.format("#selectedUser [name='%s']", application.toString()))).select();
    }
}