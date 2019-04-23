package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.DojoCombo;
import com.adstream.automate.page.controls.Edit;
import org.openqa.selenium.By;

import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: sobolev-a
 * Date: 06.12.13
 * Time: 11:50
 */
public class AddToCollectionPopUp extends PopUpWindow {

    public Edit collectionNameEdit = new Edit(parentPage, generateLocator("[role='textbox']"));

    public AddToCollectionPopUp(Page parentPage) {
        super(parentPage);
    }

    public List<String> getCollectionNames() {
        By locator = By.xpath("//*[contains(@id,'Autocomplete')][@role='option'][not(.//*[@class='bold'])]//*[contains(@class,'HighlightMatch')]");
        return web.isElementPresent(locator) ? web.findElementsToStrings(locator) : new ArrayList<String>();
    }

    public PopUpWindow setCollectionName(String collectionName) {
        collectionNameEdit.typeWithInterval(collectionName, 100);
        web.sleep(2000);
        web.click(By.xpath(String.format("//*[contains(@id,'Autocomplete')][@role='option'][contains(.,'%s')][last()]", collectionName)));
        return this;
    }

    public void typeCollectionName(String collectionName) {
        collectionNameEdit.typeWithInterval(collectionName, 100);
    }
}