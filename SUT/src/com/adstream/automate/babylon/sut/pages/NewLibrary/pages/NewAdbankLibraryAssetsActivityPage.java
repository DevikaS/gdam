package com.adstream.automate.babylon.sut.pages.NewLibrary.pages;

import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.LibraryAssetsInfoPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created by Janaki.Kamat on 26/09/2017.
 */
public class NewAdbankLibraryAssetsActivityPage extends LibraryAssetsInfoPage {
    private final String ROOT_NODE = ".asset-tab-activities-content";
    private final By activityListInputLocator=By.cssSelector("ads-md-multiselect[placeholder=\"All activity\"] input");
    private final By userInputLocator = By.cssSelector("md-contact-chips[placeholder=\"Enter the name/email address\"] input");
    private final By activityListLocator=By.cssSelector("ads-md-multiselect[placeholder=\"All activity\"] ul[repeat^=\"option.key as option in $ctrl.options\"] li");
    private final String multiSelectFormat="//*[@class=\"ui-select-choices-group\"]//li[@ng-repeat=\"option in $select.items\"]";
    private final By activityIconLocator = By.xpath("*//a[@class=\"md-button ng-scope md-ink-ripple square\"][contains(@ng-href,\"activities\")]//span[@code=\"clock\"]");

    public NewAdbankLibraryAssetsActivityPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(getPageLocator());
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementVisible(getPageLocator()));
    }

    private By getPageLocator() {
        return By.cssSelector(ROOT_NODE);
    }

    public List<String> getActivitiesDone() {
        List<String> activities = new ArrayList<>();
        for (WebElement elem : web.findElements(By.cssSelector("ads-activity-row[ng-repeat=\"activity in activityGroup track by activity.id\"] .activity-description"))) {
            activities.add(elem.getText().replaceAll("\n", " "));
        }

        return activities;
    }


    public List<String> getListOfActivities() {
        web.click(activityListInputLocator);
        Common.sleep(1000);
        return web.findElementsToStrings(activityListLocator);
    }

    public void enterUserName(String userName){
        WebElement elem=web.findElement(userInputLocator);
        elem.sendKeys(userName+ Keys.ENTER);
        Common.sleep(1000);
        if(web.isElementPresent(By.cssSelector("[class=\"md-contact-name\"] span[class=\"highlight\"]")))
           web.click(By.cssSelector("[class=\"md-contact-name\"] span[class=\"highlight\"]") );
     }

    public void searchActivityName(String activityType){
         web.findElement(activityListInputLocator).sendKeys(activityType);
         web.findElement(By.xpath("//li[@class='ui-select-choices-group']//li//span[contains(.,'"+activityType+"')]")).click();
    }

    public void removeActivityName(List<Map<String, String>> activityType){
        for (Map<String, String> row : activityType) {
             if(web.isElementPresent(By.xpath(String.format("*//ads-md-multiselect[@placeholder=\"All activity\"]//li[@ng-repeat=\"$item in $select.selected track by $index\"][..//span[contains(text(),\"%s\")]]//a[@ng-click=\"$selectMultiple.removeChoice($index)\"]", row.get("ActivityType"))))) {
                WebElement link=web.findElement(By.xpath(String.format("*//ads-md-multiselect[@placeholder=\"All activity\"]//li[@ng-repeat=\"$item in $select.selected track by $index\"][..//span[contains(text(),\"%s\")]]//a[@ng-click=\"$selectMultiple.removeChoice($index)\"]", row.get("ActivityType"))));
                web.scrollToElement(link);
                link.click();
                Common.sleep(2000);
            }
        }
    }
}
