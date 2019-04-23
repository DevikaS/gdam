package com.adstream.automate.babylon.sut.pages.library.elements;

import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AdbankFileActivityPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.DojoCombo;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import java.util.ArrayList;
import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;


public class AdbankLibraryAssetsActivityPage extends AdbankFileActivityPage {
    public AdbankLibraryAssetsActivityPage(ExtendedWebDriver web) {
        super(web);
    }

    public DojoCombo activityTypeBox;

    public String getActivityType() {
        return activityTypeBox.getSelectedLabel();
    }

    public void setActivityType(String activityType) {
        activityTypeBox.selectByVisibleText(activityType);
    }

    @Override
    public void init() {
        super.init();
        this.activityTypeBox = new DojoCombo(this, By.xpath("//*[@role='listbox']"));
    }

    public void clickFilterOnActivities(){
        web.click(By.xpath(String.format("//span[contains(@data-role, 'activityFilterButton')]")));
    }

    public void typeFilterUserName(String name) {
        web.typeClean(By.xpath("//*[@data-role='userIdSelect']"), name);
        web.click(By.cssSelector("#adbank_shared_Autocomplete_0_popup0"));
    }

    @Override
    public void load() {
        web.waitUntilElementAppearVisible(By.cssSelector("[data-dojo-type='adbank.files.activity']"));
    }

    @Override
    public void isLoaded() throws Error {
        assertTrue(web.isElementVisible(By.cssSelector("[data-dojo-type='adbank.files.activity']")));
    }

    public List<String> getActivityList() {
        List<String> activities = new ArrayList<>();
        for (WebElement activityContainer : web.findElements(getActivitiesLocatorCss())) {
            activities.add(activityContainer.getText().replaceAll("\n", " "));
        }

        return activities;
    }

    private By getActivitiesLocatorCss() {
        return By.cssSelector(".lastUnit .unit .vmiddle");
    }

    public class AssetActivityFilter {
        private DojoCombo action;
        private AdbankLibraryAssetsActivityPage page;

        public AssetActivityFilter(AdbankLibraryAssetsActivityPage page) {
            action = new DojoCombo(page, By.cssSelector(".lib-select.dijitSelect"));
            this.page = page;
        }

        public void chooseFilter(String actionValue, String user) {
            action = new DojoCombo(this.page, By.cssSelector("[data-role='actionTypeSelect']"));
            action.selectByVisibleText(actionValue);
            Common.sleep(1000);
            if (user.isEmpty()) {
                clearUserField();
            }
            web.findElement(getUserFieldLocator()).sendKeys(user);
            Common.sleep(1000);
            web.click(getButtonFilterLocator());
            Common.sleep(1000);
        }

        public void clearUserField() {
            web.findElement(getUserFieldLocator()).clear();
        }

        private By getUserFieldLocator() {
            return By.cssSelector("[data-role='userIdSelect']");
        }

        private By getButtonFilterLocator() {
            return By.cssSelector("[data-role='activityFilterButton']");
        }
    }
}
