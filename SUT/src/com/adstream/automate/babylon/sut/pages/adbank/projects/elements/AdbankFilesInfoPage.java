package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.sut.data.MetadataItem;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 27.07.12
 * Time: 11:52
 */
public class AdbankFilesInfoPage extends AdbankFileViewPage {
    private static final int ASSET_INFORMATION_FIELDS = 0;
    private static final int CUSTOM_METADATA_FIELDS = 1;
    private static final int SPECIFICATION_FIELDS = 2;

    public AdbankFilesInfoPage(ExtendedWebDriver web) {
        super(web);
    }

    public String getApprovalStatus() {
        By locator = By.cssSelector("[data-role='approval-status-icon']");
        return web.isElementPresent(locator) ? web.findElement(locator).getAttribute("class").replaceAll(".*status-(\\w*)\\s?.*", "$1") : "";
    }

    public List<String> getSectionNames() {
        return web.findElementsToStrings(By.cssSelector(".clearfix.files-info-rows>.files_info_title"));
    }

    public List<String> getAssetInformationFieldNames() {
        return getFieldNames(null, ASSET_INFORMATION_FIELDS);
    }

    public List<String> getCustomFieldNames() {
        return getCustomFieldNames(null);
    }

    public List<String> getCustomFieldNames(String section) {
        return getFieldNames(section, CUSTOM_METADATA_FIELDS);
    }

    public List<String> getSpecificationFieldNames() {
        return getFieldNames(null, SPECIFICATION_FIELDS);
    }

    public List<MetadataItem> getAssetInformationFields() {
        return getFields(ASSET_INFORMATION_FIELDS);
    }

    public List<MetadataItem> getCustomMetadataFields() {
        return getFields(CUSTOM_METADATA_FIELDS);
    }

    public List<MetadataItem> getSpecificationFields() {
        return getFields(SPECIFICATION_FIELDS);
    }

    public EditFilePopup clickEditLink() {
        waitUntilPopUpNotificationMessageDisappeared();
        web.click(getEditLinkLocator());
        return new EditFilePopup(this);
    }

    public boolean isFieldHaveSize(String fieldName, String fieldSize) {
        if (fieldSize.equalsIgnoreCase("Full Width")) {
            fieldSize = "size1of1";
        } else if (fieldSize.equalsIgnoreCase("Half Width")) {
            fieldSize = "size1of2";
        } else {
            throw new IllegalArgumentException(String.format("Unexpected field size '%s'", fieldSize));
        }

        By fieldLocator = By.xpath(String.format(
                "//*[contains(@class,'schemaDataField')][contains(@class,'%s')][.//*[contains(@class,'caption')][normalize-space()='%s:']]", fieldSize, fieldName));

        return web.isElementPresent(fieldLocator);
    }

    public boolean isEditLinkVisible() {
        return web.isElementVisible(getEditLinkLocator());
    }


    public boolean isObjectNameExistOnDropdownTreeContainerAsTitle(String projectName) {
        By elementLocator = By.cssSelector(".tree-item.relative .unit.plm.pvxs.text.size1of1 .folder-name");
        List<WebElement> list = web.findElements(elementLocator);
        for (WebElement webElement : list) {
            if ((webElement.getAttribute("title").equals(projectName)) && (!webElement.getAttribute("href").contains("folders"))) {
                return true;
            }
        }
        return false;
    }

    public boolean isFolderHighlightedOnDropdownTreeContainer(String folderName) {
        By elementLocator = By.cssSelector(".tree-root.tree-element.tree-container .relative.size1of1.tree-item");
        List<WebElement> list = web.findElements(elementLocator);
        for (WebElement webElement : list) {
            if ((webElement.getText().equals(folderName)) && (webElement.getAttribute("class").contains("current"))) {
                return true;
            }
        }
        return false;
    }

    @Override
    public DownloadFilePopUpWindow clickDownloadButton() {
        web.waitUntilElementDisappear(getDownloadDisabledButtonLocator());
        web.click(getDownloadButtonLocator());
        web.sleep(1000);
        return new DownloadFilePopUpWindow(this);
    }

    @Override
    protected By getDownloadButtonLocator() {
        return By.cssSelector("[data-dojo-type='common.downloadDialog']");
    }

    private List<MetadataItem> getFields(int fieldsType) {
        List<MetadataItem> assetInformation = new ArrayList<>();

        switch (fieldsType) {
            case CUSTOM_METADATA_FIELDS:
                for (String section : getSectionNames()) {
                    for (String name : getFieldNames(section, fieldsType)) {
                        if (section.isEmpty()) {
                            section = "default";
                        }
                        String value = getFieldValue(name, section, fieldsType).replaceAll(", +", ",");
                        assetInformation.add(new MetadataItem(section, name, value));
                    }
                }
                return assetInformation;
            case ASSET_INFORMATION_FIELDS:
            case SPECIFICATION_FIELDS:
                for (String name : getFieldNames(null, fieldsType)) {
                    assetInformation.add(new MetadataItem(name, getFieldValue(name, null, fieldsType)));
                }
                return assetInformation;
            default:
                throw new IllegalArgumentException("Unknown field type given");
        }
    }

    private List<String> getFieldNames(String section, int fieldsType) {
        web.manage().timeouts().implicitlyWait(60, TimeUnit.SECONDS);
        //web.waitUntilElementAppearVisible(By.className("mediatype-metadata"));

        switch (fieldsType) {
            case ASSET_INFORMATION_FIELDS:
                return web.findElementsToStrings(getAssetInformationFieldNamesLocator());
            case CUSTOM_METADATA_FIELDS:
                return web.findElementsToStrings(getCustomFieldNamesLocator(section));
            case SPECIFICATION_FIELDS:
                return web.findElementsToStrings(getSpecificationFieldNamesLocator());
            default:
                throw new IllegalArgumentException("Unknown field type given");
        }
    }

    private String getFieldValue(String name, String section, int fieldsType) {
        switch (fieldsType) {
            case ASSET_INFORMATION_FIELDS:
                return web.findElement(getAssetInformationFieldValueLocator(name)).getText().trim();
            case CUSTOM_METADATA_FIELDS:
                return web.findElement(getCustomFieldValueLocator(name, section)).getText().trim();
            case SPECIFICATION_FIELDS:
                return web.findElement(getSpecificationFieldValueLocator(name)).getText().trim();
            default:
                throw new IllegalArgumentException("Unknown field type given");
        }
    }

    private By getAssetInformationFieldNamesLocator() {
        return By.cssSelector("[data-dojo-type='common.assetInfoForm'] .schema_field > .caption");
    }

    private By getCustomFieldNamesLocator(String section) {
        if (section == null) return By.xpath("//*[not(contains(@class,'empty'))]/label/*[@class='caption']/*");
        return By.xpath(String.format("%s//*[not(contains(@class,'empty'))]/label/*[@class='caption']/*", getSectionXpathString(section)));
    }
   //Modified xpath as per FE 5.5.21.2035
    private By getSpecificationFieldNamesLocator() {
        return By.xpath("//*[@data-role='fileSpecification']//*[@class='bold']");
    }

    private By getAssetInformationFieldValueLocator(String name) {
        return By.xpath(String.format("//div[@data-dojo-type='common.assetInfoForm']//div[contains(@class, 'caption') and text()='%s']/following-sibling::div", name));
    }

    private By getCustomFieldValueLocator(String name, String section) {
        return By.xpath(String.format("%s//*[not(contains(@class,'empty'))]/label[*[@class='caption']/*[normalize-space()='%s']]/*[contains(@class,'value')]", getSectionXpathString(section), name));
    }
    //Modified xpath as per FE 5.5.21.2035
    private By getSpecificationFieldValueLocator(String name) {
        return By.xpath(String.format("//*[@data-role='fileSpecification']//*[@class='bold'][normalize-space()='%s']/following-sibling::*", name));
    }

    private String getSectionXpathString(String section) {
        if (section == null) {
            return "";
        } else if (section.isEmpty() || section.equalsIgnoreCase("default")) {
            return String.format("//*[contains(@class,'info-rows')][*[contains(@class,'info_title')]//*[contains(@class,'h4')][not(text()) or text()='undefined']]");
        } else {
            return String.format("//*[contains(@class,'info-rows')][*[contains(@class,'info_title')][normalize-space()='%s']]", section);
        }
    }

    private By getEditLinkLocator() {
        return By.cssSelector(".editButton");
    }

    public void clickEditLink(String tab) {
        waitUntilPopUpNotificationMessageDisappeared();
        switch(tab) {
            case "Usage Rights":
                web.click(getUsageRightAddLocator());
                break;
            case "Attachments":
                web.click(getAddAttachmentsLocator());
                break;
            case "Destinations":
                web.click(getDestinationsAddLocator());
                break;
            default:
                break;
        }
    }
    private By getUsageRightAddLocator() {
        return By.cssSelector("a[href*='/rights']");
    }

    private By getDestinationsAddLocator() {
        return By.cssSelector("a[href*='/destinations']");
    }

    private By getAddAttachmentsLocator() {
        return By.cssSelector("a[href*='/attachments']");
    }

    public String getMetaDataFieldValue(String name) {
        return web.findElement(By.xpath(String.format("//div[@data-dojo-type='common.assetInfoForm']//div[contains(@class, 'caption') and descendant::span[text()='%s']]/following-sibling::div", name))).getText();
    }

}