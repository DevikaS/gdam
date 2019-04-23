package com.adstream.automate.babylon.sut.pages.NewLibrary.elements;

import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Span;
import org.openqa.selenium.By;
import org.openqa.selenium.support.ui.ExpectedConditions;

/**
 * Created by Janaki.Kamat on 29/06/2017.
 */
public class LibraryWalkMePopup extends LibPopUpWindow {
   public LibraryWalkMePopup(Page parentPage) {
        super(parentPage,"[id^='wm-shoutout']");
        this.close = new Span(parentPage, generateLocator("[class^=\"wm-close-button\"]"));
    }

    public boolean isPopupVisible(){
        return web.isElementVisible(generateLocator());
    }

    public void clickClose(){
        if(isPopupVisible())
            this.close.click();
    }

}