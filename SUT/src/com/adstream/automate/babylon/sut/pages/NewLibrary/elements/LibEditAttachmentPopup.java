package com.adstream.automate.babylon.sut.pages.NewLibrary.elements;

import com.adstream.automate.page.Page;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;

/**
 * Created by Janaki.Kamat on 17/05/2018.
 */
public class LibEditAttachmentPopup extends LibPopUpWindow {
    private static final String savebuttonSelector = "ads-md-button[click=\"$ctrl.save()\"]";
    private static final String cancelbuttonSelector = "ads-md-button[click=\"$ctrl.cancel()\"]";
    private static final By fileNameInputSelector = By.cssSelector("input[placeholder=\"File name\"]");
    private static final By descriptionInputSelector = By.cssSelector("input[placeholder=\"Enter a description for the file\"]");
    public LibEditAttachmentPopup(Page parent) {
        super(parent, "attachment-edit-details");
        web.waitUntil(ExpectedConditions.presenceOfElementLocated(generateLocator()));
    }

    public LibEditAttachmentPopup enterFileName(String fileName) {
        WebElement elem=web.findElement(fileNameInputSelector);
        elem.clear();
        elem.sendKeys(fileName);
        return this;
    }


    public LibEditAttachmentPopup enterDescription(String description) {
        web.findElement(descriptionInputSelector).sendKeys(description);
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
