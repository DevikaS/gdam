package com.adstream.automate.babylon.sut.pages.NewLibrary.elements;

import com.adstream.automate.page.Page;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;

/**
 * Created by Janaki.Kamat on 19/09/2017.
 */
public class LibAddToCollectionPopup extends LibPopUpWindow {

    private String inputFormat = "//ads-md-multiselect[@placeholder='Search for a collection']//input";
    private String multiSelectFormat="//*[@class=\"ui-select-choices-group\"]//li[@ng-repeat=\"option in $select.items\"]";

    public LibAddToCollectionPopup(Page parent){
        super(parent,"copy-assets-to-collection");
        Common.sleep(1000);
        web.waitUntil(ExpectedConditions.presenceOfElementLocated(generateLocator()));
    }

    public void enterCollectionToCopy(String value) {
        web.typeClean(generateXpathLocator(inputFormat),value);
        Common.sleep(2000);
        for (WebElement element : web.findElements(By.xpath(multiSelectFormat))) {
                if (element.getText().contains(value)) {
                    element.click();
                    break;
                }
            }
        }


    public void clickAddhere(){
        action.click();
        web.waitUntil(ExpectedConditions.invisibilityOfElementLocated(generateLocator()));
    }

    public boolean checkCategoryAvailable(String categoryName){
        openAllParentCollections();
        Common.sleep(1000);
        return !web.isElementPresent(By.xpath(String.format("//*[@class=\"tree-item-title disable link\"]/span[contains(text(),\"%s\")]",categoryName))) && web.isElementPresent(By.xpath(String.format("//*[@class=\"tree-item-title link\"]/span[contains(text(),\"%s\")]",categoryName)));
    }

    private void openAllParentCollections()
    {
        for(WebElement elems:web.findElements(By.cssSelector("[code=\"chevron-fill-down\"]")))
            elems.click();
    }
}
