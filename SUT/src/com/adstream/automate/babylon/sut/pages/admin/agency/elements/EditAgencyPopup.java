package com.adstream.automate.babylon.sut.pages.admin.agency.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.AbstractControl;
import com.adstream.automate.page.DojoControl;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.*;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import java.util.List;

/**
 * User: lynda-k
 * Date: 12.06.14
 * Time: 12:33
 */
public class EditAgencyPopup extends PopUpWindow {

    public EditAgencyPopup(Page parentPage) {
        super(parentPage);
        action = new Button(parentPage, generateLocator(".button[name='save']"));
    }

    private By getNameFieldLocator() {
        return By.name("_cm.common.name");
    }

    private By getDescriptionFieldLocator() {
        return By.name("_cm.common.description");
    }

    private By getPinFieldLocator() {
        return By.name("_cm.common.pin");
    }

    private By getTypeFieldLocator() {
        return generateLocator("[data-schema-path*='_cm.common.agencyType'] [role='combobox']");
    }

    private By getMarketFieldLocator() {
        return generateLocator("[data-schema-path*='_cm.common.market'] [role='combobox']");
    }

    private By getDestinationIdFieldLocator() {
        return generateLocator("[data-schema-path*='_cm.common.destinationID'] .number [id*='NumberTextBox']");
    }

    private By getTimeZoneFieldLocator() {
        return generateLocator("[data-schema-path*='_cm.common.time_zone'] [role='combobox']");
    }

    private By getCountryFieldLocator() {
        return generateLocator("[data-schema-path*='_cm.common.address.country'] [role='combobox']");
    }

    private By getSAPCountryFieldLocator() {
        return generateLocator("[data-schema-path*='_cm.finance.sap.country'] [role='combobox']");
    }

    private By getSAPIdFieldLocator() {
        return By.name("_cm.finance.sap.id");
    }

    private By getEnableSAPEnabledCheckboxLocator() { return By.name("_cm.finance.sap.enabled"); }

    private By getClientCodeFieldLocator() {
        return By.name("_cm.print.clientCode");
    }

    private By getStorageFieldLocator() {
        return generateLocator("[data-schema-path*='_cm.common.storageId'] [role='combobox']");
    }

    private By getIngestLocationFieldLocator() {
        return generateLocator("[data-schema-path*='_cm.common.ingestLocation.id'] [role='combobox']");
    }

    private By getA4AgencyIdFieldLocator() {
        return By.name("_cm.a4.agencyId");
    }

    private By getFooterTextFieldLocator() {
        return By.name("_cm.common.footer-text");
    }

    private By getFooterTextColorFieldLocator() {
        return By.name("_cm.common.footer-text-color");
    }

    private By getFooterColorFieldLocator() {
        return By.name("_cm.common.footer-color");
    }

    private By getA4UserEmailFieldLocator() {
        return By.name("_cm.a4.user");
    }

    private By getBULabelsFieldLocator() {
        return By.name("_cm.common.labels");
    }

    private By getA4UserPasswordFieldLocator() {
        return By.name("_cm.a4.password");
    }

    private By getA4CreateAssetCheckboxLocator() {
        return By.name("_cm.a4.createAssetInA4");
    }

    private By getBrandingColorPreviewElementLocator() {
        return generateLocator("[data-dojo-type='admin.branding.showColorPickerSB']");
    }

    private By getBrandingColorValueFieldLocator() {
        return By.id("BGcurrentValueSB");
    }

    private By getBrandingColorPickerValueFieldLocator() {
        return By.id("colorPickerSB");
    }

    private By getBrandingLinkColorPreviewElementLocator() {
        return generateLocator("[data-dojo-type='admin.branding.showColorPickerTextSB']");
    }

    private By getBrandingLinkColorValueFieldLocator() {
        return By.id("textCurrentValueSB");
    }

    private By getBrandingLinkColorPickerValueFieldLocator() {
        return By.id("colorPickerTextSB");
    }

    private By getAutoacceptSharedCategoriesCheckboxLocator() {
        return By.name("autoaccept");
    }

    private By getPublishProjectOnCreateCheckboxLocator() {
        return By.name("_cm.common.publishProjectOnCreate");
    }

    private By getHideTemplateOnProjectCreateCheckboxLocator() {
        return By.name("_cm.common.hideTemplateFieldInProject");
    }

    private By getAutoacceptorTextFieldLocator() {
        return By.xpath("//b[*[@data-role='user-name']]/following-sibling::*//*[@role='textbox']");
    }

    private By getAutoacceptorComboboxFieldLocator() {
        return By.xpath("//b[*[@data-role='user-name']]/following-sibling::*[@role='combobox']");
    }

    private DojoCombo getDojoComboElement(By locator) {
        return new DojoCombo(parentPage, locator);
    }

    private DojoTextBox getDojoTextBoxElement(By locator) {
        return new DojoTextBox(parentPage, locator);
    }

    private Edit getEditElement(By locator) {
        return new Edit(parentPage, locator);
    }

    private boolean isValidationElementErrorVisible(AbstractControl control) {
        if (control instanceof Edit || control instanceof Checkbox) {
            WebElement controlElement = control.getWebElement();
            if (controlElement.getAttribute("class").contains("ui-input")) {
                return controlElement.getAttribute("class").contains("error");
            } else {
                WebElement rootElement = controlElement.findElement(By.xpath("ancestor::*[@widgetid][1]"));
                return rootElement.getAttribute("class").contains("dijitTextBoxError");
            }
        }
        throw new IllegalArgumentException("Unknown control: " + control);
    }

    private By getAllowExtendDictionariesCheckboxLocator() {
        return generateLocator("[data-role='enrichDictionary']");
    }

    private By getUserSelfRegistersCheckboxLocator() { return By.name("_cm.common.userSelfRegistration"); }

    private By getEnableProjectsModuleCheckboxLocator() { return By.name("_cm.common.applications.folders"); }

    // NGN-16213 - QAA: Global Admin defines Applications available to BU - By Geethanjali- code Starts
    private By getEnableWorkRequestModuleCheckboxLocator() { return By.name("_cm.common.applications.adkits"); }
    private By getEnablePresentationsModuleCheckboxLocator() { return By.name("_cm.common.applications.presentations"); }
    private By getEnableDeliveryModuleCheckboxLocator() { return By.name("_cm.common.applications.ordering"); }
    // NGN-16213 - QAA: Global Admin defines Applications available to BU - By Geethanjali- code Ends

    private By getEnableApprovalsModuleCheckboxLocator() { return By.name("_cm.common.applications.approvals");}
    // NGN-16212 - QAA: Global Admin can Copy BU - By Geethanjali- code starts

    private By getEnableTrafficModuleCheckboxLocator() { return By.name("_cm.common.applications.adpath");}
    private By getEnableIngestModuleCheckboxLocator() { return By.name("_cm.common.applications.ingest");}
    private By getEnableReportingModuleCheckboxxLocator() { return By.name("_cm.common.applications.reporting");}
    private By getEnableDashboardfeatureCheckboxLocator() { return By.name("_cm.common.applications.dashboard");}

    // NGN-16212 - QAA: Global Admin can Copy BU - By Geethanjali- code Ends

    private By getEnableProjectAccessRuleCheckboxLocator() { return By.name("access-rules");}

    private By getEnableAutoCloseApprovalCheckboxLocator() { return By.name("_cm.common.auto_close");}

    private By getMediaSupplierCheckboxLocator() {return By.name("_cm.common.mediaSupplierRequired");}

    private By getDefaultSaveInLibraryCheckboxLocator() {return By.name("_cm.common.saveInLibrary");}

    private By getAllowUserToChangeSaveInLibraryCheckboxLocator() {return By.name("_cm.common.allowUserChangeSaveInLibrary");}

    private By getDefaultValueOfManageConversionFlagCheckboxLocator() {return By.name("_cm.common.defaultMC");}

    private By getAllowUserToChangeManageConversionFlagCheckboxLocator() {return By.name("_cm.common.allowChangeMC");
    }

    private By getAnnotationsModuleCheckboxLocator() {return By.name("_cm.common.applications.annotations");
    }

    private By getEnableFinderStyleProjectView() { return By.cssSelector("[name='_cm.project.finderStyleView']");
    }

    private By getEnableLibraryModuleCheckboxLocator() { return By.name("_cm.common.applications.library"); }

    private By getEnablesTasksModuleCheckboxLocator() { return By.name("_cm.common.applications.tasks"); }

    private String getTextFieldValue(By locator) {
        return web.findElement(locator).getAttribute("value").trim();
    }

    private String getComboboxFieldSelectedValue(By locator) {
        return getDojoComboElement(locator).getSelectedLabel();
    }

    private List<String> getComboBoxFieldValues(By locator) {
        return getDojoComboElement(locator).getValues();
    }

    private List<String> getAutoSuggestFieldValue(By locator) {
        return new DojoAutoSuggest(parentPage, locator).getDisplayedItems();
    }

    private boolean isCheckboxSelected(By locator) {
        return new Checkbox(parentPage, locator).isSelected();
    }

    private void fillTextField(By locator, String value) {
        if (value != null) getEditElement(locator).type(value);
    }

    private void fillCheckboxField(By locator, boolean value) {
        Checkbox checkbox = new Checkbox(parentPage, locator);
        checkbox.setSelected(value);
        Common.sleep(1000);
        if (new Checkbox(parentPage, locator).isSelected() ^ value) {
            checkbox.setSelected(value);
            Common.sleep(1000);
        }
    }


    protected void fillComboboxField(By locator, String value) {
        if (value != null) {
            Common.sleep(2000);
            getDojoComboElement(locator).selectByVisibleText(value);
            Common.sleep(3000);
        }
    }


    private void fillDojoTextBox(By locator, String value) {
        if (value != null) getDojoTextBoxElement(locator).setDisplayedValue(value);
    }

    private void fillAutoSuggestField(By locator, List<String> values) {
        if (values != null) {
            new DojoAutoSuggest(parentPage, locator).clear();
            for (String value : values) new DojoAutoSuggest(parentPage, locator).selectByVisibleText(value);
        }
    }

    public String getNameFieldValue() {
        return getTextFieldValue(getNameFieldLocator());
    }

    public String getDescriptionFieldValue() {
        return getTextFieldValue(getDescriptionFieldLocator());
    }

    public String getPinFieldValue() {
        return getTextFieldValue(getPinFieldLocator());
    }

    public String getTimeZoneFieldValue() {
        return getComboboxFieldSelectedValue(getTimeZoneFieldLocator());
    }

    public String getCountryFieldValue() {
        return getComboboxFieldSelectedValue(getCountryFieldLocator());
    }

    public String getSAPIdFieldValue() {
        return getTextFieldValue(getSAPIdFieldLocator());
    }

    public String getClientCodeFieldValue() {
        return getTextFieldValue(getClientCodeFieldLocator());
    }

    public String getStorageFieldValue() {
        return getComboboxFieldSelectedValue(getStorageFieldLocator());
    }

    public String getIngestLocationFieldValue() {
        return getComboboxFieldSelectedValue(getIngestLocationFieldLocator());
    }

    public String getA4AgencyIdFieldValue() {
        return getTextFieldValue(getA4AgencyIdFieldLocator());
    }

    public String getFooterTextFieldValue() {
        return getTextFieldValue(getFooterTextFieldLocator());
    }

    public String getFooterTextColorFieldValue() {
        return getTextFieldValue(getFooterTextColorFieldLocator());
    }

    public String getFooterColorFieldValue() {
        return getTextFieldValue(getFooterColorFieldLocator());
    }

    public String getA4UserEmailFieldValue() {
        return getTextFieldValue(getA4UserEmailFieldLocator());
    }

    public String getA4UserPasswordFieldValue() {
        return getTextFieldValue(getA4UserPasswordFieldLocator());
    }

    public String getBrandingColorFieldValue() {
        return getTextFieldValue(getBrandingColorValueFieldLocator());
    }

    public String getBrandingLinkColorFieldValue() {
        return getTextFieldValue(getBrandingLinkColorValueFieldLocator());
    }

    public String getAutoacceptorTextFieldValue() {
        return getTextFieldValue(getAutoacceptorTextFieldLocator());
    }

    public String getTypeFieldSelectedValue() {
        return getComboboxFieldSelectedValue(getTypeFieldLocator());
    }

    public List<String> getTypeFieldValues() {
        return getComboBoxFieldValues(getTypeFieldLocator());
    }

    public List<String> getMarketFieldValues() {
        return getComboBoxFieldValues(getMarketFieldLocator());
    }

    public List<String> getBULabelsFieldValue() {
        return getAutoSuggestFieldValue(getBULabelsFieldLocator());
    }

    public boolean isA4CreateAssetCheckboxSelected() {
        return isCheckboxSelected(getA4CreateAssetCheckboxLocator());
    }

    public boolean isAutoacceptSharedCategoriesCheckboxSelected() {
        return isCheckboxSelected(getAutoacceptSharedCategoriesCheckboxLocator());
    }

    public boolean isPublishProjectOnCreateCheckboxSelected() {
        return isCheckboxSelected(getPublishProjectOnCreateCheckboxLocator());
    }

    public boolean isAllowExtendDictionariesCheckboxSelected() {
        return isCheckboxSelected(getAllowExtendDictionariesCheckboxLocator());
    }

    public boolean isMarketFieldVisible() {
        return getDojoComboElement(getMarketFieldLocator()).isVisible();
    }

    public boolean isDestinationIdFieldVisible() {
        return getEditElement(getDestinationIdFieldLocator()).isVisible();
    }

    public boolean isDestinationIdFieldValidationErrorVisible() {
        return isValidationElementErrorVisible(getEditElement(getDestinationIdFieldLocator()));
    }

    public void fillNameField(String value) {
        fillTextField(getNameFieldLocator(), value);
    }

    public void fillDescriptionField(String value) {
        fillTextField(getDescriptionFieldLocator(), value);
    }

    public void fillPinField(String value) {
        fillTextField(getPinFieldLocator(), value);
    }

    public void fillTimeZoneField(String value) {
        fillComboboxField(getTimeZoneFieldLocator(), value);
    }

    public void fillCountryField(String value) {
        fillComboboxField(getCountryFieldLocator(), value);
    }

    public void fillSAPCountryField(String value) { fillComboboxField(getSAPCountryFieldLocator(), value);}

    public void fillSAPIdField(String value) {
        fillTextField(getSAPIdFieldLocator(), value);
    }

    public void fillEnableSAPEnabledCheckbox(boolean value) {
        fillCheckboxField(getEnableSAPEnabledCheckboxLocator(), value);
    }

    public void fillClientCodeField(String value) {
        fillTextField(getClientCodeFieldLocator(), value);
    }

    public void fillStorageField(String value) {
        fillComboboxField(getStorageFieldLocator(), value);
    }

    public void fillIngestLocationField(String value) {
        fillComboboxField(getIngestLocationFieldLocator(), value);
    }

    public void fillA4AgencyIdField(String value) {
        fillTextField(getA4AgencyIdFieldLocator(), value);
    }

    public void fillFooterTextField(String value) {
        fillTextField(getFooterTextFieldLocator(), value);
    }

    public void fillFooterTextColorField(String value) {
        fillTextField(getFooterTextColorFieldLocator(), value);
    }

    public void fillFooterColorField(String value) {
        fillTextField(getFooterColorFieldLocator(), value);
    }

    public void fillA4UserEmailField(String value) {
        fillTextField(getA4UserEmailFieldLocator(), value);
    }

    public void fillA4UserPasswordField(String value) {
        fillTextField(getA4UserPasswordFieldLocator(), value);
    }

    public void fillBrandingColorField(String value) {
        web.click(getBrandingColorPreviewElementLocator());
        new DojoControl(parentPage, getBrandingColorPickerValueFieldLocator()).setAttribute("value", value);
    }

    public void fillBrandingLinkColorField(String value) {
        web.click(getBrandingLinkColorPreviewElementLocator());
        new DojoControl(parentPage, getBrandingLinkColorPickerValueFieldLocator()).setAttribute("value", value);
    }

    public void fillAutoAcceptorField(String value) {
        fillAutoAcceptSharedCategoriesCheckbox(value != null && !value.isEmpty());
        fillTextField(getAutoacceptorTextFieldLocator(), value);
        fillComboboxField(getAutoacceptorComboboxFieldLocator(), value);
    }

    public void fillTypeField(String value) {
        fillComboboxField(getTypeFieldLocator(), value);
    }

    public void fillMarketField(String value) {
        fillComboboxField(getMarketFieldLocator(), value);
    }

    // value: only numbers
    public void fillDestinationIdField(String value) {
        fillTextField(getDestinationIdFieldLocator(), value);
    }

    public void fillBULabelsField(List<String> value) {
        fillAutoSuggestField(getBULabelsFieldLocator(), value);
    }

    public void fillA4CreateAssetCheckbox(boolean value) {
        fillCheckboxField(getA4CreateAssetCheckboxLocator(), value);
    }

    public void fillAutoAcceptSharedCategoriesCheckbox(boolean value) {
        fillCheckboxField(getAutoacceptSharedCategoriesCheckboxLocator(), value);
    }

    public void fillPublishProjectOnCreateCheckbox(boolean value) {
        fillCheckboxField(getPublishProjectOnCreateCheckboxLocator(), value);
    }

    public void fillHideTemplateOnProjectCreateCheckbox(boolean value) {
        fillCheckboxField(getHideTemplateOnProjectCreateCheckboxLocator(), value);
    }

    public void fillAllowExtendDictionariesCheckbox(boolean value) {
        fillCheckboxField(getAllowExtendDictionariesCheckboxLocator(), value);
    }

    public void fillEnableFinderStyleProjectView(boolean value) {
        fillCheckboxField(getEnableFinderStyleProjectView(), value);
    }

    public void fillUserSelfRegistersCheckbox(boolean value) {
        fillCheckboxField(getUserSelfRegistersCheckboxLocator(), value);
    }

    public void fillEnableProjectsModuleCheckbox(boolean value) {
        fillCheckboxField(getEnableProjectsModuleCheckboxLocator(), value);
    }
    // NGN-16213 - QAA: Global Admin defines Applications available to BU - By Geethanjali- code Starts
    public void fillEnableWorkRequestssModuleCheckbox(boolean value) {
        fillCheckboxField(getEnableWorkRequestModuleCheckboxLocator(), value);
    }
    public void fillEnablePresentationsModuleCheckbox(boolean value) {
        fillCheckboxField(getEnablePresentationsModuleCheckboxLocator(), value);
    }

    public void fillEnableDeliveryModuleCheckbox(boolean value) {
        fillCheckboxField(getEnableDeliveryModuleCheckboxLocator(), value);
    }
    // NGN-16213 - QAA: Global Admin defines Applications available to BU - By Geethanjali- code Ends

    public void fillEnableLibraryModuleCheckbox(boolean value) {
        fillCheckboxField(getEnableLibraryModuleCheckboxLocator(), value);
    }

    public void fillEnableApprovalsModuleCheckbox(boolean value) {
        fillCheckboxField(getEnableApprovalsModuleCheckboxLocator(),value);
    }
    // NGN-16212 - QAA: Global Admin can Copy BU - By Geethanjali- code starts
    public void fillEnableTrafficModuleCheckbox(boolean value) {
        fillCheckboxField(getEnableTrafficModuleCheckboxLocator(),value);
    }
    public void fillEnableIngestModuleCheckbox(boolean value) {
        fillCheckboxField(getEnableIngestModuleCheckboxLocator(),value);
    }
    public void fillEnableReportingModuleCheckbox(boolean value) {
        fillCheckboxField(getEnableReportingModuleCheckboxxLocator(),value);
    }
    public void fillEnableDashboardfeatureCheckbox(boolean value) {
        fillCheckboxField(getEnableDashboardfeatureCheckboxLocator(),value);
    }

    // NGN-16212 - QAA: Global Admin can Copy BU - By Geethanjali- code Ends
    public void fillEnableAnnotationsModuleCheckbox(boolean value){
        fillCheckboxField(getAnnotationsModuleCheckboxLocator(),value);
    }

    public void fillEnableAutoCloseApprovalCheckbox(boolean value) {
        fillCheckboxField(getEnableAutoCloseApprovalCheckboxLocator(),value);
    }

    public void fillEnableProjectAccessRulesCheckbox(boolean value) {
        fillCheckboxField(getEnableProjectAccessRuleCheckboxLocator(),value);
    }

    public void fillEnableMediaSupplierCheckbox(boolean value){
        fillCheckboxField(getMediaSupplierCheckboxLocator(),value);
    }

    public void fillEnableDefaultSaveInLibraryCheckbox(boolean value){
        fillCheckboxField(getDefaultSaveInLibraryCheckboxLocator(),value);
    }

    public void fillEnableAllowUserToChangeSaveInLibraryCheckbox(boolean value){
        fillCheckboxField(getAllowUserToChangeSaveInLibraryCheckboxLocator(),value);
    }

    public void fillDefaultValueOfManageConversionFlagCheckbox(boolean value){
        fillCheckboxField(getDefaultValueOfManageConversionFlagCheckboxLocator(),value);
    }

    public void fillAllowUserToChangeManageConversionFlagCheckbox(boolean value){
        fillCheckboxField(getAllowUserToChangeManageConversionFlagCheckboxLocator(),value);
    }

    public void fillEnablesTasksModuleCheckbox(boolean value){
        fillCheckboxField(getEnablesTasksModuleCheckboxLocator(),value);
    }

    public void clickActionNoDelay() {
        super.clickAction();
    }

    public void clickAction() {
        super.clickAction();
        web.waitUntilElementDisappear(generateLocator());
    }
}