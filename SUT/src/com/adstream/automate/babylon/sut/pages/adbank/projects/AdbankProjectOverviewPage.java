package com.adstream.automate.babylon.sut.pages.adbank.projects;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.*;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.DojoCombo;
import org.apache.commons.lang3.time.StopWatch;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * User: ruslan.semerenko
 * Date: 24.04.12 12:35
 */
public class AdbankProjectOverviewPage extends AdbankFilesPage {
    private static final String PROJECT_FIELD_LOCATOR = "//*[contains(@class,'caption') and normalize-space()='%s']/following-sibling::*";

    public AdbankProjectOverviewPage(ExtendedWebDriver web) {
        super(web);
    }

    public String getName() {
        return getProjectFieldValue("Name:");
    }

    public String getAdvertiser() {
        return getProjectFieldValue("Advertiser:");
    }

    public String getCampaign() {
        return getProjectFieldValue("Campaign:");
    }

    public String getMediaType() {
        return getProjectFieldValue("Media type:");
    }

    public String getStartDate() {
        return getProjectFieldValue("Start date:");
    }

    public String getSubBrand() {
        return getProjectFieldValue("Sub-brand:");
    }

    public String getProduct() {
        return getProjectFieldValue("Product:");
    }

    public String getBrand() {
        return getProjectFieldValue("Brand:");
    }

    public String getEndDate() {
        return getProjectFieldValue("End date:");
    }

    public String getAdministrator() {
        return getProjectFieldValue("Project Owners:");
    }

    public String getJobNumber() {
        return getProjectFieldValue("Job number:");
    }

    public String getLogoSrc() {
        return web.findElement(By.cssSelector(".logo_block > img")).getAttribute("src");
    }

    public byte[] getLogo() {
        return getDataByUrl(getLogoSrc());
    }

    public DojoCombo activityTypeBox;

    public void setActivityType(String activityType) {
        activityTypeBox.selectByVisibleText(activityType);
    }

    @Override
    public void init() {
        super.init();
        this.activityTypeBox = new DojoCombo(this, By.xpath("//div[@class='lastUnit']//*[@role='listbox']"));
    }

    public void clickFilterOnActivities() {
        web.click(By.xpath(String.format("//span[contains(@data-role, 'activityFilterButton')]")));
    }

    public void typeFilterUserName(String name) {
        web.typeClean(By.xpath("//*[@data-role='userIdSelect']"), name);
    }

    public String getUserName() {
        String getUsername = web.findElement(By.xpath("//*[@data-role='userIdSelect']")).getAttribute("value");
        return getUsername;
    }

    public String getPublishDate() {
        String getPublishDate = web.findElement(By.cssSelector(".schema_field.trunc-text.project__cm_common_publishDate .value")).getText();
        return getPublishDate;
    }

    public String getPublishDateTimeZone() {
        String getPublishDateTimeZone = web.findElement(By.cssSelector(".schema_field.trunc-text.project__cm_common_publishDateTimezone .value")).getText();
        return getPublishDateTimeZone;
    }

    public String getPublishMessage() {
        String getPublishMessage = web.findElement(By.cssSelector(".schema_field.trunc-text.project__cm_common_publishMessage .value")).getText();
        return getPublishMessage;
    }


    public boolean isPublishDateDisplayed()
    {
       return web.findElement(By.cssSelector(".schema_field.trunc-text.project__cm_common_publishDate .value")).isDisplayed();
    }

    public boolean isPublishDateTimeZoneDisplayed() {
        return web.findElement(By.cssSelector(".schema_field.trunc-text.project__cm_common_publishDateTimezone .value")).isDisplayed();

    }

    public boolean isPublishMessageDisplayed() {
        return web.findElement(By.cssSelector(".schema_field.trunc-text.project__cm_common_publishMessage .value")).isDisplayed();

    }


    protected String getProjectFieldValue(String fieldName) {
        return web.findElement(By.xpath(String.format(PROJECT_FIELD_LOCATOR, fieldName)))
                .getText().trim();
    }

    public void clearFilterUserName() {
        web.findElement(By.xpath("//*[@data-role='userIdSelect']")).clear();
    }

    public List<Map<String, String>> getProjectFieldsList() {
        List<Map<String, String>> projectFieldsList = new ArrayList<Map<String, String>>();

        for (String fieldName : web.findElementsToStrings(By.cssSelector(".schema_field .caption"))) {
            Map<String, String> projectField = new HashMap<String, String>();
            String fieldValue = web.findElement(By.xpath(String.format(PROJECT_FIELD_LOCATOR, fieldName))).getText().trim();
            projectField.put(fieldName.replaceFirst(":$", ""), fieldValue.replaceAll(", +", ","));
            projectFieldsList.add(projectField);
        }

        return projectFieldsList;
    }

    public PublishProjectPopup clickPublishButton() {
        web.click(By.cssSelector("[data-dojo-type='adbank.project.projectPublisher'].secondary"));
        PublishNowOrLaterProjectPopup pp = new PublishNowOrLaterProjectPopup(this);
        pp.clickPublishNowButton();
        return new PublishProjectPopup(this);
    }

    public PublishProjectLaterPopup clickPublishLater()
    {
        web.click(By.cssSelector("[data-dojo-type='adbank.project.projectPublisher'].secondary"));
        PublishNowOrLaterProjectPopup pp = new PublishNowOrLaterProjectPopup(this);
        pp.clickPublishLaterButton();
        return new PublishProjectLaterPopup(this);
    }

    public PopUpWindow clickUnpublishButton() {
        web.click(By.cssSelector("[data-dojo-type='adbank.project.projectPublisher']:not(.secondary)"));
        return new PopUpWindow(this);
    }



    public boolean isPublishUnpublishButtonPresent(String buttonName) {
        return web.isElementPresent(By.xpath(String.format(".//*[contains(@class, 'button')][text()='%s']", buttonName)));
    }

    public AdbankProjectSettingsPage clickEdit() {
        web.click(By.cssSelector("[data-dojo-type='common.newProject'] .p"));
        return new AdbankProjectSettingsPage(web);
    }

    public boolean isEditProjectPopUpVisible() {
        return web.isElementVisible(By.cssSelector(".popupWindow [data-dojo-type='adbank.projects.projectEditForm']"));
    }

    public AdbankTemplateFromProjectCreatePage clickCreateTemplateFromProject() {
        web.click(getCreateTemplateFromProjectLocator());
        web.waitUntilElementAppearVisible(By.cssSelector(".projects_action_form_popup"));
        return new AdbankTemplateFromProjectCreatePage(web);
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

    public int getFilesWithTheSameNameCount(String fileName) {
        return web.findElements(By.cssSelector(".p.no-decoration[title='" + fileName + "']")).size();
    }

    public AdbankFilesCarousel getFilesCarousel() {
        return new AdbankFilesCarousel(web);
    }

    public boolean isCreateTemplateFromProjectLinkVisible() {
        web.sleep(1000);
        return web.isElementVisible(getCreateTemplateFromProjectLocator());
    }

    public String getFileApprovalStatus(String fileName) {
        return web.findElement(By.xpath(String.format("//a[text()='%s']/../../..//*[contains(@class, 'file-ratings')]/..//*[contains(@class, 'icon-status')]", fileName))).getAttribute("title");
    }

    public boolean isTermsAndConditionsLinkVisible() {
        return web.isElementVisible(getTermsAndConditionsLink());
    }

    public boolean isDeleteProjectLinkVisible() {
        return web.isElementPresent(By.linkText("Delete project")) && web.isElementVisible(By.linkText("Delete project"));
    }

    public boolean isFieldHaveSize(String fieldName, String fieldSize) {

        if (fieldSize.equalsIgnoreCase("Full Width")) {
            fieldSize = "size1of1";
        } else if (fieldSize.equalsIgnoreCase("Half Width")) {
            fieldSize = "size1of2";
        } else {
            throw new IllegalArgumentException(String.format("Unexpected field size '%s'", fieldSize));
        }

        By fieldLocator = By.xpath(String.format("//*[@data-role='schemedContent']//*[contains(@class,'%s')][.//*[normalize-space()='%s:']]", fieldSize, fieldName));

        return web.isElementPresent(fieldLocator);
    }

    public void clickFileLinkinActivity(String FileName, String activityText){
        String locator = String.format("//*[@data-type=\'tableRow\'][.//*[contains(text(),\'%s\')]]//a[contains(text(),\'%s\')]", activityText, FileName);
        web.clickThroughJavascript(By.xpath(locator));
    }

    @Override
    public void waitUntilPopUpNotificationMessageDisappeared() {
        super.waitUntilPopUpNotificationMessageDisappeared();
    }

    private By getCreateTemplateFromProjectLocator() {
        return By.cssSelector("[data-dojo-type='common.newTemplate'] .p");
    }

    private By getTermsAndConditionsLink() {
        return By.cssSelector(".projectViewForm [data-dojo-type='adbank.project.termsAndConditions_button']");
    }

    public void clickTeamtab(){
        web.click(By.xpath("//*[text()='Team']"));
    }

    public long getTeamLoadingtime(){
        StopWatch pageLoad = new StopWatch();
        pageLoad.start();
        clickTeamtab();
        web.waitUntil(ExpectedConditions.presenceOfElementLocated(By.xpath("//*[@id='single-button']")));
        pageLoad.stop();
        //Get the time
        Long pageLoadTime_Seconds = pageLoad.getTime() / 1000;
        return pageLoadTime_Seconds;
    }

    public void clickCostsTab(){
        web.click(By.xpath("//div[@class='line plm']//a[.='Costs']"));
    }

    public void clickDeleteProjectLink() {
        web.click(By.linkText("Delete project"));
    }
}
