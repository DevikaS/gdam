package com.adstream.automate.babylon.sut.pages.admin.people;

import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.AbstractForm;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Checkbox;
import com.adstream.automate.page.controls.Link;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.Select;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/*
 * Created by demidovskiy-r on 03.04.2015.
 */
public class ProfileUserSettingPage extends BaseAdminPage {
    private final static String ROOT_NODE = "[ng-if='profileLoaded']";
    private Button saveBtn;
    private Link cancelBtn;
    private String textFieldLocatorFormat = "//span[contains(text(),'%s')]/following-sibling::input";
    private String textFieldLocatorFormat1 = "//label[contains(text(),'Password')]/following-sibling::input";
    private String checkboxLocatorFormat = "//label//span[contains(text(),'%s')]/preceding-sibling::input[@name='checkbox']";

    public ProfileUserSettingPage(ExtendedWebDriver web) {
        super(web);
        saveBtn = new Button(this, By.className("save"));
        cancelBtn = new Link(this, By.className("cancel"));
    }

    @Override
    public void load() {
        web.waitUntilElementAppearVisible(getProfileUserSettingPageLocator());
    }

    @Override
    public void isLoaded() throws Error {
        assertTrue(web.isElementVisible(getProfileUserSettingPageLocator()));
    }

    public void save() {
        clickSaveBtn();
        unloadPage();
    }

    public void cancel() {
        clickCancelBtn();
        unloadPage();
    }

    public UserProfile getUserProfile() {
        return new UserProfile(this);
    }

    public static class UserProfile extends AbstractForm {
        private final static String PRIMARY_BU = "Primary Business Unit";
        private ExtendedWebDriver web;
        private Select primaryBU;

        public UserProfile(ProfileUserSettingPage parent) {
            super(parent);
            web = parent.getDriver();
            primaryBU = new Select(web.findElement(By.cssSelector("[ng-model='values.primaryBU']")));
        }

        public List<String> getAvailablePrimaryBUs() {
            List<String> primaryBUs = new ArrayList<>();
            for (WebElement element: primaryBU.getOptions())
                primaryBUs.add(element.getText().trim());
            return primaryBUs;
        }

        @Override
        public void fill(Map<String, String> fields) {
            if (fields.containsKey(PRIMARY_BU)) primaryBU.selectByVisibleText(fields.get(PRIMARY_BU));
        }

        @Override
        public String getFieldValue(String fieldName) {
            if (fieldName.equals(PRIMARY_BU)) return primaryBU.getFirstSelectedOption().getText().trim();
            throw new IllegalArgumentException("Unknown field name: " + fieldName);
        }

        @Override
        protected void initControls() {
        }

        @Override
        protected void loadForm() {
        }

        @Override
        protected void unloadForm() {
        }

        @Override
        protected String getRootNode() {
            return ROOT_NODE;
        }
    }

    private void clickSaveBtn() {
        saveBtn.click();
    }

    private void clickCancelBtn() {
        cancelBtn.click();
    }

    private void unloadPage() {
        web.waitUntilElementDisappear(getProfileUserSettingPageLocator());
    }

    private By getProfileUserSettingPageLocator() {
        return By.cssSelector(ROOT_NODE);
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
    }

    public boolean isApplicationCheckboxSelected(String application) {
        By locator = By.xpath(String.format(checkboxLocatorFormat,application));
        if(web.isElementPresent(locator) && web.isElementVisible(locator))
            return new Checkbox(this, By.xpath(String.format(checkboxLocatorFormat,application))).isSelected();
        return false;
    }

    public void clickSave() {
        web.click(By.className("save"));
        web.sleep(3000);
    }

    public boolean IsStartUpPageSectionVisible(){
        return web.isElementVisible(By.xpath("//*[@id=\"app-main\"]//users-startup-page//div[.='Startup Page']"));
    }

    public boolean checkStartupPageDropdown(String appName){
        web.click(By.xpath("//users-startup-page//div[.='Startup Page']/../following-sibling::div//b[@role='presentation']"));
        web.waitUntilElementAppearVisible(By.xpath("//users-startup-page//div//select/option"));
        return web.isElementVisible(By.xpath(String.format("//users-startup-page//div//select/option[.='%s']",appName)));
    }
}