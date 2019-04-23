package com.adstream.automate.babylon.sut.pages.NewLibrary.pages;

import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.*;
import com.adstream.automate.babylon.sut.pages.library.BaseLibraryPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.apache.commons.lang3.StringEscapeUtils;
import org.openqa.selenium.*;
import org.openqa.selenium.Point;
import scala.util.parsing.combinator.testing.Str;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;

import java.awt.*;
import java.awt.event.KeyEvent;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created by Janaki.Kamat on 24/04/2017.
 */
public class LibraryAsset<T> extends BaseLibraryPage<T> {

    private static final By sortByLocator = By.cssSelector("ads-sort-controller ads-md-select md-select");
    private static final By campaignLocator = By.cssSelector("ads-md-input md-input-container input");
    private static final By assetRowsLocator = By.xpath("//datatable-body-row");
    private final String sectionLocator = "//div[contains(@class,\"text-muted text-uppercase field-description smalltext ng-binding\")][text()='%s']";
    private final String datalocator = "%s/following-sibling::div//div[contains(@class,'filter-field-dictionary')][.//span[contains(text(),'%s')]]";
    private final By checkboxLocator = By.xpath("ads-md-checkbox/md-checkbox");
    private final String showOptionsLocator = "%s/following-sibling::div//div[@class=\"fieldFilter_toggler\"]";
    private static final By openAssetFilterLocator = By.xpath("//assets-list//*[@ng-repeat=\"button in $ctrl.buttons track by button.name\"]/button[.//span[@code=\"filters\"]]");
    private static final By openLinksLocator = By.xpath("//assets-list//*[@ng-repeat=\"button in $ctrl.buttons track by button.name\"]/button[.//span[@code=\"links\"]]");
    private final String dropdownSelectLocator = "ads-ui-select-dictionary[placeholder='%s'] [ng-click=\"$ctrl.openDropdown()\"] span";
    private static final By listViewIconLocator = By.cssSelector("[id=\"assets-list-tile-view-toggle\"] button");
    private static final By resetToDefaultLocator = By.cssSelector("a[ng-click=\"$ctrl.resetToDefault()\"]");
    private static final By saveChangesLocator = By.cssSelector("ads-md-button[ng-click=\"$ctrl.updateCollection()\"] button");
    private static final String listViewColumnLocator = "//*[@ng-repeat=\"(index, field) in $ctrl.fields\"]//span[contains(text(),\"%s\")]//ancestor::node()[4]//auc-ng-checkbox//input";
    protected static final By breadCrumLocator = By.cssSelector("[ng-repeat=\"item in $ctrl.breadcrumbs\"]");
    private static final String assetMetadataFormat = "//ads-ui-select-dictionary//input[@placeholder=\"%s\"]";
    private static final By warningForSavingParentFilterLocator = By.xpath("//ads-warning[contains(@info,\"This collection has sub-collections\")]");
    protected static final By collectionFilterIconLocator = By.cssSelector("ads-md-button[id=\"collections-filter-button\"] button");
    protected static final By collectionInfoIconLocator = By.cssSelector("ads-md-button[id=\"collection-info-button\"] button");
    protected static final By collectiontreeIconLocator = By.cssSelector("ads-md-button[id=\"collections-tree-button\"] button");
    protected static final By mediaFilterToggleLocator = By.xpath("//*[@data-role=\"media-filters-accordion\"]//ads-md-button[@click=\"$ctrl.toggle()\"]/button[..//span[@code=\"chevron-outline-down\"]]");
    private static final By clearAllFilters = By.cssSelector("a[ng-click=\"$ctrl.clearAllFilters()\"]");
    private WebElement field;

    public LibraryAsset(ExtendedWebDriver web) {
        super(web);

    }

    public List<String> getPresentedAssetsTitles() {
        return (web.isElementVisible(By.cssSelector(".assetCard__details .assetCard__title")) ? web.findElementsToStrings(By.cssSelector(".assetCard__details .assetCard__title")) : web.findElementsToStrings(By.cssSelector(".truncate.title-tmpl a")));
    }

    public void clickSelectAll() {
        web.waitUntilElementAppear(selectAllLocator);
        web.findElement(selectAllLocator).click();
    }

    public boolean isAssetNameWrapped() {

    return web.isElementVisible(By.xpath("//div[@data-role='asset-info-value']/span[@ng-reflect-auc-tooltip-truncate='true']"));

    }

    public void clickunSelectAll() {
        web.findElement(unselectAllLocator).click();
    }

    public List<String> getUploadedElementsText() {
        if (!web.isElementVisible(getUploadedElementsByCssSelector())) {
            return new ArrayList<>();
        }
        return web.findElementsToStrings(getUploadedElementsByCssSelector());
    }


    private By getUploadedElementsByCssSelector() {
        return By.cssSelector(".assetCard__details a");
    }

    public List<String> getUploadedElementsTextOnListView() {
        if (!web.isElementPresent(getUploadedElementsByXpathSelectorOnListView())) {
            return new ArrayList<>();
        }
        return web.findElementsToStrings(getUploadedElementsByXpathSelectorOnListView());
    }

    private By getUploadedElementsByXpathSelectorOnListView() {
        return By.xpath("//datatable-body-cell//div[contains(@class,'title')]/a");
    }
    public static enum MediaFilter {
        VIDEO("Video"),
        AUDIO("Audio"),
        DOCUEMNT("Document"),
        PRINT("Print"),
        OTHER("Other"),
        DIGITAL("Digital"),
        IMAGE("Image");

        private String type;

        private MediaFilter(String type) {
            this.type = type;
        }

        @Override
        public String toString() {
            return type;
        }


        public static MediaFilter findByType(String type) {
            for (MediaFilter mediaType : values())
                if (mediaType.toString().equalsIgnoreCase(type))
                    return mediaType;
            throw new IllegalArgumentException("Unknown media Filter: " + type);
        }
    }


    public By getMediaSelector(String type) {
        return By.xpath(String.format("//media-filter//div[.//span[contains(@class,\"mediaFilter-title\")][contains(text(),\"%s\")]]/ads-md-checkbox/md-checkbox", type.toLowerCase()));

    }


    public By getExpand(String type) {
        return By.cssSelector(String.format("media-filter [data-id=\"%s\"] [class=\"mediaFilter-toggler-wrapper\"] [ng-class=\"{'none':!$ctrl.isFiltersBlockHidden}\"]", type.toLowerCase()));
    }

    public By getTitle(String type) {
        return (By.xpath(String.format("//span[contains(@class,\"mediaFilter_title\")][contains(text(),\"%s\")]", type.toLowerCase())));
    }


    public static enum MediaSubType {
        CINEMA_MASTER("Cinema Master"),  // Video Type
        GENERIC_MASTER("Generic Master"),
        TITLED_MASTER("Titled Master"),
        ELEMENTS("Elements"),
        DISTRIBUTION_MASTER("Distribution Master"),
        RAW_VIDEO("Raw Vieo"),
        RUSHES("Rushes"),
        STOCK_FOOTAGE("Stock Footage"),
        QCED_MASTER("QC-ed master"),
        DIRECTORS_CUT("Director's cut"),  // End Video Type
        RADIO_FINAL_MIX("Radio Final Mix"), // Audio Type
        LIBRARY_TRACK("Library Tracks"),
        MUSIC_TRACK("Music Track"),
        TV("TV"),
        CINEMA("Cinema"),
        V_O("V/O"),
        MUSIC("Music"),
        M_E("M&E"),
        SFX("SFX"),
        FINAL_MIX("Final Mix"), // End Audio subtype took off QC-ed Master and Elements as it is already pesent
        ACTIVITY_GRID_MARKETTING_PLAN("Activity Grid/Marketting Plan"),  // Document Type
        AGENDA("Agenda"),
        ANALYSIS("Analysis"),
        BRIEF("Brief"),
        CONCEPT("Concept"),
        CONTRACT("Contract"),
        COPY("Copy"),
        ESTIMATE("Estimate"),
        GUIDELINE("GuideLine"),
        INVOICE("Invoice"),
        OTHER("Other"),
        PLANNING("Planning"),
        PURCHASE_ORDER("Purchase Order"),
        RESEARCH("Research"),
        SCRIPT("Script"),
        STRATEGY("Strategy"),
        TEMPLATE("Template"),
        INTEGRATED_CAMPAIGn_PLAN("Integrated Campaign Plan"),
        MEDIA_SCHEDULE("Media Schedule"),
        PRODCTION_SCHEDULE("Production Schedule"),
        REPORT("Report"),
        TIMELINE("TimeLine"),
        PRESENTATION("Presentation"),            // End Document Type TOOLKIT("Toolkit") is already present in Digital Type hence skipped
        DIRECT_MAIL("Direct Mail"),   // Print Type
        MAGAZINES("Magazines"),
        NEWSPAPER("Newspapaer"),
        POINT_OF_SALE("Point of Sale(POS)"),
        COMMERCIAL_POINT("Commercial Point"),
        PACKAGING("Packaging"),
        BROCHURES_AND_FLYERS("Brochuers & Flyers"), // End Print Type OTHER and Out of HOME is not listed as it is already present
        ILLUSTRATION("Illusatration"),       // IMAGE Type
        PHOTOGRAPHY("Photography"),
        PRINT("Print"),
        STOCK_IMAGES("Stock Images"), // End Image Type Generic MAstter and Titles master are already present hence not listed
        VIDEO_SPOT("Video Spot"),   // Digital Type
        PUBLICATION("Publication"),
        OUT_OF_HOME("Out Of Home"),
        RICH_MEDIA("Rich Media"),
        APPLICATION("Application"),
        FLASH("Flash"),
        BANNER("Banner"),
        WEB_PAGE("Web Page"),
        SKIN("Skin"),
        DEVICE("Device"),
        ITERACTIVE("Iteractive"),
        SOCIAL("Social"),
        _3D("3D"),
        TOOLKIT("Toolkit"),  // End Digital Type
        MEDIA_SPOT("Media Spot");

        private String type;

        private MediaSubType(String type) {
            this.type = type;
        }

        @Override
        public String toString() {
            return type;
        }

        public static MediaSubType findByType(String type) {
            for (MediaSubType mediaSubType : values())
                if (mediaSubType.toString().equalsIgnoreCase(type))
                    return mediaSubType;
            throw new IllegalArgumentException("Unknown media Sub Type: " + type);
        }


    }

    public By getMediaSubTypeSelector(String subType) {
        return By.xpath(String.format("//field-filter[@model=\"$ctrl.filterValues['_cm.common.mediaSubType']\"]//div[contains(@ng-repeat,\"val in $ctrl.topValues\")][.//span[contains(@class,\"fieldFilter_value ng-binding\")][contains(text(),\"%s\")]]//ads-md-checkbox/md-checkbox", subType));
    }


    public int getFilesCount(String fileName) {
        int count = 0;

        try {
            By locator = By.xpath(String.format("//div[@class='assetCard__details']//a[@title='%s']", fileName));
            web.waitUntilElementAppear(locator);
            count = web.findElements(locator).size();
        } catch (Exception e) {
        }
        return count;
    }

    public void setPagination(int value) {
        web.findElement(By.xpath("//ads-ui-paginator//md-select-value[@class='md-select-value']")).click();
        By locator = By.xpath(String.format("//md-option[@value='%s']", value));
        Common.sleep(2000);
        web.waitUntilElementAppear(locator).click();

    }

    public void clickNextPagination() {
        web.findElement(By.xpath("//ads-md-button[@is-disabled='!$ctrl.showNextButton()']/button")).click();
        Common.sleep(1000);
    }

    public void clickPreviousPagination() {
        web.findElement(By.xpath("//ads-md-button[@is-disabled='$ctrl.currentPageNumber <= 1']/button")).click();
        Common.sleep(1000);
    }

    public int getNextPaginationButtonPosition() {
        web.waitUntilElementAppear(By.xpath("//ads-md-button[@is-disabled='!$ctrl.showNextButton()']/button"));
        WebElement element = web.findElement(By.xpath("//ads-md-button[@is-disabled='!$ctrl.showNextButton()']/button"));
        Point point = element.getLocation();
        return point.getY();
    }

    public void clickListView() {
        if (web.isElementVisible(By.xpath("//ads-md-button[@id='assets-list-tile-view-toggle']/button//span[@code='listview']")))
            web.click(By.xpath("//ads-md-button[@id='assets-list-tile-view-toggle']/button//span[@code='listview']"));
        Common.sleep(1000);
    }

    public void clickGridView() {
        if (web.isElementVisible(By.xpath("//ads-md-button[@id='assets-list-tile-view-toggle']/button//span[@code='gridview']")))
            web.click(By.xpath("//ads-md-button[@id='assets-list-tile-view-toggle']/button//span[@code='gridview']"));
        Common.sleep(1000);
    }

    public boolean isViewOfFilesIsList() {
        return web.isElementVisible(By.xpath("//div[@ng-if='$ctrl.viewMode === $ctrl.EViewMode.list']"));

    }

    public boolean isViewOfFilesIsGrid() {
        return web.isElementVisible(By.xpath("//div[@ng-if='$ctrl.viewMode === $ctrl.EViewMode.tile']"));
    }

    public void sortListViewByColumn(String column, String order) {

        WebElement element = web.findElement(By.xpath("//datatable-header-cell[@title='" + column + "']"));
        element.click();
        Common.sleep(1000);
        String classValue = web.findElement(By.xpath("//datatable-header-cell[@title='" + column + "']")).getAttribute("class");
        if (!classValue.contains(order)) {
            web.findElement(By.xpath("//datatable-header-cell[@title='" + column + "']")).click();
        }
        Common.sleep(1000);
    }


    public String getAssetsTitleByName(String name) {
        WebElement ele = web.findElement(By.xpath("//datatable-body-cell//div[contains(@class,'title')]/a[.='" + name + "']"));
        web.scrollToElement(ele);
        return web.findElement(By.xpath("//datatable-body-cell//div[contains(@class,'title')]/a[.='" + name + "']")).getText();
    }

    private By getUploadedElementsByxpathSelector() {
        return By.xpath("//datatable-body-cell//div[contains(@class,'title')]/a");
    }

    public boolean getTotalAssetCount(int count) {
        boolean flag = false;
        String assetTotalText = "";
        assetTotalText = web.findElement(By.xpath("//span[@translate-value-name='assets']")).getText();
        if (assetTotalText.contains(count + " " + "assets")) {
            flag = true;
        }
        return flag;
    }

    public String verifyTilesMetaData(String asset, String fieldName, String fieldValue) {
        String retrieveFieldValue = "";
        web.waitUntilElementAppear(By.xpath("//div[@class='assetCard__details']//a[@title='" + asset + "']/parent::div/following-sibling::div//asset-info[@data-role='asset-info-metadata']"));
        retrieveFieldValue = web.findElement(By.xpath("//div[@class='assetCard__details']//a[@title='" + asset + "']/parent::div/following-sibling::div//asset-info[@data-role='asset-info-metadata']//span[contains(.,'" + fieldName + "')]/parent::div/following-sibling::div[@class='asset-info-value']//span[contains(.,'" + fieldValue + "')]")).getText();
        return retrieveFieldValue;
    }

    public void scrollDownToFooter() {
        web.scrollToElement(web.findElement(By.xpath("//ads-ui-paginator[@page-sizes='$ctrl.appConfig.application.pageSizes']")));
        web.sleep(2000);
    }

    public boolean verifyUsageRightsTooltip(String type,String assetName) {
        boolean flag=false;
        if (type.equalsIgnoreCase("available for use")) {
            flag = web.isElementVisible(By.xpath("//div[@class='assetCard__details']//a[@title='" + assetName + "']/parent::div/following-sibling::div//div[@class='asset-card-info-tooltip']//usage-rights-icon-ngx//span[@class='icon-state ok icon-default']"));
        }
        else if(type.equalsIgnoreCase("expired") || type.equalsIgnoreCase("not yet started")){
            flag = web.isElementVisible(By.xpath("//div[@class='assetCard__details']//a[@title='" + assetName + "']/parent::div/following-sibling::div//div[@class='asset-card-info-tooltip']//usage-rights-icon-ngx//span[@class='icon-state error icon-default']"));
        }
        return flag;
    }


    public void clickTopLabel() {
        web.findElement(By.xpath("//ads-ui-entities-list-info//span[contains(.,Showing)][@translate='SHOW_ALL']")).click();

    }

    public boolean verifyUsageRightsIndicatorOnListView(String type,String assetName) {
        boolean flag=false;
        if (type.equalsIgnoreCase("available for use")) {
            flag = web.isElementVisible(By.xpath("//usage-rights-icon-ngx//span[@class='icon-state ok icon-default']"));
        }
        else if(type.equalsIgnoreCase("expired") || type.equalsIgnoreCase("not yet started")){
            flag = web.isElementVisible(By.xpath("//usage-rights-icon-ngx//span[@class='icon-state error icon-default']"));
        }
        return flag;
    }
    public void openAsset(String number) {
        List<WebElement> list = web.findElements(By.xpath("//div[@ng-repeat='asset in $ctrl.assetsList track by asset._id']"));
        for (int i = list.size() - 1; i >= 0; i--) {
            if (i == Integer.parseInt(number)) {
                web.findElement(By.xpath("//div[@ng-repeat='asset in $ctrl.assetsList track by asset._id'][" + i + "]//div[@class='assetCard__details']/a")).click();
                break;
            }
        }
    }


    public void scrollDownToFileOnListView(int fileNumber) {
        web.scrollToElement(web.findElement(By.xpath("//datatable-row-wrapper[" + fileNumber + "]")));
        // web.scrollToElement(web.findElement(By.xpath("//ads-ui-paginator//md-select-value[@class='md-select-value']")));

    }


    public boolean isPreviewForFileAvailable(String assetId) {
        By locator = By.xpath("//file-preview-image//img[contains(@src,'/api/file/" + assetId + "')]");
        return web.isElementPresent(locator);
    }

    public void setFilter(String sectionName, String fieldValue) {
        if (web.isElementPresent(By.xpath(String.format(datalocator, String.format(sectionLocator, sectionName), fieldValue)))) {
            field = web.findElement(By.xpath(String.format(datalocator, String.format(sectionLocator, sectionName), fieldValue)));
        } else {
            web.click(getShowOptionsSelector(String.format(sectionLocator, sectionName)));
            web.click(By.cssSelector(String.format(dropdownSelectLocator, sectionName)));
            if (web.isElementPresent(By.xpath(String.format("//*[contains(@ng-repeat,\"val in $ctrl.selectValues\")]//*[normalize-space(text())='%s']", fieldValue)))) {
                web.findElement(By.xpath(String.format("//*[contains(@ng-repeat,\"val in $ctrl.selectValues\")]//*[normalize-space(text())='%s']", fieldValue))).click();
                field = web.findElement(By.xpath(String.format(datalocator, String.format(sectionLocator, sectionName), fieldValue)));
            } else
                throw new IllegalArgumentException(String.format("%s Field does not exist", fieldValue));
        }


    }


    public void clickField(boolean on, WebElement field) {
        MdCheckbox checkbox = new MdCheckbox(this, field.findElement(checkboxLocator));
        if (on)
            checkbox.selectByElement();
        else
            checkbox.deSelectByElement();
    }

    public boolean isChecked(String sectionName, String fieldValue) {
        if (web.isElementPresent(By.xpath(String.format(datalocator, String.format(sectionLocator, sectionName), fieldValue))))
            return new MdCheckbox(this, web.findElement(By.xpath(String.format(datalocator, String.format(sectionLocator, sectionName), fieldValue))).findElement(checkboxLocator)).isSelected();
        else
            return false;
    }

    public By getShowOptionsSelector(String section) {
        return By.xpath(String.format(showOptionsLocator, section));
    }


    public static class LibraryFileMetadata {
        public String getBusinessUnit() {
            return businessUnit;
        }

        private String businessUnit;

        public String getName() {
            return name;
        }

        private String name;

        public String getType() {
            return type;
        }


        private String type;

        public String getFileSize() {
            return fileSize;
        }

        private String fileSize;

        public LibraryFileMetadata(ExtendedWebDriver web, String fileName) {
            String baseLocator = String.format("//*[@class='assetCard__details'][.//a[@title=\"%s\"]]", fileName);
            businessUnit = web.findElement(By.xpath(String.format("%s", baseLocator))).getText();
            name = web.findElement(By.xpath(String.format("%s//*[contains(@class,'assetCard__title')]", baseLocator))).getText();
            type = web.findElement(By.xpath(String.format("%s//span[@class=\"info-block\"]", baseLocator))).getText();
            fileSize = web.findElement(By.xpath(String.format("%s//span[@class=\"info-block\"][2]", baseLocator))).getText();
        }

    }


    public void clickExpandFilter(MediaFilter filter) {
        if (web.isElementPresent(getExpand(filter.toString())))
            web.findElement(getExpand(filter.toString())).click();
    }


    public void selectField(String check, String fieldValue, String sectionName) {

        if (web.isElementVisible(By.cssSelector(String.format("input[placeholder=\"%s\"]", sectionName))))
            web.typeClean(By.cssSelector(String.format("input[placeholder=\"%s\"]", sectionName)), fieldValue + Keys.ENTER);
        Common.sleep(2000);
        List<WebElement> elems = web.findElements(By.cssSelector(String.format("ads-ui-select-dictionary[placeholder=\"%s\"] .option.ui-select-choices-row-inner span", sectionName)));
        for (WebElement el : elems) {
            if (el.getText().equalsIgnoreCase(fieldValue))
                el.click();
        }

    }

    public void enterUsageRightsDate(String section,String fieldValue)
    {
      if(section.equalsIgnoreCase("usage start date"))
      {
          web.typeClean(By.xpath("//input[@placeholder='Usage Start Date']"), fieldValue + Keys.ENTER);
          web.findElement(By.xpath("//div[.='Usage rights']")).click(); //to get the focus
      }
      else if(section.equalsIgnoreCase("usage end date"))
      {
          web.typeClean(By.xpath("//input[@placeholder='Usage End Date']"), fieldValue + Keys.ENTER);
          web.findElement(By.xpath("//div[.='Usage rights']")).click(); //to get the focus
      }
      else {
          throw new IllegalArgumentException("This " + section + "does not exist");
      }

    }

    public LibraryFileMetadata getFileLibraryMetadata(String fileName) {
        return new LibraryFileMetadata(web, fileName);
    }

    public List<String> getValuesFromFilter(String filterName)
    {
        web.findElement(By.xpath("//input[@placeholder='"+filterName+"']")).click();
        return web.findElementsToStrings(By.xpath("//div[@class='option ui-select-choices-row-inner']/span"));
    }

    protected By getShowOptionsLink() {
        return By.xpath("//*[@class=\"tree-item-title\"]/following-sibling::div[@class=\"tree-item-toggle\"]/a//span[text()='Show sub-collections']");
    }

    public void selectMediaSubType(String subType) {
        web.waitUntilElementAppear(By.cssSelector("input[placeholder=\"Media sub-type\"]"));
        web.typeClean(By.cssSelector("input[placeholder=\"Media sub-type\"]"), subType + Keys.ENTER);
        web.click(By.xpath("//div[@class='option ui-select-choices-row-inner']/span"));
        Common.sleep(2000);
    }


    public boolean getFiltersState(MediaFilter filter) {
        if (web.isElementPresent(mediaFilterToggleLocator))
            web.click(mediaFilterToggleLocator);
        WebElement fil = web.findElement(getMediaSelector(filter.toString()));
        return fil.getAttribute("checked") != null && fil.getAttribute("checked").equalsIgnoreCase("true");
    }

    public boolean getSubMediaState(MediaSubType filter) {
        if (web.isElementVisible(getMediaSubTypeSelector(filter.toString()))) {
            WebElement fil = web.findElement(getMediaSubTypeSelector(filter.toString()));
            return fil.getAttribute("checked") != null && fil.getAttribute("checked").equalsIgnoreCase("true");
        } else
            return false;
    }

    public boolean verifyFilterEnabled(MediaFilter filter) {
        WebElement fil = web.findElement(getMediaSelector(filter.toString()));
        return fil.getAttribute("disabled") != null && fil.getAttribute("disabled").equals("true");
    }

    private By getFileSelector(String fileName) {
        String locatorFormat = "//a[@title='%s']/ancestor::node()[4]//auc-ng-checkbox//input";
        return By.xpath(String.format(locatorFormat, fileName));
    }


    public LibraryAsset<T> selectFileByFileName(String fileName) {
        //   web.waitUntilElementAppear(By.xpath(String.format("//datatable-body[..//a[contains(text(),'%s')]]//auc-ng-checkbox//input",fileName)));
        //   web.findElement(By.xpath(String.format("//datatable-body[..//a[contains(text(),'%s')]]//auc-ng-checkbox//input",fileName))).click();
        // NEW-LIB change locatorFormat based upon List/Tile
        String locatorFormat = isViewOfFilesIsTile()
                ? "*//datatable-body-row[..//a[contains(text(),\"%s\")]]//div[@class=\"checkboxTmpl\"]/auc-ng-checkbox//input"
                : "//a[@title=\"%s\"][@data-role='asset-thumbnail']/../../auc-ng-checkbox//input";
        By locator = By.xpath(String.format(locatorFormat, fileName));
        if (web.findElement(locator).getAttribute("ng-reflect-model") == null || web.findElement(locator).getAttribute("ng-reflect-model").equalsIgnoreCase("false")) {
            if (!web.isElementPresent(locator)) {
                locator = getFileSelector(StringEscapeUtils.escapeXml10(fileName));
            }
            web.clickThroughJavascript(locator);
            web.sleep(500);
        }
        return this;
    }


    public boolean isViewOfFilesIsTile() {
              // tile view icon active
        return  web.isElementVisible(By.cssSelector("datatable-body-row"));

    }


    public void switchFilterInNeedState(String filterName, String state) {
        boolean needFiltersState = state.equalsIgnoreCase("on") || state.equalsIgnoreCase("true") || state.equalsIgnoreCase("enabled");
        MediaFilter filter = MediaFilter.findByType(filterName);
        if (getFiltersState(filter) != needFiltersState) {
            if (needFiltersState == true)
                new MdCheckbox(this, getMediaSelector(filter.toString())).selectBylocator();
            else
                new MdCheckbox(this, getMediaSelector(filter.toString())).deSelectByLocator();
        }
    }


    public boolean isAssetSelected(String fileName) {
        By assetSelectedLocator = getFileSelector(fileName);
        if (!web.isElementPresent(assetSelectedLocator)) {
            assetSelectedLocator = getFileSelector(StringEscapeUtils.escapeXml10(fileName));
        }
        return web.findElement(assetSelectedLocator).getAttribute("ng-reflect-model") != null && web.findElement(assetSelectedLocator).getAttribute("ng-reflect-model").equals("true");
    }


    public void enterCampaignValue(String value) {
        web.typeClean(campaignLocator, value + Keys.ENTER);
    }

    public String getCampaignValue() {
        return web.findElement(campaignLocator).getText();
    }

    public void clearFilter(String filterName, String filterValue) {
        Common.sleep(2000);
        switch (filterName) {
            case "MediaType":
                String mediaTypeformat = "//*[contains(@class,\"advanced-search-summary\")]//adv-search-summary-item[..//span[contains(text(),\"%s\")]]//*[@ng-click=\"$ctrl.onRemove(key)\"]";
                web.click(By.xpath(String.format(mediaTypeformat, filterValue.substring(0, 1).toUpperCase() + filterValue.substring(1).toLowerCase())));
                break;
            case "MediaSubType":
                String mediaSubTypeformat = "//*[contains(@class,\"advanced-search-summary\")][@ng-if=\"!$ctrl.areEmptyAll()\"]//adv-search-summary-item[@description=\"Media sub-type\"][.//div[contains(@class,\"filter-value\")][contains(text(),\"%s\")]]//*[contains(@ng-click,\"$ctrl.onRemove\")]";
                web.click(By.xpath(String.format(mediaSubTypeformat, filterValue)));
                break;
            case "Business Unit":
            case "Originator":
            case "Market":
            case "Advertiser":
                String filterFormat = "//*[contains(@class,\"advanced-search-summary\")][@ng-if=\"!$ctrl.areEmptyAll()\"]//adv-search-summary-item[contains(@description,\"%s\")][.//div[@ng-repeat=\"val in $ctrl.value\"]][//*[contains(text(),\"%s\")]]//span[contains(@ng-click,\"$ctrl.onRemov\")]";
                web.click(By.xpath(String.format(filterFormat, filterName, filterValue)));
                break;
            case "Campaign":
                String format = "//*[contains(@class,\"advanced-search-summary\")][@ng-if=\"!$ctrl.areEmptyAll()\"]//adv-search-summary-item[contains(@description,\"%s\")][.//div[contains(@class,\"filter-value\")]//*[contains(text(),\"%s\")]]//*[contains(@ng-click,\"$ctrl.onRemove(key)\")]";
                web.click(By.xpath(String.format(format, filterName, filterValue)));
                break;

        }

    }

    public void clickSortCombo() {
        web.click(sortByLocator);
        Common.sleep(1000);
    }

    public List<String> getSortingOptionsList() {
        return web.findElementsToStrings(By.cssSelector("md-option[ng-repeat=\"opt in $ctrl.sortOptions\"]"));
    }

    public String getSortByValue() {
        web.waitUntilElementAppear(By.cssSelector("ads-md-select[model=\"$ctrl.selectedSortOption\"] md-select-value[class=\"md-select-value\"]"));
        return web.findElement(By.cssSelector("ads-md-select[model=\"$ctrl.selectedSortOption\"] md-select-value[class=\"md-select-value\"]")).getText();

    }

    public boolean verifyPresenceOfExpanderForCommonFilters()
    {
        boolean flag=false;
        if(web.isElementVisible(By.xpath("//ads-accordion[@description='Common filters']//span[@code='chevron-outline-down']")) || web.isElementVisible(By.xpath("//ads-accordion[@description='Common filters']//span[@code='chevron-outline-up']"))){
        flag=true;}
        return flag;
    }

    public boolean isBusinessUnitAppearsAtTopUnderCommonFilters()
    {
        if(web.isElementVisible(By.xpath("//ads-accordion[@description='Common filters']//span[@code='chevron-outline-down']")))
        { web.getJavascriptExecutor().executeScript("arguments[0].click();",web.findElement(By.xpath("//ads-accordion[@description='Common filters']//span[@code='chevron-outline-down']")));}
        return web.isElementVisible(By.xpath("//field-filter[1]//ads-ui-select-dictionary[@placeholder='Business Unit']"));
    }

    public String IsMessageDisplayed() {
        return web.findElement(By.xpath("//no-access//div")).getText();
    }

    public List<String> getObjectsTitle() {
        List<WebElement> elements = getUploadedElements();
        List<String> objectsText = new ArrayList<>(elements.size());
        for (WebElement element : elements) {
            String text = element.getAttribute("ng-reflect-auc-tooltip-text").trim();
            objectsText.add(text);
        }
        return objectsText;
    }


    public List<WebElement> getUploadedElements() {
        return web.findElements(getUploadedElementsByxpathSelector());
    }

    public String getAssetsTitleById(String collectionId, String id) {
        return web.findElement(By.cssSelector(String.format(".assetCard__details a[href*='/assets/%s/info']", id))).getAttribute("title").trim();
    }

    public void setSortBy(String value) {
        if (!getSortByValue().equalsIgnoreCase(value)) {
            web.findElement(By.cssSelector("ads-md-select[model=\"$ctrl.selectedSortOption\"] md-select-value[class=\"md-select-value\"]")).click();
            web.waitUntilElementAppearVisible(By.cssSelector("md-option[ng-repeat=\"opt in $ctrl.sortOptions\"]"));
            for (WebElement option : web.findElements(By.cssSelector("md-option[ng-repeat=\"opt in $ctrl.sortOptions\"]"))) {
                if (option.getText().equalsIgnoreCase(value)) {
                    option.click();
                    break;
                }
            }
        }
    }

    public LibCollectionPopUp clickAddToCollection(CollectionType type) {
        web.click(type == CollectionType.NEW ? newCollectionPopupLocator : newSubCollectionPopupLocator);
        Common.sleep(1000);
        if (web.isElementPresent(By.xpath(String.format("//*[@ng-click=\"$ctrl.onCreateFromAssets()\"]//ads-md-button/*//*[text()='%s']", SelectionType.BY_ITEMS.getType()))))
            web.click(By.xpath(String.format("//*[@ng-click=\"$ctrl.onCreateFromAssets()\"]//ads-md-button/*//*[text()='%s']", SelectionType.BY_ITEMS.getType())));
        else if (web.isElementPresent(By.xpath(String.format("//*[@ng-click=\"$ctrl.onCreateFromFilters()\"]//ads-md-button/*//*[text()='%s']", SelectionType.BY_FILTERS.getType()))))
            web.click(By.xpath(String.format("//*[@ng-click=\"$ctrl.onCreateFromFilters()\"]//ads-md-button/*//*[text()='%s']", SelectionType.BY_FILTERS.getType())));
        return new LibCollectionPopUp(this, type == CollectionType.NEW ? "Create New Collection" : "Create New Sub Collection");
    }


    public LibCollectionPopUp getCollectionPopup(CollectionType type) {
        return new LibCollectionPopUp(this, type == CollectionType.NEW ? "Create new Collection" : "Create New Sub Collection");
    }

    public LibWorkRequestPopup getWorkRequestPopup() {
        return new LibWorkRequestPopup(this);
    }

    public void clickAssetFilter() {
        if(web.isElementVisible(By.xpath("//ads-md-button[@id='assets-open-filters-button']/button")))
        {
           web.findElement(By.xpath("//ads-md-button[@id='assets-open-filters-button']/button")).click();
            Common.sleep(2000);
        }
    }


    public void enterSearchKeyword(String text)  {

        web.waitUntilElementAppear(By.xpath("//input[@placeholder='Search for assets...']"));
        web.findElement(By.xpath("//input[@placeholder='Search for assets...']")).sendKeys(text+Keys.ENTER);
        Common.sleep(2000);
    }

    public void clickAssetFromFilterPage(String assetName)  {

        web.findElement(By.xpath("//a[@title='Fish-Ad.mov']/span")).click();

    }

    public void checkMatchAllWords(String input)
    {
        String text = web.findElement(By.xpath("//ads-md-checkbox[@ng-click='$ctrl.toggleMatchAnyKeyword()']/md-checkbox")).getAttribute("checked");
        if(input.equalsIgnoreCase("check")) {
            web.findElement(By.xpath("//ads-md-checkbox[@ng-click='$ctrl.toggleMatchAnyKeyword()']/md-checkbox")).click();

        }
        else if(input.equalsIgnoreCase("uncheck")) {
            if (text.equalsIgnoreCase("true")) {
                web.findElement(By.xpath("//ads-md-checkbox[@ng-click='$ctrl.toggleMatchAnyKeyword()']/md-checkbox")).click();
            }

        }
    }

    public boolean isMatchAllWordsChecked()
    {
       return web.isElementVisible(By.xpath("//ads-md-checkbox[@ng-click='$ctrl.toggleMatchAnyKeyword()']/md-checkbox[@checked='checked']"));
    }

   public void clearAllFilters() {
        web.click(clearAllFilters);
    }

    public String verifyMediaSubtypeOnFilterPanel()
    {
        return web.findElement(By.xpath("//adv-search-summary-item[@description='Media sub-type']//ads-truncate//span")).getText();
    }

    public boolean getAssetTypeInfo(String type, String assetName) {
        return web.isElementVisible(By.xpath(String.format("//*[contains(@class,\"assetCard__title\")]//span[text()='%s']//ancestor::div[@class=\"assetCard\"]//div[@class=\"assetCard__thumbnail-wrapper\"]//*[@class=\"assetCard__thumbnail-time\"]//*[contains(@ng-reflect-code,'%s')]", assetName, type.toLowerCase())));
    }

    public int getCount(String assetName) {
        By locator = By.xpath(String.format("//*[contains(@class,\"assetCard__details\")]//a[@title=\"%s\"]", assetName));
        if (web.isElementVisible(locator))
            return web.findElements(locator).size();
        else
            throw new IllegalArgumentException("This " + assetName + "does not exist in the library");
    }

    public int getAssetCount() {
        web.waitUntilElementAppear(By.xpath("//div[@ng-repeat='asset in $ctrl.assetsList track by asset._id']"));
        return web.findElements(By.xpath("//div[@ng-repeat='asset in $ctrl.assetsList track by asset._id']")).size();
    }

    public boolean isMetadataEditable(String metadata) {
        return web.isElementVisible(By.xpath("//adv-search-summary-item[@description='" + metadata + "']//span[contains(@class,'filter-remove')]"));
    }

    public boolean isKeywordAccepted(String keyword) {
        return web.isElementVisible(By.xpath("//md-content[@class='adv-search-summary-list _md']//adv-search-summary-item//span[contains(.,'" + keyword + "')]"));
    }

    public boolean checkTopLevelMenuExist(String buttonName) {

        return web.isElementVisible(By.xpath("//ads-md-button/button//span[.='" + buttonName + "']"));
    }

    public boolean isPreviewVisible(String assetId) {

        return web.isElementPresent(By.xpath("//a[contains(@href,'/assets/"+assetId+"')]/div[@class='img-container']//file-preview-image[@ng-reflect-thumbnail='true']"));
    }


    public void selectAssets(String count) {
        List<WebElement> elements = web.findElements(By.cssSelector("asset-card-ngx auc-ng-checkbox input[class^=\"auc-checkbox\"]"));
        for (int i = 0; i < Math.min(Integer.parseInt(count), elements.size()); i++) {
            WebElement el = elements.get(i);
            el.click();
        }
    }

    public String getLabelsValueAboutCountSelectedFiles() {
        return web.findElement(By.xpath("//ads-ui-entities-list-info//*[@translate=\"SELECTED_LENGTH\"]")).getText();
    }


    public void clickAsset(String collectionId, String id) {
        if (web.isElementVisible(By.cssSelector(String.format(".assetCard__details a[class*=\"assetCard__title\"][href*='#/collections/%s/assets/%s/info']", collectionId, id))))
            web.findElement(By.cssSelector(String.format(".assetCard__details a[class*=\"assetCard__title\"][href*='#/collections/%s/assets/%s/info']", collectionId, id))).click();
        else
            web.findElement(By.cssSelector(String.format(".assetCard__details a[class*=\"assetCard__title\"][href*='#/assets/%s/info']", id))).click();

    }

    public void clickDashboardLink() {
        web.findElement(By.xpath("*//md-tab-item//span[@class=\"ng-binding\"][contains(text(),\"Dashboard\")]")).click();
        Common.sleep(4000);
    }

    public void clickSaveChanges() {
        web.click(saveChangesLocator);
        Common.sleep(1000);
        if (web.isElementPresent(warningForSavingParentFilterLocator))
            clickSaveChangesInWarningWhileSavingFilter();

    }

    public void clickCancelChanges() {
        web.click(saveChangesLocator);
        web.waitUntilElementAppear(warningForSavingParentFilterLocator);
        if (web.isElementPresent(warningForSavingParentFilterLocator))
            clickCancelChangesInWarningWhileSavingFilter();
        Common.sleep(1000);
    }

    public Boolean checkPresenceOfNewCollectionButton(String collectionType) {
        if (CollectionType.NEW == CollectionType.findByType(collectionType))
            return web.isElementPresent(newCollectionPopupLocator);
        else if (CollectionType.SUB == CollectionType.findByType(collectionType))
            return web.isElementPresent(newSubCollectionPopupLocator);
        else
            throw new IllegalArgumentException(collectionType + " is any illegal argument");
    }

    public Boolean checkPresenceOfSelectionTypeOptions(String selectionType) {
        if (SelectionType.BY_ITEMS == SelectionType.findByType(selectionType))
            return web.isElementPresent(By.xpath(String.format("//ads-md-button/*//*[text()='%s']", SelectionType.BY_ITEMS.getType())));
        else if (SelectionType.BY_FILTERS == SelectionType.findByType(selectionType))
            return web.isElementPresent(By.xpath(String.format("//ads-md-button/*//*[text()='%s']", SelectionType.BY_FILTERS.getType())));
        else
            throw new IllegalArgumentException(selectionType + " is any illegal argument");
    }


    private boolean isListView() {
        return web.isElementVisible(By.cssSelector("ads-md-button[click=\"$mdOpenMenu($event)\"] button"));
    }


    public void selectListViewColumn(String action, String columnList) {
        if (!isListView())
            web.click(By.cssSelector("[id=\"assets-list-tile-view-toggle\"] button"));
        Common.sleep(1000);
        if (!web.isElementVisible(By.xpath("//*[@ng-repeat=\"(index, field) in $ctrl.fields\"]")))
            web.click(By.cssSelector("ads-md-button[click=\"$mdOpenMenu($event)\"] button"));
        Common.sleep(1000);
        for (String column : columnList.split(",")) {
            switch (action) {
                case "select":
                    if (web.findElement(By.xpath(String.format(listViewColumnLocator, column))).getAttribute("ng-reflect-model") == null || web.findElement(By.xpath(String.format(listViewColumnLocator, column))).getAttribute("ng-reflect-model").equalsIgnoreCase("false"))
                        web.click(By.xpath(String.format(listViewColumnLocator, column)));
                    break;
                case "deselect":
                    if (web.findElement(By.xpath(String.format(listViewColumnLocator, column))).getAttribute("ng-reflect-model").equalsIgnoreCase("true"))
                        web.getJavascriptExecutor().executeScript("arguments[0].click();", web.findElement(By.xpath(String.format(listViewColumnLocator, column))));
                    break;
                default:
                    throw new IllegalArgumentException("Illegal " + action);
            }
            web.click(By.cssSelector("ads-md-button[click=\"$mdOpenMenu($event)\"] button"));
        }
    }

    public List<String> getColumnTitles() {
        return web.findElementsToStrings(By.cssSelector(".datatable-header-cell-label"));
    }

    public void clickResetToDefault() {
        if (!isListView())
            web.click(By.cssSelector("[id=\"assets-list-tile-view-toggle\"] button"));
        Common.sleep(1000);
        if (!web.isElementVisible(By.xpath("//*[@ng-repeat=\"(index, field) in $ctrl.fields\"]")))
            web.click(By.cssSelector("ads-md-button[click=\"$mdOpenMenu($event)\"] button"));
        Common.sleep(1000);
        web.click(resetToDefaultLocator);
        Common.sleep(1000);
    }

    public void clickListViewIcon() {
        web.click(listViewIconLocator);
        Common.sleep(1000);
    }


    public List<String> getSelectedColumns() {
        List<String> listSelectedColumns = new ArrayList<String>();
        if (!isListView())
            web.click(By.cssSelector("[id=\"assets-list-tile-view-toggle\"] button"));
        Common.sleep(1000);
        if (!web.isElementVisible(By.xpath("//*[@ng-repeat=\"(index, field) in $ctrl.fields\"]")))
            web.click(By.cssSelector("ads-md-button[click=\"$mdOpenMenu($event)\"] button"));
        Common.sleep(1000);
        for (WebElement elem : web.findElements(By.xpath("//*[@ng-repeat=\"(index, field) in $ctrl.fields\"]//auc-ng-checkbox//span[@class=\"auc-checkbox-text\"]/span[@class=\"ng-binding ng-scope\"]"))) {
            if (elem.findElement(By.xpath("ancestor::node()[4]//auc-ng-checkbox//input")).getAttribute("ng-reflect-model").equals("true"))
                listSelectedColumns.add(elem.getText());
        }
        return listSelectedColumns;
    }


    public AssetInListView getAssetInListView(String assetName) {
        if (!web.isElementPresent(assetRowsLocator)) return null;
        List<WebElement> rows = web.findElements(assetRowsLocator);
        Common.sleep(4000);
        AssetInListView asset;
        for (WebElement row : rows) {
            asset = new AssetInListView(web, row);
            Common.sleep(4000);
            System.out.println("asset.getTitle()==>" + asset.getTitle());
            if (asset.getTitle().equalsIgnoreCase(assetName))
                return asset;
        }
        throw new NullPointerException("Asset Name " + assetName + " is absent");
    }


    public class AssetInListView {
        public String getTitle() {
            return title;
        }

        private String title;

        public String getOriginator() {
            return originator;
        }

        private String originator;

        public String getFileSize() {
            return fileSize;
        }

        private String fileSize;

        public String getFileType() {
            return fileType;
        }

        public AssetInListView(ExtendedWebDriver driver, WebElement row) {
            initFields(row);
        }

        private String fileType;

        private void initFields(WebElement row) {
            List<WebElement> cells = row.findElements(By.xpath("//*[@class=\"datatable-body-cell-label\"]/div"));
            List<String> list = getColumnTitlesNames(By.cssSelector("[class=\"datatable-header-cell-label draggable\"]"));
            web.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
            for (int i = 1; i < list.size(); i++) {
                String cellValue = "";
                cellValue = cells.get(i + 1).getText();
                switch (list.get(i)) {
                    case "File Size":
                        fileSize = cellValue;
                        break;
                    case "File Type":
                        fileType = cellValue;
                        break;
                    case "Originator":
                        originator = cellValue;
                        break;
                    case "Title":
                        title = cellValue;
                        break;
                }

            }
        }
    }


    public List getColumnTitlesNames(By locator) {
        List<WebElement> list = web.findElements(locator);
        List<String> columnTitles = new ArrayList<String>();
        if (list == null || list.size() == 0) return columnTitles;
        for (WebElement webElement : list) {
            columnTitles.add(webElement.getText().trim());
        }
        return columnTitles;
    }


    public void clickSaveChangesInWarningWhileSavingFilter() {
        web.waitUntilElementAppear(warningForSavingParentFilterLocator);
        web.click(By.xpath("//ads-warning[contains(@info,\"This collection has sub-collections\")]//*[@click=\"$ctrl.accept()\"]//button"));
        web.waitUntilElementDisappear(warningForSavingParentFilterLocator);
    }


    public void clickCancelChangesInWarningWhileSavingFilter() {
        web.waitUntilElementAppear(warningForSavingParentFilterLocator);
        web.click(By.xpath("//ads-warning[contains(@info,\"This collection has sub-collections\")]//*[@click=\"$ctrl.cancel()\"]//button"));
        web.waitUntilElementDisappear(warningForSavingParentFilterLocator);
    }

    public boolean isSaveChangesButtonVisible() {
        return web.isElementVisible(saveChangesLocator);
    }

    public List<String> getMediaSelector_Labels() {
        if (web.isElementPresent(mediaFilterToggleLocator))
            web.click(mediaFilterToggleLocator);
        Common.sleep(1000);
        return web.findElementsToStrings(By.xpath("//span[contains(@class,\"mediaFilter-title\")]"));
    }

    public String getMarket_Label() {
        return web.findElement(By.cssSelector("[data-id=\"_cm.marketId\"] [ng-model=\"$ctrl.model\"] input[ng-model=\"$select.search\"]")).getAttribute("placeholder");
    }

    public String getCampaign_Label() {
        return web.findElement(By.cssSelector("[data-id=\"_cm.common.Campaign\"] [ng-model=\"$ctrl.model\"]")).getAttribute("placeholder");
    }

    public String getAdvertiser_Label() {
        return web.findElement(By.cssSelector("[data-id=\"_cm.common.advertiser\"] [ng-model=\"$select.search\"]")).getAttribute("placeholder");
    }

    public String getOriginator_Label() {
        return web.findElement(By.cssSelector("[data-id=\"originator._id\"] [ng-model=\"$select.search\"]")).getAttribute("placeholder");
    }

   /* public void fillComboboxField(String name, String value) {
        WebElement elem=web.findElement(By.xpath(String.format(assetMetadataFormat,name)));
        web.scrollToElement(elem);
        elem.clear();
        elem.sendKeys(value);
        if(!value.isEmpty()){
            web.waitUntilElementAppear(By.xpath("//ul[@class='md-autocomplete-suggestions']/li/md-autocomplete-parent-scope//span[.='" + value + "']"));
            web.findElement(By.xpath("//ul[@class='md-autocomplete-suggestions']/li/md-autocomplete-parent-scope//span[.='"+value+"']")).click();
        }}*/

    public void selectAdditionalField(String value, String field) {
        String format = "input[placeholder=\"%s\"]";
        Common.sleep(3000);
        if(!value.isEmpty()) {
        web.typeClean(By.cssSelector("input[placeholder=\"Add more fields...\"]"), field + Keys.ENTER);
        web.click(By.xpath(String.format("//*[@class=\"option ui-select-choices-row-inner\"]//span[contains(text(),\"%s\")]", field)));
        web.typeClean(By.cssSelector(String.format(format, field)), value + Keys.ENTER);
        web.click(By.xpath(String.format("//*[@class=\"option ui-select-choices-row-inner\"]//span[contains(text(),\"%s\")]", value)));
        }

    }

    public void selectMediaSubType_1(String value) {
        Common.sleep(3000);
        web.typeClean(By.cssSelector("input[placeholder=\"Media sub-type\"]"), value + Keys.ENTER);
        web.click(By.xpath(String.format("//*[@class=\"option ui-select-choices-row-inner\"]//span[contains(text(),\"%s\")]", value)));
    }

    public List<String> checkMetaDataValueInDropDown(String filterName) {
        List<String> values=null;
       // web.findElement(By.xpath("//div[@class='mediaFilter'][@data-id='"+filterName+"']//span[contains(@ng-class,'isFiltersBlockHidden')]")).click();
        web.waitUntilElementAppear(By.xpath("//ads-ui-select-dictionary[@placeholder='Add more fields...']"));
        web.findElement(By.xpath("//ads-ui-select-dictionary[@placeholder='Add more fields...']//span[@code='chevron-fill-small-down']")).click();
         values = web.findElementsToStrings(By.xpath("//div[contains(@class,'ui-select-choices-row ng-scope')]//span"));
        return values;
    }


    public void switchOnFilters(String filterName)
    {
        web.waitUntilElementAppear(By.xpath("//ads-accordion[@description='Media filters']"));
        if(web.isElementVisible(By.xpath("//ads-accordion[@description='Media filters']//ads-md-button/button//span[@code='chevron-outline-down']")))
        {
            web.findElement(By.xpath("//ads-accordion[@description='Media filters']//ads-md-button/button//span[@code='chevron-outline-down']")).click();
        }
        Common.sleep(2000);
        web.findElement(By.xpath("//div[@class='mediaFilter']//span[.='"+filterName+"']")).click();

    }

    public void expandUsageRights()
    {
        web.waitUntilElementAppear(By.xpath("//ads-accordion[@description='Usage rights']"));
        web.findElement(By.xpath("//ads-accordion[@description='Usage rights']//ads-md-button/button")).click();
    }

    public String verifyToastMessage()
    {
      return web.findElement(By.xpath("//ads-md-toast//div[@data-role='toast-text']")).getText();


    }

}
