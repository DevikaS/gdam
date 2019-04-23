

package com.adstream.automate.babylon.sut.pages.NewLibrary.elements;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Checkbox;
import com.adstream.automate.page.controls.DojoCombo;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Janaki.Kamat on 11/09/2018.
 */
public class LibAddUsageRightsPopup extends LibPopUpWindow {
    private final String usageRightsSelector = "md-select[placeholder=\"Select a right type\"]";

    public LibAddUsageRightsPopup(Page parent) {
        super(parent, "add-usage-rights");
        Common.sleep(1000);
        web.waitUntil(ExpectedConditions.presenceOfElementLocated(generateLocator()));
    }

    public LibAddUsageRightsPopup selectType(String businessUnit) {
        web.click(generateLocator(usageRightsSelector));
        Common.sleep(2000);
        web.findElement(By.xpath(String.format("//md-option[@ng-repeat=\"usageType in ::$ctrl.usageTypes\"][@value='%s']", businessUnit))).click();
        return this;
    }

    public LibAddUsageRightsPopup fillGeneralFields(Map<String, String> fields) {
        selectStartDate(fields.get("StartDate"));
        selectExpirationDate(fields.get("ExpirationDate"));

        if (fields.get("ExpiresEveryDays") != null) {
            checkExpireCycleRadioButton();
            fillExpiresEveryDaysField(fields.get("ExpiresEveryDays"));
        }
      //  web.getJavascriptExecutor().executeScript("arguments[0].click();",web.findElement(By.tagName("html")));
        return this;
    }

    public void selectStartDate(String value) {
        web.findElement(By.xpath("//ads-md-datepicker[@placeholder='Start Date']//md-input-container//input")).sendKeys(value);
        web.findElement(By.xpath("//ads-md-datepicker[@placeholder='Start Date']//md-input-container//input")).sendKeys(Keys.ENTER);
        Common.sleep(2000);
    }

    public void selectExpirationDate(String value) {
        web.findElement(By.xpath("//ads-md-datepicker[@placeholder='Expire Date']//md-input-container//input")).sendKeys(value);
        web.findElement(By.xpath("//ads-md-datepicker[@placeholder='Start Date']//md-input-container//input")).sendKeys(Keys.ENTER);
        Common.sleep(2000);
    }

    public void checkExpireCycleRadioButton() {
        web.click(By.cssSelector("ads-md-radio-button[value=\"period\"] md-radio-button"));
    }

    public void fillExpiresEveryDaysField(String value) {
        if (value != null && !value.isEmpty())
            web.typeClean(By.xpath("//ads-md-input[@placeholder='Expire In Days']//md-input-container//input"), value);
    }

    public Boolean isNotificationExist()
    {
        return web.isElementVisible(By.xpath("//ads-md-checkbox[@ng-click='$ctrl.toggleNotify()']"));
    }

    public void save() {
        web.click(By.tagName("html"));
        web.findElement(generateLocator("ads-md-button[state=\"primary\"] button")).click();
        web.waitUntilElementDisappear(generateLocator());

    }
    public void checkNotify()
    {
        web.findElement(By.xpath("//ads-md-checkbox[@ng-click='$ctrl.toggleNotify()']//md-checkbox")).click();
    }

    public void enterDaysBeforeExpireToNotify(String days)
    {
        web.findElement(By.xpath("//ads-md-input[@model='$ctrl.notification.daysBefore']//input")).sendKeys(days);
    }

    public void clickCancel()
    {
        web.findElement(generateLocator("ads-md-button[state=\"default\"] button")).click();
    }

    public boolean isSaveDisabled()
    {
    return web.isElementVisible(By.xpath("//ads-md-button[@click='$ctrl.save()']/button[@disabled='disabled']"));
    }

    public LibAddUsageRightsPopup fillCountriesFields(Map<String, String> fields) {
       // selectCountry(fields.get("Country"));
        for (String country : fields.get("Country").split(",")) {
            selectCountry(country);
        }

        return fillGeneralFields(fields);
    }


    public void selectCountry(String value) {
        web.findElement(By.xpath("//ads-md-multiselect[@placeholder=\"Country\"]//input")).clear();
        if (!value.isEmpty()) {
            web.typeClean(By.xpath("//ads-md-multiselect[@placeholder=\"Country\"]//input"), value);
            web.findElement(By.xpath("//*[@class=\"ui-select-choices-group\"]//li[@ng-repeat=\"option in $select.items\"]//span[contains(text(),'"+value+"')]")).click();
        }
        web.getJavascriptExecutor().executeScript("arguments[0].click();",web.findElement(By.tagName("html")));
    }

    public void selectMedia(String value) {
        web.findElement(By.xpath("//ads-md-multiselect[@placeholder=\"Select media type\"]//input")).clear();
        Common.sleep(1000);
        if (!value.isEmpty()) {
            web.typeClean(By.xpath("//ads-md-multiselect[@placeholder=\"Select media type\"]//input"), value);
            Common.sleep(1000);
            web.findElement(By.xpath("//*[@class=\"ui-select-choices-group\"]//li[@ng-repeat=\"option in $select.items\"]//span[contains(text(),'"+value+"')]")).click();
        }
        Common.sleep(1000);
        web.getJavascriptExecutor().executeScript("arguments[0].click();",web.findElement(By.tagName("html")));
    }

    public void fillMediaTypesFields(Map<String,String> fields) {
        selectMedia(fields.get("Type"));
        Common.sleep(1000);
        addComment(fields.get("Comment"));
        //     return this;
    }

    public void fillOtherUsageRightsFields(Map<String,String> fields) {
        web.typeClean(By.cssSelector("ads-md-textArea[placeholder=\"Comment\"] textarea"),fields.get("Comment")+Keys.ENTER);
        Common.sleep(3000);
        //  return this;
    }


    public void addComment(String comment){
        web.click(By.cssSelector("ads-md-button[ng-click=\"$ctrl.comments[selectedType].isToggled = true\"] button"));
        Common.sleep(3000);
        web.findElement(By.cssSelector("ads-md-textArea[placeholder=\"Comment\"] textarea")).sendKeys(comment+Keys.ENTER);
        Common.sleep(3000);
        web.getJavascriptExecutor().executeScript("arguments[0].click();",web.findElement(By.tagName("html")));
    }



    public LibAddUsageRightsPopup fillVisualTalentFields(Map<String,String> fields) {
        fillArtist(fields.get("ArtistName"));
        fillArtistRole(fields.get("Role"));
        fillAgent(fields.get("Agent"));
        fillAgentTel(fields.get("AgentTel"));
        fillEmail(fields.get("Email"));
        fillUnion(fields.get("Union"));
        fillMoreInfoTextarea(fields.get("MoreInfo"));

        return fillGeneralFields(fields);
    }

    public LibAddUsageRightsPopup fillMusicFields(Map<String,String> fields) {
        fillArtistField(fields.get("ArtistName"));
        fillTrackTitleField(fields.get("TrackTitle"));
        fillComposerField(fields.get("Composer"));
        fillTrackNumberField(fields.get("TrackNumber"));
        fillRecordLabelField(fields.get("RecordLabel"));
        fillSubLabelField(fields.get("SubLabel"));
        fillPublicationPublisherField(fields.get("PublicationPublisher"));
        fillAlbumReleaseDate(fields.get("Album release date"));
        fillPhysicalReleaseDate(fields.get("Physical release date"));
        fillDigitalReleaseDate(fields.get("Digital release date"));
        fillTrackDurationField(fields.get("Track duration"));
        fillYearOfProductionField(fields.get("Year of production"));
        fillArrangerField(fields.get("Arranger"));
        fillContactDetailsField(fields.get("ContactDetails"));
        fillLicenseDetailsField(fields.get("LicenseDetails"));
        fillISRCNumberField(fields.get("ISRCNumber"));
        fillTrackTypeField(fields.get("TrackType"));
        fillDurationField(fields.get("Duration"));
        return fillGeneralFields(fields);
    }

    public LibAddUsageRightsPopup fillVoiceOverArtistFields(Map<String,String> fields) {
        fillArtist(fields.get("ArtistName"));
        fillArtistRole(fields.get("Role"));
        fillAgent(fields.get("Agent"));
        fillAgentTel(fields.get("AgentTel"));
        fillEmail(fields.get("Email"));
        fillUnion(fields.get("Union"));
        fillMoreInfoTextarea(fields.get("MoreInfo"));
        return fillGeneralFields(fields);
    }

    public Map<String, String> getVoiceOverArtistFieldsList(){
        Map<String, String> rule = new HashMap<>();
        rule.put("ArtistName",web.findElement(getArtistLocator()).getAttribute("value"));
        rule.put("Agent",web.findElement(getAgentLocator()).getAttribute("value"));
        rule.put("AgentTel",web.findElement(getAgentTelephoneLocator()).getAttribute("value"));
        rule.put("Email",web.findElement(getEmailLocator()).getAttribute("value"));
        rule.put("Union",web.findElement(getUnionLocator()).getAttribute("value"));
        return rule;
    }

    public Map<String, String> getVisualTalentFieldsList(){
        Map<String, String> rule = new HashMap<>();
        rule.put("ArtistName",web.findElement(getArtistLocator()).getAttribute("value"));
        rule.put("Agent",web.findElement(getAgentLocator()).getAttribute("value"));
        rule.put("AgentTel",web.findElement(getAgentTelephoneLocator()).getAttribute("value"));
        rule.put("Email",web.findElement(getEmailLocator()).getAttribute("value"));
        rule.put("Union",web.findElement(getUnionLocator()).getAttribute("value"));
        return rule;
    }

    public List <String> getValuesFromArtistField(String artistName){
      List<String> values=null;
      web.findElement(getArtistLocator()).sendKeys(artistName);
      Common.sleep(1000);
      values = web.findElementsToStrings(By.xpath("//ul[@class='md-autocomplete-suggestions']/li"));
      return values;

    }

    public void fillArtist(String value) {
        if (value != null) {
            web.waitUntilElementAppear(getArtistLocator());
            web.findElement(getArtistLocator()).clear();
            web.findElement(getArtistLocator()).sendKeys(value);
            Common.sleep(2000);
            if(web.isElementVisible(By.xpath("//ul[@class='md-autocomplete-suggestions']/li")))
            {
                web.findElement(By.xpath("//ul[@class='md-autocomplete-suggestions']/li")).click();
            }

        }
    }

    public void fillMoreInfoTextarea(String value){
        if (value != null) {
            web.findElement(getMoreInfoLocator()).sendKeys(value);
        }
    }

    public void fillArtistRole(String value) {
        if (value != null) {
            web.findElement(getArtistRoleLocator()).sendKeys(value);
            Common.sleep(1000);
        }
    }

    public void fillBaseFee(String value) {
        if (value != null) {
            WebElement elem= web.findElement(getBaseFeeLocator());
            elem.sendKeys(value);
            Common.sleep(2000);
        }
    }

    public void fillAgent(String value) {
        if (value != null) {
            web.typeClean(getAgentLocator(),value);
            Common.sleep(2000);
        }
    }

    public void fillAgentTel(String value) {
        if (value != null) {
            web.typeClean(getAgentTelephoneLocator(),value);
            Common.sleep(2000);
        }
    }

    public void fillEmail(String value) {
        if (value != null) {
            web.typeClean(getEmailLocator(),value);
        }
    }

    public void fillUnion(String value) {
        if (value != null) {
            web.typeClean(getUnionLocator(),value);
        }
    }

    public void fillISRCNumberField(String value){
        if (value != null) web.findElement(getISRCNumberFieldLocator()).sendKeys(value);
    }

    public void fillTrackTypeField(String value){
        if (value != null) web.findElement(getTrackType(value)).click();
    }
    public void fillPublicationPublisherField(String value){
        if (value != null) web.findElement(getPublicationPublisher()).sendKeys(value);
    }

    public void fillArrangerField(String value){
        if (value != null)
            web.findElement(getArrangeLocator()).sendKeys(value);
    }

    public void fillDurationField(String value){
        if (value != null)web.findElement(getDurationLocator()).sendKeys(value);
    }

    public void fillContactDetailsField(String value){
        if (value != null){
            web.findElement(getContactDetailsLocator()).sendKeys(value);
        }

    }

    public void fillLicenseDetailsField(String value){
        if (value != null) {
            web.findElement(getLicenseDetailsLocator()).sendKeys(value);
        }
    }

    public void fillDigitalReleaseDate(String value){
        if (value != null)
            web.findElement(getDigitalReleaseDate()).sendKeys(value);
    }

    public void fillAlbumReleaseDate(String value){
        if (value != null)
            web.findElement(getAlbumReleaseDate()).sendKeys(value);
    }

    public void fillPhysicalReleaseDate(String value){
        if (value != null)web.findElement(getPhysicalReleaseDate()).sendKeys(value);
    }

    public void fillTrackDurationField(String value){
        if (value != null)web.findElement(getTrackDuration()).sendKeys(value);
    }

    public void fillComposerField(String value) {
        if (value != null) web.typeClean(getComposerFieldLocator(), value);
    }

    public void fillArtistField(String value){
        if (value != null) {
            web.waitUntilElementAppear(getArtistFieldLocator());
            web.findElement(getArtistFieldLocator()).sendKeys(value);}
    }

    public void fillSubLabelField(String value){
        if (value != null) web.findElement(getSubLabel()).sendKeys(value);
    }

    public void  fillRecordLabelField(String value){
        if (value != null) web.findElement(getRecordLabelLocator()).sendKeys(value);
    }
    public void fillTrackNumberField(String value){
        if (value != null)
            web.findElement(getTrackNumberFieldLocator()).sendKeys(value);
    }

    public void fillTrackTitleField(String value){
        if (value != null)
            web.findElement(getTrackFieldLocator()).sendKeys(value);
    }

    private By getArtistFieldLocator() {
        return generateLocator("input[placeholder='Artist']");
    }

    private By getTrackNumberFieldLocator() {
        return generateLocator("input[placeholder='Track Number']");
    }

    private By getRecordLabelLocator(){
        return generateLocator("input[placeholder='Record Label']");
    }

    private By getArrangeLocator(){
        return generateLocator("input[placeholder='Arranger']");
    }

    private By getContactDetailsLocator(){
        return generateLocator("textarea[placeholder=\"Contact Details\"]");
    }

    private By getLicenseDetailsLocator(){
        return generateLocator("textarea[placeholder=\"License Details\"]");
    }

    private By getTrackFieldLocator() {
        return generateLocator("input[placeholder='Track Title']");
    }

    private By getComposerFieldLocator() {
        return generateLocator("input[placeholder='Composer']");
    }

    private By getPublicationPublisher(){
        return generateLocator("input[placeholder='Publication Publisher']");
    }

    private By getTrackType(){
        return generateLocator("input[placeholder='Publication Publisher']");
    }

    private By getSubLabel(){
        return generateLocator("input[placeholder='Sub Label']");
    }

    private By getAlbumReleaseDate(){
        return generateLocator("input[placeholder='Album release date']");
    }

    private By getPhysicalReleaseDate(){
        return generateLocator("input[placeholder='Physical release date']");
    }

    private By getDigitalReleaseDate(){
        return generateLocator("input[placeholder='Digital release date']");
    }


    private By getTrackDuration(){
        return generateLocator("input[placeholder='Track duration']");
    }

    private By getYearOfProduction(){
        return generateLocator("input[placeholder='Year of production']");
    }

    private void fillYearOfProductionField(String value){
        if (value != null)
            web.findElement(getYearOfProduction()).sendKeys(value);
    }

    private By getISRCNumberFieldLocator() {
        return generateLocator("input[placeholder='ISRC Number']");
    }

    private By getDurationLocator() {
        return generateLocator("input[placeholder='Duration']");
    }

    private By getTrackType(String value){
        return generateXpathLocator(String.format("*//div[contains(text(),\"Track Type\")]//following-sibling::ads-md-radio-group//ads-md-radio-button[value=\"%s\"]",value));
    }

    private By getArtistLocator() {
        return generateLocator("input[placeholder=\"Artist Name\"]");
    }

    private By getArtistRoleLocator() {
        return generateLocator("input[placeholder=\"Role\"]");
    }

    private By getBaseFeeLocator() {
        return generateLocator("input[placeholder=\"Base Fee\"]");
    }

    private By getAgentLocator() {
        return generateLocator("input[placeholder=\"Agent\"]");
    }

    private By getAgentTelephoneLocator() {
        return generateLocator("input[placeholder=\"Agent Telephone\"]");
    }

    private By getEmailLocator() {
        return generateLocator("input[placeholder=\"Email\"]");
    }

    private By getUnionLocator() {
        return generateLocator("input[placeholder=\"Union\"]");
    }

    private By getMoreInfoLocator() {
        return generateLocator("textarea[placeholder=\"More Info\"]");
    }


}



