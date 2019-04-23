package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.Page;
import org.openqa.selenium.By;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created by sobolev-a on 15.08.2014.
 */
public class AddColumnsProjectWindow {
    private ExtendedWebDriver web;

    public AddColumnsProjectWindow(Page parentPage) {
        web = parentPage.getDriver();
        assertTrue(web.isElementPresent(getColumnsWindowLocator()));
    }

    private By getColumnsWindowLocator() {
        return By.cssSelector("[data-dojo-type=\"common.table.tableControlDropdown\"]");
    }

    public void checkColumn(String name) {
        web.click(getColumnLocator(name));
    }

    public boolean isNotChecked(String name) {
        return web.findElement(getColumnLocator(name)).isSelected();
    }

    private By getColumnLocator(String name) {
        return By.xpath(String.format("//*[@data-role=\"dropContent\"]//*[contains(text(), '%s')]/../input[@type=\"checkbox\"]", name));
    }

}
