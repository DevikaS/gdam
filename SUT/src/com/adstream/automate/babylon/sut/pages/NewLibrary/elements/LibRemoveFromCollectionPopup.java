package com.adstream.automate.babylon.sut.pages.NewLibrary.elements;

import com.adstream.automate.page.Page;
import org.openqa.selenium.By;
import org.openqa.selenium.support.ui.ExpectedConditions;

/**
 * Created by Janaki.Kamat on 19/09/2017.
 */
public class LibRemoveFromCollectionPopup extends LibPopUpWindow {
    public LibRemoveFromCollectionPopup(Page parent) {
        super(parent, "ads-ui-remove-restore[dialog-title=\"Remove from Collection\"]");
        web.waitUntil(ExpectedConditions.presenceOfElementLocated(generateLocator()));
    }

    public void clickRemoveButton() {
        web.findElement(generateLocator("ads-md-button[click=\"$ctrl.confirm()\"] button")).click();
        web.waitUntil(ExpectedConditions.invisibilityOfElementLocated(generateLocator()));
    }

    public boolean clickRemoveButton_Message(String message) {
        web.findElement(generateLocator("ads-md-button[click=\"$ctrl.confirm()\"] button")).click();
        return web.isElementPresent(By.xpath("//*[contains(.,'" + message + "')]"));

    }

    public void clickCancelButton() {
        web.findElement(generateLocator("ads-md-button[click=\"$ctrl.cancel()\"] button")).click();
        web.waitUntil(ExpectedConditions.invisibilityOfElementLocated(generateLocator()));
    }
}