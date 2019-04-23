package com.adstream.automate.babylon.sut.pages.library.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import org.openqa.selenium.By;

import java.util.ArrayList;
import java.util.List;

/**
 * User: lynda-k
 * Date: 24.12.13
 * Time: 12:00
 */
public class RemoveAssetsConfirmationPopup extends PopUpWindow {

    public RemoveAssetsConfirmationPopup(Page<? extends Page> parentPage) {
        super(parentPage);
    }

    public List<String> getAssetNames(){
        By locator = generateLocator("ol li");
        return web.isElementPresent(locator) ? web.findElementsToStrings(locator) : new ArrayList<String>();
    }
}
