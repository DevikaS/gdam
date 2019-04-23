package com.adstream.automate.babylon.sut.pages.library.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

/**
 * Created by sobolev-a on 17.07.2014.
 */
public class LibraryRelatedAssetsPopUp extends PopUpWindow {

    public LibraryRelatedAssetsPopUp(Page parentPage) {
        super(parentPage);
    }

    public void typeRelatedFileName(String fileName) {
        web.typeClean(By.cssSelector("[ng-model=\"query\"]"), fileName);
    }


    public void selectFollowingRelatedAssets(String fileName) {
        WebElement element = web.findElement(By.xpath(String.format("//span[normalize-space(text())='%s']/ancestor::div[3]//input", fileName)));
        web.getJavascriptExecutor().executeScript("arguments[0].scrollIntoView(true);", element);
        Common.sleep(500);
        web.click(By.xpath(String.format("//span[normalize-space(text())='%s']/ancestor::div[3]//input", fileName)));
    }

    public void clickSaveButton() {
        web.click(By.cssSelector("[ng-click='save()']"));
    }


}
