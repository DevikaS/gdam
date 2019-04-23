package com.adstream.automate.babylon.sut.pages.NewLibrary.elements;

import com.adstream.automate.page.Page;
import org.openqa.selenium.By;
import org.openqa.selenium.support.ui.ExpectedConditions;

import java.util.List;

/**
 * Created by Janaki.Kamat on 08/05/2017.
 */
public class LibRemovePopup extends LibPopUpWindow {
    private static final String removebuttonSelector = "ads-md-button[click=\"$ctrl.confirm()\"]";
    private static final By fileListSelector = By.cssSelector("[ng-repeat=\"name in $ctrl.getSelectedNames()\"]");
    private static final By parentDialog = By.xpath("//md-content[contains(@class,'ads-md-dialog-content')]");


    public LibRemovePopup(Page parent) {
        super(parent, "ads-ui-remove-restore");
        web.waitUntil(ExpectedConditions.presenceOfElementLocated(generateLocator()));
    }

    public void clickRemoveFileButton() {
        web.findElement(generateLocator(removebuttonSelector)).click();
        web.waitUntil(ExpectedConditions.invisibilityOfElementLocated(generateLocator()));
    }

    public boolean isPopUpVisible()
    {
        return web.isElementVisible(parentDialog);
    }

     public List<String> getFileList() {
        return web.findElementsToStrings(fileListSelector);
    }
}
