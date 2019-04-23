package com.adstream.automate.babylon.sut.pages.ordering.elements.forms.subForms;

import com.adstream.automate.babylon.sut.pages.ordering.OrderSummaryPage;
import com.adstream.automate.babylon.sut.pages.ordering.OrderingPage;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.AbstractForm;
import com.adstream.automate.page.controls.Checkbox;
import com.adstream.automate.page.controls.Link;
import org.openqa.selenium.By;


public class TableFilterOrderSummaryPageSettings extends AbstractForm {
    public final static String ROOT_NODE = "[data-dojo-type='common.table.tableControlDropdown']";
    private Checkbox clock;
    private Checkbox advertiser;
    private Checkbox brand;
    private Checkbox subBrand;
    private Checkbox product;
    private Checkbox subtitlesRequired;
    private Checkbox title;
    private Checkbox firstAirDate;
    private Checkbox format;
    private Checkbox duration;
    private Checkbox status;
    private Checkbox approve;
    private Link restoreToDefault;

    public TableFilterOrderSummaryPageSettings(OrderSummaryPage parent) {
        super(parent);
    }

    @Override
    protected void initControls() {
        controls.put("Clock #", clock = new Checkbox(parent, generateControlLocator("column-0")));
        controls.put("Advertiser", advertiser = new Checkbox(parent, generateControlLocator("column-1")));
        controls.put("Brand", brand = new Checkbox(parent, generateControlLocator("column-2")));
        controls.put("Sub Brand", subBrand = new Checkbox(parent, generateControlLocator("column-3")));
        controls.put("Product", product = new Checkbox(parent, generateControlLocator("column-4")));
        controls.put("Subtitles Required", subtitlesRequired = new Checkbox(parent, generateControlLocator("column-5")));
        controls.put("Title", title = new Checkbox(parent, generateControlLocator("column-6")));
        controls.put("First Air Date", firstAirDate = new Checkbox(parent, generateControlLocator("column-7")));
        controls.put("Format", format = new Checkbox(parent, generateControlLocator("column-8")));
        controls.put("Duration", duration = new Checkbox(parent, generateControlLocator("column-9")));
        controls.put("Status", status = new Checkbox(parent, generateControlLocator("column-10")));
        controls.put("Approve", approve = new Checkbox(parent, generateControlLocator("column-11")));
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