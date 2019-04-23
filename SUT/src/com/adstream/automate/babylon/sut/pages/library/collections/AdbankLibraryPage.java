package com.adstream.automate.babylon.sut.pages.library.collections;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.*;
import com.adstream.automate.babylon.sut.pages.library.elements.AddAssetToProjectPopUpWindow;
import com.adstream.automate.babylon.sut.pages.library.elements.RemoveAssetsConfirmationPopup;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.DojoCombo;
import com.adstream.automate.page.controls.DojoDropDown;
import com.adstream.automate.page.controls.DojoSelect;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * User: ruslan.semerenko
 * Date: 04.09.12 12:48
 */
public class AdbankLibraryPage extends AdbankFilesPage {
    public DojoSelect mediaSubType;
    public DojoSelect sortBy;
    private final By newLibraryUrlLocator=By.xpath(".//div[@class=\"newLibraryInfo pas\"]//a[@href=\"/streamlined-library-beta\"]");

    public AdbankLibraryPage(ExtendedWebDriver web) {
        super(web);
        this.mediaSubType = new DojoSelect(this, By.cssSelector(".dijit.dijitReset.dijitInline.dijitLeft.dijitDownArrowButton.lib-select.mediaSubTypeControll.dijitSelect"));
        this.sortBy = new DojoSelect(this, By.cssSelector("[widgetid^='adbank_files_files_sort_filter']"));
    }

    public void load() {
       web.waitUntilElementAppearVisible(By.cssSelector(".tree-block"));
        web.waitUntilElementAppearVisible(By.cssSelector("#libraryAssetsContainer"));
    }

    public void isLoaded() throws Error {
        web.sleep(3000);
        assertTrue(web.isElementVisible(By.cssSelector(".tree-block")));
        assertTrue(web.isElementVisible(By.cssSelector("#libraryAssetsContainer")));
    }

    public ShareFilesPopup clickShareFilesButton(){
        web.click(By.cssSelector(".button[id*='shareAsset']:not(.disabled)"));
        return new ShareFilesPopup(this);
    }

    public boolean isPreviewAvailable() {
        int fileInfoCount = 0, filePreviewCount = 0;
        if (web.isElementPresent(By.className("file-info")))
            fileInfoCount = web.findElements(By.className("file-info")).size();
        if (web.isElementPresent(By.cssSelector(".lib-file-list-item .preview [data-dojo-type='common.imageResizer']")))
            filePreviewCount = web.findElements(By.cssSelector(".lib-file-list-item .preview [data-dojo-type='common.imageResizer']")).size();
        return fileInfoCount == filePreviewCount;
    }

    public String getAssetsTitleById(String id) {
        return web.findElement(By.cssSelector(String.format("[data-role='fileCard'] .ptxs a[href*='%s']", id))).getAttribute("title").trim();
    }

    public String getAssetTitleTextByAssetId(String id) {
        return web.findElement(By.cssSelector(String.format("[data-role='fileCard'] .ptxs a[href*='%s']", id))).getText();
    }

    public void expandCollectionsList() {
        int i, limit = 30;
        for (i = 0; i < limit && web.isElementPresent(getExpandCollectionListLocator()); i++) {
            web.click(By.cssSelector(".tree-root .hasItems:not(.active) > .arrow"));
            Common.sleep(1000);
        }
        if (i >= limit && web.isElementPresent(getExpandCollectionListLocator())) {
            throw new RuntimeException("Too much collections or library page hangs.");
        }
    }

    public List<String> getListOfCollectionsNames() {
        expandCollectionsList();
        return web.findElementsToStrings(By.cssSelector(".tree-root .title:not(.agency) a"));
    }

    public List<String> getAgencyNames() {
        return web.findElementsToStrings(By.cssSelector(".title.agency-icon a"));
    }

    public List<String> getMenuChildItems(String parentName) {
        By childrenItemsLocator = By.xpath(String.format("//li[.//a[normalize-space()='%s']]/ul/*[@data-role='tree-item']//a", parentName));
        By expandArrowLocator = By.xpath(String.format("//li[.//a[normalize-space()='%s'] and not(contains(@class,'active'))]/*[contains(@class,'arrow')]", parentName));
        if (web.isElementPresent(expandArrowLocator)) {
            web.click(expandArrowLocator);
        }
        // NGN-13096 tree doesn't expand after first click
        if (web.isElementPresent(expandArrowLocator)) {
            web.click(expandArrowLocator);
        }
        return web.findElementsToStrings(childrenItemsLocator);
    }

    public RemoveAssetsConfirmationPopup clickRemoveButton() {
        By locator = By.xpath("//span[.='Remove']");
        if (web.isElementPresent(locator) && web.isElementVisible(locator)) {
            web.click(locator);
            web.sleep(2000);
        }
        return new RemoveAssetsConfirmationPopup(this);
    }

    public void clickEditUsageRightsButtonFromMoreDropDown(){
        By locator = By.xpath("//span[.='Edit Usage Rights']");
        if (web.isElementPresent(locator) && web.isElementVisible(locator)) {
            web.click(locator);
            web.sleep(2000);
        }
    }

    public void clickEditAllSelectedButtonFromMoreDropdown() {
        By locator = By.xpath("//span[.='Edit all selected']");
        if (web.isElementPresent(locator) && web.isElementVisible(locator)) {
            web.click(locator);
            web.waitUntilElementAppearVisible(By.cssSelector("div[data-role='schemedContent']"));
        }
    }

    public boolean isAddToWorkRequestButton() {
        return web.isElementPresent(getGoToLibraryRequestButtonLocator()) &&
                web.isElementVisible(getGoToLibraryRequestButtonLocator());
    }

    public PopUpWindow clickRemoveFromCollectionButton() {
        By locator = By.xpath("//span[.='Remove from Collection']");
        web.click(locator);
        web.sleep(2000);
        return new PopUpWindow(this);
    }

    public void selectCollection(String linkName) {
        expandCollectionsList();
        web.click(By.linkText(linkName));
        Common.sleep(1000);
    }

    public void selectCollectionUI(String linkName) {
        web.click(By.linkText(linkName));
        Common.sleep(1000);
    }
    public void scrollDownToFooter() {
        web.scrollToElement(web.findElement(By.cssSelector(".footer.clearfix")));
        web.sleep(2000);
    }

    public int getItemsCount() {
        return web.findElementsToStrings(By.cssSelector("[id*='library_library_lib_file_list_item_']")).size();
    }

    public int getCountOfTotalAssets() {
        return Integer.parseInt(web.findElement(By.cssSelector("[data-id='total-count']")).getText());
    }

    public void openAsset(String number) {
        //Updated as the locators are changed
        List<WebElement> list = web.findElements(By.cssSelector("[data-role=fileCard]"));
        for (int i = list.size() - 1; i >= 0; i--) {
            if (i == Integer.parseInt(number)) {
                list.get(i).findElement(By.cssSelector(".file-info a")).click();
                break;
            }
        }
    }

    public void clickAdvancedLink() {
        By by = By.cssSelector("[data-dojo-type='library.library.advancedDropDownBtn']");
        web.waitUntilElementAppearVisible(by);
        web.click(by);
        Common.sleep(1000);
    }

    public AddToCollectionPopUp clickAddToCollection() {
        web.click(By.cssSelector("[id*='addToCollectionButton']"));
        return new AddToCollectionPopUp(this);
    }

    public void clickCloseButton() {
        web.click(By.xpath("//*[text()='Close']"));
    }

    public void clickSaveButton() {
        web.click(By.xpath("//*[text()='Save']"));
        web.sleep(1000);
    }

    public void clickDownloadOnLibrary() {
        web.click(By.xpath("//span[contains(.,'Download')]"));
        web.sleep(1000);
    }


    public CreateNewCollectionPopUp clickSaveAsACollection() {
        By by = By.xpath("//*[text()='Save as a collection']");
        web.waitUntilElementAppearVisible(by);
        web.click(by);
        return new CreateNewCollectionPopUp(this);
    }

    public int getCountOfRelatedAssets() {
        return web.findElements(By.cssSelector("[title='Related files'][data-role='relatedFilesIcon']")).size();
    }

    public void setMetaDataKey(String value) {
        new DojoDropDown(this, By.cssSelector(".advancedSearchChooser [data-role='filterKey']"))
                .selectByValue(value);
    }

    public List<String> getMetaDataKey() {
        List<String> keys = new ArrayList<>();
        for (String key : new DojoDropDown(this, getFilterNameListboxLocator()).getValues()) {
            keys.add(key.trim().replaceAll(" +", " "));
        }
        return keys;
    }

    public List<String> getMetaDataValue() {
        return new DojoCombo(this, By.cssSelector(".filter.value:not(.dijitDisabled)")).getValues();
    }

    public String getDisabledMetaDataValueSelectedLabel(String key) {
        DojoCombo elem = new DojoCombo(this, By.xpath("//*[normalize-space(text())='" + key + "']//ancestor::div[@class='vmiddle']//*[contains(@class,'filter value')]"));
        return elem.getSelectedLabel();
    }

    public void setMetaDataValue(String value) {
        new DojoCombo(this, By.cssSelector(".advancedSearchChooser .value"))
                .selectByVisibleText(value);
    }

    public void setMetaDataValueOnFly(String value) {
        web.findElement(By.cssSelector(".advancedSearchChooser .value")).sendKeys(value);
        web.sleep(200);
    }

    public String getDisabledMetaDataKeySelectedLabel(int num) {
        WebElement webElement = web.findElements(By.cssSelector(".dijit.dijitReset.dijitInline.dijitLeft.dijitDownArrowButton.lib-select.filter.key.dijitSelect.dijitSelectDisabled")).get(num);
        return new DojoSelect(this, webElement).getSelectedLabel();
    }

    public String getSortByValue() {
        return sortBy.getSelectedLabel();
    }

    public void setSortBy(String value) {
        if (!sortBy.getSelectedLabel().equals(value)) {
            WebElement assetsField = web.findElement(By.cssSelector(".files-field .lib-file-list-item"));
            sortBy.selectByVisibleText(value);
            web.waitUntilElementChanged(assetsField); //wait while field redraws
        }
    }

    // order: asc, desc
    @Override
    public void sortListViewByColumn(String columnName, String order) {
        String locator = String.format("//div[@data-dojo-type='common.table.headerColumn2' and div[text()='%s']]", columnName);
        By loaderLocator = By.cssSelector(".fixed-informer.loading");
        WebElement element = web.findElement(By.xpath(locator));
        if (!element.getAttribute("class").contains(order)) {
            element.click();
            Common.sleep(1000);
            web.waitUntilElementDisappear(loaderLocator);
            element = web.findElement(By.xpath(locator));
            if (!element.getAttribute("class").contains(order)) {
                element.click();
                Common.sleep(1000);
                web.waitUntilElementDisappear(loaderLocator);
            }
        }
        Common.sleep(1000);
    }

    public String getDisabledMetaDataValueSelectedLabel(int num) {
        WebElement webElement = web.findElements(By.cssSelector(".lib-select.filter.value.dijitDisabled")).get(num);
        return new DojoCombo(this, webElement).getSelectedLabel();
    }

    public String getMediaSubTypeSelectedValue() {
        return mediaSubType.getSelectedLabel();
    }

    public void clickAddMetadata() {
        web.click(By.cssSelector(".advancedSearchChooser .icon-plus"));
    }

    public List<String> getTestDivComponents() {
        return web.findElementsToStrings(By.cssSelector(".size1of1.clearfix.filter-line"));
    }

    public int getNumOfMetadataRow(String metadataValue) {
        int result = 0;
        for (String str : getTestDivComponents()) {
            if (str.contains(metadataValue)) return result;
            else result++;
        }
        return -1;
    }

    public void clickDeleteMetadataByNum(int num) {
        web.findElements(By.cssSelector(".icon-cross.valign-middle.mtxs.mhs")).get(num).click();
    }

    public void clickDeleteMetadataByValue(String value) {
        web.click(By.xpath(String.format("//*[contains(@value,'%s')]/ancestor::*[contains(@class,'pbxs')]//*[contains(@class, 'remove')]", value)));
    }

    public int getCountOfKeyMetadataFields() {
        if (!web.isElementPresent(By.cssSelector(".dijit.dijitReset.dijitInline.dijitLeft.dijitDownArrowButton.lib-select.filter.key.dijitSelect.dijitSelectDisabled.dijitDisabled"))) return 0;
        return web.findElements(By.cssSelector(".dijit.dijitReset.dijitInline.dijitLeft.dijitDownArrowButton.lib-select.filter.key.dijitSelect.dijitSelectDisabled.dijitDisabled")).size();
    }

    public String getLabelsValueAboutCountFiles() {
        return web.findElement(By.cssSelector("[data-id='all-items']")).getText();
    }

    public String getItemsPerPageValue() {
        return web.findElement(By.cssSelector("[id*='items_per_page'] [role='option']")).getText();
    }

    public String getLabelsValueAboutCountSelectedFiles() {
        return web.findElement(By.cssSelector(".selecteds-counter.bold")).getText();
    }

    public int getAssetsCount() {
        return web.findElements(By.cssSelector("[id*='_lib_file_list_item']>div>.preview.clickable")).size();
    }

    public void clickSelectAll() {
        web.click(By.id("total_selector"));
    }

    public int getAllAssetsCount() {
        return web.findElements(By.cssSelector(".lib-file-list-item")).size();
    }

    public int getAllSelectedAssetsCount() {
        return web.findElements(By.cssSelector(".lib-file-list-item.selected")).size();
    }

    public boolean isAdvancedLinkVisible() {
        return web.isElementVisible(By.xpath("//*[text()='Advanced']"));
    }

    public boolean isAdvancedFilterBlockVisible() {
        return web.isElementVisible(By.id("advancedFilterBlock"));
    }

    public boolean isMediaFiltersPanelVisible() {
        return web.isElementVisible(By.className("libraryAdvancedSearchController"));
    }

    public boolean getFiltersState(String filterName) {
        return web.findElement(By.cssSelector(String.format(".lib-switcher .controller.mediaTypeControll.%s", getFilterClassName(filterName)))).getAttribute("class").endsWith("on");
    }

    public void switchFilterInNeedState(String filterName, String state) {
        boolean needFiltersState = state.equalsIgnoreCase("on") || state.equalsIgnoreCase("true") || state.equalsIgnoreCase("enabled");
        if (getFiltersState(filterName) != needFiltersState) {
            web.click(By.cssSelector(String.format(".lib-switcher .controller.mediaTypeControll.%s", getFilterClassName(filterName))));
        }
    }

    public void clickAddToWorkRequestButton() {
        web.click(By.cssSelector("[id*='WorkRequestButton']"));
    }

    public void clickAddToPresentationButton() {
        web.click(By.cssSelector(".icon-presentation-lib+.valign-middle"));
    }

    public boolean checkAddToPresentationButtonEnabled() {
        web.click(By.cssSelector(".icon-presentation-lib+.valign-middle"));
        return web.isElementPresent(By.xpath("//*[contains(@id, 'library_library_addToPresentationButtonCommon')]//*[contains(text(), 'Add to new presentation')] "));
    }

    public boolean isTrashFolderPresent() {
        return web.isElementPresent(By.cssSelector(".trash-wrapper .icon-trash"));
    }

    public AddNewPresentationPopUpWindow clickAddToNewPresentation() {
        web.click(By.cssSelector("[role='menu'][style*='visible'] tr:nth-child(1)"));
        web.sleep(1000);
        return new AddNewPresentationPopUpWindow(this);
    }

    public AddExistingPresentationPopUpWindow clickAddToExistingPresentation() {
        web.click(getAddToExistingMenuLocator());
        web.sleep(1000);
        return new AddExistingPresentationPopUpWindow(this);
    }

    public boolean isAddToExistingMenuVisible() {
        return web.isElementVisible(getAddToExistingMenuLocator()) && web.isElementPresent(getAddToExistingMenuLocator());
    }

    public boolean isPreviewVisible(String assetId) {
        return web.isElementPresent(By.cssSelector("img[src*='" + assetId + "']"));
    }

    public boolean isAddToNewPresentationButtonVisible() {
        return web.isElementPresent(getAddToNewPresentationButtonLocator()) && web.isElementVisible(getAddToNewPresentationButtonLocator());
    }

    public boolean isAddToNewPresentationButtonEnabled() {
        return web.findElement(getAddToNewPresentationButtonLocator()).isEnabled();
    }

    public boolean isAddToExistingPresentationButtonVisible() {
        return web.isElementPresent(getAddToExistingPresentationButtonLocator()) && web.isElementVisible(getAddToExistingPresentationButtonLocator());
    }

    public boolean isAddToExistingPresentationButtonEnabled() {
        return web.findElement(getAddToExistingPresentationButtonLocator()).isEnabled();
    }

    public void clickAddOtherCategoryPlus() {
        web.click(By.cssSelector(".button.no-padding.no-min.add-more"));
    }

    public boolean isMetadataKeyDisabled(String key) {
        String locator = String.format("//*[contains(normalize-space(text()), '%s')]//ancestor::*[contains(@class,'key')][contains(@aria-disabled,'true')]", key);
        return web.isElementPresent(By.xpath(locator));
    }

    public String getMetadataTextValue(String key) {
        String xpath = String.format("//*[contains(@class, 'filter-line') and descendant::*[@data-role='displayValue' and normalize-space(text())='%s']]//input[@role='textbox' or @name]", key);
        return web.findElement(By.xpath(xpath)).getAttribute("value");
    }

    public boolean isCollectionSelected(String collectionName) {
        return web.isElementPresent(By.xpath(String.format("//a[normalize-space()='%s']/ancestor::li[contains(@class, 'current')]", collectionName)));
    }

    public boolean isCollectionRemove(String collectionName) {
        return !web.isElementPresent(By.xpath(String.format("//a[text()='%s']", collectionName)));
    }

    public void addUsageRightsFilter(String usageRight, String key, String value) {
        String selectedSectionXpath = String.format("//*[contains(@id,'advSearchFilter')][.//*[normalize-space()='%s']]", usageRight);
        String selectedKeySectionXpath = String.format("%s[.//*[@class='unit' and normalize-space()='%s']]", selectedSectionXpath, key);
        String selectedValueXpath = String.format("%s//*[@value='%s']", selectedKeySectionXpath, value);

        By usageRightChooserListbox = By.cssSelector(".advancedSearchChooser [data-dojo-type=\"common.simpleDropdown\"]");
        By filterChooserListbox = By.xpath(String.format("%s//*[@role='listbox' and not(contains(@class,'Disabled'))]", selectedSectionXpath));
        By addMoreButton = By.xpath(String.format("%s//*[contains(@class,'add-more')]", selectedKeySectionXpath));
        By addFilterButton = By.xpath(String.format("%s//*[contains(@class,'add-filter')]", selectedKeySectionXpath));
        By valueCombobox = By.xpath(String.format("%s//*[@role='combobox' and not(contains(@class,'Disabled'))]", selectedKeySectionXpath));
        By valueTextbox = By.xpath(String.format("%s//input[contains(@class,'value') and not(@disabled)]", selectedKeySectionXpath));

        if (!web.isElementPresent(By.xpath(selectedKeySectionXpath))) {
            new DojoDropDown(this, usageRightChooserListbox).selectByValue(usageRight);
            Common.sleep(1000);
            new DojoSelect(this, filterChooserListbox).selectByVisibleText(key);
            Common.sleep(1000);
        }

        if (!web.isElementPresent(By.xpath(selectedValueXpath))) {
            if (web.isElementPresent(addMoreButton)) {
                web.click(addMoreButton);
                web.sleep(1000);
            }

            if (web.isElementPresent(valueTextbox)) {
                web.typeClean(valueTextbox, value);
            } else if (web.isElementPresent(valueCombobox)) {
                new DojoCombo(this, valueCombobox).selectByVisibleText(value);
            } else {
                throw new IllegalStateException(String.format("Unknown control for filter %s", key));
            }

            web.click(addFilterButton);
        }
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
        web.sleep(1000);
        if (web.isElementPresent(filterValueComboBoxLocator)) {
            new DojoCombo(this, filterValueComboBoxLocator).selectByVisibleText(value);
        } else if (web.isElementPresent(filterValueTextBoxLocator)) {
            web.typeClean(filterValueTextBoxLocator, value);
        } else {
            throw new IllegalStateException(String.format("Could not find field '%s' with value '%s'", name, value));
        }

        web.click(By.cssSelector(".advancedSearchChooser .icon-plus"));
    }

    public AddAssetToProjectPopUpWindow clickAddToProject() {
        web.click(By.cssSelector("[data-dojo-type='library.library.addAssetToProjectButton']"));
        web.sleep(1000);
        return new AddAssetToProjectPopUpWindow(this);
    }

    public boolean isAddAssetToProjectButtonVisible() {
        return web.isElementVisible(By.cssSelector("[data-dojo-type='library.library.addAssetToProjectButton']"));
    }

    public boolean isAddedFilterValuePresent(String name, String value) {
        By locator = By.xpath(String.format("//*[contains(@class,'filter-line')][.//*[@data-role='filterKey'][*[normalize-space()=normalize-space('%s')]]]//*[normalize-space(@value)=normalize-space('%s') and not(@type='hidden')]", name, value));
        return web.isElementPresent(locator);
    }

    private String getFilterClassName(String filterName) {
        String filterClassName;
        if (filterName.equalsIgnoreCase("image")) filterClassName = "image-type";
        else if (filterName.equalsIgnoreCase("video")) filterClassName = "video-type";
        else if (filterName.equalsIgnoreCase("audio")) filterClassName = "audio-type";
        else if ((filterName.equalsIgnoreCase("file")) || (filterName.equalsIgnoreCase("print"))) filterClassName = "file-type";
        else if (filterName.equalsIgnoreCase("document")) filterClassName = "document-type";
        else if (filterName.equalsIgnoreCase("other")) filterClassName = "other-type";
        else filterClassName = "all-type";
        return filterClassName;
    }

    private By getFilterNameListboxLocator() {
        return By.cssSelector(".advancedSearchChooser [data-dojo-type='common.simpleDropdown']");
    }

    public List<String> getListResultAssetFromGlobalSearch() {
        return web.findElementsToStrings(getListResultAssetFromLibraryPageLocator());
    }

    private By getListResultAssetFromLibraryPageLocator() {
        return By.xpath("//*[@data-type='tableRow']//*[contains(@class, 'file-parameters')]/div[1]/a");
    }

    private By getGoToLibraryRequestButtonLocator() {
        return By.cssSelector("[data-dojo-type=\"library.library.WorkRequestButton\"]");
    }

    private By getAddToExistingMenuLocator() {
        return By.cssSelector("[role='menu'][style*='visible'] tr:nth-child(2)");
    }

    private By getAddToNewPresentationButtonLocator() {
        return By.xpath("//span[text()='Add to new presentation']");
    }

    private By getAddToExistingPresentationButtonLocator() {
        return By.xpath("//span[text()='Add to existing presentation']");
    }

    private By getExpandCollectionListLocator() {
        return By.cssSelector(".tree-root .hasItems:not(.active)");
    }
    // NGN-16213 - QAA: Global Admin defines Applications available to BU - By Geethanjali- code starts
    public boolean isTabVisible(String tab) {
        return web.isElementVisible(By.xpath(String.format(".//*[@id='app-tabs']/div/a[@href='#presentations']", tab)));
    }
    // NGN-16213 -QAA: Global Admin defines Applications available to BU- By Geethanjali- code start

    public boolean getNewLibraryAccess(String message) {
        if (web.isElementPresent(By.xpath(".//div[@class=\"newLibraryInfo pas\"]")))
            return web.findElement(By.xpath(".//div[@class=\"newLibraryInfo pas\"]")).getText().contains(message);
        else
            return false;
    }

    public void clickNewLibraryUrl() {
        web.click(newLibraryUrlLocator);
        Common.sleep(1000);
    }

    public boolean verifyforNewLibraryUrl() {
        return web.isElementPresent(newLibraryUrlLocator);
    }


    public boolean isAssetAvailable(String fileName) {
        String locatorFormat = "//a[@title='%s']/ancestor::node()[5]/../div[contains(@class,'wrapper')]";
        By locator = By.xpath(String.format(locatorFormat, fileName));
        return web.isElementPresent(locator);
    }

}