package com.adstream.automate.babylon.sut.pages.NewLibrary.pages;

import com.adstream.automate.babylon.sut.data.MetadataItem;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibraryWalkMePopup;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;

import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created by Janaki.Kamat on 06/10/2017.
 */
public class LibMultiEditAssetMetadataPage extends LibraryAssetsInfoPage {
    private static final By removeAssetLocator = By.xpath("*//*[@class=\"assetCard\"][.//*[contains(@class,'assetCard__details')]//a[@title=\"%s\"]]");
    private static final By sectionLocator= By.cssSelector("//ads-ui-sch-form-group");
    private static final By sectionDividerLocator=By.cssSelector("//ads-md-divider/span[text()=\"%s\"]");
    private static final By fieldSelectorsLocator=By.cssSelector("//ads-ui-sch-field-edit");
    private String comboBoxValueFormat = "//div[@class=\"option ui-select-choices-row-inner\"]//span";
    private static final String assetRemoveIconLocator = "*//asset-card-ngx[.//*[contains(text(),\"s\")]]//*[contains(@class,\"assetCard_remove\")]//span";
    private static final By editMessageLocator = By.cssSelector("asset-content-multi-edit a[class^='dark-ui-link']");

    public LibMultiEditAssetMetadataPage(ExtendedWebDriver web) {
        super(web);
    }

    public void load() {
        web.waitUntilElementAppearVisible(By.cssSelector("asset-wrapper-edit asset-content-multi-edit"));
    }

    public void isLoaded() throws Error {
        new LibraryWalkMePopup(this).clickClose();
        assertTrue(web.isElementVisible(By.cssSelector("asset-wrapper-edit asset-content-multi-edit")));
    }

    public List<String> getAvailableComboBoxValues(String field,String assetType)
    {
        if(assetType.equalsIgnoreCase("video") || assetType.equalsIgnoreCase("audio"))
        {
            WebElement sectionType = web.findElement(By.xpath("//ads-accordion[@description='"+assetType+"']//ads-md-button"));
            web.scrollToElement(sectionType);
            sectionType.click();

            WebElement headerType = web.findElement(By.xpath("//ads-accordion[@description='"+assetType+"']//ads-accordion[contains(@description,'Technical')]//ads-md-button"));
            web.scrollToElement(headerType);
            headerType.click();

        }
        else if(assetType.equalsIgnoreCase("digital") || assetType.equalsIgnoreCase("image"))
        {
            WebElement sectionType = web.findElement(By.xpath("//ads-accordion[@description='"+assetType+"']//ads-md-button"));
            web.scrollToElement(sectionType);
            sectionType.click();

            WebElement headerType = web.findElement(By.xpath("//ads-accordion[@description='"+assetType+"']//ads-accordion[contains(@description,'General')]//ads-md-button"));
            web.scrollToElement(headerType);
            headerType.click();
        }
        By locator = By.xpath(String.format("//ads-ui-sch-field-edit//ads-ui-select-dictionary[@label='%s']//span[contains(@class,'icon-arrow')]", field));
        web.scrollToElement(web.findElement(locator));
        web.findElement(locator).click();
        Common.sleep(1000);
        List<String> values = web.findElementsToStrings(By.xpath("//div[contains(@class,'ui-select-choices-row ng-scope')]//span"));
        return values;

    }

    public List<String> getSectionNames() {
        return web.findElementsToStrings(By.xpath("*//*[contains(@ng-repeat,\"section in $ctrl.sections\")]/ads-accordion//div[contains(@class,\"ng-binding\")]"));
    }

    public void fillEditFilePopup(List<MetadataItem> fields) {
        for (MetadataItem field : fields)
            fillFieldByName(field.getKey(), field.getValue(), field.getSection());
    }

    public boolean isSectionExpanded(String section){
        return web.isElementPresent(By.xpath(String.format("*//*[contains(@ng-repeat,\"section in $ctrl.sections\")]/ads-accordion[@description=\"%s\"]//*[@layout=\"row\"]/*[contains(text(),\"%s\")]/following-sibling::*[@click=\"$ctrl.toggle()\"]//button//span[contains(@code,\"chevron-outline-up\")]",section.toLowerCase(),section.toLowerCase())));
    }

    public void expandSection(String section,String name){
        if(!web.isElementPresent(By.xpath(String.format("*//*[contains(@ng-repeat,\"section in $ctrl.sections\")]/ads-accordion[@description=\"%s\"]//*[@layout=\"row\"]/*[contains(text(),\"%s\")]/following-sibling::*[@click=\"$ctrl.toggle()\"]//button//span[contains(@code,\"chevron-outline-up\")]",section.toLowerCase(),section.toLowerCase())))){
            web.click(By.xpath(String.format("*//*[contains(@ng-repeat,\"section in $ctrl.sections\")]/ads-accordion[@description=\"%s\"]//*[@layout=\"row\"]/*[contains(text(),\"%s\")]/following-sibling::*[@click=\"$ctrl.toggle()\"]//button",section.toLowerCase(),section.toLowerCase())));
            Common.sleep(1000);
        }
        List<WebElement> expandSection = web.findElements(By.cssSelector(String.format("ads-accordion[description=\"%s\"] [click=\"$ctrl.toggle()\"] button",section.toLowerCase())));
        for(WebElement elem:expandSection) {
            if(!web.isElementVisible(By.cssSelector(String.format("[placeholder=\"%s\"]",name)))) {
                if (!elem.findElement(By.cssSelector("span[code^=\"chevron-outline\"]")).getAttribute("code").equalsIgnoreCase("chevron-outline-up")) {
                    web.scrollToElement(elem);
                    elem.click();
                    Common.sleep(1000);
                }
            }
            else
                break;
        }
    }
    public void fillFieldByName(String name, String value, String section) {
    //    System.out.println("name===>"+name);
        expandSection(section,name);
        if (web.isElementPresent(By.xpath(getDateFieldLocator(name, section)))) {
            fillDateBoxField(name, value, section);
        } else if (web.isElementPresent(By.xpath(getComboboxFieldLocator(name, section)))) {
            fillComboboxField(name, value, section);
        } else if (web.isElementPresent(getTextFieldLocator(name, section))) {
            fillTextField(name, value, section);
        } else if (web.isElementPresent(By.xpath(getMultiSelectFieldLocator(name, section)))) {
            fillMultiSelectField(name, value, section);
        } else {
            String message = String.format("Field '%s' is not present on Edit File popup", name);
            if (section != null) message += String.format(" in section '%s'", section);
            throw new IllegalArgumentException(message);

        }
    }


    private By getTextFieldLocator(String name, String section) {
        String format = "%s//ads-md-input[@placeholder='%s']//input";
        return By.xpath(String.format(format, getSectionXpathString(section), name));
    }


    private String getMultiSelectFieldLocator(String name, String section) {
        String format = "%s//ads-md-multiselect[@placeholder='%s']//input";
        return String.format(format, getSectionXpathString(section), name);
    }

    private String getComboboxFieldLocator(String name, String section) {
        String format = "%s//ads-ui-select-dictionary[@placeholder='%s']//input";
        return String.format(format, getSectionXpathString(section), name);
    }


    private String getDateFieldLocator(String name, String section) {
        String format = "%s//ads-md-datepicker[@placeholder='%s']//md-input-container//input";
        return String.format(format, getSectionXpathString(section), name);
    }

    private By getComboInputSelector(String name, String value, String section){
        String comboInputFormat="%s//ads-md-dictionary[@placeholder='%s']//md-autocomplete-wrap/input";
        return By.xpath(String.format(comboInputFormat,getSectionXpathString(section),name));
    }


    public void fillComboboxField(String name, String value, String section) {
        if(web.isElementPresent(By.xpath(String.format("%s//ads-ui-select-dictionary[@placeholder='%s']//*[@ng-click=\"$ctrl.clearModel()\"]",getSectionXpathString(section),name)))) {
            web.scrollToElement(web.findElement(By.xpath(String.format("%s//ads-ui-select-dictionary[@placeholder='%s']//*[@ng-click=\"$ctrl.clearModel()\"]",getSectionXpathString(section),name))));
            web.click(By.xpath(String.format("%s//ads-ui-select-dictionary[@placeholder='%s']//*[@ng-click=\"$ctrl.clearModel()\"]", getSectionXpathString(section), name)));
        }
        else
            web.findElement(By.xpath(getComboboxFieldLocator(name, section))).clear();
        if(!value.isEmpty()) {
            try {
                if (web.isElementPresent(By.xpath(String.format("%s//ads-ui-select-dictionary[@placeholder='%s']//*[@ng-click=\"$ctrl.clearModel()\"]", getSectionXpathString(section), name)))) {
                    web.scrollToElement(web.findElement(By.xpath(String.format("%s//ads-ui-select-dictionary[@placeholder='%s']//*[@ng-click=\"$ctrl.clearModel()\"]", getSectionXpathString(section), name))));
                    web.click(By.xpath(String.format("%s//ads-ui-select-dictionary[@placeholder='%s']//*[@ng-click=\"$ctrl.clearModel()\"]", getSectionXpathString(section), name)));
                } else {
                    WebElement elem = web.findElement(By.xpath(getComboboxFieldLocator(name, section)));
                    web.scrollToElement(elem);
                    elem.click();
                    elem.sendKeys(value);
                    web.waitUntilElementAppear(By.xpath("//ads-ui-select-dictionary//div[contains(@class,'ui-select-choices-row-inner')]//span[contains(text(),'" + value + "')]"));
                    web.findElement(By.xpath("//ads-ui-select-dictionary//div[contains(@class,'ui-select-choices-row-inner')]//span[contains(text(),'" + value + "')]")).click();

                }
            }
            catch(Exception e){
                if(web.isElementPresent(By.xpath("/*//*[contains(text(),\"No matches found\")]")))
                    web.click(By.xpath("/*//*[contains(text(),\"No matches found\")]"));
            }}
    }

    public void fillMultiSelectField(String name, String value, String section) {
        WebElement elem=web.findElement(By.xpath(getMultiSelectFieldLocator(name, section)));
        if(!value.trim().isEmpty()) {
            web.scrollToElement(elem);
            web.typeClean(By.xpath(getMultiSelectFieldLocator(name, section)), value);
            Common.sleep(1000);
            for (WebElement element : web.findElements(By.xpath(multiSelectFormat))) {
                if (element.getText().equalsIgnoreCase(value)) {
                    element.click();
                    break;
                }
            }
        }
        else{
            for(WebElement link:web.findElements(By.xpath(String.format("*//ads-md-multiselect[@placeholder=\"%s\"]//a[@ng-click=\"$selectMultiple.removeChoice($index)\"]",name))))
                link.click();
        }
    }


    protected String getSectionXpathString(String section) {
        if (section == null)
            return "";
        else
            return String.format("*//*[@description=\"%s\"]//*[contains(@class,\"layout-row\")]", section.toLowerCase());
    }

    public void fillDateBoxField(String name, String value, String section) {
        web.scrollToElement(web.findElement(By.xpath(getDateFieldLocator(name, section))));
        web.getJavascriptExecutor().executeScript("arguments[0].setAttribute('value', '" + value +"')", (web.findElement(By.xpath(getDateFieldLocator(name, section)))));
      }

    public void fillTextField(String name, String value, String section) {
        web.scrollToElement(web.findElement(getTextFieldLocator(name, section)));
        web.typeClean(getTextFieldLocator(name, section), value);
    }

    private void waitUntilEditFilePopUpAppears() {
        web.waitUntilElementAppearVisible(By.cssSelector("asset-content-multi-edit"));
        web.sleep(1000);
    }

    public void save() {
        web.click(By.cssSelector("[click=\"$ctrl.submit()\"] button"));
        waitUntilEditFilePopUpAppears();
    }

    public void cancel() {
        web.click(By.cssSelector("[click=\"$ctrl.cancel()\"] button"));
        waitUntilEditFilePopUpAppears();
    }

    public void clickEditAssetIcon()
    {
        web.click(By.cssSelector("ads-md-button[click=\"$ctrl.onEditClick()\"] button"));
    }


    public void removeAsset(String title){
        web.click(By.xpath(String.format(assetRemoveIconLocator,title)));
    }

    public List<String> getTitleNames() {
        return web.findElementsToStrings(By.xpath("//*[contains(@class,'assetCard__details')]//a"));
    }

    public String getEditMessage(){
        return web.findElement(editMessageLocator).getText();
    }

    public void clickEditMessage(String editMessage){
        if(web.isElementVisible(editMessageLocator) && web.findElement(editMessageLocator).getText().equalsIgnoreCase(editMessage))
            web.click(editMessageLocator);
    }

    public boolean checkSectionPresent(String sectionName){
        return web.isElementPresent(By.xpath(getSectionXpathString(sectionName)));
    }

    public String getMultiSelectCount_Label(){
        return web.findElement(By.cssSelector("[translate=\"ASSET_MULTI_EDIT_COUNT\"]")).getText();
    }

    public String getOneByOne_Label(){
        return web.findElement(By.cssSelector("[ng-click=\"$ctrl.editOneByOne()\"]")).getText();
    }

    public String getMetadata_Label(){
        return web.findElement(By.cssSelector("[class^=\"asset-tab-info-content\"] .text-muted.text-uppercase.ng-scope")).getText();
    }

    public String getProductInfo_Label(){
        return web.findElement(By.cssSelector("ads-ui-sch-form-group ads-accordion .smalltext.text-muted.text-uppercase.ng-binding")).getText();
    }


    public String getSaveButton_Label(){
        return web.findElement(By.cssSelector("[click=\"$ctrl.submit()\"] button[ng-click=\"$ctrl.onClick()\"]")).getText();
    }

    public String getCancelButton_Label(){
        return web.findElement(By.cssSelector("ads-md-button[click=\"$ctrl.cancel()\"] button[ng-click=\"$ctrl.onClick()\"] span[class=\"ng-scope\"]")).getText();
    }

    public String getEditDetails_Label(){
        return web.findElement(By.cssSelector("asset-tabs h4[ng-if=\"$ctrl.edit\"]")).getText();
    }
}
