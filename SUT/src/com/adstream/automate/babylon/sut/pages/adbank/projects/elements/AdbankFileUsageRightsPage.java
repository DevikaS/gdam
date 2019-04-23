package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Checkbox;
import com.adstream.automate.page.controls.DojoCombo;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.thoughtworks.selenium.SeleneseTestBase.assertFalse;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 24.10.12
 * Time: 13:19

 */
public class AdbankFileUsageRightsPage extends AdbankFileViewPage {
    public static final String GENERAL = "General";
    public static final String COUNTRIES = "Countries";
    public static final String MEDIA_TYPES = "Media Types";
    public static final String VISUAL_TALENT = "Visual Talent";
    public static final String VOICE_OVER_ARTIST = "Voice-over Artist";
    public static final String MUSIC = "Music";
    public static final String OTHER_USAGE = "Other usage";

    public AdbankFileUsageRightsPage (ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementDisappear(By.xpath("//*[@data-role='existingUsages'][normalize-space(text())='Loading...']"));
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertFalse(web.isElementVisible(By.xpath("//*[@data-role='existingUsages'][normalize-space(text())='Loading...']")));
    }

    public List<Map<String, String>> getGeneralFieldsList() {
        List<Map<String, String>> rules = new ArrayList<>();

        if (!web.isElementPresent(By.xpath(getUsageRuleXpath(GENERAL)))) return rules;

        List<String> startDates = web.findElementsToStrings(By.xpath(String.format(
                "%s//*[contains(@class,'loopContainer')]/*[position() mod 2 = 1]//*[last()]", getUsageRuleXpath(GENERAL))));
        List<String> expireDates = web.findElementsToStrings(By.xpath(String.format(
                "%s//*[contains(@class,'loopContainer')]/*[position() mod 2 = 0]//*[last()]", getUsageRuleXpath(GENERAL))));

        for (int i = 0; i < startDates.size(); i++) {
            Map<String, String> rule = new HashMap<>();
            rule.put("StartDate", startDates.get(i));
            rule.put("ExpirationDate", expireDates.get(i));
            rules.add(rule);
        }

        return rules;
    }

    public List<Map<String, String>> getCountriesFieldsList() {
        List<Map<String, String>> rules = new ArrayList<>();

        if (!web.isElementPresent(By.xpath(getUsageRuleXpath(COUNTRIES)))) return rules;

        List<String> countries = web.findElementsToStrings(By.cssSelector(String.format(
                "%s .itemsList > *:not(.headers) .unit:nth-child(1) div", getUsageRuleCssSelector(COUNTRIES))));
        List<String> startDates = web.findElementsToStrings(By.cssSelector(String.format(
                "%s .itemsList > *:not(.headers) .unit:nth-child(2) div", getUsageRuleCssSelector(COUNTRIES))));
        List<String> expireDates = web.findElementsToStrings(By.cssSelector(String.format(
                "%s .itemsList > *:not(.headers) .unit:nth-child(3) div", getUsageRuleCssSelector(COUNTRIES))));

        for (int i = 0; i < startDates.size(); i++) {
            Map<String, String> rule = new HashMap<>();
            rule.put("Country", countries.get(i));
            rule.put("StartDate", startDates.get(i));
            rule.put("ExpirationDate", expireDates.get(i));
            rules.add(rule);
        }

        return rules;
    }

    public List<Map<String, String>> getMediaTypesFieldsList() {
        List<Map<String, String>> rules = new ArrayList<>();

        if (!web.isElementPresent(By.xpath(getUsageRuleXpath(MEDIA_TYPES)))) return rules;

        List<String> typesWithoutComment = web.findElementsToStrings(By.xpath(String.format(
                "%s//*[contains(@class,'bold')][not(following-sibling::*[1][self::*[not(contains(@class,'bold'))]])]",
                getUsageRuleXpath(MEDIA_TYPES))));

        for (String type : typesWithoutComment) {
            Map<String, String> rule = new HashMap<>();
            rule.put("Type", type);
            rule.put("Comment", "");
            rules.add(rule);
        }

        List<String> typesWithComment = web.findElementsToStrings(By.xpath(String.format(
                "%s//*[contains(@class,'bold')][following-sibling::*[1][self::*[not(contains(@class,'bold'))]]]",
                getUsageRuleXpath(MEDIA_TYPES))));
        List<String> comments = web.findElementsToStrings(By.xpath(String.format(
                "%s//*[not(contains(@class,'bold'))][contains(@class,'mbm')]", getUsageRuleXpath(MEDIA_TYPES))));

        for (int i = 0; i < typesWithComment.size(); i++) {
            Map<String, String> rule = new HashMap<>();
            rule.put("Type", typesWithComment.get(i));
            rule.put("Comment", comments.get(i));
            rules.add(rule);
        }

        return rules;
    }

    public List<Map<String, String>> getVisualTalentFieldsList() {
        List<Map<String, String>> rules = new ArrayList<>();

        if (!web.isElementPresent(By.xpath(getUsageRuleXpath(VISUAL_TALENT)))) return rules;

        List<String> artistsNames = web.findElementsToStrings(By.cssSelector(String.format(
                "%s .row > .unit:nth-child(1) .vmiddle:last-child", getUsageRuleCssSelector(VISUAL_TALENT))));
        List<String> artistsRoles = web.findElementsToStrings(By.cssSelector(String.format(
                "%s .row > .unit:nth-child(2) .vmiddle", getUsageRuleCssSelector(VISUAL_TALENT))));
        List<String> startDates = web.findElementsToStrings(By.cssSelector(String.format(
                "%s .row > .unit:nth-child(3) .vmiddle", getUsageRuleCssSelector(VISUAL_TALENT))));
        List<String> expireDates = web.findElementsToStrings(By.cssSelector(String.format(
                "%s .row > .unit:nth-child(4) .vmiddle", getUsageRuleCssSelector(VISUAL_TALENT))));
        expandRuleRows(VISUAL_TALENT);
        List<String> baseFees = getExpandedFieldsList(VISUAL_TALENT, "Base Studio Fee/Day Rate");
        List<String> agents = getExpandedFieldsList(VISUAL_TALENT, "Agent");
        List<String> agentTels = getExpandedFieldsList(VISUAL_TALENT, "Agent Tel");
        List<String> emails = getExpandedFieldsList(VISUAL_TALENT, "Email Address");
        List<String> unions = getExpandedFieldsList(VISUAL_TALENT, "Union");
        List<String> moreInfoFields = getExpandedFieldsList(VISUAL_TALENT, "More Info");

        for (int i = 0; i < artistsNames.size(); i++) {
            Map<String, String> rule = new HashMap<>();
            rule.put("ArtistName", artistsNames.get(i));
            rule.put("StartDate", startDates.get(i));
            rule.put("ExpirationDate", expireDates.get(i));
            rule.put("BaseFee", baseFees.get(i));
            rule.put("Agent", agents.get(i));
            rule.put("AgentTel", agentTels.get(i));
            rule.put("Email", emails.get(i));
            rule.put("Union", unions.get(i));
            rule.put("MoreInfo", moreInfoFields.get(i));
            rule.put("Role", artistsRoles.get(i));
            rules.add(rule);
        }

        return rules;
    }

    public List<Map<String, String>> getVoiceOverArtistFieldsList() {
        List<Map<String, String>> rules = new ArrayList<>();

        if (!web.isElementPresent(By.xpath(getUsageRuleXpath(VOICE_OVER_ARTIST)))) return rules;

        List<String> artistsNames = web.findElementsToStrings(By.cssSelector(String.format(
                "%s .row > .unit:nth-child(1) .vmiddle:last-child", getUsageRuleCssSelector(VOICE_OVER_ARTIST))));
        List<String> roles = web.findElementsToStrings(By.cssSelector(String.format(
                "%s .row > .unit:nth-child(2) .vmiddle", getUsageRuleCssSelector(VOICE_OVER_ARTIST))));
        List<String> startDates = web.findElementsToStrings(By.cssSelector(String.format(
                "%s .row > .unit:nth-child(3) .vmiddle", getUsageRuleCssSelector(VOICE_OVER_ARTIST))));
        List<String> expireDates = web.findElementsToStrings(By.cssSelector(String.format(
                "%s .row > .unit:nth-child(4) .vmiddle", getUsageRuleCssSelector(VOICE_OVER_ARTIST))));
        expandRuleRows(VOICE_OVER_ARTIST);
        List<String> baseFees = getExpandedFieldsList(VOICE_OVER_ARTIST, "Base Studio Fee/Day Rate");
        List<String> agents = getExpandedFieldsList(VOICE_OVER_ARTIST, "Agent");
        List<String> agentTels = getExpandedFieldsList(VOICE_OVER_ARTIST, "Agent Tel");
        List<String> emails = getExpandedFieldsList(VOICE_OVER_ARTIST, "Email Address");
        List<String> unions = getExpandedFieldsList(VOICE_OVER_ARTIST, "Union");
        List<String> moreInfoFields = getExpandedFieldsList(VOICE_OVER_ARTIST, "More Info");

        for (int i = 0; i < artistsNames.size(); i++) {
            Map<String, String> rule = new HashMap<>();
            rule.put("ArtistName", artistsNames.get(i));
            rule.put("Role", roles.get(i));
            rule.put("StartDate", startDates.get(i));
            rule.put("ExpirationDate", expireDates.get(i));
            rule.put("BaseFee", baseFees.get(i));
            rule.put("Agent", agents.get(i));
            rule.put("AgentTel", agentTels.get(i));
            rule.put("Email", emails.get(i));
            rule.put("Union", unions.get(i));
            rule.put("MoreInfo", moreInfoFields.get(i));
            rules.add(rule);
        }

        return rules;
    }

    public List<Map<String, String>> getMusicFieldsList() {
        List<Map<String, String>> rules = new ArrayList<>();

        if (!web.isElementPresent(By.xpath(getUsageRuleXpath(MUSIC)))) return rules;

        List<String> artists = web.findElementsToStrings(By.cssSelector(String.format(
                "%s .row > .unit:nth-child(1) .vmiddle:last-child", getUsageRuleCssSelector(MUSIC))));
        List<String> trackTitles = web.findElementsToStrings(By.cssSelector(String.format(
                "%s .row > .unit:nth-child(2) .vmiddle", getUsageRuleCssSelector(MUSIC))));
        List<String> startDates = web.findElementsToStrings(By.cssSelector(String.format(
                "%s .row > .unit:nth-child(3) .vmiddle", getUsageRuleCssSelector(MUSIC))));
        List<String> expireDates = web.findElementsToStrings(By.cssSelector(String.format(
                "%s .row > .unit:nth-child(4) .vmiddle", getUsageRuleCssSelector(MUSIC))));
        expandRuleRows(MUSIC);
        List<String> composers = getExpandedFieldsList(MUSIC, "Composer");
        List<String> trackNumbers = getExpandedFieldsList(MUSIC, "Track Number");
        List<String> recordLabels = getExpandedFieldsList(MUSIC, "Record Label");
        List<String> subLabels = getExpandedFieldsList(MUSIC, "Sub Label");
        List<String> licenseDetails = getExpandedFieldsList(MUSIC, "License Details");
        List<String> publishers = getExpandedFieldsList(MUSIC, "Publication Co/Publisher");
        List<String> arrangers = getExpandedFieldsList(MUSIC, "Arranger");
        List<String> isrcNumbers = getExpandedFieldsList(MUSIC, "ISRC Number");
        List<String> durations = getExpandedFieldsList(MUSIC, "Duration");
        List<String> contactDetails = getExpandedFieldsList(MUSIC, "Contact Details");

        for (int i = 0; i < artists.size(); i++) {
            Map<String, String> rule = new HashMap<>();
            rule.put("ArtistName", artists.get(i));
            rule.put("TrackTitle", trackTitles.get(i));
            rule.put("StartDate", startDates.get(i));
            rule.put("ExpirationDate", expireDates.get(i));
            rule.put("Composer", composers.get(i));
            rule.put("TrackNumber", trackNumbers.get(i));
            rule.put("RecordLabel", recordLabels.get(i));
            rule.put("SubLabel", subLabels.get(i));
            rule.put("LicenseDetails", licenseDetails.get(i));
            rule.put("PublicationPublisher", publishers.get(i));
            rule.put("Arranger", arrangers.get(i));
            rule.put("ISRCNumber", isrcNumbers.get(i));
            rule.put("Duration", durations.get(i));
            rule.put("ContactDetails", contactDetails.get(i));
            rules.add(rule);
        }

        return rules;
    }

    public List<Map<String, String>> getOtherUsageFieldsList() {
        List<Map<String, String>> rules = new ArrayList<>();

        if (!web.isElementPresent(By.xpath(getUsageRuleXpath(OTHER_USAGE)))) return rules;

        List<String> comments = web.findElementsToStrings(By.cssSelector(String.format(
                "%s .loopContainer .mbm", getUsageRuleCssSelector(OTHER_USAGE))));

        for (String comment : comments) {
            Map<String, String> rule = new HashMap<>();
            rule.put("Comment", comment);
            rules.add(rule);
        }

        return rules;
    }

    public void selectUsageType(String value) {
        new DojoCombo(this, By.cssSelector(".usage-rights-selector[role='combobox']")).selectByVisibleText(value);
    }

    public AddUsageRightsPopUp clickAddUsageType() {
        web.click(getAddUsageTypeButtonLocator());
        Common.sleep(1000);
        return new AddUsageRightsPopUp(this);
    }

    public void clickEditLinkForUsageRule(String usageRule) {
        web.click(getEditUsageRuleLinkLocator(usageRule));
    }

    public int isCountofEditFormsAreCorrect(String typeUsage) {
        return web.findElements(By.xpath("//div[text()='" + typeUsage + "']")).size();
    }

    public void saveUsageRule(String ruleType) {
        web.click(By.cssSelector(String.format("[data-usagetype='%s'] [name='Save']", ruleType)));
        web.sleep(1000);
    }

    public void fillGeneralFields(int entryNumber, Map<String,String> fields) {
        fillCommonUsageFields(GENERAL, entryNumber, fields);
    }

    public void fillCountriesFields(int entryNumber, Map<String,String> fields) {
        if (fields.get("Country") != null) selectCountry(COUNTRIES, entryNumber, fields.get("Country"));
        fillCommonUsageFields(COUNTRIES, entryNumber, fields);
    }

    public void fillMediaTypesFields(int entryNumber, Map<String,String> fields) {
        String containerXpath = String.format("//*[@data-usagetype='%s']//*[contains(@class,'usage_rights_item')][%s]", MEDIA_TYPES, entryNumber);
        By checkLocator = By.xpath(String.format("%s//*[contains(@class,'pbxs')][div[text()='%s']]/input", containerXpath, fields.get("Type")));
        By commentFieldLocator = By.xpath(String.format("%s//*[*[contains(@class,'pbxs')]/div[text()='%s']]//textarea", containerXpath, fields.get("Type")));

        new Checkbox(this, checkLocator).select();
        web.typeClean(commentFieldLocator, fields.get("Comment"));
        fillCommonUsageFields(MEDIA_TYPES, entryNumber, fields);
    }

    public void fillVisualTalentFields(int entryNumber, Map<String,String> fields) {
        fillUsageTextFieldByName(VISUAL_TALENT, entryNumber, "artistName", fields.get("ArtistName"));
        fillUsageTextFieldByName(VISUAL_TALENT, entryNumber, "role", fields.get("Role"));
        fillCommonUsageFields(VISUAL_TALENT, entryNumber, fields);
    }

    public void fillVoiceOverArtistFields(int entryNumber, Map<String,String> fields) {
        fillUsageTextFieldByName(VOICE_OVER_ARTIST, entryNumber, "artistName", fields.get("ArtistName"));
        fillUsageTextFieldByName(VOICE_OVER_ARTIST, entryNumber, "role", fields.get("Role"));
        fillUsageTextFieldByName(VOICE_OVER_ARTIST, entryNumber, "baseFee", fields.get("BaseFee"));
        fillUsageTextFieldByName(VOICE_OVER_ARTIST, entryNumber, "agent", fields.get("Agent"));
        fillUsageTextFieldByName(VOICE_OVER_ARTIST, entryNumber, "agentTel", fields.get("AgentTel"));
        fillUsageTextFieldByName(VOICE_OVER_ARTIST, entryNumber, "email", fields.get("Email"));
        fillUsageTextFieldByName(VOICE_OVER_ARTIST, entryNumber, "union", fields.get("Union"));
        fillUsageTextFieldByName(VOICE_OVER_ARTIST, entryNumber, "moreInfo", fields.get("MoreInfo"));

        if (fields.get("StartDate") != null) {
            String locator = getUsageRuleEditEntryLocator(VOICE_OVER_ARTIST, entryNumber);
            locator += String.format(" :not([data-role='expire-date']) > .date");
            new DojoCombo(this, By.cssSelector(locator)).selectByVisibleText(fields.get("StartDate"));
        }

        if (fields.get("ExpiresEveryDays") != null && !fields.get("ExpiresEveryDays").isEmpty()) {
            clickExpireCycleRadioButton(VOICE_OVER_ARTIST, entryNumber);
            typeExpiresEveryDays(VOICE_OVER_ARTIST, entryNumber, fields.get("ExpiresEveryDays"));
        } else if (fields.get("ExpirationDate") != null) {
            String locator = getUsageRuleEditEntryLocator(VOICE_OVER_ARTIST, entryNumber);
            locator += String.format(" [data-role='expire-date'] > .date");
            new DojoCombo(this, By.cssSelector(locator)).selectByVisibleText(fields.get("ExpirationDate"));
        }

        fillCommonUsageFields(VOICE_OVER_ARTIST, entryNumber, fields);
    }

    public void fillMusicFields(int entryNumber, Map<String,String> fields) {
        fillUsageTextFieldByName(MUSIC, entryNumber, "artist", fields.get("ArtistName"));
        fillUsageTextFieldByName(MUSIC, entryNumber, "trackTitle", fields.get("TrackTitle"));
        fillUsageTextFieldByName(MUSIC, entryNumber, "composer", fields.get("Composer"));
        fillUsageTextFieldByName(MUSIC, entryNumber, "trackNumber", fields.get("TrackNumber"));
        fillUsageTextFieldByName(MUSIC, entryNumber, "recordLabel", fields.get("RecordLabel"));
        fillUsageTextFieldByName(MUSIC, entryNumber, "subLabel", fields.get("SubLabel"));
        fillUsageTextFieldByName(MUSIC, entryNumber, "publicationPublisher", fields.get("PublicationPublisher"));
        fillUsageTextFieldByName(MUSIC, entryNumber, "arranger", fields.get("Arranger"));
        fillUsageTextFieldByName(MUSIC, entryNumber, "ISRCNumber", fields.get("ISRCNumber"));
        fillUsageTextFieldByName(MUSIC, entryNumber, "duration", fields.get("Duration"));
        fillUsageTextFieldByName(MUSIC, entryNumber, "licenseDetails", fields.get("LicenseDetails"));
        fillUsageTextFieldByName(MUSIC, entryNumber, "contactDetails", fields.get("ContactDetails"));
        fillCommonUsageFields(MUSIC, entryNumber, fields);
    }


    public void fillOtherUsageFields(int entryNumber, Map<String,String> fields) {
        fillUsageTextFieldByName(OTHER_USAGE, entryNumber, "comment", fields.get("Comment"));
        fillCommonUsageFields(OTHER_USAGE, entryNumber, fields);
    }

    private void fillUsageTextFieldByName(String ruleType, int entryNumber, String name, String value) {
        if (value != null) {
            String locator;
            if (name.equals("artistName")) {
                locator = String.format("%s [id^='adbank_usageRights_artistsSelector']", getUsageRuleEditEntryLocator(ruleType, entryNumber));
            } else {
                locator = String.format("%s [name='%s']", getUsageRuleEditEntryLocator(ruleType, entryNumber), name);
            }
            web.typeClean(By.cssSelector(locator), value);
        }
    }

    private void checkUsageCheckboxByName(String ruleType, int entryNumber, String name) {
        String locator = String.format("%s [name='%s']", getUsageRuleEditEntryLocator(ruleType, entryNumber), name);
        new Checkbox(this, By.cssSelector(locator)).select();
    }

    private void fillCommonUsageFields(String ruleType, int entryNumber, Map<String,String> fields) {
        if (!ruleType.equals(VOICE_OVER_ARTIST) && !ruleType.equals(MEDIA_TYPES)) {
            if (fields.get("StartDate") != null && !fields.get("StartDate").isEmpty()) {
                selectStartDate(ruleType, entryNumber, fields.get("StartDate"));
            }

            if (fields.get("ExpiresEveryDays") != null && !fields.get("ExpiresEveryDays").isEmpty()) {
                clickExpireCycleRadioButton(ruleType, entryNumber);
                typeExpiresEveryDays(ruleType, entryNumber, fields.get("ExpiresEveryDays"));
            } else if (fields.get("ExpirationDate") != null) {
                selectExpirationDate(ruleType, entryNumber, fields.get("ExpirationDate"));
            }
        }

        if (Boolean.parseBoolean(fields.get("NotifyIfExpired"))) {
            checkUsageCheckboxByName(ruleType, entryNumber, "notifyIfExpired");
            fillUsageTextFieldByName(ruleType, entryNumber, "notifyDays", fields.get("DaysFromExpire"));

            if (Boolean.parseBoolean(fields.get("IncludeTeam"))) {
                checkUsageCheckboxByName(ruleType, entryNumber, "includeTeam");
            }
        }
    }

    public void removeUsageRuleEntry(String ruleType, int entryNumber) {
        web.clickThroughJavascript(By.cssSelector(String.format("%s .removeUsage", getUsageRuleEditEntryLocator(ruleType, entryNumber))));
        web.sleep(1000);
    }

    public void clickExpireCycleRadioButton(String ruleType, int entryNumber) {
        web.click(By.cssSelector(String.format("%s input.unit.mrxs[value='cycle']", getUsageRuleEditEntryLocator(ruleType, entryNumber))));
    }

    public void typeExpiresEveryDays(String ruleType, int entryNumber, String value) {
        web.typeClean(By.cssSelector(String.format("%s [name='expireEveryDays']", getUsageRuleEditEntryLocator(ruleType, entryNumber))), value);
    }

    public void selectStartDate(String ruleType, int entryNumber, String value) {
        By locator = By.cssSelector(String.format("%s :not([data-role='expire-date']) > .date", getUsageRuleEditEntryLocator(ruleType, entryNumber)));
        new DojoCombo(this, locator).selectByVisibleText(value);
    }

    public void selectExpirationDate(String ruleType, int entryNumber, String value) {
        By locator = By.cssSelector(String.format("%s [data-role='expire-date'] > .date", getUsageRuleEditEntryLocator(ruleType, entryNumber)));
        new DojoCombo(this, locator).selectByVisibleText(value);
    }

    public void selectCountry(String ruleType, int entryNumber, String value) {
        By locator = By.cssSelector(String.format("%s .dijitComboBox[id*='FilteringSelect']:not(.usage-rights-selector)", getUsageRuleEditEntryLocator(ruleType, entryNumber)));
        new DojoCombo(this, locator).selectByVisibleText(value);
    }

    public boolean isUsageRulePresent(String usageRule) {
        return web.isElementVisible(By.xpath(getUsageRuleXpath(usageRule)));
    }

    public boolean isEditLinkPresentForUsageRule(String usageRule) {
        return web.isElementVisible(getEditUsageRuleLinkLocator(usageRule));
    }

    private String getUsageRuleEditEntryLocator(String ruleType, int entryNumber) {
        return String.format("[data-usagetype='%s'] .usage_rights_item:nth-child(%d)", ruleType, entryNumber + 1);
    }

    private String getUsageRuleCssSelector(String ruleType) {
        return String.format("[data-usagetype='%s']", ruleType);
    }

    private String getUsageRuleXpath(String ruleType) {
        return String.format("//*[@data-usagetype='%s']", ruleType);
    }

    private By getAddUsageTypeButtonLocator() {
        return By.cssSelector("[data-role='add-usage-rule']");
    }

    private By getEditUsageRuleLinkLocator(String usageRule) {
        return By.cssSelector(String.format("[data-usagetype='%s'] [data-role='editButton']", usageRule));
    }

    private void expandRuleRows(String usageRule) {
        if (!web.isElementPresent(By.xpath(String.format("%s//*[@data-role='tableRow'][contains(@class, 'expanded')]", getUsageRuleXpath(usageRule))))) {
            List<WebElement> rows = web.findElements(By.xpath(String.format("%s//*[@data-role='tableRow']", getUsageRuleXpath(usageRule))));
            for (WebElement row : rows) {
                row.click();
                web.sleep(500);
            }
        }
    }

    private List<String> getExpandedFieldsList(String usageRule, String fieldName) {
        return web.findElementsToStrings(By.xpath(String.format(
                "%s//*[contains(@class,'pas')]//*[contains(@class,'bold')][text()='%s']/following-sibling::*",
                getUsageRuleXpath(usageRule),
                fieldName)));
    }
}