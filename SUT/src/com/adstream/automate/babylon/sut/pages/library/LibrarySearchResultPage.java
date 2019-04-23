package com.adstream.automate.babylon.sut.pages.library;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.DojoDropDown;
import com.adstream.automate.page.controls.DojoSelect;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 05.02.13
 * Time: 14:50

 */
public class LibrarySearchResultPage extends BaseLibraryPage {
    public DojoSelect itemPerPage;

    public LibrarySearchResultPage(ExtendedWebDriver web) {
        super(web);
        this.itemPerPage = new DojoSelect(this, By.cssSelector(".itemPerPage.lib-select.dijitSelect"));
    }

    public String getItemsPerPageSelectedValues() {
        return itemPerPage.getSelectedLabel().trim();
    }

    public List<String> getItemsPerPageValues() {
        return itemPerPage.getLabels();
    }

    public List<String> getAvailableMetadataFilters() {
        List<String> result = new ArrayList<>();
        for (String item : new DojoDropDown(this, By.cssSelector(".advancedSearchChooser [data-role='filterKey']")).getValues()) {
            result.add(item.trim());
        }
        return result;
    }

    public boolean isAnyCollectionSelected() {
        return web.isElementPresent(By.cssSelector("li.current")) && web.isElementVisible(By.cssSelector("li.current"));
    }

    public void setItemPerPage(String value) {
        if (!itemPerPage.getSelectedLabel().equals(value)) {
            WebElement assetsField = web.findElement(By.cssSelector(".files-field"));
            itemPerPage.selectByValue(value);
            web.waitUntilElementChanged(assetsField); //wait while field redraws
        }
    }

    public List<String> getUploadedElementsText() {
        web.waitUntilElementAppearVisible(getUploadedElementsByCssSelector());
        if (!web.isElementPresent(getUploadedElementsByCssSelector())) return new ArrayList<>();
        return web.findElementsToStrings(getUploadedElementsByCssSelector());
    }

    private By getUploadedElementsByCssSelector() {
        return By.cssSelector(".file-info a");
    }
}
