package com.adstream.automate.babylon.sut.pages.admin.categories;

import com.adstream.automate.babylon.sut.data.MetadataItem;
import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.CreateNewCollectionPopUp;
import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.DojoCombo;
import com.adstream.automate.page.controls.DojoDropDown;
import com.adstream.automate.page.controls.DojoSelect;
import com.adstream.automate.utils.Common;
import org.apache.commons.lang.StringUtils;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.*;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10.09.12
 * Time: 13:36
 */
public class CategoriesPage extends BaseAdminPage<CategoriesPage> {
    public DojoDropDown metaDataKey;
    public DojoCombo metaDataValue;

    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(By.cssSelector("[data-dojo-type='admin.categories.collectionTree']"));
    }

    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementVisible(By.cssSelector("[data-dojo-type='admin.categories.collectionTree']")));
    }

    public CategoriesPage(ExtendedWebDriver web) {
        super(web);
        this.metaDataKey = new DojoDropDown(this, By.cssSelector(".advancedSearchChooser [data-dojo-type='common.simpleDropdown']"));
        this.metaDataValue = new DojoCombo(this, By.cssSelector(".advancedSearchChooser [role='combobox']"));
    }

    public List<String> getListOfCategoriesNames() {
        return web.findElementsToStrings(By.cssSelector("[data-role='collectionsTree'] a"));
    }

    public void setMetaDataKey(String value) {
        metaDataKey.selectByValue(value);
        Common.sleep(1000);
    }

    public List<String> getMetaDataKey() {
        List<String> result = new ArrayList<>();
        for (String key : metaDataKey.getValues()) {
            result.add(key.trim().replaceAll(" +", " "));
        }
        return result;
    }

    public void setMetaDataValue(String value) {
        metaDataValue.selectByVisibleText(value);
    }

    public List<String> getMetaDataValues() {
        return metaDataValue.getValues();
    }

    public void selectCategoriesByName(String linkName) {
        web.click(By.linkText(linkName));
    }

    public CreateNewCategoryPopUp clickNewCategory() {
        web.click(By.cssSelector(".button.mls[data-dojo-type*='newCategory']"));
        return new CreateNewCategoryPopUp(this);
    }

    public String getActiveCategoryName() {
        return web.findElement(By.cssSelector("li.current")).getText().trim();
    }

    public int getCategoriesCountByName(String categoryName) {
        return web.findElementsToStrings(By.xpath(String.format("//*[@data-role='collectionsTree']//a[contains(.,'%s')]", categoryName))).size();
    }

    public List<String> getMetadataValueByItemName(String metadataItemName) {
        String xpath = String.format("//*[@role]//*[contains(text(),'%s')]/ancestor::div[contains(@id,'advSearch')]//input[contains(@id,'FilteringSelect')]", metadataItemName);
        return web.findElementsToStrings(By.xpath(xpath), "VALUE");
    }

    public boolean isMetadataTextValueWithItsKeyExist(String key) {
        By locator = By.xpath(String.format("//*[@role]//*[contains(text(),'%s')]/ancestor::div[contains(@id,'advSearch')]//input[contains(@class,'value') and not(@disabled)]", key));
        return web.isElementPresent(locator) && web.isElementVisible(locator);
    }

    public void typeMetadataTextValueByKey(String key, String value) {
        web.typeClean(By.xpath(String.format("//*[@role]//*[contains(text(),'%s')]/ancestor::div[contains(@id,'advSearch')]//input[contains(@class,'value') and not(@disabled)]", key)), value);
    }

    public List<String> getMetadataTextValueByKey() {
        return web.findElementsToStrings(By.xpath("//*[@role]//*/ancestor::div[contains(@id,'advSearch')]//input[contains(@class,'value')]"), "value");
    }

    public List<String> getMetadataValuesByKeyName(String key) {
        DojoCombo currentMDValue = new DojoCombo(this, By.xpath(String.format("//*[@role]//*[contains(text(),'%s')]/ancestor::div[contains(@id,'advSearch')]//input[contains(@id,'FilteringSelect')]", key)));
        return currentMDValue.getValues();
    }

    public void setMetadataValueByKey(String key, String value) {
        DojoCombo currentMDValue = new DojoCombo(this, By.xpath(String.format("//*[@role]//*[contains(text(),'%s')]/ancestor::div[contains(@id,'advSearch')]//input[contains(@id,'FilteringSelect')]", key)));
        currentMDValue.selectByVisibleText(value);
    }

    public List<String> getAllMetadataValues() {
        return web.findElementsToStrings(By.cssSelector(".filter.value input.dijitReset.dijitInputInner"), "value");
    }

    public List<String> getAllMetadatasKeys() {
        return web.findElementsToStrings(By.cssSelector(".filter.key"));
    }

    public boolean getFiltersState(String filterName) {
        return web.findElement(By.cssSelector(String.format(".lib-switcher .controller.mediaTypeControll.%s", getFilterClassName(filterName)))).getAttribute("class").endsWith("on");
    }

    public void switchFilterInNeedState(String filterName, String state) {
        boolean needFiltersState = state.equalsIgnoreCase("on")
                || state.equalsIgnoreCase("true")
                || state.equalsIgnoreCase("enabled");
        if (getFiltersState(filterName)!=needFiltersState) {
            web.click(By.cssSelector(
                    String.format(".lib-switcher .controller.mediaTypeControll.%s", getFilterClassName(filterName))));
            Common.sleep(500);
        }
    }

    public void clickAddMetaData() {
        web.click(By.cssSelector(".button.no-padding.no-min.add-filter"));
    }

    public ManageUsersCategoriesPopUp clickLibraryTeam(String teamName) {
        web.click(By.xpath(String.format("//*[@data-type='user_group'][text()='%s']", teamName)));
        return new ManageUsersCategoriesPopUp(this);
    }

    public int getCountOfDeleteMetadataButtons() {
        if (!web.isElementPresent(By.cssSelector(".button.no-padding.no-min.remove"))) return 0;
        return web.findElements(By.cssSelector(".button.no-padding.no-min.remove")).size();
    }

    public int getCountOfKeyMetadataFields() {
        if (!web.isElementPresent(By.cssSelector(".dijit.dijitReset.dijitInline.dijitLeft.dijitDownArrowButton.lib-select.filter.key.dijitSelect.dijitSelectDisabled.dijitDisabled"))) return 0;
        return web.findElements(By.cssSelector(".dijit.dijitReset.dijitInline.dijitLeft.dijitDownArrowButton.lib-select.filter.key.dijitSelect.dijitSelectDisabled.dijitDisabled")).size();
    }

    public List<String> getUsersList() {
        By locator = By.cssSelector("[title='Users'] a[data-type='user']");
        return web.isElementPresent(locator) ? web.findElementsToStrings(locator) : new ArrayList<String>();
    }

    public List<String> getLibraryTeamsList() {
        By locator = By.cssSelector("[title='Library Teams'] a[data-type='user_group']");
        return web.isElementPresent(locator) ? web.findElementsToStrings(locator) : new ArrayList<String>();
    }

    public ManagePermissionsPopUp clickUserLinkById(String userId) {
        web.click(By.cssSelector(String.format("[title='Users'] a[data-type='user'][data-id='%s']", userId)));
        return new ManagePermissionsPopUp(this);
    }

    public ManagePermissionsPopUp clickManageUsers() {
        web.click(By.cssSelector("[id*='addUsersToCategory'][data-dojo-props*='Add Users']"));
        return new ManagePermissionsPopUp(this);
    }

    public AddAgencyPopUp clickAddAgency() {
        web.click(By.xpath("//span[text()='Add Business Units']"));
        return new AddAgencyPopUp(this);
    }

    public AddLibraryTeamPopup clickAddLibraryTeam() {
        web.click(By.xpath("//span[text()='Add Library Team']"));
        return new AddLibraryTeamPopup(this);
    }

    public boolean isAddUsersButtonVisible() {
        By locator = By.cssSelector("[id*='addUsersToCategory'][data-dojo-props*='Add Users']");
        return web.isElementPresent(locator) && web.isElementVisible(locator);

    }

    public boolean isAddBusinessUnitButtonVisible() {
        By locator = By.cssSelector("[id*='addUsersToCategory'][data-dojo-props*='Add Business Unit']");
        return web.isElementPresent(locator) && web.isElementVisible(locator);

    }

    public boolean isAddLibraryTeamButtonVisible() {
        By locator = By.cssSelector("[id*='addUsersToCategory'][data-dojo-props*='Add Library Team']");
        return web.isElementPresent(locator) && web.isElementVisible(locator);

    }

    public boolean isAddAgencyPopupVisible() {
        By locator = By.xpath("//*[contains(@class,'popupWindow')][*[contains(@class,'windowHead')]//*[contains(text(),'Add Business Units')]]");
        return web.isElementPresent(locator) && web.isElementVisible(locator);
    }

    public boolean isRemoveAgencyPopupVisible() {
        By locator = By.xpath("//*[contains(@class,'popupWindow')][*[contains(@class,'windowHead')]//*[contains(text(),'Remove')]]");
        return web.isElementPresent(locator) && web.isElementVisible(locator);
    }

    public String getRemoveAgencyPopupText(){
        return web.findElement(By.cssSelector(".content")).getText();
    }

    public ManagePermissionsPopUp openManageUsersPopup() {
        if (!web.isElementVisible(getAddUsersToCategoryPopUpLocator()))
            clickManageUsers();
        web.waitUntilElementAppearVisible(getAddUsersToCategoryPopUpLocator());
        web.sleep(1000);
        return new ManagePermissionsPopUp(this);
    }

    public boolean isUserPresentOnThePage(String userId) {
        return web.isElementPresent(By.cssSelector(String.format(".p.no-decoration[data-userid*='%s']", userId)));
    }

    public PopUpWindow clickDeleteButton() {
        web.click(By.cssSelector("[data-dojo-type='admin.categories.delCategory']"));
        web.sleep(1000);
        return new PopUpWindow(this);
    }

    public List<String> getActiveMetadataValues() {
        web.click(By.cssSelector("[data-role='valueBlock'] [aria-disabled='false'] input.dijitArrowButtonInner"));
        web.sleep(1000);
        return web.findElementsToStrings(By.cssSelector("[id*='FilteringSelect'] .dijitMenuItem.dijitReset"));
    }

    public void clickDeleteMetadataByKey(String key) {
        web.click(By.xpath(String.format("//*[text()='%s']//ancestor::div[contains(@class,'filter-line')]//*[contains(@class,'icon-cross')]", key)));
    }

    public void clickSaveButton() {
        web.sleep(2000);
        web.click(By.name("save"));
    }

    public List<String> getAllMetadataKeys() {
        return web.findElementsToStrings(By.cssSelector(".filter.key"));
    }

    public void selectMediaSubType(String subType) {
        web.click(By.className("mediaSubTypeControll"));
        web.click(By.xpath(String.format("//td[contains(text(),'%s')]", subType)));
    }

    public String getMediaSubType() {
        return web.findElement(By.className("mediaSubTypeControll")).getText();
    }

    public PopUpWindow clickRemoveUser(String userId) {
        web.clickThroughJavascript(By.cssSelector(String.format(".delete.mls[href*='%s']", userId)));
        web.sleep(1000);
        return new PopUpWindow(this);
    }

    public PopUpWindow clickRemoveLibraryTeam(String teamId) {
        web.clickThroughJavascript(By.cssSelector(String.format(".delete.mls[href*='%s']", teamId)));
        web.sleep(1000);
        return new PopUpWindow(this);
    }

    public ManageUsersCategoriesPopUp openManageUsersCategory(String userId) {
        web.findElement(By.cssSelector((String.format(".no-decoration[data-id*='%s']", userId)))).click();
        web.sleep(1000);
        web.sleep(9000);//Temporary hack till FAB-424 is open as the select role button is hidden behind the exception. Once FAB-424 is fixed this line can be commented out.
        return new ManageUsersCategoriesPopUp(this);
    }

    public PopUpWindow clickRemoveAgency(String agencyId) {
        web.clickThroughJavascript(By.cssSelector(String.format(".delete.mls[href*='%s']", agencyId)));
        web.sleep(1000);
        return new PopUpWindow(this);
    }

    public CreateNewCollectionPopUp clickSaveAsACollection() {
        web.click(By.xpath("//*[text()='Save as a collection']"));
        return new CreateNewCollectionPopUp(this);
    }

    public boolean isAgencyExistInAgenciesList(String agencyName) {
        By locator = By.xpath(String.format("//div[normalize-space(@title)='Business Units']//li//a[text()='%s']", agencyName));
        return web.isElementPresent(locator) && web.isElementVisible(locator);
    }

    public int getCountOfAgencies() {
        By locator = By.xpath("//div[normalize-space(@title)=normalize-space('Business Units')]//li");
        if (web.isElementPresent(locator) && web.isElementVisible(locator)) {
            return web.findElements(locator).size();
        }
        return 0;
    }

    public int getCountOfUsers() {
        if (!web.isElementPresent(By.xpath("//div[normalize-space(@title)='Users']//li")) && !web.isElementVisible(By.xpath("//div[normalize-space(@title)='Users']//li"))) return 0;
        return web.findElements(By.xpath("//div[normalize-space(@title)='Users']//li")).size();

    }

    private By getAddUsersToCategoryPopUpLocator() {
        return  By.cssSelector(".popupWindow.dijitDialog:not([style*='display: none'])");
    }

    private String getFilterClassName(String filterName) {
        String filterClassName;

        if (filterName.equalsIgnoreCase("image")) filterClassName = "image-type";
        else if (filterName.equalsIgnoreCase("video")) filterClassName = "video-type";
        else if (filterName.equalsIgnoreCase("audio")) filterClassName = "audio-type";
        else if (filterName.equalsIgnoreCase("file") || filterName.equalsIgnoreCase("print")) filterClassName = "file-type";
        else if (filterName.equalsIgnoreCase("document")) filterClassName = "document-type";
        else if (filterName.equalsIgnoreCase("other")) filterClassName ="other-type";
        else  filterClassName = "all-type";

        return filterClassName;
    }

    public List<String> getAvailableFiltersList() {
        return new DojoDropDown(this, getFilterNameListboxLocator()).getValues();
    }

    public List<MetadataItem> getAddedFilters() {
        List<MetadataItem> fields = new ArrayList<>();

        for (String name : web.findElementsToStrings(getAddedFilterNamesLocator())) {
            String value = StringUtils.join(web.findElementsToStrings(getAddedFilterValuesLocator(name), "value"), ",");
            fields.add(new MetadataItem(name, value));
        }

        return fields;
    }

    public void addFilter(String name, String value) {
        if (!isAddedFilterValuePresent(name, value)) {
            addNewFilter(name, value);
        }
    }

    public void addNewFilter(String name, String value) {
        By filterValueComboBoxLocator = By.cssSelector(".advancedSearchChooser [role='combobox']");
        By filterValueTextBoxLocator = By.cssSelector(".advancedSearchChooser input.filter");

        new DojoDropDown(this, getFilterNameListboxLocator()).selectByValue(name);
        web.sleep(2000);
        if (web.isElementPresent(getFilterValueDateLocator())) {
            new DojoCombo(this, getFilterValueDateLocator()).selectByVisibleText(value);
        } else if (web.isElementPresent(filterValueComboBoxLocator)) {
            new DojoCombo(this, filterValueComboBoxLocator).selectByVisibleText(value);
        } else if (web.isElementPresent(filterValueTextBoxLocator)) {
            web.typeClean(filterValueTextBoxLocator, value);
        } else {
            throw new IllegalStateException(String.format("Could not find field '%s' with value '%s'", name, value));
        }

        web.click(By.cssSelector(".advancedSearchChooser .icon-plus"));
    }

    public boolean isElementExist(String usageRight, String key) {
        if (!web.isElementPresent(getSubFilterContainerLocator(usageRight))) {
            setMetaDataKey(usageRight);
        }
        return new DojoSelect(this, getSubFilterKeySelectLocator())
                .getLabels().contains(key);
    }

    private By getCategoryNameLocator(String category) {
        return By.xpath(String.format(String.format("//*[normalize-space(text())='%s']", category)));
    }

    public boolean isCategoryExist(String category) {
        By categoryName = getCategoryNameLocator(category);
        By collapseCategoryIcon = By.xpath(String.format("//*[normalize-space(text())='%s']/../../../*[@class='arrow']", category));
        if (web.isElementPresent(categoryName) && web.isElementVisible(categoryName)) {
            if (web.isElementPresent(collapseCategoryIcon) && web.isElementVisible(collapseCategoryIcon))
                web.click(collapseCategoryIcon);
            return true;
        } else {
            return false;
        }
    }

    public void addUsageRightsFilter(String usageRight, String key, String value) {
        By addMoreButton = By.xpath(getSubFilterContainerXpath(usageRight) + "//*[contains(@class,'add-more')]");
        By addFilterButton = By.xpath(getSubFilterContainerXpath(usageRight) + "//*[contains(@class,'add-filter')]");
        By valueCombobox = By.xpath(getSubFilterContainerXpath(usageRight) + "//*[@role='combobox' and not(contains(@class,'Disabled'))]");
        By valueTextbox = By.xpath(getSubFilterContainerXpath(usageRight) + "//input[contains(@class,'value') and not(@disabled)]");

        if (!web.isElementPresent(getSubFilterContainerLocator(usageRight))) {
            setMetaDataKey(usageRight);
            new DojoSelect(this, getSubFilterKeySelectLocator()).selectByVisibleText(key);
            Common.sleep(1000);
        }
        if (web.isElementVisible(addMoreButton)) {
            web.click(addMoreButton);
            Common.sleep(1000);
        }
        if (web.isElementPresent(valueTextbox)) {
            web.typeClean(valueTextbox, value);
        } else if (web.isElementPresent(valueCombobox)) {
            new DojoCombo(this, valueCombobox).selectByVisibleText(value);
        } else {
            throw new IllegalStateException(String.format("Unknown control for filter %s", key));
        }
        Common.sleep(1000);
        web.click(addFilterButton);
        Common.sleep(1000);
    }

    public boolean isAddedFilterValuePresent(String name, String value) {
        By locator = By.xpath(String.format("//*[contains(@class,'filter-line')][.//*[@data-role='filterKey'][*[normalize-space()=normalize-space('%s')]]]//*[normalize-space(@value)=normalize-space('%s') and not(@type='hidden')]", name, value));
        return web.isElementPresent(locator);
    }

    public List<String> getCollectionChildren(String collectionName) {
        String locator = String.format("//li[@data-role='tree-item' and div/div/a[normalize-space(text())='%s']]/ul/li/div/div/a", collectionName);
        return web.findElementsToStrings(By.xpath(locator));
    }

    private By getAddedFilterNamesLocator() {
        return By.cssSelector(".advancedSearchContainer .filter-line [data-role='displayValue']");
    }

    private By getAddedFilterValuesLocator(String name) {
        return By.xpath(String.format("//*[contains(@class,'filter-line')][.//*[@data-role='displayValue'][normalize-space(text())='%s']]//*[@disabled][@type='text']", name.trim()));
    }

    private By getFilterNameListboxLocator() {
        return By.cssSelector(".advancedSearchChooser [data-dojo-type='common.simpleDropdown']");
    }

    private By getFilterValueDateLocator() {
        return By.cssSelector(".advancedSearchChooser .date[role='combobox']");
    }

    private By getSubFilterKeySelectLocator() {
        return By.cssSelector(".advancedSearchContainer [data-role='filterKey']:not(.dijitDisabled)");
    }

    private By getSubFilterContainerLocator(String filterName) {
        return By.xpath(getSubFilterContainerXpath(filterName));
    }

    private String getSubFilterContainerXpath(String filterName) {
        return String.format("//*[@data-dojo-type='common.advSearchFilterBlock'][*[@class='size1of1 pvxs'][normalize-space()='%s']]", filterName);
    }

    public List<String>  getMetadataFields(String assetType){
        List<String> metadataFields = new ArrayList<>();
        By locator = By.xpath(String.format("//div[@class='dropdown-panel table-controller']//div[@class='dropdown-item '][contains(@value,'_cm.%s')]",assetType));
        web.click(By.xpath("//*[@class='dropdown-container lib']//div[@class='dropdown-button']"));
        web.waitUntilElementAppearVisible(By.xpath("//div[@class='dropdown-panel table-controller']//*[.='Common']"));
        for(String field : web.findElementsToStrings(locator)){
            metadataFields.add(field);
        }
        return metadataFields;
    }

    public boolean verifyAssetTypeMetaDataFieldPresent(String assetType){
        return web.isElementVisible(By.xpath(String.format("//div[@class='dropdown-panel table-controller']//*[.='%s']",assetType)));
    }
}