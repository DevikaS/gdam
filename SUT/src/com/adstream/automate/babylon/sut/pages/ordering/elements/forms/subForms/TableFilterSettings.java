package com.adstream.automate.babylon.sut.pages.ordering.elements.forms.subForms;

import com.adstream.automate.babylon.sut.pages.ordering.OrderingPage;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.AbstractForm;
import com.adstream.automate.page.controls.Checkbox;
import com.adstream.automate.page.controls.Link;
import org.openqa.selenium.By;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 06.09.13
 * Time: 18:56
 */
public class TableFilterSettings extends AbstractForm {
    public final static String ROOT_NODE = "[data-dojo-type='common.table.tableControlDropdown']";
    private Checkbox order;
    private Checkbox dateTime;
    private Checkbox advertiser;
    private Checkbox brand;
    private Checkbox subBrand;
    private Checkbox product;
    private Checkbox market;
    private Checkbox no_Clocks;
    private Checkbox owner;
    private Link restoreToDefault;

    public TableFilterSettings(OrderingPage parent) {
        super(parent);
    }

    @Override
    protected void initControls() {
        controls.put("Order #", order = new Checkbox(parent, generateControlLocator("column-0")));
        controls.put("Date & Time", dateTime = new Checkbox(parent, generateControlLocator("column-1")));
        controls.put("Advertiser", advertiser = new Checkbox(parent, generateControlLocator("column-2")));
        controls.put("Brand", brand = new Checkbox(parent, generateControlLocator("column-3")));
        controls.put("Sub Brand", subBrand = new Checkbox(parent, generateControlLocator("column-4")));
        controls.put("Product", product = new Checkbox(parent, generateControlLocator("column-5")));
        controls.put("Market", market = new Checkbox(parent, generateControlLocator("column-6")));
        controls.put("No Clocks", no_Clocks = new Checkbox(parent, generateControlLocator("column-7")));
        controls.put("Creator", owner = new Checkbox(parent, generateControlLocator("column-8")));
        controls.put("Owner", owner = new Checkbox(parent, generateControlLocator("column-9")));
    }

    @Override
    protected void loadForm() {
        getDriver().waitUntilElementAppearVisible(getFormLocator());
    }

    @Override
    protected void unloadForm() {
        getDriver().waitUntilElementDisappear(getFormLocator());
    }

    @Override
    protected String getRootNode() {
        return ROOT_NODE;
    }

    public void restoreToDefault() {
        if (restoreToDefault == null) restoreToDefault = new Link(parent, By.cssSelector("[data-type='restoreDefault'] a"));
        restoreToDefault.click();
    }

    private By getFormLocator() {
        return By.cssSelector(getRootNode());
    }

    private By generateControlLocator(String partialLocator) {
        return By.cssSelector("[data-column-id='" + partialLocator +"'] [type='checkbox']");
    }
}