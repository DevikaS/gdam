package com.adstream.automate.babylon.sut.pages.ordering.elements.forms;

import com.adstream.automate.babylon.sut.pages.ordering.OrderItemPage;
import com.adstream.automate.babylon.sut.pages.ordering.elements.dictionaries.Markets;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.popupForms.ARPPLoginForm;
import com.adstream.automate.babylon.sut.pages.ordering.elements.popup.SelectFromExistingFormatsPopUp;
import com.adstream.automate.page.AbstractControl;
import com.adstream.automate.page.controls.*;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.ExpectedConditions;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 27.08.13
 * Time: 0:28
 */
public class AddInformationForm extends AbstractCustomFieldsForm {
    public static final String ROOT_NODE = ".addInformationForm";
    private Edit additionalInformation;
    private DojoCombo advertiser;
    private DojoCombo brand;
    private DojoCombo subBrand;
    private DojoCombo product;
    private Edit campaign;
    private Edit clockNumber;
    private DojoCombo pubId;
    private Edit duration;
    private DojoDateTextBox firstAirDate;
    private DojoCombo format;
    protected Edit title;
    private DojoCombo subtitlesRequired;
    protected DojoCombo mediaAgency;
    protected DojoCombo creativeAgency;
    protected DojoCombo postHouse;
    // related to specific market
    private Edit clave;
    private Edit creativeAgencyContact;
    private DojoCombo language;
    private Edit mediaAgencyContact;
    private DojoCombo watermarkingRequired;
    private Edit watermarkingCode;
    private DojoCombo watermarkingBrand;
    private DojoCombo model;
    private Edit productDescription;
    private Edit creativeDescription;
    private DojoCombo sector;
    private DojoCombo group;
    private DojoCombo watermarkingProduct;
    private Edit mbcidCode;
    private DojoCombo categoria;
    private Edit match;
    private DojoCombo mediaSubType;
    private Edit type;
    private Edit marketSegment;
    private Edit crt;
    private DojoDateTextBox dateOfAncineRegistration;
    private Edit director;
    private Edit numberOfVersions;
    private Edit cnpj;
    private Edit disneyCode;
    private DojoCombo typeDeMentions;
    private DojoCombo mentions;
    private Edit arppVersionNumber;
    private Edit arppSubmissionNumber;
    private Edit arppSubmissionResults;
    private Edit arppSubmissionCommentsCode;
    private Edit arppSubmissionDetails;
    private Edit motivnummer;
    private Edit sujetAkm;
    private Edit deliveryTitle;
    private DojoCombo version;
    private Edit cadNo;
    private Edit megatimeCode;
    private Edit televisaId;
    private Edit suisa;
    private Edit rifCode;
    private Link loginLnk;
    private Button spotGateCodeBtn;
    private Map<String, Boolean> warningIconsNextControlsVisibility;
    private Map<String, String> readonlyValues;
    private Map<String, String> fieldsLabels;
    protected OrderItemPage parent;

    public AddInformationForm(OrderItemPage parent) {
        super(parent);
        this.parent = parent;
        autoCodeBtn = new Button(parent, generateElementLocatorByDataRole("adCodeAutoButton"));
        spotGateCodeBtn = new Button(parent, generateElementLocatorByDataRole("autoButton"));
        loginLnk = new Link(parent, generateElementLocatorByDataRole("loginLink"));
    }

    @Override
    protected void initControls() {
        controls.put(SchemaField.ADDITIONAL_INFORMATION.toString(), additionalInformation = new Edit(parent, generateTextFieldLocator(CM.COMMON, SchemaField.ADDITIONAL_INFORMATION.getPathName().toString())));
        controls.put(SchemaField.ADVERTISER.toString(), advertiser = new DojoCombo(parent, generateComboBoxLocator(CM.ASSET_COMMON, SchemaField.ADVERTISER.getPathName().toString())));
        controls.put(SchemaField.BRAND.toString(), brand = new DojoCombo(parent, generateComboBoxLocator(CM.ASSET_COMMON, SchemaField.BRAND.getPathName().toString())));
        controls.put(SchemaField.SUB_BRAND.toString(), subBrand = new DojoCombo(parent, generateComboBoxLocator(CM.ASSET_COMMON, SchemaField.SUB_BRAND.getPathName().toString())));
        controls.put(SchemaField.PRODUCT.toString(), product = new DojoCombo(parent, generateComboBoxLocator(CM.ASSET_COMMON, SchemaField.PRODUCT.getPathName().toString())));
        controls.put(SchemaField.CAMPAIGN.toString(), campaign = new Edit(parent, generateTextFieldLocator(CM.ASSET_COMMON, SchemaField.CAMPAIGN.getPathName().toString())));
        controls.put(SchemaField.CLOCK_NUMBER.toString(), clockNumber = new Edit(parent, generateClockNumberLocator()));
        controls.put(SchemaField.DURATION.toString(), duration = new Edit(parent, generateTextFieldLocator(CM.COMMON, SchemaField.DURATION.getPathName().toString())));
        controls.put(SchemaField.FIRST_AIR_DATE.toString(), firstAirDate = new DojoDateTextBox(parent, generateComboBoxLocator(CM.COMMON, SchemaField.FIRST_AIR_DATE.getPathName().toString())));
        controls.put(SchemaField.FORMAT.toString(), format = new DojoCombo(parent, generateComboBoxLocator(CM.COMMON, SchemaField.FORMAT.getPathName().toString())));
        controls.put(SchemaField.TITLE.toString(), title = new Edit(parent, generateTextFieldLocator(CM.COMMON, SchemaField.TITLE.getPathName().toString())));
        controls.put(SchemaField.SUBTITLES_REQUIRED.toString(), subtitlesRequired = new DojoCombo(parent, generateComboBoxLocator(CM.METADATA, SchemaField.SUBTITLES_REQUIRED.getPathName().toString())));
        controls.put(SchemaField.MEDIA_AGENCY.toString(), mediaAgency = new DojoCombo(parent, generateComboBoxLocator(CM.COMMON, SchemaField.MEDIA_AGENCY.getPathName().toString())));
        controls.put(SchemaField.CREATIVE_AGENCY.toString(), creativeAgency = new DojoCombo(parent, generateComboBoxLocator(CM.COMMON, SchemaField.CREATIVE_AGENCY.getPathName().toString())));
        controls.put(SchemaField.POST_HOUSE.toString(), postHouse = new DojoCombo(parent, generateComboBoxLocator(CM.COMMON, SchemaField.POST_HOUSE.getPathName().toString())));
        // Spain market fields
        controls.put(SchemaField.CLAVE.toString(), clave = new Edit(parent, generateTextFieldLocator(CM.METADATA, SchemaField.CLAVE.getPathName().toString())));
        controls.put(SchemaField.CREATIVE_AGENCY_CONTACT.toString(), creativeAgencyContact = new Edit(parent, generateTextFieldLocator(CM.METADATA, SchemaField.CREATIVE_AGENCY_CONTACT.getPathName().toString())));
        controls.put(SchemaField.LANGUAGE.toString(), language = new DojoCombo(parent, generateComboBoxLocator(CM.METADATA, SchemaField.LANGUAGE.getPathName().toString())));
        controls.put(SchemaField.MEDIA_AGENCY_CONTACT.toString(), mediaAgencyContact = new Edit(parent, generateTextFieldLocator(CM.METADATA, SchemaField.MEDIA_AGENCY_CONTACT.getPathName().toString())));
        controls.put(SchemaField.WATERMARKING_REQUIRED.toString(), watermarkingRequired = new DojoCombo(parent, generateComboBoxLocator(CM.METADATA, SchemaField.WATERMARKING_REQUIRED.getPathName().toString())));
        controls.put(SchemaField.WATERMARKING_CODE.toString(), watermarkingCode = new Edit(parent, generateWatermarkingCodeLocator()));
        controls.put(SchemaField.WATERMARKING_BRAND.toString(), watermarkingBrand = new DojoCombo(parent, generateComboBoxLocator(CM.METADATA, SchemaField.WATERMARKING_BRAND.getPathName().toString())));
        controls.put(SchemaField.MODEL.toString(), model = new DojoCombo(parent, generateComboBoxLocator(CM.METADATA, SchemaField.MODEL.getPathName().toString())));
        controls.put(SchemaField.PRODUCT_DESCRIPTION.toString(), productDescription = new Edit(parent, generateTextFieldLocator(CM.METADATA, SchemaField.PRODUCT_DESCRIPTION.getPathName().toString())));
        controls.put(SchemaField.CREATIVE_DESCRIPTION.toString(), creativeDescription = new Edit(parent, generateTextFieldLocator(CM.METADATA, SchemaField.CREATIVE_DESCRIPTION.getPathName().toString())));
        controls.put(SchemaField.SECTOR.toString(), sector = new DojoCombo(parent, generateComboBoxLocator(CM.METADATA, SchemaField.SECTOR.getPathName().toString())));
        controls.put(SchemaField.GROUP.toString(), group = new DojoCombo(parent, generateComboBoxLocator(CM.METADATA, SchemaField.GROUP.getPathName().toString())));
        controls.put(SchemaField.WATERMARKING_PRODUCT.toString(), watermarkingProduct = new DojoCombo(parent, generateComboBoxLocator(CM.METADATA, SchemaField.WATERMARKING_PRODUCT.getPathName().toString())));
        // Belgium market field
        controls.put(SchemaField.MBCID_CODE.toString(), mbcidCode = new Edit(parent,generateTextFieldLocator(CM.METADATA, SchemaField.MBCID_CODE.getPathName().toString())));
        // Italy Pubblicita' market fields
        controls.put(SchemaField.CATEGORIA_MERCEOLOGICA_SETTORE.toString(), categoria = new DojoCombo(parent, generateComboBoxLocator(CM.METADATA, SchemaField.CATEGORIA_MERCEOLOGICA_SETTORE.getPathName().toString())));
        controls.put(SchemaField.MATCH.toString(), match = new Edit(parent, generateTextFieldLocator(CM.METADATA, SchemaField.MATCH.getPathName().toString())));
        controls.put(SchemaField.MEDIA_SUB_TYPE.toString(), mediaSubType = new DojoCombo(parent, generateComboBoxLocator(CM.METADATA, SchemaField.MEDIA_SUB_TYPE.getPathName().toString())));
        // Brazil market fields
        controls.put(SchemaField.TYPE.toString(), type = new Edit(parent, generateTextFieldLocator(CM.METADATA, SchemaField.TYPE.getPathName().toString())));
        controls.put(SchemaField.MARKET_SEGMENT.toString(), marketSegment = new Edit(parent, generateTextFieldLocator(CM.METADATA, SchemaField.MARKET_SEGMENT.getPathName().toString())));
        controls.put(SchemaField.CRT.toString(), crt = new Edit(parent, generateTextFieldLocator(CM.METADATA, SchemaField.CRT.getPathName().toString())));
        controls.put(SchemaField.DATE_OF_ANCINE_REGISTRATION.toString(), dateOfAncineRegistration = new DojoDateTextBox(parent, generateComboBoxLocator(CM.METADATA, SchemaField.DATE_OF_ANCINE_REGISTRATION.getPathName().toString())));
        controls.put(SchemaField.DIRECTOR.toString(), director = new Edit(parent, generateTextFieldLocator(CM.METADATA, SchemaField.DIRECTOR.getPathName().toString())));
        controls.put(SchemaField.NUMBER_OF_VERSIONS.toString(), numberOfVersions = new Edit(parent, generateTextFieldLocator(CM.METADATA, SchemaField.NUMBER_OF_VERSIONS.getPathName().toString())));
        controls.put(SchemaField.CNPJ.toString(), cnpj = new Edit(parent, generateTextFieldLocator(CM.METADATA, SchemaField.CNPJ.getPathName().toString())));
        // Disney Pan Nordic market field
        controls.put(SchemaField.DISNEY_CODE.toString(), disneyCode = new Edit(parent, generateTextFieldLocator(CM.METADATA, SchemaField.DISNEY_CODE.getPathName().toString())));
        // ARPP information fields of France market
        controls.put(SchemaField.TYPE_DE_MENTIONS.toString(), typeDeMentions = new DojoCombo(parent, generateComboBoxLocator(CM.METADATA, SchemaField.TYPE_DE_MENTIONS.getPathName().toString())));
        controls.put(SchemaField.MENTIONS.toString(), mentions = new DojoCombo(parent, generateComboBoxLocator(CM.METADATA, SchemaField.MENTIONS.getPathName().toString())));
        controls.put(SchemaField.ARPP_VERSION_NUMBER.toString(), arppVersionNumber = new Edit(parent, generateTextFieldLocator(CM.ARPP, SchemaField.ARPP_VERSION_NUMBER.getPathName().toString())));
        controls.put(SchemaField.ARPP_SUBMISSION_NUMBER.toString(), arppSubmissionNumber = new Edit(parent, generateTextFieldLocator(CM.ARPP, SchemaField.ARPP_SUBMISSION_NUMBER.getPathName().toString())));
        controls.put(SchemaField.ARPP_SUBMISSION_RESULTS.toString(), arppSubmissionResults = new Edit(parent, generateTextFieldLocator(CM.ARPP, SchemaField.ARPP_SUBMISSION_RESULTS.getPathName().toString())));
        controls.put(SchemaField.ARPP_SUBMISSION_COMMENTS_CODE.toString(), arppSubmissionCommentsCode = new Edit(parent, generateTextFieldLocator(CM.ARPP, SchemaField.ARPP_SUBMISSION_COMMENTS_CODE.getPathName().toString())));
        controls.put(SchemaField.ARPP_SUBMISSION_DETAILS.toString(), arppSubmissionDetails = new Edit(parent, generateTextFieldLocator(CM.ARPP, SchemaField.ARPP_SUBMISSION_DETAILS.getPathName().toString())));
        if (getMarketCountryCode().equals(Markets.FRANCE.getCountryCode()) && isLoggedIntoARPPSystem())
            controls.put(SchemaField.CLOCK_NUMBER.toString(), pubId = new DojoCombo(parent, generateComboBoxLocator(CM.COMMON, SchemaField.CLOCK_NUMBER.getPathName().toString())));
        // Germany market field
        controls.put(SchemaField.MOTIVNUMMER.toString(), motivnummer = new Edit(parent, generateTextFieldLocator(CM.METADATA, SchemaField.MOTIVNUMMER.getPathName().toString())));
        // Austria market field
        controls.put(SchemaField.SUJET_AKM.toString(), sujetAkm = new Edit(parent, generateTextFieldLocator(CM.METADATA, SchemaField.SUJET_AKM.getPathName().toString())));
        // Netherlands market field
        controls.put(SchemaField.DELIVERY_TITLE.toString(), deliveryTitle = new Edit(parent, generateTextFieldLocator(CM.METADATA, SchemaField.DELIVERY_TITLE.getPathName().toString())));
        controls.put(SchemaField.VERSION.toString(), version = new DojoCombo(parent, generateComboBoxLocator(CM.METADATA, SchemaField.VERSION.getPathName().toString())));
        // Australia market field
        controls.put(SchemaField.CAD_NO.toString(), cadNo = new Edit(parent, generateTextFieldLocator(CM.METADATA, SchemaField.CAD_NO.getPathName().toString())));
        // Chile market field
        controls.put(SchemaField.MEGATIME_CODE.toString(), megatimeCode = new Edit(parent, generateTextFieldLocator(CM.METADATA, SchemaField.MEGATIME_CODE.getPathName().toString())));
        // Mexico market field
        controls.put(SchemaField.TELEVISA_ID.toString(), televisaId = new Edit(parent, generateTextFieldLocator(CM.METADATA, SchemaField.TELEVISA_ID.getPathName().toString())));
        // Switzerland market field
        controls.put(SchemaField.SUISA.toString(), suisa = new Edit(parent, generateTextFieldLocator(CM.METADATA, SchemaField.SUISA.getPathName().toString())));
        // Venezuela market field
        controls.put(SchemaField.RIF_CODE.toString(), rifCode = new Edit(parent, generateTextFieldLocator(CM.METADATA, SchemaField.RIF_CODE.getPathName().toString())));
    }

    @Override
    protected void loadForm() {
        getDriver().waitUntilElementAppearVisible(getFormLocator());
    }

    @Override
    protected void unloadForm() {
        getDriver().waitUntilElementDisappear(getFormLocator());
    }

    @Override
    protected String getRootNode() {
        return ROOT_NODE;
    }

    public void fillAdvertiserHierarchyCustomFields(Map<String, String> fields) {
        for (Map.Entry<String, String> field : fields.entrySet()) {
            String fieldName = field.getKey();
            String fieldValue = field.getValue();
            AbstractControl control = getAdvertiserHierarchyCustomControls(fieldName).get(fieldName);
            if (control instanceof DojoCombo) {
                if (((DojoCombo) control).getValues().contains(fieldValue)) {
                    ((DojoCombo) control).selectByVisibleText(fieldValue);
                } else {
                    ((DojoCombo) control).selectValueOnFly(fieldValue);
                }
            } else
                throw new IllegalStateException("Unknown class of control: " + control.getClass());
        }
    }

    public String getAdvertiserHierarchyCustomFieldValue(String fieldName){
        AbstractControl control = getAdvertiserHierarchyCustomControls(fieldName).get(fieldName);
        if (control instanceof DojoCombo)
            return ((DojoCombo) control).getDisplayedValue();
        else
            throw new IllegalStateException("Unknown class of control: " + control.getClass());
    }

    public String getReadOnlyValue(String fieldName) {
        if (getDefaultReadOnlyValues().containsKey(fieldName))
            return getDefaultReadOnlyValues().get(fieldName);
        else
            return getCustomReadOnlyValues(fieldName).get(fieldName);
    }

    public String getFieldsLabel(String fieldName) {
        if (getFieldsLabels().containsKey(fieldName))
            return getFieldsLabels().get(fieldName);
        else
            throw new IllegalArgumentException("Unknown field name: " + fieldName);
    }

    public List<String> getMetadataFieldLabels() {
        return getDriver().findElementsToStrings(getMetadataFieldLabelLocator());
    }

    public boolean isWarningIconVisibleNextFollowingField(String fieldName) {
        if (getWarningIconVisibilitiesNextControls().containsKey(fieldName))
            return getWarningIconVisibilitiesNextControls().get(fieldName);
        throw new IllegalArgumentException("Unknown field name: " + fieldName);
    }

    public String getWarningMessageNextFollowingField(String fieldName) {
        if (getWarningIconVisibilitiesNextControls().containsKey(fieldName))
            if (getWarningIconVisibilitiesNextControls().get(fieldName)) {
                forceWarningTooltipByFieldName(fieldName);
                ExpectedConditions.presenceOfElementLocated(getDijitTooltipContainer());
                getDriver().waitUntil(new ExpectedCondition<Boolean>() {
                    public Boolean apply(WebDriver webDriver) {
                        return !webDriver.findElement(getDijitTooltipContainer()).getText().isEmpty();
                    }
                });
                return getDijitTooltipContainerText();
            } else
                throw new IllegalStateException("Warning icon is not present at this page!");
        throw new IllegalArgumentException("Unknown field name: " + fieldName);
    }

    public void generateCode(String codeType) {
        final GeneratedCodeType generatedCodeType = GeneratedCodeType.findByType(codeType);
        switchClickingByCodeType(generatedCodeType);
        waitForCodeGenerating(generatedCodeType);
     }

    public void pushAutoCodeButton(String codeType) {
        switchClickingByCodeType(GeneratedCodeType.findByType(codeType));
    }

    public boolean isAutoCodeBtnActive() {
        return !autoCodeBtn.getAttribute("class").contains("disabled");
    }

    public void waitForCodeGenerating(final GeneratedCodeType generatedCodeType) {
        getDriver().waitUntil(new ExpectedCondition<Boolean>() {
            public Boolean apply(WebDriver webDriver) {
                return !webDriver.findElement(generatedCodeType.equals(GeneratedCodeType.WATERMARKING_CODE) ? generateWatermarkingCodeLocator() : generateClockNumberLocator()).getAttribute("value").isEmpty();
            }
        });
    }

    public void waitForAutoCodeGeneration(final GeneratedCodeType generatedCodeType) {
        boolean unfound=true;
        int count = 0;
        while(unfound && count <=3 ){
            count++;
            if (fluentWaitMethodReturn()== true)
                unfound = false;
        }
    }

    private boolean fluentWaitMethodReturn(){
        return getDriver().waitUntil(new ExpectedCondition<Boolean>() {
            public Boolean apply(WebDriver webDriver) {
                return !webDriver.findElement(generateClockNumberLocator()).getAttribute("value").isEmpty();
            }
        });
    }

    public SelectFromExistingFormatsPopUp getSelectFromExistingFormatsPopUp() {
        if (!isSelectFromExistingFormatsPopUpVisible())
            clickAutoCodeBtn();
        return new SelectFromExistingFormatsPopUp(parent, SelectFromExistingFormatsPopUp.TITLE);
    }

    public boolean isSelectFromExistingFormatsPopUpVisible() {
        return getDriver().isElementVisible(By.xpath(SelectFromExistingFormatsPopUp.TITLE_NODE));
    }

    public ARPPLoginForm getARPPLoginForm() {
        if (!getDriver().isElementVisible(By.cssSelector(ARPPLoginForm.ROOT_NODE)))
            clickLoginLnk();
        return new ARPPLoginForm(parent);
    }

    public boolean isLoggedIntoARPPSystem() {
        return getDriver().getJavascriptExecutor().executeScript("return dojo.cookie('ordering_arpp')") != null
                && !getDriver().getJavascriptExecutor().executeScript("return dojo.cookie('ordering_arpp')").equals("") ;
    }

    public void logOffARPPSystem() {
        getDriver().getJavascriptExecutor().executeScript("dojo.cookie('ordering_arpp', '')");
    }

    public String getARPPHintMessage() {
        return getDriver().findElement(generateFormElementLocator("[data-role='arppLinkContainer'] .bold")).getText();
    }

    public List<String> getAvailablePubIds() {
        getControls();
        return pubId.getValues();
    }

    private void clickSpotGateBtn() {
        spotGateCodeBtn.click();
    }

    private void clickLoginLnk() {
        loginLnk.click();
    }

    private void switchClickingByCodeType(GeneratedCodeType codeType) {
        switch (codeType) {
            case DEFAULT:
            case WATERMARKING_CODE:
                clickAutoCodeBtn();
                break;
            case SPOT_GATE_CODE: clickSpotGateBtn(); break;
            default: throw new IllegalArgumentException("Unknown generated code type: " + codeType);
        }
    }

    private void initAdvertiserHierarchyCustomControls(String fieldName) {
        controls.put(fieldName, new DojoCombo(parent, generateComboBoxLocator(CM.ASSET_COMMON, fieldName.replaceAll(" ", ""))));
    }

    private Map<String, AbstractControl> getAdvertiserHierarchyCustomControls(String fieldName) {
        if (controls == null) {
            controls = new HashMap<>();
        }
        initAdvertiserHierarchyCustomControls(fieldName);
        return controls;
    }

    private void initDefaultReadOnlyFieldsValues() {
        readonlyValues.put(SchemaField.CLOCK_NUMBER.toString(), getDriver().findElement(generateReadOnlyFieldValueLocator(SchemaField.CLOCK_NUMBER.getPathName().toString())).getText());
        readonlyValues.put(SchemaField.ADVERTISER.toString(), getDriver().isElementPresent(generateReadOnlyFieldValueLocator(SchemaField.ADVERTISER.getPathName().toString())) ? getDriver().findElement(generateReadOnlyFieldValueLocator(SchemaField.ADVERTISER.getPathName().toString())).getText() : "");
        readonlyValues.put(SchemaField.BRAND.toString(), getDriver().isElementPresent(By.cssSelector(getRootNode() + " [class*='_common_brand'] .value")) ? getDriver().findElement(By.cssSelector(getRootNode() + " [class*='_common_brand'] .value")).getText() : ""); // to avoid mixing brand and sub brand
        readonlyValues.put(SchemaField.SUB_BRAND.toString(), getDriver().isElementPresent(generateReadOnlyFieldValueLocator(SchemaField.SUB_BRAND.getPathName().toString())) ? getDriver().findElement(generateReadOnlyFieldValueLocator(SchemaField.SUB_BRAND.getPathName().toString())).getText() : "");
        readonlyValues.put(SchemaField.PRODUCT.toString(), getDriver().isElementPresent(generateReadOnlyFieldValueLocator(SchemaField.PRODUCT.getPathName().toString())) ? getDriver().findElement(generateReadOnlyFieldValueLocator(SchemaField.PRODUCT.getPathName().toString())).getText() : "");
        readonlyValues.put(SchemaField.CAMPAIGN.toString(), getDriver().findElement(generateReadOnlyFieldValueLocator(SchemaField.CAMPAIGN.getPathName().toString())).getText());
        readonlyValues.put(SchemaField.TITLE.toString(), getDriver().findElement(generateReadOnlyFieldValueLocator(SchemaField.TITLE.getPathName().toString())).getText());
        readonlyValues.put(SchemaField.DURATION.toString(), getDriver().findElement(generateReadOnlyFieldValueLocator(SchemaField.DURATION.getPathName().toString())).getText());
        readonlyValues.put(SchemaField.FIRST_AIR_DATE.toString(), getDriver().findElement(generateReadOnlyFieldValueLocator(SchemaField.FIRST_AIR_DATE.getPathName().toString())).getText());
        readonlyValues.put(SchemaField.FORMAT.toString(), getDriver().findElement(generateReadOnlyFieldValueLocator(SchemaField.FORMAT.getPathName().toString())).getText());
        readonlyValues.put(SchemaField.SUBTITLES_REQUIRED.toString(), getDriver().isElementPresent(generateReadOnlyFieldValueLocator(SchemaField.SUBTITLES_REQUIRED.getPathName().toString())) ? getDriver().findElement(generateReadOnlyFieldValueLocator(SchemaField.SUBTITLES_REQUIRED.getPathName().toString())).getText() : "");
        readonlyValues.put(SchemaField.ADDITIONAL_INFORMATION.toString(), getDriver().findElement(generateReadOnlyFieldValueLocator(SchemaField.ADDITIONAL_INFORMATION.getPathName().toString())).getText());
        if (getMarketCountryCode().equals(Markets.FRANCE.getCountryCode())) {
            // ARPP information fields
            readonlyValues.put(SchemaField.TYPE_DE_MENTIONS.toString(), getDriver().findElement(generateReadOnlyFieldValueLocator(SchemaField.TYPE_DE_MENTIONS.getPathName().toString())).getText());
            readonlyValues.put(SchemaField.MENTIONS.toString(), getDriver().findElement(generateReadOnlyFieldValueLocator(SchemaField.MENTIONS.getPathName().toString())).getText());
            readonlyValues.put(SchemaField.ARPP_VERSION_NUMBER.toString(), getDriver().findElement(generateReadOnlyFieldValueLocator(SchemaField.ARPP_VERSION_NUMBER.getPathName().toString())).getText());
            readonlyValues.put(SchemaField.ARPP_SUBMISSION_NUMBER.toString(), getDriver().findElement(generateReadOnlyFieldValueLocator(SchemaField.ARPP_SUBMISSION_NUMBER.getPathName().toString())).getText());
            readonlyValues.put(SchemaField.ARPP_SUBMISSION_RESULTS.toString(), getDriver().findElement(generateReadOnlyFieldValueLocator(SchemaField.ARPP_SUBMISSION_RESULTS.getPathName().toString())).getText());
            readonlyValues.put(SchemaField.ARPP_SUBMISSION_COMMENTS_CODE.toString(), getDriver().findElement(generateReadOnlyFieldValueLocator(SchemaField.ARPP_SUBMISSION_COMMENTS_CODE.getPathName().toString())).getText());
            readonlyValues.put(SchemaField.ARPP_SUBMISSION_DETAILS.toString(), getDriver().findElement(generateReadOnlyFieldValueLocator(SchemaField.ARPP_SUBMISSION_DETAILS.getPathName().toString())).getText());
        }
        if (getMarketCountryCode().equals(Markets.DISNEY_PAN_NORDIC.getCountryCode()))
            readonlyValues.put(SchemaField.DISNEY_CODE.toString(), getDriver().findElement(generateReadOnlyFieldValueLocator(SchemaField.DISNEY_CODE.getPathName().toString())).getText());
    }

    private void initCustomReadOnlyFieldsValues(String fieldName) {
        readonlyValues.put(fieldName, getDriver().findElement(generateReadOnlyFieldValueLocator(fieldName.replaceAll(" ", ""))).getText());
    }

    private Map<String, String> getDefaultReadOnlyValues() {
        if (readonlyValues == null) {
            readonlyValues = new HashMap<>();
            initDefaultReadOnlyFieldsValues();
        }
        return readonlyValues;
    }

    private Map<String, String> getCustomReadOnlyValues(String fieldName) {
        getDefaultReadOnlyValues();
        initCustomReadOnlyFieldsValues(fieldName);
        return readonlyValues;
    }

    private void initWarningIconsVisibility() {
        warningIconsNextControlsVisibility.put(SchemaField.CLOCK_NUMBER.toString(), getDriver().isElementVisible(generateWarningIconNextTextFieldLocator(CM.COMMON, SchemaField.CLOCK_NUMBER.getPathName().toString())));
    }

    private Map<String, Boolean> getWarningIconVisibilitiesNextControls() {
        if (warningIconsNextControlsVisibility == null) {
            warningIconsNextControlsVisibility = new HashMap<>();
            initWarningIconsVisibility();
        }
        return warningIconsNextControlsVisibility;
    }

    private void initFieldsLabels() {
        fieldsLabels.put(SchemaField.CLOCK_NUMBER.toString(), getDriver().findElement(generateTextFieldLocator(CM.COMMON, SchemaField.CLOCK_NUMBER.getPathName().toString())).findElement(generateFieldsLabelLocator(SchemaField.CLOCK_NUMBER.getPathName().toString())).getText());
        fieldsLabels.put(SchemaField.ADVERTISER.toString(), getDriver().findElement(generateComboBoxLocator(CM.ASSET_COMMON, SchemaField.ADVERTISER.getPathName().toString())).findElement(generateFieldsLabelLocator(SchemaField.ADVERTISER.getPathName().toString())).getText());
        fieldsLabels.put(SchemaField.ADVERTISER.toString(), getDriver().findElement(generateComboBoxLocator(CM.ASSET_COMMON, SchemaField.ADVERTISER.getPathName().toString())).findElement(generateFieldsLabelLocator(SchemaField.ADVERTISER.getPathName().toString())).getText());
        fieldsLabels.put(SchemaField.BRAND.toString(), getDriver().findElement(generateComboBoxLocator(CM.ASSET_COMMON, SchemaField.BRAND.getPathName().toString())).findElement(generateFieldsLabelLocator(SchemaField.BRAND.getPathName().toString())).getText());
        fieldsLabels.put(SchemaField.SUB_BRAND.toString(), getDriver().findElement(generateComboBoxLocator(CM.ASSET_COMMON, SchemaField.BRAND.getPathName().toString())).findElement(generateFieldsLabelLocator(SchemaField.SUB_BRAND.getPathName().toString())).getText());
        fieldsLabels.put(SchemaField.PRODUCT.toString(), getDriver().findElement(generateComboBoxLocator(CM.ASSET_COMMON, SchemaField.PRODUCT.getPathName().toString())).findElement(generateFieldsLabelLocator(SchemaField.PRODUCT.getPathName().toString())).getText());
        fieldsLabels.put(SchemaField.CAMPAIGN.toString(), getDriver().findElement(generateTextFieldLocator(CM.ASSET_COMMON, SchemaField.CAMPAIGN.getPathName().toString())).findElement(generateFieldsLabelLocator(SchemaField.CAMPAIGN.getPathName().toString())).getText());
        fieldsLabels.put(SchemaField.TITLE.toString(), getDriver().findElement(generateTextFieldLocator(CM.COMMON, SchemaField.TITLE.getPathName().toString())).findElement(generateFieldsLabelLocator(SchemaField.TITLE.getPathName().toString())).getText());
        fieldsLabels.put(SchemaField.DURATION.toString(), getDriver().findElement(generateTextFieldLocator(CM.COMMON, SchemaField.DURATION.getPathName().toString())).findElement(generateFieldsLabelLocator(SchemaField.DURATION.getPathName().toString())).getText());
        fieldsLabels.put(SchemaField.FIRST_AIR_DATE.toString(), getDriver().findElement(generateComboBoxLocator(CM.COMMON, SchemaField.FIRST_AIR_DATE.getPathName().toString())).findElement(generateFieldsLabelLocator(SchemaField.FIRST_AIR_DATE.getPathName().toString())).getText());
        fieldsLabels.put(SchemaField.FORMAT.toString(), getDriver().findElement(generateComboBoxLocator(CM.COMMON, SchemaField.FORMAT.getPathName().toString())).findElement(generateFieldsLabelLocator(SchemaField.FORMAT.getPathName().toString())).getText());
        fieldsLabels.put(SchemaField.ADDITIONAL_INFORMATION.toString(), getDriver().findElement(generateTextFieldLocator(CM.COMMON, SchemaField.ADDITIONAL_INFORMATION.getPathName().toString())).findElement(generateFieldsLabelLocator(SchemaField.ADDITIONAL_INFORMATION.getPathName().toString())).getText());
        fieldsLabels.put(SchemaField.POST_HOUSE.toString(), getDriver().findElement(generateComboBoxLocator(CM.COMMON, SchemaField.POST_HOUSE.getPathName().toString())).findElement(generateFieldsLabelLocator(SchemaField.POST_HOUSE.getPathName().toString())).getText());
        fieldsLabels.put(SchemaField.CREATIVE_AGENCY.toString(), getDriver().findElement(generateComboBoxLocator(CM.COMMON, SchemaField.CREATIVE_AGENCY.getPathName().toString())).findElement(generateFieldsLabelLocator(SchemaField.CREATIVE_AGENCY.getPathName().toString())).getText());
    }

    private Map<String, String> getFieldsLabels() {
        if (fieldsLabels == null) {
            fieldsLabels = new HashMap<>();
            initFieldsLabels();
        }
        return fieldsLabels;
    }

    protected enum CM {
        COMMON("common"),
        ASSET_COMMON("asset"),
        METADATA("metadata"),
        ARPP("arpp");

        private String cmPart;

        private CM(String cmPart) {
            this.cmPart = cmPart;
        }

        @Override
        public String toString() {
            return cmPart;
        }
    }

    public static enum GeneratedCodeType {
        DEFAULT("auto code"),
        WATERMARKING_CODE("watermarking code"),
        SPOT_GATE_CODE("spot gate code");

        private String type;

        private GeneratedCodeType(String type) {
            this.type = type;
        }

        @Override
        public String toString() {
            return type;
        }

        public static GeneratedCodeType findByType(String type) {
            for (GeneratedCodeType code: values())
                if (code.toString().equals(type))
                    return code;
            throw new IllegalArgumentException("Unknown generated code type: " + type);
        }
    }

    private void forceWarningTooltipByFieldName(String fieldName) {
        if (fieldName.equals(SchemaField.CLOCK_NUMBER.toString()))
            getDriver().click(generateWarningIconNextTextFieldLocator(CM.COMMON, SchemaField.CLOCK_NUMBER.getPathName().toString()));
        else
            throw new IllegalArgumentException("Unknown field name: " + fieldName);
    }

    private String getDijitTooltipContainerText() {
        return getDriver().findElement(getDijitTooltipContainer()).getText();
    }

    private String getMarketCountryCode() {
        return parent.getSelectedMarket().replaceAll("selected-market icon-market48 unit pointer ", "");
    }

    private By generateClockNumberLocator() {
        return generateTextFieldLocator(CM.COMMON, SchemaField.CLOCK_NUMBER.getPathName().toString());
    }



    private By generateWatermarkingCodeLocator() {
        return generateTextFieldLocator(CM.METADATA, SchemaField.WATERMARKING_CODE.getPathName().toString());
    }

    private By generateReadOnlyFieldValueLocator(String partialLocator) {
        return By.cssSelector(getRootNode() + " [class*='_" + partialLocator + "'] .value");
    }

    private By generateFieldsLabelLocator(String partialLocator) {
        return By.xpath(String.format("//ancestor::div[contains(@data-schema-path, '%s')]/label/div | //ancestor::div[contains(@data-schema-path, '%s')]/*[contains(@class,'label')]", partialLocator, partialLocator));
    }

    private By generateWarningIconNextTextFieldLocator(CM cmPart, String partialLocator) {
        switch (cmPart) {
            case COMMON: return By.cssSelector("[name='_cm.common." + partialLocator + "']" + " + .spriteicon:not([class*='hidden'])");
            case METADATA: return By.cssSelector("[name='_cm.metadata." + partialLocator + "']" + " + .spriteicon:not([class*='hidden'])");
            default: throw new IllegalArgumentException("Unknown cm part: " + cmPart);
        }
    }

    protected By generateTextFieldLocator(CM cmPart, String partialLocator) {
        switch (cmPart) {
            case COMMON: return By.name("_cm.common." + partialLocator);
            case ASSET_COMMON: return By.name("_cm.asset.common." + partialLocator);
            case METADATA: return By.name("_cm.metadata." + partialLocator);
            case ARPP: return By.name("_cm.arpp." + partialLocator);
            default: throw new IllegalArgumentException("Unknown cm part: " + cmPart);
        }
    }

    protected By generateComboBoxLocator(CM cmPart, String partialLocator) {
        switch (cmPart) {
            case COMMON: return By.cssSelector("[data-schema-path*='_cm.common." + partialLocator + "'] .dijitComboBox");
            case ASSET_COMMON: return By.cssSelector("[data-schema-path*='_cm.asset.common." + partialLocator + "'] .dijitComboBox");
            case METADATA: return By.cssSelector("[data-schema-path*='_cm.metadata." + partialLocator + "'] .dijitComboBox");
            case ARPP: return By.cssSelector("[data-schema-path*='_cm.arpp." + partialLocator + "'] .dijitComboBox");
            default: throw new IllegalArgumentException("Unknown cm part: " + cmPart);
        }
    }

    private By getMetadataFieldLabelLocator() {
        return By.cssSelector("[data-schema-path*='metadata'] label");
    }

    private By getDijitTooltipContainer() {
        return By.className("dijitTooltipContainer");
    }

    private By getFormLocator() {
        return By.cssSelector(getRootNode());
    }

    public String getClockNumber()
    {
        String autoCode = getDriver().findElement(By.xpath("//input[contains(@id,'common_prop_schema_ClockNumber')]")).getAttribute("value");
        return autoCode;
    }
}