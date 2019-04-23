package com.adstream.automate.babylon.sut.pages.adbank.projects;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * User: lynda-k
 * Date: 19.07.14
 * Time: 14:43
 */
public class AdbankWorkRequestTemplateOverviewPage extends AdbankWorkRequestFilesWithFoldersPage {
    private static final String WORK_REQUEST_FIELD_LOCATOR = "//*[contains(@class,'caption') and normalize-space()='%s']/following-sibling::*";

    public AdbankWorkRequestTemplateOverviewPage(ExtendedWebDriver web) {
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

    public AdbankWorkRequestTemplateSettingsPage clickEdit(){
        web.click(By.cssSelector("[data-dojo-type='common.newProject'] .p"));
        return new AdbankWorkRequestTemplateSettingsPage(web);
    }

    public boolean isEditWorkRequestTeplatePopUpVisible() {
        return web.isElementVisible(By.cssSelector(".popupWindow [data-dojo-type='adbank.projects.projectEditForm']"));
    }

    public boolean isDeleteTemplateLinkVisible() {
        if (!web.isElementPresent(By.linkText("Delete template"))) return false;
        return web.isElementVisible(By.linkText("Delete template"));
    }

    public void clickDeleteTemplateLink() {
        web.click(By.linkText("Delete template"));
    }
}