package com.adstream.automate.babylon.sut.pages.admin.agency.agencySearch;

import com.adstream.automate.babylon.sut.pages.admin.agency.agencySearch.GlobalAdminSearchAgencyPage;
import com.adstream.automate.babylon.sut.pages.admin.agency.agencySearch.AgencyList;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.AbstractForm;
import com.adstream.automate.page.controls.*;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.Map;

/*
 * Created by Geethanjali.K on 20-01-2016-NGN16208
 */

public class SearchAgencyModelForm extends AbstractForm {
    private final static String ROOT_NODE = "[on-submit='businessUnitsListCtrl.doSearch()']";
    private Edit type;
    private Edit businessUnit;
    private DojoDropDownButton countryButton;
    private DojoCombo countryList;
    private Edit countrytb;
    private final String COUNTRY = "Country";
    private Button searchBtn;


    public SearchAgencyModelForm(GlobalAdminSearchAgencyPage parent) {
        super(parent);



        countryButton =  new DojoDropDownButton(parent, By.cssSelector(".select2-arrow>b"));
        countryList = new DojoCombo(parent,  By.className("select2-result-label"));
        countrytb = new Edit(parent, By.cssSelector(".select2-search"));
        searchBtn = new Button(parent, generateFormElementLocator(".mtm"));
    }

    @Override
    protected void initControls() {
        controls.put("Business_Unit name", businessUnit = new Edit(parent, generateFormElementLocatorByNgModel("businessUnitName")));
        controls.put("AgencyType", type = new Edit(parent, generateFormElementLocatorByNgModel("businessUnitType")));

    }

    @Override
    public void fill(Map<String, String> fields) {
        if (fields.containsKey(COUNTRY)) {
            countryButton.click();
            countrytb.sendKeys(fields.get(COUNTRY));
            countryList.click();
            fields.remove(COUNTRY); // because super fill method doesn't know anything about angular controls
        }

        super.fill(fields);
    }

    @Override
    public String getFieldValue(String fieldName) {

        return fieldName.equals(COUNTRY) ? countrytb.getText().trim() : super.getFieldValue(fieldName);
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

    public AgencyList search() {
        clickSearchBtn();
        waitUntilLoadSpinnerDisappears();
        return new AgencyList(getDriver());
    }


    private void clickSearchBtn() {
        searchBtn.click();
    }

    private By generateFormElementLocatorByNgModel(String partialLocator) {
        return generateFormElementLocator(String.format("[ng-model*='%s']", partialLocator));
    }


    private By getFormLocator() {
        return By.cssSelector(getRootNode());
    }

}