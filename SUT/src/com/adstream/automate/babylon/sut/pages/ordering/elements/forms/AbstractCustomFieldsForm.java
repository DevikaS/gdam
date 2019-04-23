package com.adstream.automate.babylon.sut.pages.ordering.elements.forms;

import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.page.controls.*;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import java.util.List;

/*
 * Created by demidovskiy-r on 26.12.2014.
 */
public abstract class AbstractCustomFieldsForm extends AbstractForm {
    protected Button autoCodeBtn;

    public AbstractCustomFieldsForm(BasePage parent) {
        super(parent);
    }

    public void fillFieldByName(String fieldName, String value) {
        if (getDriver().isElementPresent(getAutoSuggestFieldLocator(fieldName)))
            fillAutoSuggestField(fieldName, value);
        else if (getDriver().isElementPresent(getDateBoxFieldLocator(fieldName)))
            fillDateBoxField(fieldName, value);
        else if (getDriver().isElementPresent(getComboBoxFieldLocator(fieldName)))
            fillComboboxField(fieldName, value);
        else if (getDriver().isElementPresent(getRadioButtonFieldLocator(fieldName)))
            fillRadioButtonsField(fieldName, value);
        else if (getDriver().isElementPresent(getMultilineFieldLocator(fieldName)))
            fillMultilineField(fieldName, value);
        else if (getDriver().isElementPresent(getAddressSchemaLocator(fieldName)))
            fillAddressField(fieldName, value);
        else if (getDriver().isElementPresent(getTextFieldLocator(fieldName)))
            fillTextField(fieldName, value);
        else if (getDriver().isElementPresent(getHyperlinkFieldLocator(fieldName)))
            fillHyperlinkField(fieldName, value);
        else if (getDriver().isElementPresent(getPhoneFieldLocator(fieldName)))
            fillPhoneField(fieldName, value);
        else {
            String message = String.format("Field '%s' is not present on Additional Information section!", fieldName);
            throw new IllegalArgumentException(message);
        }
    }

    public boolean isCustomFieldVisible(String fieldName) {
        return getDriver().isElementVisible(getAutoSuggestFieldLocator(fieldName)) ||
                getDriver().isElementVisible(getDateBoxFieldLocator(fieldName)) ||
                getDriver().isElementVisible(getComboBoxFieldLocator(fieldName)) ||
                getDriver().isElementVisible(getRadioButtonFieldLocator(fieldName)) ||
                getDriver().isElementVisible(getMultilineFieldLocator(fieldName)) ||
                getDriver().isElementVisible(getAddressSchemaLocator(fieldName)) ||
                getDriver().isElementVisible(getTextFieldLocator(fieldName)) ||
                getDriver().isElementVisible(getHyperlinkFieldLocator(fieldName)) ||
                getDriver().isElementVisible(getPhoneFieldLocator(fieldName));
    }

    public boolean isCustomFieldDisabled(String fieldName) {
        return new Edit(parent, getTextFieldLocator(fieldName)).disabled(5);
    }


    public String getFieldValueByName(String fieldName) {
        if (getDriver().isElementPresent(getAutoSuggestFieldLocator(fieldName)))
            return getDriver().findElement(getAutoSuggestFieldLocator(fieldName)).getText().replaceAll("[^a-z0-9]", " ").replaceAll("   ", " ").trim();
        else if (getDriver().isElementPresent(getDateBoxFieldLocator(fieldName)))
            return new DojoCombo(parent, getDateBoxFieldLocator(fieldName)).getDisplayedValue();
        else if (getDriver().isElementPresent(getComboBoxFieldLocator(fieldName)))
            return new DojoCombo(parent, getComboBoxFieldLocator(fieldName)).getDisplayedValue();
        else if (getDriver().isElementPresent(getRadioButtonFieldLocator(fieldName)))
            return getSelectedRadioButtons();
        else if (getDriver().isElementPresent(getMultilineFieldLocator(fieldName)))
            return new Edit(parent, getMultilineFieldLocator(fieldName)).getText();
        else if (getDriver().isElementPresent(getAddressSchemaLocator(fieldName)))
            return getAddressValues(fieldName);
        else if (getDriver().isElementPresent(getTextFieldLocator(fieldName)))
            return new Edit(parent, getTextFieldLocator(fieldName)).getValue();
        else if (getDriver().isElementPresent(getHyperlinkFieldLocator(fieldName)))
            return new Edit(parent, getHyperlinkFieldLocator(fieldName)).getValue();
        else if (getDriver().isElementPresent(getPhoneFieldLocator(fieldName)))
            return new Edit(parent, getPhoneFieldLocator(fieldName)).getValue();
        else
            throw new IllegalArgumentException("Unknown field: " + fieldName);
    }

    protected void clickAutoCodeBtn() {
        autoCodeBtn.click();
    }

    protected By generateElementLocatorByDataRole(String partialLocator) {
        return By.cssSelector(getRootNode() + " [data-role='" + partialLocator + "']");
    }

    private void fillAutoSuggestField(String fieldName, String values) {
        DojoAutoSuggest autoSuggest = new DojoAutoSuggest(parent, getAutoSuggestFieldLocator(fieldName));
        autoSuggest.clear();
        for (String value : values.split(",")) {
            if (autoSuggest.getAvailableItems().contains(value))
                autoSuggest.selectByVisibleText(value);
            else
                autoSuggest.selectItemOnFly(value);
        }
    }

    private void fillDateBoxField(String fieldName, String value) {
        DojoDateTextBox airDate = new DojoDateTextBox(parent, getDateBoxFieldLocator(fieldName));
        airDate.setDisplayedValue(value);
        airDate.slotChange();
    }

    private void fillComboboxField(String fieldName, String value) {
        DojoCombo combobox = new DojoCombo(parent, getComboBoxFieldLocator(fieldName));
        if (combobox.getValues().contains(value))
            combobox.selectByVisibleText(value);
        else
            combobox.selectValueOnFly(value);
    }

    private void fillRadioButtonsField(String fieldName, String value) {
        WebElement element = getDriver().findElement(getRadioButtonFieldLocator(fieldName));
        element.findElement(By.xpath(String.format(".//*[normalize-space(@value)=normalize-space('%s')]", value))).click();
    }

    private void fillMultilineField(String fieldName, String value) {
        new Edit(parent, getMultilineFieldLocator(fieldName)).type(value);
    }

    private void fillAddressField(String fieldName, String value) {
        String[] address = value.split(",");
        new Edit(parent, getAddressFieldsLocator(fieldName, "addressLine1")).type(address[0]);
        new Edit(parent, getAddressFieldsLocator(fieldName, "city")).type(address[1]);
        new Edit(parent, getAddressFieldsLocator(fieldName, "province")).type(address[2]);
        new Edit(parent, getAddressFieldsLocator(fieldName, "postCode")).type(address[3]);
        new DojoCombo(parent, getAddressCountryComboBoxLocator(fieldName)).selectByVisibleText(address[4]);
    }

    private void fillTextField(String fieldName, String value) {
        new Edit(parent, getTextFieldLocator(fieldName)).type(value);
    }

    private void fillHyperlinkField(String fieldName, String value) {
        new Edit(parent, getHyperlinkFieldLocator(fieldName)).type(value);
    }

    private void fillPhoneField(String fieldName, String value) {
        new Edit(parent, getPhoneFieldLocator(fieldName)).type(value);
    }

    private String getAddressValues(String fieldName) {
        return new Edit(parent, getAddressFieldsLocator(fieldName, "addressLine1")).getValue() + "," +
                new Edit(parent, getAddressFieldsLocator(fieldName, "city")).getValue() + "," +
                new Edit(parent, getAddressFieldsLocator(fieldName, "province")).getValue() + "," +
                new Edit(parent, getAddressFieldsLocator(fieldName, "postCode")).getValue() + "," +
                new DojoCombo(parent, getAddressCountryComboBoxLocator(fieldName)).getDisplayedValue();
    }

    private String getSelectedRadioButtons() {
        List<WebElement> elements = getDriver().findElements(By.cssSelector("[type='radio']"));
        for (WebElement e : elements) {
            Select select = new Select(parent, e);
            if (select.isSelected())
                return select.getValue();
        }
        return "";
    }

    private By getAddressSchemaLocator(String fieldName) {
        return By.xpath(String.format("//*[contains(@class,'schema_field')]//ancestor::div[@class='schema_field']/*[.='%s']", fieldName));
    }

    private By getAddressFieldsLocator(String titleOfSection, String fieldName) {
        return By.xpath(String.format("//*[contains(@class,'schema_field')]//*[.='%s']/ancestor::div[@class='schema_field']//*[contains(@name,'%s')]", titleOfSection, fieldName));
    }

    private By getAddressCountryComboBoxLocator(String titleOfSection) {
        return By.xpath(String.format("//*[contains(@class,'schema_field')]//*[.='%s']/ancestor::div[@class='schema_field']//*[@role='combobox']", titleOfSection));
    }

    private By getHyperlinkFieldLocator(String fieldName) {
        return By.xpath(String.format("//*[contains(@data-schema-path,'%s')]//*[contains(@name,'linkUrl')]", prepareFieldName(fieldName)));
    }

    private By getComboBoxFieldLocator(String fieldName) {
        return By.xpath(String.format("//*[contains(@class,'schemaDataField')][.//label[normalize-space()=normalize-space('%s')]]//*[@role='combobox']", fieldName));
    }

    private By getRadioButtonFieldLocator(String fieldName) {
        return By.xpath(String.format("//*[@data-dojo-type='common.prop_schema.radioButtons'][label[normalize-space()=normalize-space('%s')]]", fieldName));
    }

    private By getAutoSuggestFieldLocator(String fieldName) {
        return By.xpath(String.format("//*[contains(@class,'schemaDataField')][.//label[normalize-space()=normalize-space('%s')]]//*[@role='autosuggest']", fieldName));
    }

    private By getPhoneFieldLocator(String fieldName) {
        return By.xpath(String.format("//*[contains(@data-schema-path,'%s')]//*[contains(@class,'phoneField ')]/input", prepareFieldName(fieldName)));
    }

    private By getTextFieldLocator(String fieldName) {
        return By.xpath(String.format("//*[contains(@class,'schema_field')]//*[.='%s']/following-sibling::input", fieldName));
    }

    private By getMultilineFieldLocator(String fieldName) {
        return By.xpath(String.format("//*[contains(@class,'schema_field')]//*[.='%s']/following-sibling::*/textarea", fieldName));
    }

    private By getDateBoxFieldLocator(String fieldName) {
        //return By.xpath(String.format("//*[contains(@class,'schema_field')]//*/*[.='%s']/following-sibling::*/*[@role='combobox'][contains(@id,'Date')]", fieldName));
        return By.xpath(String.format("//*[contains(@class,'schema_field')]//*/*[.='%s']/following-sibling::*[@role='combobox'][contains(@id,'Date')]", fieldName));
    }

    private String prepareFieldName(String fieldName) {
        return fieldName.replaceAll("-", "")
                        .replaceAll(" ", "");
    }
}