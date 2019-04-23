package com.adstream.automate.babylon.sut.pages.NewLibrary.elements;

import com.adstream.automate.page.Page;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;


public class LibRemoveAttachmentPopup extends LibPopUpWindow {
        public LibRemoveAttachmentPopup(Page parent) {
        super(parent, "ads-ui-remove-restore");
        web.waitUntil(ExpectedConditions.presenceOfElementLocated(generateLocator()));
    }

    public void clickRemove()
    {
        web.findElement(By.xpath("//ads-md-button[@click='$ctrl.confirm()']")).click();
    }
}
