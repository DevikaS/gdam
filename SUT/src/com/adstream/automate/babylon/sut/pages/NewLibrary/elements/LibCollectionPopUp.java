package com.adstream.automate.babylon.sut.pages.NewLibrary.elements;

import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Edit;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.support.ui.ExpectedConditions;

import java.util.List;

/**
 * Created by Janaki.Kamat on 24/04/2017.
 */
public class LibCollectionPopUp extends LibPopUpWindow {
    private String title;
    public Edit collectionNameEdit = new Edit(parentPage, generateLocator("[model=\"$ctrl.collection._cm.common.name\"] input"));
    private final String collectionLocationSelector="md-select[placeholder=\"Collection location\"]";
    public LibCollectionPopUp(Page parentPage, String title) {
        super(parentPage,"collection-edit-details");
        web.waitUntil(ExpectedConditions.presenceOfElementLocated(generateLocator()));
        this.title=title;

    }

    public LibCollectionPopUp setCollectionName(String collectionName) {
        collectionNameEdit.type(collectionName);
        Common.sleep(3000);
        return this;
    }


    public LibCollectionPopUp typeCollectionName(String collectionName) {
        collectionNameEdit.type(collectionName);
        return this;
    }

    public LibCollectionPopUp selectCollectionLocation(String businessUnit){
        web.click(generateLocator(collectionLocationSelector + " [class=\"md-select-icon\"]"));
        Common.sleep(2000);
        web.findElement(By.xpath(String.format("//md-option[@ng-repeat=\"agency in $ctrl.allowedLocations\"]//*[contains(text(),'%s')]",businessUnit))).click();
        return this;
    }


    public void clickAction() {
        action.click();
        Common.sleep(1000);
    }

    public boolean verifyMessage(String message)
    {
        web.waitUntilElementAppear(By.xpath(String.format("//*[contains(.,'%s')]",message)));
        return web.isElementVisible(By.xpath(String.format("//*[contains(.,'%s')]", message)));
    }

    public void clickCancel() {
        cancel.click();
        Common.sleep(1000);
    }

    public List<String> getLocationValues(){
        web.click(generateLocator(collectionLocationSelector + " [class=\"md-select-icon\"]"));
        Common.sleep(2000);
        return web.findElementsToStrings(By.cssSelector("md-option[ng-repeat=\"agency in $ctrl.allowedLocations\"] div"));
   }

}
