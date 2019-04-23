package com.adstream.automate.babylon.sut.pages.NewLibrary.elements;

import com.adstream.automate.page.Page;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by devika on 16/04/2018.
 */
public class RestorePopUp extends LibPopUpWindow {


    public RestorePopUp(Page parentPage) {
        super(parentPage, "ads-ui-remove-restore");
        web.waitUntil(ExpectedConditions.presenceOfElementLocated(generateLocator()));

    }



    public void cancelPopup()
    {
        cancel.click();
    }

    public void clickAdd()
    {
        action.click();
    }




}
