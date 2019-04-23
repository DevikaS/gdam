package com.adstream.automate.babylon.sut.pages.adcost;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebElement;

/**
 * Created by Raja.Gone on 16/05/2017.
 */
public class AdCostsUsageBuyoutDetailsPage extends BaseAdCostPage<AdCostsUsageBuyoutDetailsPage> {

    private String usageBuyOutParentLocator = "//cost-usage-buyout";
    By usageBuyoutDetailsPageLocator = By.xpath(getUsageBuyOutParentLocator());

    public String getUsageBuyOutParentLocator() {
        return usageBuyOutParentLocator;
    }

    public AdCostsUsageBuyoutDetailsPage(ExtendedWebDriver web) {
        super(web);
        closeWakeMePopUp();
    }

    public boolean waitUntilUsageBuyoutDetailsPageVisible() {
        return web.isElementVisible(usageBuyoutDetailsPageLocator);
    }

    public void waitUntilAllFeildsLoads() {
        final long timeOut = 500;
        final long globalTimeout = 5 * 60 * 1000; // 5 mins
        By fieldsLocator = By.xpath("//form[@name='usageBuyoutForm']");
        long start = System.currentTimeMillis();
        do {
            Common.sleep(timeOut * 1);
        } while (!web.isElementVisible(fieldsLocator) && System.currentTimeMillis() - start < globalTimeout);
        if (System.currentTimeMillis() - start > globalTimeout)
            throw new TimeoutException("Check if fields section loaded on Usage/Buyout details page!!");
        web.click(By.xpath("//h3"));
    }

    private String textFieldLocatorFormat = "//input[contains(@id,'input')][@placeholder='%s']";
    private String comboBoxLocatorFormat = "//*[@placeholder='%s'] [@role='combobox'][@name='autocomplete']";
    private String comboBoxLocatorFormat1 = "//*[@placeholder='%s'] [@role='combobox']";
    private String comboBoxMultiSelectLocatorFormat = "//ads-md-multiselect[contains(@placeholder,'%s')]//div/ul/li/input";
    private String radioButtonsFieldLocatorFormat = "//legend[contains(text(),\"%s\")]";
    private String listBoxFormat = "//*[contains(@placeholder,'%s')][@role='listbox']";
    private String listBoxValueFormat = "//md-content[@class='_md']/div/md-option/div";
    private String comboBoxValueFormat = "//li[@role=\"option\"]";
    private String multipleComboBoxValueFormat = "//li[@role='option']//span";
    private String checkBoxFormat="//md-checkbox//span[.='%s']";


    private String datePickerFormat = "//ads-md-datepicker[@placeholder=\"%s\"]//span[@code=\"calendar\"]";


    public void fillFieldByName(String fieldName, String fieldValues) {
        By textFieldLocator = By.xpath(String.format(usageBuyOutParentLocator + textFieldLocatorFormat, fieldName));
        By comboBoxLocator = By.xpath(String.format(usageBuyOutParentLocator + comboBoxLocatorFormat, fieldName));
        By comboBoxMultiSelectLocator = By.xpath(String.format(usageBuyOutParentLocator + comboBoxMultiSelectLocatorFormat, fieldName));
        By listBoxLocator = By.xpath(String.format(usageBuyOutParentLocator + listBoxFormat, fieldName));
        By radioButtonsFieldLocator = By.xpath(String.format(usageBuyOutParentLocator + radioButtonsFieldLocatorFormat, fieldName));
        By buttonToClickLocator = By.xpath(String.format(usageBuyOutParentLocator + buttonNameFormat, fieldName));
        By datePickerLocator = By.xpath(String.format(usageBuyOutParentLocator + datePickerFormat, fieldName));
        By dateFieldLocator =  By.xpath(String.format("//*[@class='ads-md-datepicker']//input[@placeholder='%s']", fieldName));
        By checkBoxLocator = By.xpath(String.format(checkBoxFormat,fieldName));


        for (String fieldValue : fieldValues.split(";")) {
            if (web.isElementPresent(datePickerLocator)) {
                web.click(datePickerLocator);
                web.typeClean(dateFieldLocator, fieldValue);
                web.click(By.xpath(String.format("//*[@class='ads-md-datepicker']//ads-md-input[@placeholder='%s']/../../following-sibling::div//span[.='Done']",fieldName)));
                web.sleep(1000);
            } else if (web.isElementPresent(radioButtonsFieldLocator)) {
                web.click(By.xpath(String.format(usageBuyOutParentLocator + "//md-radio-button[@value='%s']", fieldValue)));
            } else if (web.isElementPresent(listBoxLocator)) {
                scrollToFieldName(web.findElement(listBoxLocator));
                web.click(listBoxLocator);
                web.sleep(500);
                for (WebElement element : web.findElements(By.xpath(listBoxValueFormat))) {
                    if (element.getText().equalsIgnoreCase(fieldValue)) {
                        element.click();
                        break;
                    }
                }
            } else if (web.isElementPresent(comboBoxLocator)) {
                web.typeClean(comboBoxLocator, fieldValue);
                web.click(comboBoxLocator);
                web.click(usageBuyoutDetailsPageLocator);
            } else if (web.isElementPresent(comboBoxMultiSelectLocator)) {
                WebElement ele = getDriver().findElement(comboBoxMultiSelectLocator);
                ele.click();
                Common.sleep(500);
                ele.sendKeys(fieldValue);
                for (WebElement element : web.findElements(By.xpath(multipleComboBoxValueFormat))) {
                    if (element.getText().equalsIgnoreCase(fieldValue)) {
                        web.scrollToElement(element);
                        element.click();
                        web.click(usageBuyoutDetailsPageLocator);
                        break;
                    }
                }
            } else if (web.isElementPresent(textFieldLocator)) {
                scrollToFieldName(web.findElement(textFieldLocator));
                web.typeClean(textFieldLocator,fieldValue);
            } else if (web.isElementPresent(buttonToClickLocator)) {
                web.click(buttonToClickLocator);
            } else if (web.isElementPresent(checkBoxLocator)) {
                boolean scenarioState = fieldValue.equalsIgnoreCase("Check");
                WebElement elemt = web.findElement(By.xpath(String.format(checkBoxFormat, fieldName).concat("/../../..")));
                boolean actualStateOnUI= elemt.getAttribute("aria-checked").equalsIgnoreCase("true");
                if(scenarioState!=actualStateOnUI) {
                    elemt.findElement(By.xpath("//div[@class='md-container md-ink-ripple']")).click();
                }
            } else {
                throw new IllegalArgumentException(String.format("Unknown field name '%s'", fieldName));
            }
        }
    }

    public boolean verifyValuesForFieldsOnFormPage(String fieldName, String fieldValue) {
        By comboBoxLocator = By.xpath(String.format(usageBuyOutParentLocator + comboBoxLocatorFormat, fieldName));
        By comboBoxLocator1 = By.xpath(String.format(usageBuyOutParentLocator + comboBoxLocatorFormat1, fieldName));
        By listBoxLocator = By.xpath(String.format(usageBuyOutParentLocator+listBoxFormat, fieldName));
        String comboBoxFormat = "//ul[@class='md-autocomplete-suggestions']//li";
//        String comboBoxValueFormat = "//li[@role=\"option\"]";

        if (web.isElementPresent(comboBoxLocator)) {
            web.findElement(comboBoxLocator).clear();
            web.findElement(comboBoxLocator).sendKeys(fieldValue);
            Common.sleep(500);
            if (!web.isElementVisible(By.xpath(comboBoxFormat)))
                web.findElement(comboBoxLocator).click();
                if (web.findElement(By.xpath(comboBoxFormat)).getText().equalsIgnoreCase(fieldValue))
                    return true;
        }
        else if (web.isElementPresent(listBoxLocator)) {
            scrollToFieldName(web.findElement(listBoxLocator));
            web.click(listBoxLocator);
            for (WebElement element : web.findElements(By.xpath(listBoxValueFormat))) {
                if (element.getText().equalsIgnoreCase(fieldValue)) {
                    return true;
                }
            }
        }else if (web.isElementPresent(comboBoxLocator1)) {
            web.findElement(comboBoxLocator1).clear();
            web.findElement(comboBoxLocator1).sendKeys(fieldValue);
            Common.sleep(500);
            if (!web.isElementVisible(By.xpath(comboBoxValueFormat)))
                web.findElement(comboBoxLocator).click();
            if (web.findElement(By.xpath(comboBoxValueFormat)).getText().equalsIgnoreCase(fieldValue))
                return true;
        }
        return false;
    }

    public boolean isFieldDisabled(String fieldName, String attributeValue){
        By datePickerLocator = By.xpath(String.format(usageBuyOutParentLocator + "//ads-md-datepicker//input[@placeholder='%s']", fieldName));
        By textFieldLocator = By.xpath(String.format(usageBuyOutParentLocator + textFieldLocatorFormat, fieldName));

        if (web.isElementPresent(datePickerLocator)) {
            if(attributeValue.equalsIgnoreCase("disabled"))
                attributeValue="true";
            else attributeValue="false";
            return web.findElement(datePickerLocator).getAttribute("disabled").equalsIgnoreCase(attributeValue);
        }
        else if (web.isElementPresent(textFieldLocator))
            return web.findElement(textFieldLocator).getAttribute("class").contains(attributeValue);
        return false;
    }
}
