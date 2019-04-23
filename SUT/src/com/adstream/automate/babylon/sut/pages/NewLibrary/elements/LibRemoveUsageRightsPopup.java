
package com.adstream.automate.babylon.sut.pages.NewLibrary.elements;
import com.adstream.automate.page.Page;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.support.ui.ExpectedConditions;

/**
 * Created by Janaki.Kamat on 30/10/2018.
 */
public class LibRemoveUsageRightsPopup  extends LibPopUpWindow {
    private static final String RemoveSelector = "ads-md-button[click=\"$ctrl.accept()\"] button";
    private static final String cancelSelector = "ads-md-button[click=\"$ctrl.cancel()\"] button";


    public LibRemoveUsageRightsPopup(Page parent) {
        super(parent, "ads-warning[dialog-title=\"Remove usage rights\"]");
        web.waitUntil(ExpectedConditions.presenceOfElementLocated(generateLocator()));
    }

    public void clickRemove(){
        web.getJavascriptExecutor().executeScript("arguments[0].click();",web.findElement(generateLocator(RemoveSelector)));
        Common.sleep(1000);
        web.waitUntilElementDisappear(generateLocator());
    }

    public void clickCancel(){
        web.click(generateLocator(cancelSelector));
    }
}
