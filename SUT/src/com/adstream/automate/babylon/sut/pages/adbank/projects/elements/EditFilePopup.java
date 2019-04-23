package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.sut.data.MetadataItem;
import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.ordering.elements.popup.SelectFromExistingFormatsPopUp;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.DojoAutoSuggest;
import com.adstream.automate.page.controls.DojoCombo;
import com.adstream.automate.page.controls.DojoDateTextBox;
import com.adstream.automate.utils.Common;
import org.apache.commons.lang3.StringUtils;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;
import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: lynda-k
 * Date: 02.04.13
 * Time: 09:10
 */
public class EditFilePopup extends PopUpWindow {
    private static final int AVAILABLE_FIELDS = 0;
    private static final int REQUIRED_FIELDS = 1;
    private static final int DISABLED_FIELDS = 2;
    private static final int LOCKED_FIELDS = 3;
    private static final int VALIDATION_ERROR_FIELDS = 4;
    private Button autoCodeBtn;

    public EditFilePopup(Page parentPage) {
        super(parentPage);
        waitUntilEditFilePopUpAppears();
        autoCodeBtn = new Button(parentPage, By.cssSelector("[data-role='adCodeAutoButton']"));
    }

    public List<String> getSectionNames() {
        return web.findElementsToStrings(By.xpath("//*[@class='clearfix']//h5"));
    }

    public List<String> getAvailableFieldNames() {
        return getFieldNames(null, AVAILABLE_FIELDS);
    }

    public List<String> getRequiredFieldNames() {
        return getFieldNames(null, REQUIRED_FIELDS);
    }

    public List<String> getDisabledFieldNames() {
        return getFieldNames(null, DISABLED_FIELDS);
    }

    public List<String> getAvailableFieldNames(String section) {
        return getFieldNames(section, AVAILABLE_FIELDS);
    }

    public List<String> getRequiredFieldNames(String section) {
        return getFieldNames(section, REQUIRED_FIELDS);
    }

    public List<String> getDisabledFieldNames(String section) {
        return getFieldNames(section, DISABLED_FIELDS);
    }

    public String getAutoSuggestFieldValue(String name, String section) {
        DojoAutoSuggest element = new DojoAutoSuggest(parentPage, getAutoSuggestFieldLocator(name, section));

        return StringUtils.join(element.getDisplayedItems(), ",");
    }

    public String getComboboxFieldValue(String name, String section) {
        return new DojoCombo(parentPage, getComboboxFieldLocator(name, section)).getSelectedLabel();
    }

    public String getDateFieldValue(String name, String section) {
        return new DojoCombo(parentPage, getDateFieldLocator(name, section)).getSelectedLabel();
    }

    public String getRadioButtonsFieldValue(String name, String section) {
        WebElement parentElement = web.findElement(getRadioButtonsFieldLocator(name, section));

        for (WebElement element : parentElement.findElements(By.xpath(".//input")))
            if (element.isSelected())
                return element.getAttribute("value").trim();

        return "";
    }

    public String getMultilineFieldValue(String name, String section) {
        return web.findElement(getMultilineFieldLocator(name, section)).getAttribute("value").trim();
    }

    public String getMultilineFieldRowsCount(String name) {
        return web.findElement(getMultilineFieldLocator(name, null)).getAttribute("rows").trim();
    }

    public String getTextFieldValue(String name, String section) {
        return web.findElement(getTextFieldLocator(name, section)).getAttribute("value").trim();
    }

    public List<MetadataItem> getAvailableFieldsInfo() {
        return getFieldsInfo(AVAILABLE_FIELDS);
    }

    public List<MetadataItem> getRequiredFieldsInfo() {
        return getFieldsInfo(REQUIRED_FIELDS);
    }

    public List<MetadataItem> getDisabledFieldsInfo() {
        return getFieldsInfo(DISABLED_FIELDS);
    }

    public List<MetadataItem> getLockedFieldsInfo() {
        return getFieldsInfo(LOCKED_FIELDS);
    }

    public List<MetadataItem> getValidationErrorFieldsInfo() {
        return getFieldsInfo(VALIDATION_ERROR_FIELDS);
    }

    public List<String> getAvailableComboBoxValues(String name, String section) {
        return new DojoCombo(parentPage, getComboboxFieldLocator(name, section)).getValues();
    }
    //NGN-16223-QAA: User can see Collections based on Market code changes starts
    public List<String> getAvailableAutoSuggestBoxValues(String name, String section) {
        return new DojoCombo(parentPage, getAutoSuggestboxFieldLocator(name, section)).getValues();
    }
    //NGN-16223-QAA: User can see Collections based on Market code changes Ends
    public List<String> getAvailableRadioButtonsValues(String name, String section) {
        String format = "%s//*[@data-dojo-type='common.prop_schema.radioButtons'][label[normalize-space()=normalize-space('%s')]]//input";
        return web.findElementsToStrings(By.xpath(String.format(format, getSectionXpathString(section), name)), "value");
    }

    public boolean isErrorAppearsOnField(String fieldName) {
        String fieldXpath = String.format("//*[contains(@data-dojo-type,'radioButtons')][.//*[normalize-space()=normalize-space('%s')]]", fieldName);
        By errorLocator = By.xpath(String.format("%s//*[contains(@class,'error')][contains(normalize-space(),normalize-space('%s'))]", fieldXpath, fieldName));
        return web.isElementPresent(errorLocator) && web.isElementVisible(errorLocator);
    }

    //Todo: should be refactored using helper methods instead of string locator formatting
    public boolean isFieldHaveSize(String fieldName, String fieldSize) {
        if (fieldSize.equalsIgnoreCase("Full Width")) {
            fieldSize = "size1of1";
        } else if (fieldSize.equalsIgnoreCase("Half Width")) {
            fieldSize = "size1of2";
            Character a = fieldName.charAt(fieldName.toCharArray().length - 1 );
            a.compareTo(a);
        } else {
            throw new IllegalArgumentException(String.format("Unexpected field size '%s'", fieldSize));
        }

        By fieldLocator = By.xpath(String.format("//*[@data-role='schemedContent']//*[contains(@class,'%s')][normalize-space()=normalize-space('%s')]", fieldSize, fieldName));

        return web.isElementPresent(fieldLocator);
    }

    public void fillEditFilePopup(List<MetadataItem> fields) {
        for (MetadataItem field : fields)
            fillFieldByName(field.getKey(), field.getValue(), field.getSection());
    }

    public boolean isNextButtonVisible(){
        By locator = getNextButtonLocator();
        return web.isElementPresent(locator) &&  web.findElement(locator).isEnabled();

    }

    public By getNextButtonLocator() {
        return By.cssSelector("[data-role=\"next\"]");
    }

    public void fillAutoSuggestField(String name, String values, String section) {
        DojoAutoSuggest autoSuggest = new DojoAutoSuggest(parentPage, getAutoSuggestFieldLocator(name, section));
        autoSuggest.clear();

        for (String value : values.split(",")) {
            if (autoSuggest.getAvailableItems().contains(value)) {
                autoSuggest.selectByVisibleText(value);
            } else {
                autoSuggest.selectItemOnFly(value);
            }
        }
        Common.sleep(1000);
    }

    public void fillDateBoxField(String name, String value, String section) {
        DojoDateTextBox airDate = new DojoDateTextBox(parentPage, getDateBoxFieldLocator(name, section));
        airDate.setDisplayedValue(value);
        airDate.slotChange();
    }

    public void fillComboboxField(String name, String value, String section) {
        DojoCombo combobox = new DojoCombo(parentPage, getComboboxFieldLocator(name, section));

        if (combobox.getValues().contains(value)) {
            combobox.selectByVisibleText(value);
        } else {
            combobox.selectValueOnFly(value);
        }
    }

    public void fillRadioButtonsField(String name, String value, String section) {
        WebElement element = web.findElement(getRadioButtonsFieldLocator(name, section));
        element.findElement(By.xpath(String.format(".//label[contains(text(), '%s')]/input", value))).click();
    }

    public void fillMultilineField(String name, String value, String section) {
        web.typeClean(getMultilineFieldLocator(name, section), value);
    }

    public void fillTextField(String name, String value, String section) {
        web.typeClean(getTextFieldLocator(name, section), value);
    }

    public void fillLinkUrlField(String name, String value, String section) {
        web.typeClean(getLinkUrlFieldLocator(name, section), value);
    }

    public void fillLinkTextField(String name, String value, String section) {
        web.typeClean(getLinkTextFieldLocator(name, section), value);
    }

    public void fillPhoneField(String name, String value, String section) {
        web.typeClean(getPhoneFieldLocator(name, section), value);
    }

    public void fillFieldByName(String name, String value, String section) {
        if (web.isElementPresent(getAutoSuggestFieldLocator(name, section))) {
            fillAutoSuggestField(name, value, section);
            Common.sleep(1000);
        } else if (web.isElementPresent(getDateBoxFieldLocator(name, section))) {
            fillDateBoxField(name, value, section);
        } else if (web.isElementPresent(getComboboxFieldLocator(name, section))) {
            fillComboboxField(name, value, section);
            Common.sleep(500);
        } else if (web.isElementPresent(getRadioButtonsFieldLocator(name, section))) {
            fillRadioButtonsField(name, value, section);
        } else if (web.isElementPresent(getMultilineFieldLocator(name, section))) {
            fillMultilineField(name, value, section);
        } else if (web.isElementPresent(getTextFieldLocator(name, section))) {
            fillTextField(name, value, section);
        }
         else if (web.isElementPresent(getLinkUrlFieldLocator(name, section)))
        {
            fillLinkUrlField(name, value, section);
            if (web.isElementPresent(getLinkTextFieldLocator(name, section))) fillLinkTextField(name, value, section);
        }
        else if (web.isElementPresent(getPhoneFieldLocator(name, section))) {
            fillPhoneField(name, value, section);
        }
        else if (web.isElementPresent(getTimingFieldLocator(name, section))) {
            fillTimingField(name, value, section);
        }
        else {
            String message = String.format("Field '%s' is not present on Edit File popup", name);
            if (section != null) message += String.format(" in section '%s'", section);
            throw new IllegalArgumentException(message);
        }
    }

    public void save() {
        action.click();
        waitUntilEditFilePopUpDisappears();
    }

    public void clickSaveButton(){
        web.findElement(By.xpath("//button[@name='save']")).click();
    }

    public void cancel() {
        cancel.click();
        waitUntilEditFilePopUpDisappears();
    }

    public void close() {
        close.click();
        waitUntilEditFilePopUpDisappears();
    }

    public void generateAutoCode(final String fieldName, final String section) {
        clickAutoCodeBtn();
        web.waitUntil(new ExpectedCondition<Boolean>() {
            public Boolean apply(WebDriver webDriver) {
                return !webDriver.findElement(getTextFieldLocator(fieldName, section)).getAttribute("value").isEmpty();
            }
        });
    }

    public void clickAutoCodeButton() {
        clickAutoCodeBtn();
    }

    public SelectFromExistingFormatsPopUp getSelectFromExistingFormatsPopUp() {
        if (!web.isElementVisible(By.xpath(SelectFromExistingFormatsPopUp.TITLE_NODE)))
            clickAutoCodeButton();
        return new SelectFromExistingFormatsPopUp((AdbankFilesInfoPage)parentPage, SelectFromExistingFormatsPopUp.TITLE);
    }

    public boolean isAutoCodeBtnActive() {
        return !autoCodeBtn.getAttribute("class").contains("disabled");
    }

    private List<String> getFieldNames(String section, Integer fieldsType) {
        List<String> fieldNames = new ArrayList<String>();
        switch (fieldsType) {
            case AVAILABLE_FIELDS:
                return web.isElementPresent(getFieldNamesLocator(section)) ? web.findElementsToStrings(getFieldNamesLocator(section)) : fieldNames;
            case REQUIRED_FIELDS:
                return web.isElementPresent(getRequiredFieldNamesLocator(section)) ? web.findElementsToStrings(getRequiredFieldNamesLocator(section)) : fieldNames;
            case DISABLED_FIELDS:
                return web.isElementPresent(getDisabledFieldNamesLocator(section)) ? web.findElementsToStrings(getDisabledFieldNamesLocator(section)) : fieldNames;
            case LOCKED_FIELDS:
                return web.isElementPresent(getLockedFieldNamesLocator(section)) ? web.findElementsToStrings(getLockedFieldNamesLocator(section)) : fieldNames;
            case VALIDATION_ERROR_FIELDS:
                return web.isElementPresent(getValidationErrorFieldNamesLocator(section)) ? web.findElementsToStrings(getValidationErrorFieldNamesLocator(section)) : fieldNames;
            default:
                throw new IllegalArgumentException("Unknown field type given");
        }
    }

    private List<MetadataItem> getFieldsInfo(Integer fieldsType) {
        List<MetadataItem> fieldsInfo = new ArrayList<>();

        for (String section : getSectionNames()) {
            List<String> fieldNames = getFieldNames(section, fieldsType);
            if (fieldNames.isEmpty()) continue;
            for (String name : fieldNames) {
                String value;

                if (web.isElementPresent(getAutoSuggestFieldLocator(name, section))) {
                    value = getAutoSuggestFieldValue(name, section);
                } else if (web.isElementPresent(getComboboxFieldLocator(name, section))) {
                    value = getComboboxFieldValue(name, section);
                } else if (web.isElementPresent(getRadioButtonsFieldLocator(name, section))) {
                    value = getRadioButtonsFieldValue(name, section);
                } else if (web.isElementPresent(getMultilineFieldLocator(name, section))) {
                    value = getMultilineFieldValue(name, section);
                } else if (web.isElementPresent(getTextFieldLocator(name, section))) {
                    value = getTextFieldValue(name, section);
                } else if (web.isElementPresent(getDateFieldLocator(name, section))) {
                    value = getDateFieldValue(name, section);
                } else {
                    String message = String.format("Field '%s' is not present on Edit File popup", name);
                    if (section != null) message += String.format(" in section '%s'", section);
                    throw new IllegalArgumentException(message);
                }

                fieldsInfo.add(new MetadataItem(section.isEmpty() ? "default" : section, name, value));
            }
        }

        return fieldsInfo;
    }

    private void clickAutoCodeBtn() {
        autoCodeBtn.click();
    }

    public void clickAutoCodeButtonForCustomCode() {
        clickAutoCodeBtn();
        web.sleep(7000);
    }

    private void waitUntilEditFilePopUpAppears() {
        web.waitUntilElementAppearVisible(getFormLocator());
        web.sleep(1000);
    }

    private void waitUntilEditFilePopUpDisappears() {
        web.waitUntilElementDisappear(getFormLocator());
        web.sleep(1000);
    }

    private By getTextFieldLocator(String name, String section) {
        String format = "%s//*[contains(@class,'schema_field')]//*[text()='%s']/../input";
        return By.xpath(String.format(format, getSectionXpathString(section), name));
    }

    private By getLinkUrlFieldLocator(String name, String section) {
        //String format = "%s//*[contains(@class,'schema_field')]//*[contains(@name,'linkUrl')]";
        String format = "%s//*[contains(@class,'schema_field')]//*[label[normalize-space()=normalize-space('%s')]]//*[contains(@name,'linkUrl')]";
        return By.xpath(String.format(format, getSectionXpathString(section), name));
    }

    private By getLinkTextFieldLocator(String name, String section) {
        String format = "%s//*[contains(@class,'schema_field')][.//*[text()='%s']]//input[contains(@name,'linkUrl')]";
        return By.xpath(String.format(format, getSectionXpathString(section), name));
    }

    private By getPhoneFieldLocator(String name, String section) {
      // String format = "%s//*[contains(@class,'schema_field')]//*[contains(@class,'phoneField ')]/input";
       String format = "%s//*[contains(@class,'schema_field')]//*[label[normalize-space()=normalize-space('%s')]]//*[contains(@class,'phoneField ')]/input";
        return By.xpath(String.format(format, getSectionXpathString(section), name));
    }

    private By getMultilineFieldLocator(String name, String section) {
        String format = "%s//*[contains(@class,'schema_field')]//*[text()='%s']/following-sibling::*/textarea";
        return By.xpath(String.format(format, getSectionXpathString(section), name));
    }

    private By getRadioButtonsFieldLocator(String name, String section) {
        String format = "%s//*[@data-dojo-type='common.prop_schema.radioButtons'][label[normalize-space()=normalize-space('%s')]]";
        return By.xpath(String.format(format, getSectionXpathString(section), name));
    }

    private By getComboboxFieldLocator(String name, String section) {
        String format = "%s//*[contains(@class,'schema_field')]//label[*[text()='%s']]//following-sibling::*[@role='combobox']";
        return By.xpath(String.format(format, getSectionXpathString(section), name));
    }
    //NGN-16223-QAA: User can see Collections based on Market code changes starts
    private By getAutoSuggestboxFieldLocator(String name, String section) {
        String format = "%s//*[contains(@class,'schema_field')]//label[*[text()='%s']]//following-sibling::*[@role='autosuggest']";
        return By.xpath(String.format(format, getSectionXpathString(section), name));
    }
    //NGN-16223-QAA: User can see Collections based on Market code changes Ends
    private By getDateFieldLocator(String name, String section) {
        //String format = "%s//*[contains(@class,'schema_field')]//*[text()='%s']/following-sibling::*//*[@role='combobox']";
        String format = "%s//*[contains(@class,'schema_field')]//*[text()='%s']/following-sibling::*[@role='combobox']";
        return By.xpath(String.format(format, getSectionXpathString(section), name));
    }

    private By getDateBoxFieldLocator(String name, String section) {
       // String format = "%s//*[contains(@class,'schema_field')]//*/*[text()='%s']/following-sibling::*/*[@role='combobox'][contains(@id,'Date')]";
        String format = "%s//*[contains(@class,'schema_field')]//*/*[text()='%s']/following-sibling::*[@role='combobox'][contains(@id,'Date')]";
        return By.xpath(String.format(format, getSectionXpathString(section), name));
    }

    private By getAutoSuggestFieldLocator(String name, String section) {
        String format = "%s//*[contains(@class,'schemaDataField')][./*[@class='schema_field']/label[normalize-space()=normalize-space('%s')]]//*[@role='autosuggest']";
        return By.xpath(String.format(format, getSectionXpathString(section), name));
    }

    private By getFieldNamesLocator(String section) {
        return By.xpath(String.format("%s//*[@data-schema-path]//div[text()][1][not(contains(@class,'error'))][not(contains(@class,'schema_field'))][not(@id)][not(contains(@class,'mbm'))][not(contains(@class,'mvs'))]",
                getSectionXpathString(section))); //added some [not()] blocks to avoid taking wrong elements from market schema
    }

    private By getRequiredFieldNamesLocator(String section) {
        return By.xpath(String.format("%s//label[not(input)]/*[1][contains(@class,'required_field')]", getSectionXpathString(section)));
    }

    private By getDisabledFieldNamesLocator(String section) {
        return By.xpath(String.format("%s//*[contains(@class,'schemaDataField')][.//*[@aria-disabled='true']]//label[not(input)]/*[1]", getSectionXpathString(section)));
    }

    private By getLockedFieldNamesLocator(String section) {
        return By.xpath(String.format("%s//*[contains(@class,'schemaDataField')][.//*[contains(@data-dojo-props,'disabled : true')]]//label/*[1]", getSectionXpathString(section)));
    }

    private By getValidationErrorFieldNamesLocator(String section) {
        return By.xpath(String.format("%s//label/*[1][./following-sibling::*[contains(@class,'error')]]", getSectionXpathString(section)));
    }

    private String getSectionXpathString(String section) {
        if (section == null) {
            return "";
        } else if (section.isEmpty() || section.equalsIgnoreCase("default")) {
            return "//*[@class='clearfix']/*[.//h5[not(text())]]/following-sibling::*[1]";
        } else {
            return String.format("//*[@class='clearfix']/*[.//h5[normalize-space()=normalize-space('%s')]]/following-sibling::*[1]", section);
        }
    }

    private By getFormLocator() {
        return By.xpath("//*[contains(@class,'popupWindow')][.//*[contains(@id,'title') and contains(.,'Edit')]]//*[@data-role='schemedContent']");
    }

    public void fillTimingField(String name, String value, String section) {
        web.typeClean(getTimingFieldLocator(name, section), value);
    }

    private By getTimingFieldLocator(String name, String section) {
        String format = "%s//*[contains(@id,'adbank_files_fileTimingInfoEditForm_0')]//*[text()='%s']/../input";
        return By.xpath(String.format(format, getSectionXpathString(section), name));
    }
}