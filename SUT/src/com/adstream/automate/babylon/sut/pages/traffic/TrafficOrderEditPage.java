package com.adstream.automate.babylon.sut.pages.traffic;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.PageCreator;
import com.adstream.automate.babylon.sut.pages.traffic.element.MasterArrivedPopup;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.DojoAutoSuggest;
import com.adstream.automate.page.controls.DojoCombo;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by denysb on 30/11/2015.
 */
public class TrafficOrderEditPage extends BaseTrafficPage {

    private static final By isLoaded = By.cssSelector("[data-dojo-type^='ordering.form.manager.App']");
    private static final By holdForApprovalSelector = By.cssSelector("[data-role='holdForApprovalBtn']");
    private static final By heldForApprovalSelector = By.cssSelector(".mts.hold-btn.button.unit-right.unset_on_hold[data-role='releaseDestinationsBtn']");
    private static final By holdForApprovalDeliverySelector = By.cssSelector("[data-role='holdDelivery']");
    private static final By restartDeliverySelector = By.cssSelector("[data-role='restartDelivery']");
    private static final By masterArrivedSelector = By.cssSelector("[id^='ordering_summary_masterArrived']");
    private static final By undoMasterArrivedSelector = By.cssSelector("[id^='ordering_summary_undoMasterArrived']");
    private static final By expandAllInformationSelector = By.xpath("//span[contains(text(),'Add information')]");
    private static final By expandDestinationSectionSelector = By.xpath("//span[contains(text(),'Select Destinations')]");
    private static final By proceedButtonSelector = By.cssSelector("[data-role='proceedButton']");
    private static final By isHoldFodApprovalButtonActive = By.cssSelector(".unset_on_hold");
    private Button holdForApprovalButton;
    private Button heldForApprovalButton;
    private Button holdForApprovalDeliveryButton;
    private Button masterArrivedButton;
    private Button undoMasterArrivedButton;
    private Button proccedButton;
    private Button restartDelivery;

    private String textFieldLocatorFormat = "//*[contains(@class,'schemaDataField')]//label[translate(normalize-space(),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')='%s']//*[contains(@type,'text')]";
    private String multilineFieldLocatorFormat = "//*[contains(@class,'schemaDataField')]//label[.//*[normalize-space()='%s']]//textarea";
    private String comboboxLocatorFormat = "//*[contains(@class,'schema_field')]//label[normalize-space()='%s']/following-sibling::*[@role='combobox']";
    private String dateFieldLocatorFormat = "//*[contains(@class,'schema_field')]//*[normalize-space()='%s']//*[@role='combobox']";
    private String autoSuggestLocatorFormat = "//*[contains(@class,'schema_field')]//label[normalize-space()='%s']/following-sibling::*[@role='autosuggest']";
    private String phoneFieldLocatorFormat = "//*[contains(@class,'schemaDataField')]//*[.//label[normalize-space()='%s']]//*[contains(@data-dojo-type, 'PhoneField')]/input";
    private String radioButtonsFieldLocatorFormat = "//*[@data-dojo-type='common.prop_schema.radioButtons'][label[normalize-space()='%s']]";


    public TrafficOrderEditPage(ExtendedWebDriver web) {
        super(web);
        holdForApprovalButton = new Button(this,holdForApprovalSelector);
        masterArrivedButton = new Button(this,masterArrivedSelector);
        undoMasterArrivedButton = new Button(this,undoMasterArrivedSelector);
        proccedButton = new Button(this,proceedButtonSelector);
        restartDelivery = new Button(this,restartDeliverySelector);
        holdForApprovalDeliveryButton = new Button(this,holdForApprovalDeliverySelector);
        heldForApprovalButton = new Button(this,heldForApprovalSelector);
    }

    @Override
    public void isLoaded(){
        web.isElementVisible(isLoaded);
    }

    public void clickHoldForApprovalButtonOnTrafficOrderEditPage(){
        web.waitUntilElementAppearVisible(holdForApprovalSelector);
        holdForApprovalButton.click();
    }


    public void expandAddInformationSection(){
        web.waitUntilElementAppearVisible(expandAllInformationSelector);
        web.findElement(expandAllInformationSelector).click();
    }

    public void expandDestinationsSection(){
        web.waitUntilElementAppear(expandDestinationSectionSelector);
        web.findElement(expandDestinationSectionSelector).click();}

    public void clickHoldForApprovalDeliveryButtonOnTrafficOrderEditPage(){
        web.waitUntilElementAppear(holdForApprovalDeliverySelector);
        holdForApprovalDeliveryButton.click();
    }

    public void clickRestartDeliveryButtonOnTrafficOrderEditPage(){
     //   web.waitUntilElementAppear(restartDeliverySelector);
        if(web.isElementPresent(restartDeliverySelector)) {
            web.scrollToElement(web.findElement(restartDeliverySelector));
            restartDelivery.click();
        }
    }

    public void clickProceedButton(){
        web.waitUntilElementAppearVisible(proceedButtonSelector);
        proccedButton.click();
    }

    public boolean checkIsHoldForApprovalButtonActive(){
        return web.isElementPresent(isHoldFodApprovalButtonActive);
    }

    public void clickOnMassterArrivedButton(){
        web.waitUntilElementAppearVisible(masterArrivedSelector);
        masterArrivedButton.click();
    }

    public PopUpWindow clickOnUndoMassterArrivedButton(){
        web.waitUntilElementAppearVisible(undoMasterArrivedSelector);
        undoMasterArrivedButton.click();
        return new PopUpWindow(this);
    }

    public List<Map<String,String>> getTrafficOrderFieldsList(String fieldsType) {
        List<Map<String,String>> projectFieldsList = new ArrayList<>();

        By fieldsNamesLocator;

        if (fieldsType.equalsIgnoreCase("required")) {
            fieldsNamesLocator = By.cssSelector("[data-role='schemedContent'] .required_field");
        } else if (fieldsType.equalsIgnoreCase("all")) {
            fieldsNamesLocator = By.cssSelector(".projects_action_form_popup label>div:first-child,.projects_action_form_popup .label");
        } else {
            throw new IllegalArgumentException(String.format("Unknown fields type '%s'", fieldsType));
        }

        for (String fieldName : web.findElementsToStrings(fieldsNamesLocator)) {
            Map<String,String> projectField = new HashMap<>();

            By textFieldLocator = By.xpath(String.format(textFieldLocatorFormat, fieldName.toLowerCase()));
            By multilineFieldLocator = By.xpath(String.format(multilineFieldLocatorFormat, fieldName));
            By comboboxLocator = By.xpath(String.format(comboboxLocatorFormat, fieldName));
            By dateFieldLocator = By.xpath(String.format(dateFieldLocatorFormat, fieldName));
            By autoSuggestLocator = By.xpath(String.format(autoSuggestLocatorFormat, fieldName));
            By phoneFieldLocator = By.xpath(String.format(phoneFieldLocatorFormat, fieldName));
            By radioButtonsFieldLocator = By.xpath(String.format(radioButtonsFieldLocatorFormat, fieldName));

            if (web.isElementPresent(textFieldLocator)) {
                projectField.put(fieldName, web.findElement(textFieldLocator).getAttribute("value"));
            } else if (web.isElementPresent(multilineFieldLocator)) {
                projectField.put(fieldName, web.findElement(multilineFieldLocator).getText().trim());
            } else if (web.isElementPresent(phoneFieldLocator)) {
                projectField.put(fieldName, web.findElement(phoneFieldLocator).getAttribute("value"));
            } else if (web.isElementPresent(radioButtonsFieldLocator)) {
                String fieldValue = "";
                WebElement parentElement = web.findElement(radioButtonsFieldLocator);
                for (WebElement element : parentElement.findElements(By.xpath(".//input")))
                    if (element.isSelected())
                        fieldValue = element.getAttribute("value").trim();

                projectField.put(fieldName, fieldValue);
            } else if (web.isElementPresent(comboboxLocator)) {
            } else if (web.isElementPresent(dateFieldLocator)) {
            }

            projectFieldsList.add(projectField);
        }


        return projectFieldsList;
    }

    public void fillTrafficOrderFieldByName(String fieldName, String fieldValues) {
        By textFieldLocator = By.xpath(String.format(textFieldLocatorFormat, fieldName.toLowerCase()));
        By multilineFieldLocator = By.xpath(String.format(multilineFieldLocatorFormat, fieldName));
        By comboboxLocator = By.xpath(String.format(comboboxLocatorFormat, fieldName));
        By dateFieldLocator = By.xpath(String.format(dateFieldLocatorFormat, fieldName));
        By phoneFieldLocator = By.xpath(String.format(phoneFieldLocatorFormat, fieldName));
        By radioButtonsFieldLocator = By.xpath(String.format(radioButtonsFieldLocatorFormat, fieldName));

        for (String fieldValue : fieldValues.split(",")) {
            if (web.isElementPresent(comboboxLocator))
            {
                DojoCombo combobox = new DojoCombo(this, comboboxLocator);

                if (combobox.getValues().contains(fieldValue)) {
                    combobox.selectByVisibleText(fieldValue);
                } else {
                    combobox.selectValueOnFly(fieldValue);
                }
            }
            else if (web.isElementPresent(dateFieldLocator))
            {
                new DojoCombo(this, dateFieldLocator).selectByVisibleText(fieldValue);
                web.click(dateFieldLocator);
            }

            else if (web.isElementPresent(textFieldLocator)) {
                Common.sleep(1000);
                web.typeClean(textFieldLocator, fieldValue);
            } else if (fieldName.equalsIgnoreCase("IncludeFiles")) {
                if (fieldValue.contains("true")) web.click(By.name("cloneFiles"));
            } else if (web.isElementPresent(multilineFieldLocator)) {
                web.typeClean(multilineFieldLocator, fieldValue);
            } else if (web.isElementPresent(phoneFieldLocator)) {
                web.typeClean(phoneFieldLocator, fieldValue);
            } else if (web.isElementPresent(radioButtonsFieldLocator)) {

            }   else {
                throw new IllegalArgumentException(String.format("Unknown field name '%s'", fieldName));
            }
        }
    }


    public MasterArrivedPopup openMasterArrivedPopUp(){
        clickOnMassterArrivedButton();
        return new MasterArrivedPopup(this);
    }

}
