package com.adstream.automate.babylon.sut.pages.NewLibrary.elements;

/**
 * Created by Janaki.Kamat on 27/06/2018.
 */

import com.adstream.automate.page.Page;
import org.openqa.selenium.By;
import org.openqa.selenium.support.ui.ExpectedConditions;

public class LibRemoveCollectionPopup extends LibPopUpWindow {
    private static final String removebuttonSelector = "ads-md-button[click=\"$ctrl.accept()\"]";
    private static final String cancelbuttonSelector = "ads-md-button[click=\"$ctrl.cancel()\"]";

    public LibRemoveCollectionPopup(Page parent) {
        super(parent, "ads-warning[dialog-title^=\"Remove collection\"]");
        web.waitUntil(ExpectedConditions.presenceOfElementLocated(generateLocator()));
    }

    public void clickRemoveButton() {
        web.findElement(generateLocator(removebuttonSelector)).click();
        web.waitUntilElementAppear( By.xpath(".//*[contains(text(),\"Collection has been removed successfully\")]"));
        web.waitUntil(ExpectedConditions.invisibilityOfElementLocated(generateLocator()));

    }

    public void clickCancelButton() {
        web.findElement(generateLocator(cancelbuttonSelector)).click();
        web.waitUntil(ExpectedConditions.invisibilityOfElementLocated(generateLocator()));
    }

    public void clickAction() {
        web.findElement(By.xpath("//ads-warning[contains(@dialog-title,'Remove collection')]")).click();
        action.click();
        web.waitUntilElementAppear(By.xpath("//*[contains(.,'Collection has been removed successfully')]"));

    }
}
