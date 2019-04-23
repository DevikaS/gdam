package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.DojoCombo;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 15.09.12
 * Time: 18:13
 */
public class AdbankFileActivityPage extends AdbankFileViewPage {
    public AdbankFileActivityPage(ExtendedWebDriver web) {
        super(web);
    }

    public DojoCombo activityTypeBox;

    public void setActivityType(String activityType) {
        activityTypeBox.selectByVisibleText(activityType);
    }

    @Override
    public void init() {
        super.init();
        this.activityTypeBox = new DojoCombo(this, By.xpath("//*[@data-role='projectPanel']//*[@role='listbox']"));
    }

    public void clickFilterOnActivities(){
        web.click(By.xpath(String.format("//span[contains(@data-role, 'activityFilterButton')]")));
    }

    public void typeFilterUserName(String name) {
        web.typeClean(By.xpath("//*[@data-role='userIdSelect']"), name);
        web.click(By.cssSelector("#adbank_shared_Autocomplete_1_popup0"));
    }

    public List<Map<String,String>> getActivities() {
        List<Map<String,String>> activities = new ArrayList<>();
        web.navigate().refresh();
        web.waitUntilElementAppearVisible(By.cssSelector(".files_activities_item .avatar > img"));
        List<String> userLogos = web.findElementsToStrings(By.cssSelector(".files_activities_item .avatar > img"), "src");
        List<String> userNames = web.findElementsToStrings(By.cssSelector(".files_activities_item .lastUnit a.p"));
        List<String> massages = web.findElementsToStrings(By.cssSelector(".files_activities_item .lastUnit span.p"));

        for (int i = 0; i < userNames.size(); i++) {
            Map<String,String> activity = new HashMap<>();
            activity.put("Logo", Integer.toString(getDataByUrl(userLogos.get(i)).length));
            activity.put("UserName", userNames.get(i));
            activity.put("ActivityMessage", massages.get(i));
            activities.add(activity);
        }

        return activities;
    }

    public String getFileNameOnActivityTab(User user) {
        String locator = getActivityContainerLocator(user) + "//span[contains(@class, 'bold')]";
        if (web.isElementPresent(By.xpath(locator))) {
            return web.findElement(By.xpath(locator)).getText();
        }  else {
            return "";
        }
    }

    public int getActivitiesCount() {
        List<WebElement> activitiesList = web.findElements(getActivitiesCountLocator());
        return activitiesList.size();
    }

    private String getActivityContainerLocator(User user) {
        return String.format("//li[contains(@class, 'files_activities_item') and //img[contains(@src, '%s')]]", user.getId());
    }

    private By getActivitiesCountLocator() {
        return By.cssSelector("[data-dojo-type='adbank.files.activity']");
    }

    public List<String> getActivityList() {
        List<String> activities = new ArrayList<>();
        for (WebElement activityContainer : web.findElements(getActivitiesLocatorCss())) {
            activities.add(activityContainer.getText());
        }

        return activities;
    }

    private By getActivitiesLocatorCss() {
        return By.cssSelector(".lastUnit .unit .vmiddle");
    }

    public class FileActivityFilter {
        private DojoCombo action;
        private AdbankFileActivityPage page;

        public FileActivityFilter(AdbankFileActivityPage page) {
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