package com.adstream.automate.babylon.sut.pages.NewLibrary.elements;

import com.adstream.automate.page.Page;
import org.openqa.selenium.support.ui.ExpectedConditions;

/**
 * Created by Janaki.Kamat on 25/09/2017.
 */
public class LibDeleteAssetsAttachmentPopUp extends LibPopUpWindow {
    public LibDeleteAssetsAttachmentPopUp(Page parent) {
        super(parent, "ads-md-button[click=\"$ctrl.remove()\"] button");
        web.waitUntil(ExpectedConditions.presenceOfElementLocated(generateLocator()));
    }

    public void clickRemoveButton() {
        web.findElement(generateLocator()).click();
        web.waitUntil(ExpectedConditions.invisibilityOfElementLocated(generateLocator()));
    }
}
