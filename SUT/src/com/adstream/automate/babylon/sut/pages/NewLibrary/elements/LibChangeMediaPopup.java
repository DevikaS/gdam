package com.adstream.automate.babylon.sut.pages.NewLibrary.elements;
import com.adstream.automate.page.Page;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;

import java.util.List;

/**
 * Created by Janaki.Kamat on 08/05/2017.
 */
public class LibChangeMediaPopup extends LibPopUpWindow {
    public LibChangeMediaPopup(Page parent){
        super(parent,"ads-ui-change-media-type");
        Common.sleep(1000);
        web.waitUntilElementAppear(generateLocator());
    }

    public void clickSave(){
        action.click();
        web.waitUntil(ExpectedConditions.invisibilityOfElementLocated(generateLocator()));
    }

    public void changeMediaType(String mediaType) {
       web.findElement(generateLocator("ads-md-select[model=\"$ctrl.selectedMediaType\"] [class=\"md-select-icon\"]")).click();
       web.findElement(By.xpath(String.format("//*[@ng-repeat=\"val in $ctrl.mediaTypes\"]//*[@class=\"md-text ng-binding\"][contains(normalize-space(text()),'%s')]",mediaType))).click();
    }

    public String getchangeMedia_Label(){
        return web.findElement(By.xpath("//ads-md-select[@on-change=\"$ctrl.onSelectChange()\"]//preceding-sibling::span[@class=\"ng-scope\"]")).getText();
    }

    public String getSaveButton_Label(){
        return web.findElement(By.cssSelector("ads-md-button[data-role=\"change-media-type-save\"] button [class=\"ng-scope\"]")).getText();
    }

    public String getChangeMedia_Title(){
        return web.findElement(By.cssSelector("span[translate=\"CHANGE_MEDIATYPE\"]")).getText();
    }

    public String getCancel_Title(){
        return web.findElement(By.cssSelector("ads-md-button[click=\"$ctrl.cancel()\"] button")).getText();
    }

    public String getChangeMedia_Verify(){
        return web.findElement(By.cssSelector("div[class=\"content-title\"] .ng-scope")).getText();
    }


}

