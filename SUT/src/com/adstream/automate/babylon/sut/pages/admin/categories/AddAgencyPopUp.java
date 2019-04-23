package com.adstream.automate.babylon.sut.pages.admin.categories;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Edit;
import org.openqa.selenium.By;
import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 01.02.13
 * Time: 8:01

 */
public class AddAgencyPopUp extends PopUpWindow {
    public Edit agencyName;

    public AddAgencyPopUp(Page parentPage) {
        super(parentPage);
        agencyName = new Edit(parentPage, generateLocator("[role='textbox']"));
    }

    public void setAgencyName(String text) {
        agencyName.type(text);
        web.sleep(1000);
    }

    public void selectAgency(String text) {
        setAgencyName(text);
        web.click(By.xpath(String.format("//*[@role='option'][normalize-space()='%s']", text)));
    }

    public List<String> getAgenciesDropdownList() {
        if (!web.isElementPresent(By.xpath("//span[@class='dijitComboBoxHighlightMatch']/parent::div"))) return new ArrayList<String>();
        return web.findElementsToStrings(By.xpath("//span[@class='dijitComboBoxHighlightMatch']/parent::div"));
    }

    public List<String> getSelectedAgenciesList() {
        if (!web.isElementPresent(By.className("as-selection-item"))) return new ArrayList<String>();
        return web.findElementsToStrings(By.className("as-selection-item"));
    }

    public void clickDeleteButton(int num) {
        web.findElement(By.xpath("//a[contains(text(),'×')][" + num+ "]")).click();
    }

    public void clickAddButton() {
        web.click(By.cssSelector(".button[name=\"Add\"]"));
    }
}