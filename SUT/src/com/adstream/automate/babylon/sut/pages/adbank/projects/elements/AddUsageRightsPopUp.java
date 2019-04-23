package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Checkbox;
import com.adstream.automate.page.controls.DojoCombo;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 24.10.12
 * Time: 14:23

 */
public class AddUsageRightsPopUp extends PopUpWindow {
    public AddUsageRightsPopUp(Page parentPage) {
        super(parentPage);
        action = new Button(parentPage, generateLocator(".button[name='Save']"));
    }

    public boolean isStartDateFieldRed() {
        return isFieldRed(getStartDateFieldLocator());
    }

    public boolean isExpirationDateFieldRed() {
        return isFieldRed(getExpirationDateFieldLocator());
    }

    public boolean isExpiresEveryDaysFieldRed() {
        return isFieldRed(getExpiresEveryDaysFieldLocator());
    }

    public boolean isCountryFieldRed() {
        return isFieldRed(getCountryFieldLocator());
    }

    public boolean isArtistNameFieldRed() {
        return isFieldRed(generateLocator(".artistName"));
    }

    public boolean isArtistFieldRed() {
        return isFieldRed(getArtistFieldLocator());
    }

    public boolean isArtistRoleFieldRed() {
        return isFieldRed(getArtistRoleFieldLocator());
    }

    public boolean isRoleFieldRed() {
        return isFieldRed(getRoleFieldLocator());
    }

    public boolean isTrackTitleFieldRed() {
        return isFieldRed(getTrackTitleFieldLocator());
    }

    public boolean isUsageRightsNotificationSettingsAreaVisible() {
        return web.isElementVisible(getUsageRightsNotificationSettingsArea());
    }

    public AddUsageRightsPopUp fillGeneralFields(Map<String,String> fields) {
        selectStartDate(fields.get("StartDate"));
        selectExpirationDate(fields.get("ExpirationDate"));

        if (fields.get("ExpiresEveryDays") != null) {
            checkExpireCycleRadioButton();
            fillExpiresEveryDaysField(fields.get("ExpiresEveryDays"));
        }

        return this;
    }

    public AddUsageRightsPopUp fillCountriesFields(Map<String,String> fields) {
        selectCountry(fields.get("Country"));

        return fillGeneralFields(fields);
    }

    public AddUsageRightsPopUp fillMediaTypesFields(Map<String,String> fields) {
        checkMediaTypeCheckbox(fields.get("Type"));
        fillMediaTypeCommentTextarea(fields.get("Type"), fields.get("Comment"));

        return this;
    }

    public AddUsageRightsPopUp fillVisualTalentFields(Map<String,String> fields) {
        fillArtistNameField(fields.get("ArtistName"));
        fillArtistRoleField(fields.get("Role"));
        fillBaseFeeField(fields.get("BaseFee"));
        fillAgentField(fields.get("Agent"));
        fillAgentTelField(fields.get("AgentTel"));
        fillEmailField(fields.get("Email"));
        fillUnionField(fields.get("Union"));
        fillMoreInfoTextarea(fields.get("MoreInfo"));

        return fillGeneralFields(fields);
    }

    public AddUsageRightsPopUp fillVoiceOverArtistFields(Map<String,String> fields) {
        fillArtistNameField(fields.get("ArtistName"));
        fillRoleField(fields.get("Role"));
        fillBaseFeeField(fields.get("BaseFee"));
        fillAgentField(fields.get("Agent"));
        fillAgentTelField(fields.get("AgentTel"));
        fillEmailField(fields.get("Email"));
        fillUnionField(fields.get("Union"));
        fillMoreInfoTextarea(fields.get("MoreInfo"));

        return fillGeneralFields(fields);
    }

    public AddUsageRightsPopUp fillMusicFields(Map<String,String> fields) {
        fillArtistField(fields.get("ArtistName"));
        fillTrackTitleField(fields.get("TrackTitle"));
        fillComposerField(fields.get("Composer"));
        fillTrackNumberField(fields.get("TrackNumber"));
        fillRecordLabelField(fields.get("RecordLabel"));
        fillSubLabelField(fields.get("SubLabel"));
        fillPublicationPublisherField(fields.get("PublicationPublisher"));
        fillArrangerField(fields.get("Arranger"));
        fillISRCNumberField(fields.get("ISRCNumber"));
        fillDurationField(fields.get("Duration"));
        fillLicenseDetailsTextarea(fields.get("LicenseDetails"));
        fillContactDetailsTextarea(fields.get("ContactDetails"));

        return fillGeneralFields(fields);
    }

    public AddUsageRightsPopUp fillOtherUsageFields(Map<String,String> fields) {
        fillOtherUsageCommentTextarea(fields.get("Comment"));

        return this;
    }

    public List <String> getValuesFromArtistField(){
        DojoCombo dc= new DojoCombo(parentPage,By.cssSelector(".artistName [role='textbox']"));
        return dc.getValues();
    }

    public Map<String, String> getVoiceOverArtistFieldsList(){
        Map<String, String> rule = new HashMap<>();
        rule.put("ArtistName",web.findElement(generateLocator(".artistName [role='textbox']")).getAttribute("value"));
        rule.put("BaseFee",web.findElement(getBaseFeeFieldLocator()).getAttribute("value"));
        rule.put("Agent",web.findElement(getAgentFieldLocator()).getAttribute("value"));
        rule.put("AgentTel",web.findElement(getAgentTelFieldLocator()).getAttribute("value"));
        rule.put("Email",web.findElement(getEmailFieldLocator()).getAttribute("value"));
        rule.put("Union",web.findElement(getUnionFieldLocator()).getAttribute("value"));
        return rule;
    }

    public Map<String, String> getVisualTalentFieldsList(){
        Map<String, String> rule = new HashMap<>();
        rule.put("ArtistName",web.findElement(generateLocator(".artistName [role='textbox']")).getText());
        rule.put("BaseFee",web.findElement(getBaseFeeFieldLocator()).getAttribute("value"));
        rule.put("Agent",web.findElement(getAgentFieldLocator()).getAttribute("value"));
        rule.put("AgentTel",web.findElement(getAgentTelFieldLocator()).getAttribute("value"));
        rule.put("Email",web.findElement(getEmailFieldLocator()).getAttribute("value"));
        rule.put("Union",web.findElement(getUnionFieldLocator()).getAttribute("value"));
        return rule;
    }

    public void selectStartDate(String value) {
        if (value != null && !value.isEmpty()) {
            new DojoCombo(parentPage, getStartDateFieldLocator()).selectByVisibleText(value);
        }
    }

    public void selectExpirationDate(String value) {
        if (value != null && !value.isEmpty()) new DojoCombo(parentPage, getExpirationDateFieldLocator()).selectByVisibleText(value);
    }

    public void selectCountry(String value) {
        DojoCombo dojoCombo = new DojoCombo(parentPage, getCountryFieldLocator());
        if (value != null && !value.isEmpty()) {
            for (String countty : value.split(",")) {
                dojoCombo.selectByVisibleText(countty);
            }
        }
    }

    public void fillExpiresEveryDaysField(String value) {
        if (value != null && !value.isEmpty()) web.typeClean(getExpiresEveryDaysFieldLocator(), value);
    }

    public void fillArtistNameField(String value) {
        if (value != null) {
            web.typeClean(generateLocator(".artistName [role='textbox']"), value);
            new DojoCombo(parentPage, generateLocator(".artistName")).selectByVisibleText(value);
        }
    }

    public void fillArtistField(String value) {
        if (value != null) web.typeClean(getArtistFieldLocator(), value);
    }

    public void fillArtistRoleField(String value) {
        if (value != null) web.typeClean(getArtistRoleFieldLocator(), value);
    }

    public void fillRoleField(String value) {
        if (value != null) web.typeClean(getRoleFieldLocator(), value);
    }

    public void fillBaseFeeField(String value) {
        if (value != null) web.typeClean(getBaseFeeFieldLocator(), value);
    }

    public void fillAgentField(String value) {
        if (value != null) web.typeClean(getAgentFieldLocator(), value);
    }

    public void fillAgentTelField(String value) {
        if (value != null) web.typeClean(getAgentTelFieldLocator(), value);
    }

    public void fillEmailField(String value) {
        if (value != null) web.typeClean(getEmailFieldLocator(), value);
    }

    public void fillUnionField(String value) {
        if (value != null) web.typeClean(getUnionFieldLocator(), value);
    }

    public void fillTrackTitleField(String value) {
        if (value != null) web.typeClean(getTrackTitleFieldLocator(), value);
    }

    public void fillComposerField(String value) {
        if (value != null) web.typeClean(getComposerFieldLocator(), value);
    }

    public void fillTrackNumberField(String value) {
        if (value != null) web.typeClean(getTrackNumberFieldLocator(), value);
    }

    public void fillRecordLabelField(String value) {
        if (value != null) web.typeClean(getRecordLabelFieldLocator(), value);
    }

    public void fillSubLabelField(String value) {
        if (value != null) web.typeClean(getSubLabelFieldLocator(), value);
    }

    public void fillPublicationPublisherField(String value) {
        if (value != null) web.typeClean(getPublicationPublisherFieldLocator(), value);
    }

    public void fillArrangerField(String value) {
        if (value != null) web.typeClean(getArrangerFieldLocator(), value);
    }

    public void fillISRCNumberField(String value) {
        if (value != null) web.typeClean(getISRCNumberFieldLocator(), value);
    }

    public void fillDurationField(String value) {
        if (value != null) web.typeClean(getDurationFieldLocator(), value);
    }

    public void fillDaysFromExpireField(String rightsType, String value) {
        web.typeClean(By.cssSelector(String.format("[data-rightstype='%s'] [name='notifyDays']", rightsType)), value);
    }

    public void fillMoreInfoTextarea(String value) {
        if (value != null) web.typeClean(getMoreInfoTextareaLocator(), value);
    }

    public void fillLicenseDetailsTextarea(String value) {
        if (value != null) web.typeClean(getLicenseDetailsTextareaLocator(), value);
    }

    public void fillContactDetailsTextarea(String value) {
        if (value != null) web.typeClean(getContactDetailsTextareaLocator(), value);
    }

    public void fillMediaTypeCommentTextarea(String type, String comment) {
        if (comment != null) web.typeClean(getMediaTypeCommentTextareaLocator(type), comment);
    }

    public void fillOtherUsageCommentTextarea(String comment) {
        if (comment != null) web.typeClean(getOtherUsageCommentTextareaLocator(), comment);
    }


    public void checkNotifyIfExpiredCheckbox(String rightsType) {
        new Checkbox(parentPage, By.cssSelector(String.format("[data-rightstype='%s'] [name='notifyIfExpired']", rightsType))).select();
    }

    public void checkIncludeTeamCheckbox(String rightsType) {
        new Checkbox(parentPage, By.cssSelector(String.format("[data-rightstype='%s'] [name='includeTeam']", rightsType))).select();
    }

    public void checkExpireCycleRadioButton() {
        web.click(getExpireCycleRadioButtonLocator());
    }

    public void checkMediaTypeCheckbox(String type) {
        WebElement element = web.findElement(getMediaTypeCheckboxLocator(type));
        if (!element.isSelected()) element.click();
    }

    public boolean isFieldRed(By locator) {
        return web.isElementPresent(locator) && web.findElement(locator).getAttribute("class").toLowerCase().contains("error");
    }

    private By getStartDateFieldLocator() {
        return By.xpath("//*[@role='combobox'][.//*[@name='startDate']]");
    }

    private By getExpirationDateFieldLocator() {
        return generateLocator("[data-role='expire-date'] > .date");
    }

    private By getCountryFieldLocator() {
        return generateLocator("[name='usageCountry'] .schema_theme");
    }

    private By getExpiresEveryDaysFieldLocator() {
        return generateLocator("[name='expireInDays']");
    }

    private By getArtistFieldLocator() {
        return generateLocator("[name='artist']");
    }

    private By getArtistRoleFieldLocator() {
        return generateLocator("[name='role']");
    }

    private By getRoleFieldLocator() {
        return generateLocator("[name='role']");
    }

    private By getBaseFeeFieldLocator() {
        return generateLocator("[name='baseFee']");
    }

    private By getAgentFieldLocator() {
        return generateLocator("[name='agent']");
    }

    private By getAgentTelFieldLocator() {
        return generateLocator("[name='agentTel']");
    }

    private By getEmailFieldLocator() {
        return generateLocator("[name='email']");
    }

    private By getUnionFieldLocator() {
        return generateLocator("[name='union']");
    }

    private By getTrackTitleFieldLocator() {
        return generateLocator("[name='trackTitle']");
    }

    private By getComposerFieldLocator() {
        return generateLocator("[name='composer']");
    }

    private By getTrackNumberFieldLocator() {
        return generateLocator("[name='trackNumber']");
    }

    private By getRecordLabelFieldLocator() {
        return generateLocator("[name='recordLabel']");
    }

    private By getSubLabelFieldLocator() {
        return generateLocator("[name='subLabel']");
    }

    private By getPublicationPublisherFieldLocator() {
        return generateLocator("[name='publicationPublisher']");
    }

    private By getArrangerFieldLocator() {
        return generateLocator("[name='arranger']");
    }

    private By getISRCNumberFieldLocator() {
        return generateLocator("[name='ISRCNumber']");
    }

    private By getDurationFieldLocator() {
        return generateLocator("[name='duration']");
    }

    private By getMoreInfoTextareaLocator() {
        return generateLocator("[name='moreInfo']");
    }

    private By getLicenseDetailsTextareaLocator() {
        return generateLocator("[name='licenseDetails']");
    }

    private By getContactDetailsTextareaLocator() {
        return generateLocator("[name='contactDetails']");
    }

    private By getOtherUsageCommentTextareaLocator() {
        return generateLocator("[name='comment']");
    }

    private By getMediaTypeCommentTextareaLocator(String type) {
        return By.xpath(String.format("//*[*[contains(@class,'pbxs')]/div[text()='%s']]//textarea", type));
    }

    private By getExpireCycleRadioButtonLocator() {
        return generateLocator("input.unit.mrxs[value='period']");
    }

    private By getMediaTypeCheckboxLocator(String type) {
        return By.xpath(String.format("//*[contains(@class,'pbxs')][div[text()='%s']]/input", type));
    }

    private By getUsageRightsNotificationSettingsArea() {
        return By.cssSelector("[data-dojo-type*='usageRightsNotificationExpirationSet']");
    }
}