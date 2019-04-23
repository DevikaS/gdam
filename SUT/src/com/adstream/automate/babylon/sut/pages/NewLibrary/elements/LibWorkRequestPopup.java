package com.adstream.automate.babylon.sut.pages.NewLibrary.elements;

/**
 * Created by Janaki.Kamat on 27/06/2018.
 */

import com.adstream.automate.page.Page;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;

import java.util.List;

/**
 * Created by Janaki.Kamat on 08/05/2017.
 */
public class LibWorkRequestPopup extends LibPopUpWindow {

    private static final String selectLocator = "//ads-ui-select-dictionary[@placeholder='%s']//span[@code='chevron-fill-small-down']";
    private static final String comboSelector = "//ads-md-autocomplete//input[@placeholder='%s']";
    private static final String textArea = "//textarea[@placeholder='%s']";
    private static final String inputSelectorProjectAdmin = "//ads-md-contact-chips[@label='%s']//input";
    private static final String inputSelector = "//ads-accordion[@description='General']//ads-md-input[@placeholder='%s']//md-input-container//input";
    private static final String dateSelector = "//ads-md-datepicker//ads-md-input//input[@placeholder='%s']";
    private String multilineFieldLocatorFormat = "//ads-md-textarea[@placeholder='%s']//md-input-container//textarea";
    private static final String buttonSelector = "//ads-md-button[@click='$ctrl.submit()']/button";
    private static final String includeFiles = "//ads-md-checkbox[@checked='$ctrl.getIncludeFiles()']/md-checkbox";
    private static final String publishImmediately = "//ads-md-checkbox[@checked='$ctrl.published']/md-checkbox";

    private WebElement selectTemplate;
    private WebElement projectType;
    private WebElement mediaType;
    private WebElement projectStatus;
    private WebElement name;
    private WebElement jobNumber;
    private WebElement startDate;
    private WebElement endDate;

    public LibWorkRequestPopup(Page parent) {
        super(parent, "ads-ui-work-request");
        web.waitUntil(ExpectedConditions.presenceOfElementLocated(generateLocator()));
        initializeFields();
    }

    public void clickSave() {
        Common.sleep(2000);
        web.findElement(By.xpath("//ads-ui-work-request//span[contains(.,'new work request')]")).click();//Before saving, need to be clicked somewhere on the page otherwise save will fail
        web.scrollToElement(web.findElement(By.xpath("//ads-md-button[@click='$ctrl.submit()']/button")));
        web.findElement(By.xpath("//ads-md-button[@click='$ctrl.submit()']/button")).click();

    }

    public List<String> getRequiredFieldsNames() {
        return web.findElementsToStrings(By.xpath("//input[@required='required']"), "placeholder");
    }

    public List<String> getAllFieldsNames() {
        return web.findElementsToStrings(By.xpath("//*[@is-required=\"$ctrl.field.required\"][.//div[contains(@class,\"ads-md-input-required\")]]"), "placeholder");
    }

    public void initializeFields() {
        selectTemplate = web.findElement(generateXpathLocator(String.format(comboSelector, "Select template")));
        projectType = web.findElement(generateXpathLocator(String.format(selectLocator, "Project Type")));
        mediaType = web.findElement(generateXpathLocator(String.format(selectLocator, "Media type")));
        projectStatus = web.findElement(generateXpathLocator(String.format(selectLocator, "Project Status")));
        name = web.findElement(generateXpathLocator(String.format(inputSelector, "Name")));
        jobNumber = web.findElement(generateXpathLocator(String.format(inputSelector, "Job number")));
        startDate = web.findElement(generateXpathLocator(String.format(dateSelector, "Start date")));
        endDate = web.findElement(generateXpathLocator(String.format(inputSelector, "End date")));
    }

    public void fillWorkRequestByName(String fieldName, String fieldValues) {
        for (String fieldValue : fieldValues.split(",")) {
            if (web.isElementPresent(By.xpath(String.format(comboSelector, fieldName)))) {
                WebElement elem = web.findElement(By.xpath(String.format(comboSelector, fieldName)));
                web.scrollToElement(elem);
                elem.click();
                elem.sendKeys(fieldValue);
                web.waitUntilElementAppear(By.xpath("//span[contains(.,'" + fieldValue + "')]"));
                web.findElement(By.xpath("//span[contains(.,'" + fieldValue + "')]")).click();
            }
            else if (web.isElementPresent(By.xpath(String.format(selectLocator, fieldName)))) {
                WebElement elem = web.findElement(By.xpath(String.format(selectLocator, fieldName)));
                web.scrollToElement(elem);
                elem.click();
                elem.sendKeys(fieldValue);
                web.waitUntilElementAppear(By.xpath("//span[contains(.,'" + fieldValue + "')]"));
                web.findElement(By.xpath("//span[contains(.,'" + fieldValue + "')]")).click();
            }
            else if (web.isElementPresent(By.xpath(String.format(inputSelector, fieldName)))) {
                web.typeClean(By.xpath(String.format(inputSelector, fieldName)), fieldValue);

            }
            else if (web.isElementPresent(By.xpath(String.format(dateSelector, fieldName)))) {
                web.typeClean(By.xpath(String.format(dateSelector, fieldName)), fieldValue);

            }
            else if (web.isElementPresent(By.xpath(String.format(textArea, fieldName)))) {
               web.typeClean(By.xpath(String.format(textArea, fieldName)), fieldValue);

            }
            else if (web.isElementPresent(By.xpath(String.format(textArea, fieldName)))) {
                web.typeClean(By.xpath(String.format(textArea, fieldName)), fieldValue);

            }

            else if (web.isElementPresent(By.xpath(String.format(inputSelectorProjectAdmin, fieldName)))) {
                WebElement elem = web.findElement(By.xpath(String.format(inputSelectorProjectAdmin, fieldName)));
                web.scrollToElement(elem);
                elem.click();
                elem.sendKeys(fieldValue);
                web.waitUntilElementAppear(By.xpath("//span[contains(.,'" + fieldValue + "')]"));
                web.findElement(By.xpath("//span[contains(.,'" + fieldValue + "')]")).click();
            }

          else if (fieldName.equalsIgnoreCase("IncludeFiles")) {
                if (fieldValue.contains("true")){
                    web.click(By.xpath(includeFiles));
                }
            }

            else if (fieldName.equalsIgnoreCase("Publish Immediately")) {
                if (fieldValue.contains("true")){
                    web.click(By.xpath(publishImmediately));
                }
            }
              else {
               throw new IllegalArgumentException(String.format("Unknown field name '%s'", fieldName));
            }
        }

    }

    public String verifyMetadataOnWorkRequestAssetPopup(String fieldName)
    {
        String value="";
       if (web.isElementVisible(By.xpath("//ads-ui-sch-field-edit//ads-ui-select-dictionary//div[@title='" + fieldName + "']"))) {
             value= web.findElement(By.xpath("//ads-ui-sch-field-edit//ads-ui-select-dictionary//div[@title='" + fieldName + "']")).getText();
       }
        return value;
    }

}

