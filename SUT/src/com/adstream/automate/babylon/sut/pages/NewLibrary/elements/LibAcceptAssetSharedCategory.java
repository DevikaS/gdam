package com.adstream.automate.babylon.sut.pages.NewLibrary.elements;

import com.adstream.automate.page.Page;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.support.ui.ExpectedConditions;

import java.util.List;

/**
 * Created by janaki.kamat on 12/06/2018.
 */
public class LibAcceptAssetSharedCategory extends LibPopUpWindow {

    public LibAcceptAssetSharedCategory(Page parent){
        super(parent,"accept-reject-inbox-assets");
        Common.sleep(1000);
        web.waitUntil(ExpectedConditions.presenceOfElementLocated(generateLocator()));
    }


    public void clickYes(){
        Common.sleep(1000);
        web.click(generateLocator("[click=\"$ctrl.confirm()\"]"));
        web.waitUntil(ExpectedConditions.invisibilityOfElementLocated(generateLocator()));
    }

    public void clickCancel(){
        Common.sleep(1000);
        web.click(generateLocator("[click=\"$ctrl.cancel()\"]"));
        web.waitUntil(ExpectedConditions.invisibilityOfElementLocated(generateLocator()));
    }

    public List<String> getAssets(){
        return web.findElementsToStrings(By.cssSelector("[ng-repeat=\"asset in ::$ctrl.assets\"]"));
    }
}
