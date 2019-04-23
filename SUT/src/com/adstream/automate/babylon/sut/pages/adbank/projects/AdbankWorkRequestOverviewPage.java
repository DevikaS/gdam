package com.adstream.automate.babylon.sut.pages.adbank.projects;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.Select;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * User: lynda-k
 * Date: 19.06.14
 * Time: 14:43
 */
public class AdbankWorkRequestOverviewPage extends AdbankWorkRequestFilesWithFoldersPage {
    private static final String WORK_REQUEST_FIELD_LOCATOR = "//*[contains(@class,'caption') and normalize-space()='%s']/following-sibling::*";
    private Select notification;

    public AdbankWorkRequestOverviewPage(ExtendedWebDriver web) {
        super(web);
    }

    public List<Map<String,String>> getWorkRequesFieldsList() {
        List<Map<String,String>> projectFieldsList = new ArrayList<Map<String, String>>();

        for (String fieldName : web.findElementsToStrings(By.cssSelector(".schema_field .caption"))) {
            Map<String,String> projectField = new HashMap<String, String>();
            String fieldValue = web.findElement(By.xpath(String.format(WORK_REQUEST_FIELD_LOCATOR, fieldName))).getText().trim();
            projectField.put(fieldName.replaceFirst(":$", ""), fieldValue.replaceAll(", +", ","));
            projectFieldsList.add(projectField);
        }

        return projectFieldsList;
    }

    public boolean isPublishUnpublishButtonPresent(String buttonName) {
        return web.isElementPresent(By.xpath(String.format(".//*[contains(@class, 'button')][text()='%s']", buttonName)));
    }

    public AdbankWorkRequestSettingsPage clickEdit(){
        web.click(By.cssSelector("[data-dojo-type='common.newProject'] .p"));
        return new AdbankWorkRequestSettingsPage(web);
    }

    public boolean isEditWorkRequestPopUpVisible() {
        return web.isElementVisible(By.cssSelector(".popupWindow [data-dojo-type='adbank.projects.projectEditForm']"));
    }

    public PublishWorkRequestPopup clickPublishButton() {
        web.click(By.cssSelector("[data-dojo-type='adbank.project.projectPublisher'].secondary"));
        return new PublishWorkRequestPopup(this);
    }

    public List<String> getActivityList() {
        List<String> activities = new ArrayList<>();
        for (WebElement activityContainer : web.findElements(getActivitiesLocatorCss())) {
            activities.add(activityContainer.getText().replaceAll("\n", " "));
        }

        return activities;
    }

    private By getActivitiesLocatorCss() {
        return By.cssSelector(".unit.size5of6");
    }

    public void setEmailNotificationOnWRLevel(String fieldName, String state){
        String locator = "//div[@ng-repeat='userSubscription in userSubscriptions']";
        web.click(By.xpath("//span[contains(@id, 'adbank_shared_selectProjectSubscriptions_')][.='Subscribe']"));
        if(web.isElementVisible(By.xpath(locator))){
           web.scrollToElement(web.findElement(By.xpath(String.format(locator.concat("/div[.='%s']"),fieldName))));
           notification = new Select(web.findElement(By.xpath(String.format(locator.concat("/div[.='%s']/..//select"),fieldName))));
           notification.selectByVisibleText(state);
           web.sleep(500);
           web.click(By.xpath("//button[@ng-click='save()']"));
        }
    }

    public boolean isLinkDisplayedByLinktext(String link) {
        web.sleep(1000);
        return web.isElementPresent(By.linkText(link)) && web.isElementVisible(By.linkText(link));
    }

    public AdbankTemplateFromProjectCreatePage clickCreateTemplateFromProject() {
        web.click(By.cssSelector("[data-dojo-type='common.newTemplate'] .p"));
        web.waitUntilElementAppearVisible(By.cssSelector(".projects_action_form_popup"));
        return new AdbankTemplateFromProjectCreatePage(web);
    }

    public void clickDeleteProjectLink() {
        web.click(By.linkText("Delete project"));
    }


}