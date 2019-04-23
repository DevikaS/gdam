package com.adstream.automate.babylon.sut.pages.NewLibrary.elements;

import com.adstream.automate.page.Page;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;

/**
 * Created by Janaki.Kamat on 21/05/2018.
 */
public class LibEditCollectionPopup extends LibPopUpWindow {
    private static final String savebuttonSelector = "ads-md-button[click=\"$ctrl.save()\"] button";
    private static final String cancelbuttonSelector = "ads-md-button[click=\"$ctrl.cancel()\"] button";
    private static final String collectionNameSelector = "ads-md-input[placeholder=\"Collection name\"] input";

    public LibEditCollectionPopup(Page parent) {
        super(parent, "collection-edit-details[dialog-title^=\"Edit details\"]");
        web.waitUntil(ExpectedConditions.presenceOfElementLocated(generateLocator()));
    }


    public LibEditCollectionPopup enterCollectionName(String collection){
        WebElement input=web.findElement(By.cssSelector(collectionNameSelector));
        input.clear();
        input.sendKeys(collection);
        Common.sleep(1000);
        return this;
    }
    public void clickSave() {
        web.findElement(generateLocator(savebuttonSelector)).click();
        web.waitUntil(ExpectedConditions.invisibilityOfElementLocated(generateLocator()));

    }

    public void clickCancel() {
        web.findElement(generateLocator(cancelbuttonSelector)).click();
        web.waitUntil(ExpectedConditions.invisibilityOfElementLocated(generateLocator()));
    }
}
