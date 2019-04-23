package com.adstream.automate.babylon.sut.pages.ordering.elements.forms;

import com.adstream.automate.babylon.sut.pages.ordering.OrderItemPage;
import com.adstream.automate.page.controls.*;
import org.openqa.selenium.By;

/*
 * Created by demidovskiy-r on 26.12.13.
 */

public class AddUsageRightForm extends AbstractForm {
    public static final String ROOT_NODE = "[data-dojo-type='adbank.usageRights.add_usage_rights_form']";
    private DojoTextBox startDate;
    private DojoTextBox expireDate;
    private Checkbox useAirDate;
    private Checkbox notifyIfExpired;
    private Edit notifyDays;
    private Checkbox includeTeam;
    private DojoAutoSuggest country;
    private Button saveBtn;
    private Button cancelBtn;

    public AddUsageRightForm(OrderItemPage parent) {
        super(parent);
        saveBtn = new Button(parent, generateFormElementLocator("[name='Save']"));
        cancelBtn = new Button(parent, generateFormElementLocator(".cancel"));
    }

    @Override
    protected void initControls() {
        //General
        controls.put("Start Date", startDate = new DojoTextBox(parent, getDateFieldLocator(".size5of6")));
        controls.put("Expire Date", expireDate = new DojoTextBox(parent, getDateFieldLocator("[data-role='expire-date']")));
        controls.put("Use Air Date", useAirDate = new Checkbox(parent, By.name("useAirDate")));
        controls.put("Notify If Expired", notifyIfExpired = new Checkbox(parent, By.name("notifyIfExpired")));
        controls.put("Notify Days", notifyDays = new Edit(parent, By.name("notifyDays")));
        controls.put("Include Team", includeTeam = new Checkbox(parent, By.name("includeTeam")));
        // Countries
        controls.put("Country", country = new DojoAutoSuggest(parent, By.name("usageCountry")));
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

    public void save(){
        saveBtn.click();
        getDriver().waitUntilElementDisappear(getFormLocator());
    }

    public void cancel() {
        cancelBtn.click();
        getDriver().waitUntilElementDisappear(getFormLocator());
    }

    private By getDateFieldLocator(String partialLocator) {
        return By.cssSelector(getRootNode() + " " + partialLocator + " .dijitDateTextBox");
    }

    private By getFormLocator() {
        return By.cssSelector(getRootNode());
    }
}