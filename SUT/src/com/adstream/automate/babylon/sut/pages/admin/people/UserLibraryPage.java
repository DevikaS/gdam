package com.adstream.automate.babylon.sut.pages.admin.people;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.DojoSelect;
import org.openqa.selenium.By;

import java.util.ArrayList;
import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * User: lynda-k
 * Date: 17.04.14
 * Time: 13:02
 */
public class UserLibraryPage extends UsersPage {
    private static final By CATEGORIES_LIST_CONTAINER = By.cssSelector("[data-dojo-type='admin.people.categoryManagementFormLoader']");

    public UserLibraryPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(CATEGORIES_LIST_CONTAINER);
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementVisible(CATEGORIES_LIST_CONTAINER));
    }

    public List<String> getListOfCategoryRoles() {
        if (!web.isElementPresent(By.cssSelector(".itemsList.add-items-container.wide.mbm .row"))) return new ArrayList<String>();
        return web.findElementsToStrings(By.cssSelector(".itemsList.add-items-container.wide.mbm .row"));
    }

    public List<String> getAvailableCategories() {
        return new DojoSelect(this, By.cssSelector("#selectedUser .collections")).getLabels();
    }

    public List<String> getAvailableRoles() {
        return new DojoSelect(this, By.cssSelector("#selectedUser .roles")).getLabels();
    }

    public String getSelectedCategory() {
        DojoSelect categoriesSelect = new DojoSelect(this, By.cssSelector("#selectedUser .collections"));
        return categoriesSelect.getSelectedLabel();
    }

    public String getSelectedRole() {
        DojoSelect categoriesSelect = new DojoSelect(this, By.cssSelector("#selectedUser .roles"));
        return categoriesSelect.getSelectedLabel();
    }

    public List<String> getAssignedCategoriesList() {
        return web.findElementsToStrings(By.cssSelector("#selectedUser [id*='CollectionListItem'] > *:nth-child(1)"));
    }

    public List<String> getAssignedRolesList() {
        return web.findElementsToStrings(By.cssSelector("#selectedUser [id*='CollectionListItem'] > *:nth-child(2)"));
    }

    public boolean isRoleSelectBoxActiveForCategory(String categoryName) {
        By locator = By.xpath(String.format(
                "//*[text()='%s']/following-sibling::*/*[@data-role='selectRole'][not(contains(@class,'dijitSelectDisabled'))]", categoryName));
        return web.isElementPresent(locator);
    }

    public void selectCategory(String name) {
        new DojoSelect(this, By.cssSelector("#selectedUser .collections")).selectByVisibleText(name);
    }

    public void assignRoleForCategory(String categoryName, String roleName) {
        By locator = By.xpath(String.format(
                "//*[text()='%s']/following-sibling::*/*[@data-role='selectRole'][not(contains(@class,'dijitSelectDisabled'))]", categoryName));
        new DojoSelect(this, locator).selectByVisibleText(roleName);
    }

    public void selectRole(String name) {
        new DojoSelect(this, By.cssSelector("#selectedUser .roles")).selectByVisibleText(name);
    }

    public void removeCategory(String categoryName, String roleName) {
        clickRemoveCategory(categoryName, roleName).action.click();
    }

    public PopUpWindow clickRemoveCategory(String categoryName, String roleName) {
        web.click(By.xpath(String.format("//*[*[.='%s']][//*[text()='%s']]//*[contains(@class,'icon-cross')]", categoryName, roleName)));
        web.sleep(1000);
        return new PopUpWindow(this);
    }
}