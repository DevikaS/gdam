package com.adstream.automate.babylon.sut.pages.adbank.projects;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

/**
 * User: ruslan.semerenko
 * Date: 07.05.12 16:53
 */
public class AdbankTemplateOverviewPage extends AdbankTemplateFilesWithFoldersPage {
    private static final String PROJECT_FIELD_LOCATOR = "//*[@class='caption' and normalize-space(text())='%s']/following-sibling::div";
    public AdbankTemplateOverviewPage(ExtendedWebDriver web) {
        super(web);
    }

    public AdbankTemplateSettingsPage clickEdit() {
        web.click(By.xpath("//*[text()='Edit']"));
        web.waitUntilElementAppearVisible(getTemplatesPopUpTitleLocator());
        web.sleep(1000);
        return new AdbankTemplateSettingsPage(web);
    }

    public boolean isEditLinkVisible() {
        return web.isElementPresent(By.xpath("//*[text()='Edit']")) && web.isElementVisible(By.xpath("//*[text()='Edit']"));
    }

    public boolean isEditTemplatePopUpVisible() {
        return web.isElementVisible(getTemplatesPopUpTitleLocator());
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

    public String getProduct() {
        return getProjectFieldValue("Product:");
    }

    public String getSubBrand() {
        return getProjectFieldValue("Sub-brand:");
    }

    public String getBrand() {
        return getProjectFieldValue("Brand:");
    }

    public String getAdministrator() {
        return getProjectFieldValue("Project Owners:");
    }
    /*  there is no jobbumber fo template
    public String getJobNumber() {
        return getProjectFieldValue("Job Number:");
    } */

    public String getLogoSrc() {
        return web.findElement(By.cssSelector(".logo_block > img")).getAttribute("src");
    }

    public byte[] getLogo() {
        return getDataByUrl(getLogoSrc());
    }

    protected String getProjectFieldValue(String fieldName) {
        return web.findElement(By.xpath(String.format(PROJECT_FIELD_LOCATOR, fieldName)))
                .getText().trim();
    }

    public boolean isDeleteTemplateLinkVisible() {
        if (!web.isElementPresent(By.linkText("Delete template"))) return false;
        return web.isElementVisible(By.linkText("Delete template"));
    }

    private By getTemplatesPopUpTitleLocator() {
        return By.cssSelector(".popupWindow:not([style*='display: none'])>.windowHead");
    }

    public void clickTeamtab(){
        web.click(By.xpath("//*[text()='Team']"));
    }

    public void clickDeleteTemplateLink() {
        web.click(By.linkText("Delete template"));
    }

}