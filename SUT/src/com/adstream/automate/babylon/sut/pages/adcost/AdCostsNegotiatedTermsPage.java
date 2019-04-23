package com.adstream.automate.babylon.sut.pages.adcost;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

/**
 * Created by Raja.Gone on 17/05/2017.
 */
public class AdCostsNegotiatedTermsPage extends BaseAdCostPage<AdCostsNegotiatedTermsPage> {

    private String negotiatedTermsParentLocator = "//cost-negotiated-terms";
    By negotiatedTermsPageLocator = By.xpath(getnegotiatedTermsParentLocator());

    public AdCostsNegotiatedTermsPage(ExtendedWebDriver web) {
        super(web);
        closeWakeMePopUp();
    }

    public boolean waitUntilNegotiatedTermsPageVisible() { return web.isElementVisible(negotiatedTermsPageLocator); }

    public String getnegotiatedTermsParentLocator() { return negotiatedTermsParentLocator; }

    private String textFieldLocatorFormat = "//*[contains(@id,'input')][@placeholder='%s']";
    private String comboBoxLocatorFormat = "//*[@placeholder='%s'] [@role='combobox']";
    private String comboBoxMultiSelectLocatorFormat = "//*[contains(@placeholder,'%s')]//*[contains(@name,'multiselect')]";
    private String radioButtonsFieldLocatorFormat = "//legend[contains(text(),\"%s\")]";
    private String listBoxFormat = "//*[contains(@placeholder,'%s')][@role='listbox']";
    private String listBoxValueFormat = "//md-content[@class='_md']/div/md-option/div";
    private String comboBoxValueFormat = "//li[@role=\"option\"]";
    private String datePickerFormat = "//ads-md-datepicker[@placeholder=\"%s\"]//span[@code=\"calendar\"]";


    public void fillFieldByName(String fieldName, String fieldValues) {
        By textFieldLocator = By.xpath(String.format(negotiatedTermsParentLocator+textFieldLocatorFormat, fieldName));
        By comboBoxLocator = By.xpath(String.format(negotiatedTermsParentLocator+comboBoxLocatorFormat, fieldName));
        By comboBoxMultiSelectLocator = By.xpath(String.format(negotiatedTermsParentLocator+comboBoxMultiSelectLocatorFormat, fieldName));
        By listBoxLocator = By.xpath(String.format(negotiatedTermsParentLocator+listBoxFormat, fieldName));
        By radioButtonsFieldLocator = By.xpath(String.format(negotiatedTermsParentLocator+radioButtonsFieldLocatorFormat, fieldName));
        By buttonToClickLocator = By.xpath(String.format(negotiatedTermsParentLocator+buttonNameFormat, fieldName));
        By datePickerLocator = By.xpath(String.format(negotiatedTermsParentLocator+datePickerFormat, fieldName));
        By dateFieldLocator = By.xpath("//ads-md-calendar[@class=\"ng-scope ng-isolate-scope\"]//input[@placeholder=\"dd/MM/yyyy\"]");


        for (String fieldValue : fieldValues.split(",")) {
            if (web.isElementPresent(datePickerLocator)) {
                web.click(datePickerLocator);
                web.typeClean(dateFieldLocator,fieldValue);
                web.click(By.xpath("//ads-md-calendar[@class=\"ng-scope ng-isolate-scope\"]//button"));
            } else if (web.isElementPresent(radioButtonsFieldLocator)) {
                web.click(By.xpath(String.format(negotiatedTermsParentLocator + "//md-radio-button[@value='%s']", fieldValue)));
            }else  if(web.isElementPresent(listBoxLocator)) {
                web.click(listBoxLocator);
                String locator = generateLocatorForListBoxValues(fieldName);
                for (WebElement element : web.findElements(By.xpath(locator))) {
                    if (element.getText().equalsIgnoreCase(fieldValue)) {
                        element.click();
                        break;
                    }
                }
            } else if (web.isElementPresent(comboBoxLocator)) {
                scrollToFieldName(web.findElement(comboBoxLocator));
                web.typeClean(comboBoxLocator, fieldValue);
                Common.sleep(2000);
                for (WebElement element : web.findElements(By.xpath(comboBoxValueFormat))) {
                    if (element.getText().equalsIgnoreCase(fieldValue)) {
                        element.click();
                        web.click(negotiatedTermsPageLocator);
                        break;
                    }
                }
            }else if (web.isElementPresent(comboBoxMultiSelectLocator)) {
                WebElement ele = getDriver().findElement(comboBoxMultiSelectLocator);
                ele.click();
                ele.sendKeys(fieldValue);
                Common.sleep(2000);
                for (WebElement element : web.findElements(By.xpath(comboBoxValueFormat))) {
                    if (element.getText().equalsIgnoreCase(fieldValue)) {
                        element.click();
                        web.click(negotiatedTermsPageLocator);
                        break;
                    }
                }
            }
            else if (web.isElementPresent(textFieldLocator)) {
                scrollToFieldName(web.findElement(textFieldLocator));
                web.typeClean(textFieldLocator, fieldValue);
            } else if (web.isElementPresent(buttonToClickLocator)) {
                web.click(buttonToClickLocator);
            } else {
                throw new IllegalArgumentException(String.format("Unknown field name '%s'", fieldName));
            }
        }
    }

    private String generateLocatorForListBoxValues(String fieldName){
        String listBoxValueFormatLocator = listBoxValueFormat;
        String locatorFormat = "//md-content[@class='_md']/div/md-option[@ng-repeat='item in costsNegotiatedTermsCtrl.%s']/div";
        switch (fieldName){
            case "Produced Asset":
                listBoxValueFormatLocator = String.format(locatorFormat, "productionAssets");
                break;
            case "Makeup Artist":
                listBoxValueFormatLocator = String.format(locatorFormat, "talentDecisionRights");
                break;
            case "Hair Stylist":
                listBoxValueFormatLocator = String.format(locatorFormat, "talentDecisionRights");
                break;
            case "Nail Artist":
                listBoxValueFormatLocator = String.format(locatorFormat, "talentDecisionRights");
                break;
            case "Wardrobe Artist":
                listBoxValueFormatLocator = String.format(locatorFormat, "talentDecisionRights");
                break;
            case "Celebrity":
                listBoxValueFormatLocator = String.format(locatorFormat, "travelEntourageTravel");
                break;
            case "Manager":
                listBoxValueFormatLocator = String.format(locatorFormat, "travelEntourageTravel");
                break;
            case "Glam Squad":
                listBoxValueFormatLocator = String.format(locatorFormat, "travelEntourageTravel");
                break;
            case "Security":
                listBoxValueFormatLocator = String.format(locatorFormat, "travelEntourageTravel");
                break;
        }
        return listBoxValueFormatLocator;
    }
}
