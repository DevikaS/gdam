package com.adstream.automate.babylon.sut.pages.admin.people.search;

import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import org.openqa.selenium.By;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/*
 * Created by demidovskiy-r on 29.04.2015.
 */
public class GlobalAdminSearchUsersPage extends BaseAdminPage<GlobalAdminSearchUsersPage> {
    private final String ROOT_NODE = ".md-search";
    private Button previousPageBtn;
    private Button nextPageBtn;

    public GlobalAdminSearchUsersPage(ExtendedWebDriver web) {
        super(web);
        previousPageBtn = new Button(this, By.className("prev"));
        nextPageBtn = new Button(this, By.className("next"));
    }

    @Override
    public void load() {
        web.waitUntilElementAppearVisible(getPageLocator());
    }

    @Override
    public void isLoaded() throws Error {
        assertTrue(web.isElementVisible(getPageLocator()));
    }

    public SearchModelForm getSearchModelForm() {
        return new SearchModelForm(this);
    }

    public UsersList getUsersList() {
        return new UsersList(web);
    }

    private By getPageLocator() {
        return By.cssSelector(ROOT_NODE);
    }
}