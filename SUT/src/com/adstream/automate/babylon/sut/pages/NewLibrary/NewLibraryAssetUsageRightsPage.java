

package com.adstream.automate.babylon.sut.pages.NewLibrary;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibAddUsageRightsPopup;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibEditUsageRightsPopup;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibRemoveUsageRightsPopup;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibraryWalkMePopup;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.LibraryAssetsInfoPage;
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

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created by Janaki.Kamat on 27/06/2018.
 */
public class NewLibraryAssetUsageRightsPage extends LibraryAssetsInfoPage {
    private static final By usageRights = By.cssSelector("[ng-repeat=\"(key, usageRightGroup) in $ctrl.usageRightsGroups track by key\"] .smalltext");
    private static final By addUsageRightsButton = By.cssSelector("[id=\"usage-rights-add-button\"]");
    private static final By editUsageRightsButton = By.cssSelector("[click^=\"$ctrl.edit(usageRightGroupName, $index)\"] button");
    private static final By removeUsageRightsButton = By.cssSelector("[click=\"$ctrl.remove(usageRightGroupName, $index)\"] button");
    public static final String GENERAL = "General";
    public static final String COUNTRIES = "Countries";
    public static final String MEDIA_TYPES = "Media Types";
    public static final String VISUAL_TALENT = "Visual Talent";
    public static final String VOICE_OVER_ARTIST = "Voice-over Artist";
    public static final String MUSIC = "Music";
    public static final String OTHER_USAGE = "Other usage";

    public NewLibraryAssetUsageRightsPage(ExtendedWebDriver web) {
        super(web);
    }

    public void load() {
        web.waitUntilElementAppearVisible(getPageLocator());
    }

    public void isLoaded() throws Error {
        new LibraryWalkMePopup(this).clickClose();
        assertTrue(web.isElementVisible(getPageLocator()));
    }

    private By getPageLocator() {
        return By.tagName("asset-tab-usage-rights");
    }

    public String getUsageRights() {
        return web.findElement(usageRights).getText();
    }

    public LibAddUsageRightsPopup clickAddUsageRights() {
        web.click(addUsageRightsButton);
        Common.sleep(1000);
        return new LibAddUsageRightsPopup(this);
    }

    public LibEditUsageRightsPopup clickEditUsageRights(String usageRule, int entryNumber) {
        if (!web.isElementPresent(By.xpath(getUsageRuleXpath(usageRule)))) throw new IllegalArgumentException("");
        if (web.isElementPresent(By.xpath(String.format("//*[@ng-repeat = \"(usageRightGroupName, usageRightGroup) in $ctrl.usageRightsGroups track by usageRightGroupName\"][@description=\"%s\"]//md-divider[@ng-if=\"!$ctrl.isToggled\"]", usageRule))))
            web.click(By.xpath(String.format("//*[@ng-repeat = \"(usageRightGroupName, usageRightGroup) in $ctrl.usageRightsGroups track by usageRightGroupName\"][translate(@description, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')=\"%s\"]//ads-md-button[starts-with(@id,\"accordion-toggle\")]//button", usageRule.toLowerCase())));
        List<WebElement> elems=web.findElements(By.xpath(String.format("//*[@ng-repeat = \"(usageRightGroupName, usageRightGroup) in $ctrl.usageRightsGroups track by usageRightGroupName\"][translate(@description, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')=\"%s\"]//ads-md-button[@click=\"::$mdOpenMenu($event)\"]//button", usageRule.toLowerCase())));
        elems.get(entryNumber-1).click();
        web.getJavascriptExecutor().executeScript("arguments[0].click();",web.findElement(editUsageRightsButton));
        Common.sleep(1000);
        return new LibEditUsageRightsPopup(this);
    }

    public LibRemoveUsageRightsPopup clickRemoveUsageRights(String usageRule, int entryNumber) {
        if (!web.isElementPresent(By.xpath(getUsageRuleXpath(usageRule)))) throw new IllegalArgumentException("");

        if (web.isElementPresent(By.xpath(String.format("//*[@ng-repeat = \"(usageRightGroupName, usageRightGroup) in $ctrl.usageRightsGroups track by usageRightGroupName\"][@description=\"%s\"]//md-divider[@ng-if=\"!$ctrl.isToggled\"]", usageRule))))
            web.click(By.xpath(String.format("//*[@ng-repeat = \"(usageRightGroupName, usageRightGroup) in $ctrl.usageRightsGroups track by usageRightGroupName\"][translate(@description, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')=\"%s\"]//ads-md-button[starts-with(@id,\"accordion-toggle\")]//button", usageRule.toLowerCase())));
        web.click(By.xpath(String.format("//*[@ng-repeat = \"(usageRightGroupName, usageRightGroup) in $ctrl.usageRightsGroups track by usageRightGroupName\"][translate(@description, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')=\"%s\"]//ads-md-button[@click=\"::$mdOpenMenu($event)\"]//button", usageRule.toLowerCase())));
        List<WebElement> elems=web.findElements(By.xpath(String.format("//*[@ng-repeat = \"(usageRightGroupName, usageRightGroup) in $ctrl.usageRightsGroups track by usageRightGroupName\"][translate(@description, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')=\"%s\"]//ads-md-button[@click=\"::$mdOpenMenu($event)\"]//button", usageRule.toLowerCase())));
        elems.get(entryNumber-1).click();
        Common.sleep(1000);
        web.getJavascriptExecutor().executeScript("arguments[0].click()",web.findElement(removeUsageRightsButton));
        return new LibRemoveUsageRightsPopup(this);
    }


    public List<Map<String, String>> getGeneralFieldsList() {
        List<Map<String, String>> rules = new ArrayList<>();

        if (!web.isElementPresent(By.xpath(getUsageRuleXpath(GENERAL)))) return rules;

        if (web.isElementPresent(By.xpath(String.format("//*[@ng-repeat = \"(usageRightGroupName, usageRightGroup) in $ctrl.usageRightsGroups track by usageRightGroupName\"][@description=\"%s\"]//md-divider[@ng-if=\"!$ctrl.isToggled\"]", GENERAL))))
            web.click(By.xpath(String.format("//*[@ng-repeat = \"(usageRightGroupName, usageRightGroup) in $ctrl.usageRightsGroups track by usageRightGroupName\"][@description=\"%s\"]//ads-md-button[@id=\"accordion-toggle-General\"]//button", GENERAL.substring(0, 1).toUpperCase() + GENERAL.substring(1))));
        List<String> startDates = web.findElementsToStrings(By.xpath(String.format(
                "%s//*[@ng-if=\"::$ctrl.oneTimeBinding\"][..//*[contains(text(),\"Start Date\")]]//*[contains(@class,\"value\")]", getUsageRuleXpath(GENERAL))));
        List<String> expireDates = web.findElementsToStrings(By.xpath(String.format(
                "%s//*[@ng-if=\"::$ctrl.oneTimeBinding\"][..//*[contains(text(),\"Expire Date\")]]//*[contains(@class,\"value\")]", getUsageRuleXpath(GENERAL))));

        for (int i = 0; i < startDates.size(); i++) {
            Map<String, String> rule = new HashMap<>();
            rule.put("StartDate", startDates.get(i));
            rule.put("ExpirationDate", expireDates.get(i));
            rules.add(rule);
        }

        return rules;
    }

    public List<Map<String, String>> getCountries() {
        List<Map<String, String>> rules = new ArrayList<>();

        if (!web.isElementPresent(By.xpath(getUsageRuleXpath(COUNTRIES)))) return rules;
        if (web.isElementVisible(By.xpath(String.format("//*[@ng-repeat = \"(usageRightGroupName, usageRightGroup) in $ctrl.usageRightsGroups track by usageRightGroupName\"][@description=\"%s\"]//md-divider[@ng-if=\"!$ctrl.isToggled\"]", COUNTRIES))))
            web.click(By.xpath(String.format("//*[@ng-repeat = \"(usageRightGroupName, usageRightGroup) in $ctrl.usageRightsGroups track by usageRightGroupName\"][@description=\"%s\"]//ads-md-button[@id=\"accordion-toggle-Countries\"]//button", COUNTRIES)));
        List<String> countries = web.findElementsToStrings(By.xpath(String.format(
                "%s//*[@ng-if=\"::$ctrl.oneTimeBinding\"][..//*[contains(text(),\"Country\")]]//*[contains(@class,\"value\")]", getUsageRuleXpath(COUNTRIES))));
        List<String> startDates = web.findElementsToStrings(By.xpath(String.format(
                "%s//*[@ng-if=\"::$ctrl.oneTimeBinding\"][..//*[contains(text(),\"Start Date\")]]//*[contains(@class,\"value\")]", getUsageRuleXpath(COUNTRIES))));
        List<String> expireDates = web.findElementsToStrings(By.xpath(String.format(
                "%s//*[@ng-if=\"::$ctrl.oneTimeBinding\"][..//*[contains(text(),\"Expire Date\")]]//*[contains(@class,\"value\")]", getUsageRuleXpath(COUNTRIES))));

        for (int i = 0; i < startDates.size(); i++) {
            Map<String, String> rule = new HashMap<>();
            rule.put("Country", countries.get(i));
            rule.put("StartDate", startDates.get(i));
            rule.put("ExpirationDate", expireDates.get(i));
            rules.add(rule);
        }

        return rules;
    }


    public List<Map<String, String>> getMediaTypes() {
        List<Map<String, String>> rules = new ArrayList<>();
        if (!web.isElementPresent(By.xpath(getUsageRuleXpath(MEDIA_TYPES)))) return rules;
        if (web.isElementPresent(By.xpath(String.format("//*[@ng-repeat = \"(usageRightGroupName, usageRightGroup) in $ctrl.usageRightsGroups track by usageRightGroupName\"][@description=\"%s\"]//md-divider[@ng-if=\"!$ctrl.isToggled\"]", MEDIA_TYPES))))
            web.click(By.xpath(String.format("//*[@ng-repeat = \"(usageRightGroupName, usageRightGroup) in $ctrl.usageRightsGroups track by usageRightGroupName\"][@description=\"%s\"]//ads-md-button[@id=\"accordion-toggle-Media-Types\"]//button", MEDIA_TYPES)));
        Common.sleep(1000);
        List<String> mediaTypes = web.findElementsToStrings(By.cssSelector("ads-accordion[description=\"Media Types\"] [ng-repeat=\"(usageItemName, usageItemValue) in usage.properties track by usageItemName\"] .label"));
        List<String> comments = web.findElementsToStrings(By.cssSelector("ads-accordion[description=\"Media Types\"] [ng-repeat=\"(usageItemName, usageItemValue) in usage.properties track by usageItemName\"] .value"));

        for (int i = 0; i < mediaTypes.size(); i++) {
            Map<String, String> rule = new HashMap<>();
            rule.put("Type", mediaTypes.get(i));
            rule.put("Comment", comments.get(i));
            rules.add(rule);
        }

        return rules;
    }

    public List<Map<String, String>> getMusicFieldsList() {
        List<Map<String, String>> rules = new ArrayList<>();

        if (!web.isElementPresent(By.xpath(getUsageRuleXpath(MUSIC)))) return rules;
        if (web.isElementPresent(By.xpath(String.format("//*[@ng-repeat = \"(usageRightGroupName, usageRightGroup) in $ctrl.usageRightsGroups track by usageRightGroupName\"][@description=\"%s\"]//md-divider[@ng-if=\"!$ctrl.isToggled\"]", MUSIC))))
            web.click(By.xpath(String.format("//*[@ng-repeat = \"(usageRightGroupName, usageRightGroup) in $ctrl.usageRightsGroups track by usageRightGroupName\"][@description=\"%s\"]//ads-md-button[@click=\"$ctrl.toggle()\"]//button", MUSIC)));

        List<String> artists = web.findElementsToStrings(By.cssSelector(
                "ads-accordion[description=\"Music\"] ads-md-read-only[label=\"Artist\"] .value"));
        List<String> trackTitles = web.findElementsToStrings(By.cssSelector("ads-accordion[description=\"Music\"] ads-md-read-only[label=\"Track Title\"] .value"));
        List<String> startDates = web.findElementsToStrings(By.cssSelector("ads-accordion[description=\"Music\"] ads-md-read-only[label=\"Start Date\"] .value"));
        List<String> expireDates = web.findElementsToStrings(By.cssSelector("ads-accordion[description=\"Music\"] ads-md-read-only[label=\"Expire Date\"] .value"));

        List<String> composers = web.findElementsToStrings(By.cssSelector("[label=\"Composer\"] .value"));
        List<String> trackNumbers = web.findElementsToStrings(By.cssSelector("[label=\"Track Number\"] .value"));
        List<String> recordLabels = web.findElementsToStrings(By.cssSelector("[label=\"Record Label\"] .value"));
        List<String> subLabels = web.findElementsToStrings(By.cssSelector("[label=\"Sub Label\"] .value"));
        List<String> licenseDetails = web.findElementsToStrings(By.cssSelector("[label=\"License Details\"] .value"));
        List<String> publishers = web.findElementsToStrings(By.cssSelector("[label=\"Publication Publisher\"] .value"));
        List<String> arrangers = web.findElementsToStrings(By.cssSelector("[label=\"Arranger\"] .value"));
        List<String> isrcNumbers = web.findElementsToStrings(By.cssSelector("[label=\"ISRC Number\"] .value"));
        List<String> durations = web.findElementsToStrings(By.cssSelector("[label=\"Duration\"] .value"));
        List<String> contactDetails = web.findElementsToStrings(By.cssSelector("[label=\"Contact Details\"] .value"));

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

    private String getUsageRuleXpath(String ruleType) {
        return String.format("//*[@ng-repeat = \"(usageRightGroupName, usageRightGroup) in $ctrl.usageRightsGroups track by usageRightGroupName\"][@description=\"%s\"]", ruleType);
    }

    public List<Map<String, String>> getOtherUsageList() {
        List<Map<String, String>> rules = new ArrayList<>();
        if (!web.isElementPresent(By.xpath(getUsageRuleXpath(OTHER_USAGE)))) return rules;
        if (web.isElementPresent(By.xpath(String.format("//*[@ng-repeat = \"(usageRightGroupName, usageRightGroup) in $ctrl.usageRightsGroups track by usageRightGroupName\"][@description=\"%s\"]//md-divider[@ng-if=\"!$ctrl.isToggled\"]", OTHER_USAGE))))
            web.click(By.xpath(String.format("//*[@ng-repeat = \"(usageRightGroupName, usageRightGroup) in $ctrl.usageRightsGroups track by usageRightGroupName\"][@description=\"%s\"]//ads-md-button[@id=\"accordion-toggle-Other-usage\"]//button", OTHER_USAGE)));
        List<String> comments = web.findElementsToStrings(By.cssSelector("ads-accordion[description=\"Other usage\"] [label=\"Comment\"] .value"));

        for (int i = 0; i < comments.size(); i++) {
            Map<String, String> rule = new HashMap<>();
            rule.put("Comment", comments.get(i));
            rules.add(rule);
        }

        return rules;
    }


    public List<Map<String, String>> getVisualTalentList() {
        List<Map<String, String>> rules = new ArrayList<>();
        if (!web.isElementPresent(By.xpath(getUsageRuleXpath(VISUAL_TALENT)))) return rules;
        if (web.isElementPresent(By.xpath(String.format("//*[@ng-repeat = \"(usageRightGroupName, usageRightGroup) in $ctrl.usageRightsGroups track by usageRightGroupName\"][@description=\"%s\"]//md-divider[@ng-if=\"!$ctrl.isToggled\"]", VISUAL_TALENT))))
            web.click(By.xpath(String.format("//*[@ng-repeat = \"(usageRightGroupName, usageRightGroup) in $ctrl.usageRightsGroups track by usageRightGroupName\"][@description=\"%s\"]//ads-md-button[@id=\"accordion-toggle-Visual-Talent\"]//button", VISUAL_TALENT)));

        List<String> artistsNames = web.findElementsToStrings(By.cssSelector("ads-accordion[description=\"Visual Talent\"] [label=\"Artist Name\"] .value"));
        List<String> artistsRoles = web.findElementsToStrings(By.cssSelector("ads-accordion[description=\"Visual Talent\"] [label=\"Role\"] .value"));
        List<String> startDates = web.findElementsToStrings(By.cssSelector("ads-accordion[description=\"Visual Talent\"] [label=\"Start Date\"] .value"));
        List<String> expireDates = web.findElementsToStrings(By.cssSelector("ads-accordion[description=\"Visual Talent\"] [label=\"Expire Date\"] .value"));
        List<String> agents = web.findElementsToStrings(By.cssSelector("ads-accordion[description=\"Visual Talent\"] ads-md-read-only[label=\"Agent\"] .value"));
        List<String> agentTels =  web.findElementsToStrings(By.cssSelector("ads-accordion[description=\"Visual Talent\"] ads-md-read-only[label=\"Agent Telephone\"] .value"));
        List<String> emails = web.findElementsToStrings(By.cssSelector("ads-accordion[description=\"Visual Talent\"] ads-md-read-only[label=\"Email\"] .value"));
        List<String> unions = web.findElementsToStrings(By.cssSelector("ads-accordion[description=\"Visual Talent\"] ads-md-read-only[label=\"Union\"] .value"));
        List<String> moreInfoFields = web.findElementsToStrings(By.cssSelector("ads-accordion[description=\"Visual Talent\"] ads-md-read-only[label=\"More Info\"] .value"));

        Common.sleep(2000);
        for (int i = 0; i < artistsNames.size(); i++) {
            Map<String, String> rule = new HashMap<>();
            rule.put("ArtistName", artistsNames.get(i));
            rule.put("StartDate", startDates.get(i));
            rule.put("ExpirationDate", expireDates.get(i));
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
        if(web.isElementVisible(By.xpath(String.format("//ads-accordion[@description='%s']//ads-md-button/button//span[@code='chevron-outline-down']",VOICE_OVER_ARTIST))))
        {
          WebElement ele = web.findElement(By.xpath(String.format("//ads-accordion[@description='%s']//ads-md-button/button//span[@code='chevron-outline-down']",VOICE_OVER_ARTIST)));
          web.clickThroughJavascript(ele);
      }
        List<String> artistsNames = web.findElementsToStrings(By.cssSelector("ads-accordion[description=\"Voice-over Artist\"] [label=\"Artist Name\"] .value"));
        List<String> artistsRoles = web.findElementsToStrings(By.cssSelector("ads-accordion[description=\"Voice-over Artist\"] [label=\"Role\"] .value"));
        List<String> startDates = web.findElementsToStrings(By.cssSelector("ads-accordion[description=\"Voice-over Artist\"] [label=\"Start Date\"] .value"));
        List<String> expireDates = web.findElementsToStrings(By.cssSelector("ads-accordion[description=\"Voice-over Artist\"] [label=\"Expire Date\"] .value"));
        List<String> agents = web.findElementsToStrings(By.cssSelector("ads-accordion[description=\"Voice-over Artist\"] ads-md-read-only[label=\"Agent\"] .value"));
        List<String> agentTels =  web.findElementsToStrings(By.cssSelector("ads-accordion[description=\"Voice-over Artist\"] ads-md-read-only[label=\"Agent Telephone\"] .value"));
        List<String> emails = web.findElementsToStrings(By.cssSelector("ads-accordion[description=\"Voice-over Artist\"] ads-md-read-only[label=\"Email\"] .value"));
        List<String> unions = web.findElementsToStrings(By.cssSelector("ads-accordion[description=\"Voice-over Artist\"] ads-md-read-only[label=\"Union\"] .value"));
        List<String> moreInfoFields = web.findElementsToStrings(By.cssSelector("ads-accordion[description=\"Voice-over Artist\"] ads-md-read-only[label=\"More Info\"] .value"));
        Common.sleep(2000);
        for (int i = 0; i < artistsRoles.size(); i++) {
            Map<String, String> rule = new HashMap<>();
            rule.put("ArtistName", artistsNames.get(i));
            rule.put("StartDate", startDates.get(i));
            rule.put("ExpirationDate", expireDates.get(i));
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


    public Boolean checkRemoveOption(String usageRule, int entryNumber) {
        if (!web.isElementPresent(By.xpath(getUsageRuleXpath(usageRule)))) throw new IllegalArgumentException("");

        if (web.isElementPresent(By.xpath(String.format("//*[@ng-repeat = \"(usageRightGroupName, usageRightGroup) in $ctrl.usageRightsGroups track by usageRightGroupName\"][@description=\"%s\"]//md-divider[@ng-if=\"!$ctrl.isToggled\"]", usageRule))))
            web.click(By.xpath(String.format("//*[@ng-repeat = \"(usageRightGroupName, usageRightGroup) in $ctrl.usageRightsGroups track by usageRightGroupName\"][translate(@description, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')=\"%s\"]//ads-md-button[starts-with(@id,\"accordion-toggle\")]//button", usageRule.toLowerCase())));
        Common.sleep(1000);
        web.click(By.xpath(String.format("//*[@ng-repeat = \"(usageRightGroupName, usageRightGroup) in $ctrl.usageRightsGroups track by usageRightGroupName\"][translate(@description, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')=\"%s\"]//ads-md-button[@click=\"::$mdOpenMenu($event)\"]//button", usageRule.toLowerCase())));
        List<WebElement> elems=web.findElements(By.xpath(String.format("//*[@ng-repeat = \"(usageRightGroupName, usageRightGroup) in $ctrl.usageRightsGroups track by usageRightGroupName\"][translate(@description, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')=\"%s\"]//ads-md-button[@click=\"::$mdOpenMenu($event)\"]//button", usageRule.toLowerCase())));
        elems.get(entryNumber-1).click();
        Common.sleep(1000);
        return web.isElementPresent(removeUsageRightsButton);
    }


    public Boolean checkAddOption() {
        return web.isElementPresent(addUsageRightsButton);
    }

    public Boolean checkMessage(String message) {
        return web.findElement(By.cssSelector("asset-tab-usage-rights .ng-binding")).getText().contains(message);
    }

    public boolean isEditLinkPresent(String usagerule)
    {
        boolean flag=false;
        web.findElement(By.xpath("//ads-accordion[@description='"+usagerule+"']//ads-md-button/button")).click();
        if(web.isElementVisible(By.xpath("//div[@class='usage-item ng-scope'][1]//ads-md-button/button")))
        {
            web.findElement(By.xpath("//div[@class='usage-item ng-scope'][1]//ads-md-button/button")).click();
            flag=web.isElementVisible(By.xpath("//ads-md-button[@click='$ctrl.edit(usageRightGroupName, $index)']"));
        }
        return flag;
    }


    public boolean getUsageIndicator(String text) {
        return web.isElementVisible(By.xpath("//span[.='" + text + "']"));

    }

    public int countOfUsageRights(String usagerule )
    {
        web.findElement(By.xpath("//ads-accordion[@description='"+usagerule+"']//ads-md-button/button")).click();
        return web.findElements(By.xpath("//ads-accordion[@description='"+usagerule+"']//div[@class='usage-item ng-scope']")).size();
    }

}

