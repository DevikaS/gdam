package com.adstream.automate.babylon.sut.pages.NewLibrary.pages;

import com.adstream.automate.babylon.sut.data.MetadataItem;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibAcceptAssetSharedCategory;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibEditFilePopup;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibraryWalkMePopup;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.RestorePopUp;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.FlowPlayerPage;
import com.adstream.automate.babylon.sut.pages.library.BaseLibraryPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.apache.commons.lang.ArrayUtils;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.FluentWait;
import org.openqa.selenium.support.ui.Wait;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.function.Function;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created by Janaki.Kamat on 25/04/2017.
 */
public class LibraryAssetsInfoPage extends BaseLibraryPage<LibraryAssetsInfoPage> {
    private static final int ADMIN_INFORMATION_FIELDS = 0;
    private static final int ASSET_INFORMATION_FIELDS = 1;
    private static final int FILE_SPECIFICATION_FIELDS = 2;
    private static final By backToLibraryLocator = By.cssSelector("ads-md-button[click=\"$ctrl.closeView()\"]");
    protected static final String multiSelectFormat = "//*[@class=\"ui-select-choices-group\"]//li[@ng-repeat=\"option in $select.items\"]";
    private static final By menuSlateStoryBoard = By.cssSelector("ads-md-button[data-role=\"file-preview-video-toggle\"] button");
    private static final By acceptButtonLocator = By.cssSelector("[id='inbox-previewer-accept-button'] button");
    private static final By rejectButtonLocator = By.cssSelector("[id='inbox-previewer-reject-button'] button");

    //  private static final By sectionLocator= By.xpath("//ads-ui-sch-form//ads-ui-sch-form-group[contains(@class,\"ng-scope ng-isolate-scope\")]//span[contains(@class,\"smalltext ng-binding\")]");

    public LibraryAssetsInfoPage(ExtendedWebDriver web) {
        super(web);
    }

    public void load() {
        web.waitUntilElementAppearVisible(By.cssSelector("asset-wrapper[class=\"ng-scope ng-isolate-scope\"]"));
    }

    public void isLoaded() throws Error {
        new LibraryWalkMePopup(this).clickClose();
        assertTrue(web.isElementVisible(By.cssSelector("asset-wrapper[class=\"ng-scope ng-isolate-scope\"]")));
    }

    public List<String> getSectionNames() {
        return web.findElementsToStrings(By.cssSelector("[class=\"text-muted text-uppercase ng-scope\"]"));
    }

    public By getAssetInformationFieldNamesLocator() {
        return By.cssSelector("[class^=\"asset-data-group\"] [class^=\"ng-isolate-scope\"] [class=\"label ng-binding ng-scope\"]");
    }


    private By getSpecificationFieldsLocator() {
        return By.cssSelector("[class^=\"asset-data-group\"] [ng-if=\"$ctrl.fileSpecDictionary[key]\"] [class=\"label ng-binding ng-scope\"]");
    }

    private By getProjectRelatedIconLocator(){
        return By.xpath("//ads-md-button[@ui-sref='.relatedProjects']");
    }

    private By getCustomMetadataFieldsLocator() {
        return By.cssSelector("[data=\"$ctrl.asset\"] div[class^='asset-data-group'] [class=\"label ng-binding ng-scope flex\"]");
    }

    private By getAssetInformationValueLocator(String name) {
        return By.xpath(String.format("//*[contains(@class,\"asset-data-group\")]//ads-md-read-only[@label='%s']//*[@class=\"value ng-binding ng-scope\"]", name));
    }

    private By getCustomFieldValueLocator(String name, String section) {
        if (section.equalsIgnoreCase("METADATA"))
            return By.xpath(String.format("//div/ads-ui-sch-field-view[contains(@ng-repeat,\"field in $ctrl.group.fields\")]//ads-md-read-only[@label=\"%s\"]//*[contains(@class,'value')]", name));
        else
            return By.xpath(String.format("%s//following-sibling::div/*[contains(@ng-repeat,\"field in $ctrl.group.fields\")]//*[@ng-if=\"$ctrl.label\"][normalize-space()='%s']/following-sibling::*[contains(@class,'value')]", getSectionXpathString(section), name));
    }

    private By getSpecificationFieldValueLocator(String name) {
        return By.xpath(String.format("//*[contains(@class,\"asset-data-group\")]//*[@label='%s']//ads-truncate[contains(@class,'ng-isolate-scope flex-offset')]", name));

         }

    public List<String> getAssetInformationFieldNames() {
        return getFieldNames(null, ASSET_INFORMATION_FIELDS);
    }

    public List<String> getCustomFieldNames() {
        return getCustomFieldNames(null);
    }

    public List<String> getCustomFieldNames(String section) {
        return getFieldNames(section, ADMIN_INFORMATION_FIELDS);
    }

    public List<String> getSpecificationFieldNames() {
        return getFieldNames(null, ASSET_INFORMATION_FIELDS);
    }


    public List<String> getFieldNames(String section, int fieldType) {
        switch (fieldType) {
            case ADMIN_INFORMATION_FIELDS:
                return web.findElementsToStrings(getCustomFieldNamesLocator(section));
            case ASSET_INFORMATION_FIELDS:
                return web.findElementsToStrings(getAssetInformationFieldNamesLocator());
            case FILE_SPECIFICATION_FIELDS:
                return web.findElementsToStrings(getSpecificationFieldsLocator());
            default:
                throw new IllegalArgumentException("Unknown field type given");
        }

    }

    private List<MetadataItem> getFields(int fieldsType) {
        List<MetadataItem> assetInformation = new ArrayList<>();
        switch (fieldsType) {
            case ADMIN_INFORMATION_FIELDS:
                for (String section : getSectionNames()) {
                    if (section.isEmpty()) {
                        section = "default";
                    }
                    for (String name : getFieldNames(section, fieldsType)) {
                        String value = getFieldValue(name, section, fieldsType).replaceAll(", +", ",");
                        assetInformation.add(new MetadataItem(section, name, value));
                    }
                }
                return assetInformation;
            case ASSET_INFORMATION_FIELDS:
            case FILE_SPECIFICATION_FIELDS:
                for (String name : getFieldNames(null, fieldsType)) {
                    assetInformation.add(new MetadataItem(name, getFieldValue(name, null, fieldsType)));
                }
                return assetInformation;
            default:
                throw new IllegalArgumentException("Unknown field type given");
        }
    }


    public String getFieldValue(String named, String section, int fieldType) {
        switch (fieldType) {
            case ASSET_INFORMATION_FIELDS:
                return web.findElement(getAssetInformationValueLocator(named)).getText();
            case ADMIN_INFORMATION_FIELDS:
                return web.findElement(getCustomFieldValueLocator(named, section)).getText();
            case FILE_SPECIFICATION_FIELDS:
                return web.findElement(getSpecificationFieldValueLocator(named)).getText();
            default:
                throw new IllegalArgumentException("Unknown field type given");
        }
    }

    /* public String getValue(String name,int section){
         switch (section){
             case ADMIN_INFORMATION_FIELDS:
                 for(WebElement adminField:web.findElements(getProductInfoFieldsLocator(section))){
                     if(name.equalsIgnoreCase(adminField.getText()))
                         return adminField.findElement(By.cssSelector("+div[class=\"value ng-binding flex-offset-10 flex\"]\"")).getText();
                 }
             case ASSET_INFORMATION_FIELDS:
                 for(WebElement adminField:web.findElements(getAssetInformationFieldNamesLocator())){
                     if(name.equalsIgnoreCase(adminField.getText()))
                         return adminField.findElement(By.cssSelector("+div[class=\"value ng-binding flex-offset-10 flex\"]")).getText();
                 }
             case FILE_SPECIFICATION_FIELDS:
                 for(WebElement adminField:web.findElements(getSpecificationFieldsLocator())){
                     if(name.equalsIgnoreCase(adminField.getText()))
                         return adminField.findElement(By.cssSelector("+div[class=\"value ng-binding flex-offset-10 flex\"]")).getText();
                 }
             default:
                 throw new IllegalArgumentException("Unknown field values");
         }
     }
 */
    private By getEditIconLocator() {
        return By.cssSelector("ads-md-button[click=\"$ctrl.onEditClick()\"] button");
    }

    public By getTabLocator(String collectionId, String assetId, String tab) {
        return By.cssSelector(String.format("[href=\"#/collections/%s/assets/%s/%s\"]", collectionId, assetId, tab));
    }

    public void clickEditTabLink(String CollectionId, String assetId, String tab) {
        waitUntilPopUpNotificationMessageDisappeared();
        switch (tab) {
            case "Attachments":
                web.click(getTabLocator(CollectionId, assetId, "attachments"));
                break;
            case "Destinations":
                web.click(getTabLocator(CollectionId, assetId, "deliveries"));
                break;
            default:
                break;
        }
    }

    public LibEditFilePopup clickEditLink() {
        web.waitUntilElementAppear(getEditIconLocator());
        web.findElement(getEditIconLocator()).click();
        return new LibEditFilePopup(this);
    }

    public boolean isDownloadButtonVisible() {
        return web.isElementVisible(getDownloadButtonLocator());
    }

    // TODO Download Original Button not visible right now
    public boolean isDownloadOriginalVisible() {
        if (!web.isElementVisible(getDownloadButtonLocator()))
            return false;
        return clickDownloadOnLibrary().isMasterDownloadVisible();
    }

    public boolean isDownloadProxyVisible() {
        if (!web.isElementVisible(getDownloadButtonLocator()))
            return false;
        return clickDownloadOnLibrary().isProxyDownloadVisible();
    }
    public boolean isPreviewForFileAvailable(String assetId,String assetName) {
        boolean condition = false;

        if (assetName.contains(".mp4") || assetName.contains(".mov") || assetName.contains(".wmv") || assetName.contains(".mpg")) {
            By locator = By.xpath("//ads-file-preview-video//ads-video-player");
            condition = web.isElementPresent(locator);
        }
        else if (assetName.contains(".gif") || assetName.contains(".swf"))
       {
             By locator = By.xpath("//ads-file-preview-digital[contains(@url,'/api/file/"+assetId+"')]");
            condition = web.isElementPresent(locator);
        }
        else if(assetName.contains(".ai") ||assetName.contains(".psd") ||assetName.contains(".jpg"))
        {
            By locator = By.xpath("//ads-file-preview-image//img[contains(@src,'/api/file/"+assetId+"')]");
            condition = web.isElementPresent(locator);
        }
        else if(assetName.contains(".html") || assetName.contains(".xlsx") || assetName.contains(".xls") || assetName.contains(".doc") || assetName.contains(".docx") || assetName.contains(".ppt") || assetName.contains(".pptx") || assetName.contains(".pdf"))
        {
            By locator = By.xpath("//ads-file-preview-pdf");
            condition = web.isElementPresent(locator);
        }
        else if(assetName.contains(".zip"))
        {
            By locator = By.xpath("//ads-file-preview-icon");
            condition = web.isElementPresent(locator);
        }
        else if(assetName.contains(".txt"))
        {
            By locator = By.xpath("//ads-file-preview");
            condition = web.isElementPresent(locator);
        }
        return  condition;
    }

    public boolean isShareAssetVisible() {
        openPopup();
        return web.isElementVisible(getShareButtonLocator());
    }

    public boolean isRemoveButtonVisible() {
        openPopup();
        return web.isElementVisible(getRemoveButtonLocator());
    }

    public boolean isChangeMediaButtonVisible() {
        openPopup();
        return web.isElementVisible(getChangeMediaLocator());
    }

    public boolean isAttachmentsIconVisible(){
        return web.isElementVisible(getAttachmentsIconLocator());
    }

    public boolean isUsageRightsIconVisible(){
        return web.isElementVisible(getAddUsageRightsButtonLocatorOnAssetInfoPage());
    }


    public boolean isDelivereiesIconVisible(){
        return web.isElementVisible(getDeliveriesIconLocator());
    }

    public boolean isProjectsIconVisible(){
        return web.isElementVisible(getProjectsIconLocator());
    }

    public boolean isActivitiesIconVisible(){
        return web.isElementVisible(getActivitiesIconLocator());
    }

    public boolean isInfoIconVisible(){
        return web.isElementVisible(getInfoIconLocator());
    }

    public boolean isEditLinkVisible() {
        return web.isElementVisible(getEditIconLocator());
    }

    public boolean isPlayerAvailable() {
        return new FlowPlayerPage(web).isPlayerReady();
    }


    public List<MetadataItem> getAssetInformationFields() {
        return getFields(ASSET_INFORMATION_FIELDS);
    }

    public List<MetadataItem> getCustomMetadataFields() {
        return getFields(ADMIN_INFORMATION_FIELDS);
    }

    public List<MetadataItem> getSpecificationFields() {
        return getFields(FILE_SPECIFICATION_FIELDS);
    }

    private By getCustomFieldNamesLocator(String section) {
        if (section.equalsIgnoreCase("METADATA"))
            return By.xpath("//div/ads-ui-sch-field-view[contains(@ng-repeat,\"field in $ctrl.group.fields\")]//*[@ng-if=\"$ctrl.label\"]");
        else
            return By.xpath(String.format("%s//following-sibling::div/*[contains(@ng-repeat,\"field in $ctrl.group.fields\")]//*[@ng-if=\"$ctrl.label\"]", getSectionXpathString(section)));
    }

    protected String getSectionXpathString(String section) {
        if (section == null) {
            return "";
        } else {
            return String.format(".//*[contains(@ng-repeat,\"section in $ctrl.sections\")]//*[@description=\"%s\"]", section);
        }
    }



    public void clickBackToLibrary() {
        web.click(backToLibraryLocator);
        web.waitUntilElementDisappear(By.cssSelector("asset-wrapper[class=\"ng-scope ng-isolate-scope\"]"));
    }

    public String getHyperlinkCustomMetadataValue(String name)
    {
            return web.findElement(By.xpath("//div/ads-ui-sch-field-view[contains(@ng-repeat,'field in $ctrl.group.fields')]//ads-md-read-only-link[@label='" + name + "']//*[contains(@class,'value')]")).getText();
    }

    public boolean isUsageIndicatorLabelExist(String text) {
        return web.isElementVisible(By.xpath("//span[.='" + text + "']"));

    }

    public void play() throws InterruptedException {
        web.getJavascriptExecutor().executeScript("jwplayer().play();");
    }

    public String getJwplayerState() throws InterruptedException {
        waitForPlayer();
        return web.getJavascriptExecutor().executeScript("return jwplayer().getState()").toString();
    }

    private boolean waitForPlayer() throws InterruptedException {
        boolean isPlayerLoaded = false;
        Wait<JavascriptExecutor> wait = new FluentWait<JavascriptExecutor>(web.getJavascriptExecutor())
                .withTimeout(30, TimeUnit.SECONDS)
                .pollingEvery(5, TimeUnit.SECONDS)
                .ignoring(NullPointerException.class);

       isPlayerLoaded = wait.until(new Function<JavascriptExecutor, Boolean>() {
            public Boolean apply(JavascriptExecutor executor) {
                return executor.executeScript("return jwplayer().getState()") != null;
            }
        });
        return isPlayerLoaded;
    }

    private boolean waitForMenuForSlateStoryboardToBeDisplayed(){
        return getDriver().waitUntil(new ExpectedCondition<Boolean>() {
            public Boolean apply(WebDriver webDriver) {
                Common.sleep(1000);
                webDriver.navigate().refresh();
                return webDriver.findElement(menuSlateStoryBoard).isDisplayed();
            }
        });

    }

    public void fillFieldByName(String name, String value, String section) {
        expandSection(section, name);
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

    public void expandSection(String section, String name) {
        if (!web.isElementPresent(By.xpath(String.format("*//*[contains(@ng-repeat,\"section in $ctrl.sections\")]/ads-accordion[@description=\"%s\"]//*[@layout=\"row\"]/*[contains(text(),\"%s\")]/following-sibling::*[@click=\"$ctrl.toggle()\"]//button//span[contains(@code,\"chevron-outline-up\")]", section.toLowerCase(), section.toLowerCase())))) {
            web.click(By.xpath(String.format("*//*[contains(@ng-repeat,\"section in $ctrl.sections\")]/ads-accordion[@description=\"%s\"]//*[@layout=\"row\"]/*[contains(text(),\"%s\")]/following-sibling::*[@click=\"$ctrl.toggle()\"]//button", section.toLowerCase(), section.toLowerCase())));
            Common.sleep(1000);
        }
        List<WebElement> expandSection = web.findElements(By.cssSelector(String.format("ads-accordion[description=\"%s\"] [click=\"$ctrl.toggle()\"] button", section.toLowerCase())));
        for (WebElement elem : expandSection) {
            if (!web.isElementVisible(By.cssSelector(String.format("[placeholder=\"%s\"]", name)))) {
                if (!elem.findElement(By.cssSelector("span[code^=\"chevron-outline\"]")).getAttribute("code").equalsIgnoreCase("chevron-outline-up")) {
                    web.scrollToElement(elem);
                    elem.click();
                    Common.sleep(1000);
                }
            } else
                break;
        }
    }

    public void clickRelatedProjects()
    {
        web.findElement(getProjectRelatedIconLocator()).click();
    }

    public void fillDateBoxField(String name, String value, String section) {
        web.scrollToElement(web.findElement(By.xpath(getDateFieldLocator(name, section))));
        web.getJavascriptExecutor().executeScript("arguments[0].setAttribute('value', '" + value + "')", (web.findElement(By.xpath(getDateFieldLocator(name, section)))));
    }

    public boolean checkIsPlayerAvailable(String type) {
        boolean flag=false;
        if (type.equalsIgnoreCase("video")) {
            return web.isElementVisible(By.xpath("//ads-file-preview-video[@on-play='$ctrl.onPlay()']"));
        }
        else if(type.equalsIgnoreCase("audio")){
            return web.isElementVisible(By.xpath("//ads-file-preview-audio[@on-play='$ctrl.onPlay()']"));
        }
        return flag;
    }

    public void fillTextField(String name, String value, String section) {
        web.scrollToElement(web.findElement(getTextFieldLocator(name, section)));
        web.typeClean(getTextFieldLocator(name, section), value);
    }

    private String getDateFieldLocator(String name, String section) {
        String format = "%s//ads-md-datepicker[@placeholder='%s']//md-input-container//input";
        return String.format(format, getSectionXpathString(section), name);
    }

    private By getTextFieldLocator(String name, String section) {
        String format = "%s//ads-md-input[@placeholder='%s']//input";
        return By.xpath(String.format(format, getSectionXpathString(section), name));
    }

    private String getComboboxFieldLocator(String name, String section) {
        String format = "%s//ads-md-dictionary[@placeholder='%s']//ads-md-autocomplete//md-input-container//input";
        return String.format(format, getSectionXpathString(section), name);
    }

    private String getMultiSelectFieldLocator(String name, String section) {
        String format = "%s//ads-md-multiselect[@placeholder='%s']//input";
        return String.format(format, getSectionXpathString(section), name);
    }


    public void fillComboboxField(String name, String value, String section) {

        if(web.isElementPresent(By.xpath(String.format("%s//ads-ui-select-dictionary[@placeholder='%s']//*[@ng-click=\"$ctrl.clearModel()\"]",getSectionXpathString(section),name)))) {
            web.scrollToElement(web.findElement(By.xpath(String.format("%s//ads-ui-select-dictionary[@placeholder='%s']//*[@ng-click=\"$ctrl.clearModel()\"]",getSectionXpathString(section),name))));
            web.click(By.xpath(String.format("%s//ads-ui-select-dictionary[@placeholder='%s']//*[@ng-click=\"$ctrl.clearModel()\"]", getSectionXpathString(section), name)));
        }
        else {
            WebElement elem = web.findElement(By.xpath(getComboboxFieldLocator(name, section)));
            web.scrollToElement(elem);
            elem.click();
            elem.sendKeys(value);
            web.waitUntilElementAppear(By.xpath("//ads-ui-select-dictionary//div[contains(@class,'ui-select-choices-row-inner')]//span[contains(text(),'" + value + "')]"));
            web.findElement(By.xpath("//ads-ui-select-dictionary//div[contains(@class,'ui-select-choices-row-inner')]//span[contains(text(),'" + value + "')]")).click();

        }

    }


    public void fillMultiSelectField(String name, String value, String section) {
        WebElement elem = web.findElement(By.xpath(getMultiSelectFieldLocator(name, section)));
        if (!value.trim().isEmpty()) {
            web.scrollToElement(elem);
            web.typeClean(By.xpath(getMultiSelectFieldLocator(name, section)), value);
            Common.sleep(1000);
            for (WebElement element : web.findElements(By.xpath(multiSelectFormat))) {
                if (element.getText().equalsIgnoreCase(value)) {
                    element.click();
                    break;
                }
            }
        } else {
            for (WebElement link : web.findElements(By.xpath(String.format("*//ads-md-multiselect[@placeholder=\"%s\"]//a[@ng-click=\"$selectMultiple.removeChoice($index)\"]", name))))
                link.click();
        }
    }

    public LibraryAssetsInfoPage openSlateStoryBoardMenu() {
        if(!isVideo_inSlateMode() && !isVideo_inStoryBoardMode())
            waitForMenuForSlateStoryboardToBeDisplayed();
        if (web.isElementPresent(menuSlateStoryBoard))
            web.click(menuSlateStoryBoard);
        Common.sleep(2000);
        return this;
    }

    public void clickSlateStoryBoardButton(String option) {
        web.click(By.xpath(String.format("//button//span[contains(text(),\"%s\")]", option.toLowerCase())));
        Common.sleep(1000);
    }



    public void clickActvities(){
        web.click(getActivitiesIconLocator());
        Common.sleep(1000);
    }

    public Boolean isVideo_inSlateMode(){
        return web.isElementVisible(By.cssSelector("ads-file-preview-image[data-role=\"video-preview-slate\"] img"));
    }

    public Boolean isVideo_inStoryBoardMode(){
        return web.isElementVisible(By.cssSelector("ads-file-preview-storyboard")) && web.findElements(By.cssSelector("file-preview-image +.open-preview-mask")).size()==7;
    }

    public List<String> getStateStoryBoardOptions(){
        if(!web.isElementPresent(By.xpath("//*[contains(@data-role,\"video-preview-select\")]")))
            return  new ArrayList<String>();
        else {
            List<String> options=web.findElementsToStrings(By.xpath("//*[contains(@data-role,\"video-preview-select\")]//span"));
            web.click(menuSlateStoryBoard);
            return options;
        }
    }

    public void expandSlitImage(){
        WebElement expanIcon=web.findElements(By.cssSelector("file-preview-image +.open-preview-mask")).get(0).findElement(By.cssSelector("auc-ng-icon .icon-state.icon-filled"));
        web.getJavascriptExecutor().executeScript("arguments[0].click();",expanIcon);
    }

    public void minimizeSlitImage(){
        web.getJavascriptExecutor().executeScript("arguments[0].click();",web.findElement(By.cssSelector("file-preview-image +div [ng-reflect-code=\"minimize\"] .icon-state.icon-filled")));
    }

    public boolean checkExapndedSlitImage(){
       return web.findElements(By.cssSelector(".file-preview-image-container.original")).size() == 1;
    }

    public String[] getStoryBoardFileIds(){
        List<String> Ids= new ArrayList<String>();
        List<WebElement> fileIds=web.findElements(By.cssSelector(".storyboard-tile file-preview-image img.preview"));
        for(WebElement elem:fileIds){
            String fileId[]=elem.getAttribute("src").split("/");
            Ids.add(fileId[fileId.length-1]);
        }
        return Ids.toArray(new String[Ids.size()]);
    }

    public LibAcceptAssetSharedCategory sharedCategoryButton(String button){
        switch(button){
            case "accept":
                web.click(acceptButtonLocator);
                break;
            case "reject":
                web.click(rejectButtonLocator);
                break;
            default:
                throw new IllegalArgumentException(String.format("Button %s is not present on the page",button));
        }
        return new LibAcceptAssetSharedCategory(this);
    }
    public boolean isActivityTabPresent() {
        return web.isElementVisible(By.xpath("//ads-md-button[@id='asset-activities-tab']"));
    }
    public boolean isUsageRightsTabPresent() {
        return web.isElementVisible(By.xpath("//ads-md-button[@id='asset-tab-usage-rights']"));
    }
    public boolean isMoreOptionTabPresent() {
        return web.isElementVisible(By.xpath("//ads-md-button[@id='asset-preview-more-options']"));
    }

    public boolean isShareAssetOptionPresent() {
        return web.isElementVisible(By.xpath("//ads-md-button[@id='asset-preview-share']"));
    }

    public RestorePopUp clickRestore()
    {
        web.findElement(By.xpath("//ads-md-button[@id='trash-previewer-restore-button']/button")).click();
        return new RestorePopUp(this);
    }



}
