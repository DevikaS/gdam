package com.adstream.automate.babylon.sut.pages.admin.people;

import com.adstream.automate.babylon.sut.data.UserDecorator;
import com.adstream.automate.babylon.sut.elements.controls.complex.LogoElement;
import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Checkbox;
import com.adstream.automate.page.controls.DojoCombo;
import com.adstream.automate.page.controls.Edit;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.HashMap;
import java.util.Map;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created by Arti Sharma.
 * Date: 25.10.18
 */
public class GlobalAdminCreateUserPage extends BaseAdminPage {
    protected Edit email;
    private String textFieldLocatorFormat = "//span[contains(text(),'%s')]/following-sibling::input";
    private String textFieldLocatorFormat1 = "//label[contains(text(),'Password')]/following-sibling::input";
    private String checkboxLocatorFormat = "//label//span[contains(text(),'%s')]/preceding-sibling::input[@name='checkbox']";

    public GlobalAdminCreateUserPage(ExtendedWebDriver web) {
        super(web);
        email = new Edit(this, By.xpath("//span[contains(text(),'Primary Email Address')]/following-sibling::input"));
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(By.cssSelector("#app-main > div.content-container.pam.ng-scope"));
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue( web.isElementVisible(By.cssSelector("#app-main > div.content-container.pam.ng-scope")));
    }

    public void clickSave() {
            web.click(By.className("save"));
            web.sleep(3000);
    }

    public void clickCancel() {
        web.click(By.cssSelector(".cancel.mls"));
    }

    public boolean isApplicationCheckboxVisible(String application) {
        By locator = By.xpath(String.format(checkboxLocatorFormat,application));
        return web.isElementPresent(locator) && web.isElementVisible(locator);
    }

    public void setApplicationAccessCheckboxState(String application, boolean enabled) {
        WebElement locator = web.findElement(By.xpath(String.format(checkboxLocatorFormat,application)));
        web.scrollToElement(locator);
        if (isApplicationCheckboxVisible(application)) {
            if (enabled) {
                new Checkbox(this, By.xpath(String.format(checkboxLocatorFormat,application))).select();
            } else {
                new Checkbox(this, By.xpath(String.format(checkboxLocatorFormat,application))).deselect();
            }
        }
        else {
            throw new RuntimeException("checkbox not exist on user details page");
        }
        clickSave();
    }

    public GlobalAdminCreateUserPage fillFieldsToCreateUser(UserDecorator user) {
        By textFieldLocator ;
        By textFieldLocator1 ;
        By checkboxLocator ;

        if (!user.getFirstName().equals(null)|| !user.getFirstName().isEmpty()) {
             textFieldLocator = By.xpath(String.format(textFieldLocatorFormat, "First Name"));
             web.typeClean(textFieldLocator,user.getFirstName());
        }
        if (!user.getLastName().equals(null)|| !user.getLastName().isEmpty()) {
             textFieldLocator = By.xpath(String.format(textFieldLocatorFormat, "Second Name"));
             web.typeClean(textFieldLocator, user.getLastName());
        }
        if (!user.getPassword().equals(null)|| !user.getPassword().isEmpty()) {
            textFieldLocator1 = By.xpath(String.format(textFieldLocatorFormat1, "Password"));
            web.typeClean(textFieldLocator1, user.getPassword());
        }
        if (!user.getEmail().equals(null)|| !user.getEmail().isEmpty()) {
            textFieldLocator = By.xpath(String.format(textFieldLocatorFormat, "Primary Email Address"));
            web.typeClean(textFieldLocator, user.getEmail());
        }
        if (user.isLibraryAccess()) {
           checkboxLocator = By.xpath(String.format(checkboxLocatorFormat,"Streamlined Library"));
           web.setCheckBoxTo(checkboxLocator, user.isLibraryAccess());
        }
        if (user.isOrderingAccess()) {
            checkboxLocator = By.xpath(String.format(checkboxLocatorFormat,"Delivery"));
            web.setCheckBoxTo(checkboxLocator, user.isOrderingAccess());
        }
        if (user.isTrafficAccess()) {
            checkboxLocator = By.xpath(String.format(checkboxLocatorFormat,"Traffic"));
            web.setCheckBoxTo(checkboxLocator, user.isTrafficAccess());
        }
        if (user.isDashboardAccess()) {
            checkboxLocator = By.xpath(String.format(checkboxLocatorFormat,"Dashboard"));
            web.setCheckBoxTo(checkboxLocator, user.isDashboardAccess());
        }
        if (user.isFoldersAccess()) {
            checkboxLocator = By.xpath(String.format(checkboxLocatorFormat,"Folders"));
            web.setCheckBoxTo(checkboxLocator, user.isFoldersAccess());
        }
        if (!user.getRoleName().equals(null)|| !user.getRoleName().isEmpty()) {
            String userRole="";
            if(user.getRoleName().equals("Business Unit Admin")) {
               userRole = "Administrator" ;
            }else if(user.getRoleName().equals("Business Unit User")){
                   userRole = "agency.user" ;
            }
            By roleLocator = By.xpath(String.format("//div//select/option[.='%s']",userRole));
            web.click(By.xpath("//div/a/span[2][@class='select2-arrow']/b"));
            web.waitUntilElementAppearVisible(By.xpath("//div//select/option"));
            web.typeClean(By.xpath("//div[@class='select2-search']/label/following-sibling::input"),userRole);
            web.waitUntilElementAppearVisible(roleLocator);
            web.click(roleLocator);
        }
        return this;
    }
}