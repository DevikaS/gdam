package com.adstream.automate.babylon.sut.pages.adcost;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.*;

import java.awt.*;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.DataFlavor;

/**
 * Created by Raja.Gone on 21/04/2017.
 */
public class AdCostsDetailsPage extends BaseAdCostPage<AdCostsDetailsPage> {

    //    private String textFieldLocatorFormat = "//*[@id='input'][@placeholder='%s']";
    private String textFieldLocatorFormat = "//*[@label='%s']//input[@id='input']";
    private String textInpuFieldLocatorFormat = "//input[@placeholder='%s'][@id='$ctrl.inputId']";
    private String comboBoxLocatorFormat = "//*[contains(@placeholder,'%s')] [@role='combobox'][@name='autocomplete']";
    private String comboBoxMultiSelectLocatorFormat = "//*[contains(@placeholder,'%s')]//*[contains(@name,'multiselect')]//input";
    private String radioButtonsFieldLocatorFormat = "//ads-md-radio-button";
    private String listBoxFormat = "//*[contains(@placeholder,'%s')][@role='listbox']";
    private String listBoxValueFormat = "//md-content[@class='_md']/div/md-option/div";
    private String comboBoxValueFormat = "//ul[@class='md-autocomplete-suggestions']//li";
    private String multiComboBoxValueFormat = "//li[@role=\"option\"]/div/span[contains(text(), '%s')]";
    private String agencyProducerBoxValueFormat = " //*[@class='select2-result-label ui-select-choices-row-inner']//span[contains(text(), '%s')]";
    private String costDetailsParentLocator = "//cost-details-editable";
    By costDetailsPageLocator = By.xpath(costDetailsParentLocator);

    private String agencyCostCreator;
    private String agencyName;
    private String agencyLocation;
    private String projectName;
    private String brand;
    private String sector;
    private String projectNumber;

    public String getCostDetailsParentLocator() {
        return costDetailsParentLocator;
    }

    public AdCostsDetailsPage(ExtendedWebDriver web) {
        super(web);
        closeWakeMePopUp();
    }

    public boolean waitUntilCostDetailsPageVisible() {
        return web.isElementVisible(costDetailsPageLocator);
    }

    public void waitUntilCostDetailsPageDisappears() {
        web.waitUntilElementDisappear(costDetailsPageLocator);
    }

    public void fillFieldByName(String fieldName, String fieldValues) {
        By textFieldLocator = By.xpath(String.format(textFieldLocatorFormat, fieldName));
        By textInputFieldLocator = By.xpath(String.format(textInpuFieldLocatorFormat, fieldName));
        By comboBoxLocator = By.xpath(String.format(comboBoxLocatorFormat, fieldName));
        By comboBoxMultiSelectLocator = By.xpath(String.format(comboBoxMultiSelectLocatorFormat, fieldName));
        By radioButtonsFieldLocator = By.xpath(radioButtonsFieldLocatorFormat);
        By listBoxLocator = By.xpath(String.format(listBoxFormat, fieldName));
        By buttonToClickLocator = By.xpath(String.format(buttonNameFormat, fieldName));

        for (String fieldValue : fieldValues.split(",")) {
            if (web.isElementPresent(listBoxLocator)) {
                web.click(listBoxLocator);
                String locator = generateLocatorForListBoxValues(fieldName);
                web.waitUntilElementAppearVisible(By.xpath(locator));
                for (WebElement element : web.findElements(By.xpath(locator))) {
                    if (element.getText().equalsIgnoreCase(fieldValue)) {
                        web.scrollToElement(element);
                        element.click();
                        break;
                    }
                }
            } else if (web.isElementPresent(comboBoxLocator)) {
                web.findElement(comboBoxLocator).clear();
                web.findElement(comboBoxLocator).sendKeys(fieldValue);
                Common.sleep(2000);
                if (!web.isElementVisible(By.xpath(comboBoxValueFormat)))
                    web.findElement(comboBoxLocator).click();
                for (WebElement element : web.findElements(By.xpath(comboBoxValueFormat))) {
                    if (element.getText().equalsIgnoreCase(fieldValue)) {
                        web.scrollToElement(element);
                        element.click();
                        break;
                    }
                }
            } else if (web.isElementPresent(comboBoxMultiSelectLocator)) {
                WebElement ele = web.findElement(comboBoxMultiSelectLocator);
                ele.click();
                ele.sendKeys(fieldValue);
                Common.sleep(2000);
                web.waitUntilElementAppearVisible(By.xpath(" //*[@class='select2-result-label ui-select-choices-row-inner']"));
                if (web.findElement(By.xpath(String.format(agencyProducerBoxValueFormat, fieldValue))).getText().equalsIgnoreCase(fieldValue)) {
                    web.findElement(By.xpath(String.format(agencyProducerBoxValueFormat, fieldValue))).click();
                    Common.sleep(2000);
                    web.click(costDetailsPageLocator);
                    Common.sleep(1000);
                }
            } else if (web.isElementVisible(textFieldLocator)) {
                web.typeClean(textFieldLocator, fieldValue);
            } else if (web.isElementVisible(textInputFieldLocator)) {
                web.typeClean(textInputFieldLocator, fieldValue);
            } else if (web.isElementPresent(radioButtonsFieldLocator)) {
                WebElement element = web.findElement(radioButtonsFieldLocator);
                element.findElement(By.xpath(String.format("//*[@value='%s']", fieldValue))).click();
            } else if (web.isElementPresent(buttonToClickLocator)) {
                new Button(this, buttonToClickLocator).click();
            } else {
                throw new IllegalArgumentException(String.format("Unknown field name '%s'", fieldName));
            }
        }
    }

    private String generateLocatorForListBoxValues(String fieldName) {
        String listBoxValueFormatLocator = listBoxValueFormat;
        String locatorFormat = "//md-content[@class='_md']/div/md-option[@ng-repeat='item in $ctrl.%s']/div";
        switch (fieldName) {
            case "Content Type":
                listBoxValueFormatLocator = String.format(locatorFormat, "contentTypes");
                break;
            case "Production Type":
                listBoxValueFormatLocator = String.format(locatorFormat, "productionTypes");
                break;
            case "Budget Region":
                listBoxValueFormatLocator = String.format(locatorFormat, "regions");
                break;
            case "Organisation":
                listBoxValueFormatLocator = String.format(locatorFormat, "organisations");
                break;
            case "Agency Payment Currency":
                listBoxValueFormatLocator = String.format(locatorFormat, "currencies");
                break;
            case "Approval stage for submission":
                listBoxValueFormatLocator = "//md-content[@class='_md']/div/md-option[@ng-repeat='approvalStage in $ctrl.approvalStages']/div";
                break;
            case "Type":
                listBoxValueFormatLocator = "//md-content[@class='_md']/div/md-option[@ng-repeat='usageType in $ctrl.usageTypes']/div";
                break;
            case "Usage/Buyout/Contract":
                listBoxValueFormatLocator = "//md-content[@class='_md']/div/md-option[@ng-repeat='usage in $ctrl.usageBuyoutTypes']/div";
                break;
        }
        return listBoxValueFormatLocator;
    }

    public String getDefaultAgencyCurrency(String fieldName) {
        return web.findElement(By.xpath(String.format(listBoxFormat, fieldName))).getText();
    }

    public boolean isAIPESectionVisible() {
        return web.isElementVisible(By.xpath("//fieldset[contains(@class, 'flex-')]"));
    }

    public String getFieldValueInCostDetailsSection(String fieldName) {
        String filedLocator;
        if (fieldName.equalsIgnoreCase("Project Number"))
            filedLocator = "//ads-md-autocomplete[@id='cd-project-number-select']//input";
        else
            filedLocator = String.format("//ads-md-input[@label='%s']//input[@id='input']", fieldName);
        By byFormat = By.xpath(filedLocator);
        String fieldValue = web.findElement(byFormat).getAttribute("value").trim();
        switch (fieldName) {
            case "Agency Cost Creator":
                agencyCostCreator = fieldValue;
                break;
            case "Agency Name":
                agencyName = fieldValue;
                break;
            case "Agency Location":
                agencyLocation = fieldValue;
                break;
            case "Project Name":
                projectName = fieldValue;
                break;
            case "Brand":
                brand = fieldValue;
                break;
            case "Sector":
                sector = fieldValue;
                break;
            case "Project Number":
                projectNumber = fieldValue;
                break;
            default:
                throw new IllegalArgumentException("Unknown fieldName: " + fieldName);
        }
        return fieldValue;
    }

    public boolean verifyCurrencyFieldIsEditable() {
        if (web.findElement(By.xpath("//md-content//md-select[@placeholder='Agency Payment Currency']")).getAttribute("aria-disabled").equals("false"))
            return true;
        return false;
    }

    public boolean verifyFieldsAreEditableOnCostDetailPage(String fieldName) {
        By locator = By.xpath(String.format("//md-content//input[@placeholder='%s'][@disabled='disabled']", fieldName));
        if (web.isElementPresent(locator))
            return false;
        return true;
    }

    public boolean checkProjectIdOnCostDetailPage(String fieldName, String projectNumber) {
        By comboBoxLocator = By.xpath(String.format(comboBoxLocatorFormat, fieldName));
        boolean itemFound = false;
        if (web.isElementPresent(comboBoxLocator)) {
            web.findElement(comboBoxLocator).clear();
            web.findElement(comboBoxLocator).sendKeys(projectNumber);
            Common.sleep(2000);
            if (!web.isElementVisible(By.xpath(comboBoxValueFormat)))
                web.findElement(comboBoxLocator).click();
            for (WebElement element : web.findElements(By.xpath(comboBoxValueFormat))) {
                if (element.getText().equalsIgnoreCase(projectNumber)){
                    itemFound = true;
                    break;
                }
            }
        }
        return itemFound;
    }

    public void checkBrandAutoPopulatedAfterFillingProject(String projectNumber) {
        By comboBoxLocator = By.xpath(String.format(comboBoxLocatorFormat, "Project#"));
        if (web.findElement(By.xpath(String.format(textFieldLocatorFormat, "Brand"))).getAttribute("value").isEmpty()) {
            web.findElement(comboBoxLocator).click();
        }
    }
}
