package com.adstream.automate.babylon.sut.pages.NewLibrary.elements;

import com.adstream.automate.page.Page;
import org.openqa.selenium.support.ui.ExpectedConditions;

/**
 * Created by Janaki.Kamat on 23/04/2018.
 */
public class LibEditAssetClosePopup extends LibPopUpWindow {
    private static final String saveAndCloseSelector = "ads-md-button[click=\"$ctrl.locals.saveAndClose()\"] button";
    private static final String closeWithoutSavingSelector = "ads-md-button[click=\"$ctrl.locals.close()\"] button";
    private static final String cancelSelector = "ads-md-button[click=\"$ctrl.locals.cancel()\"] button";


    public LibEditAssetClosePopup(Page parent) {
        super(parent, "ads-prompt[dialog-title=\"Unsaved changes\"]");
        web.waitUntil(ExpectedConditions.presenceOfElementLocated(generateLocator()));
    }

    public void clickSave(){
        web.click(generateLocator(saveAndCloseSelector));
    }

    public void clickClose(){
        web.click(generateLocator(closeWithoutSavingSelector));
    }

    public void clickCancel(){
        web.click(generateLocator(cancelSelector));
    }
}
