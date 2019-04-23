package com.adstream.automate.babylon.sut.pages.ordering.elements.forms;

import com.adstream.automate.babylon.sut.pages.ordering.OrderItemPage;
import com.adstream.automate.page.controls.DojoCombo;
import com.adstream.automate.page.controls.Edit;
import org.openqa.selenium.By;

/*
 * Created by demidovskiy-r on 19.03.2015.
 */
public class CommonInformationForm extends AddInformationForm {
    public static final String ROOT_NODE = ".commonInformationForm";
    private DojoCombo advertiser;
    private DojoCombo brand;
    private DojoCombo subBrand;
    private DojoCombo product;
    private Edit campaign;

    public CommonInformationForm(OrderItemPage parent) {
        super(parent);
    }

    @Override
    protected void initControls() {
        controls.put(SchemaField.ADVERTISER.toString(), advertiser = new DojoCombo(parent, generateComboBoxLocator(CM.ASSET_COMMON, SchemaField.ADVERTISER.getPathName().toString())));
        controls.put(SchemaField.BRAND.toString(), brand = new DojoCombo(parent, generateComboBoxLocator(CM.ASSET_COMMON, SchemaField.BRAND.getPathName().toString())));
        controls.put(SchemaField.SUB_BRAND.toString(), subBrand = new DojoCombo(parent, generateComboBoxLocator(CM.ASSET_COMMON, SchemaField.SUB_BRAND.getPathName().toString())));
        controls.put(SchemaField.PRODUCT.toString(), product = new DojoCombo(parent, generateComboBoxLocator(CM.ASSET_COMMON, SchemaField.PRODUCT.getPathName().toString())));
        controls.put(SchemaField.CAMPAIGN.toString(), campaign = new Edit(parent, generateTextFieldLocator(CM.ASSET_COMMON, SchemaField.CAMPAIGN.getPathName().toString())));
        controls.put(SchemaField.TITLE.toString(), title = new Edit(parent, generateTextFieldLocator(CM.COMMON, SchemaField.TITLE.getPathName().toString())));
        controls.put(SchemaField.MEDIA_AGENCY.toString(), mediaAgency = new DojoCombo(parent, generateComboBoxLocator(CM.COMMON, SchemaField.MEDIA_AGENCY.getPathName().toString())));
        controls.put(SchemaField.POST_HOUSE.toString(), postHouse = new DojoCombo(parent, generateComboBoxLocator(CM.COMMON, SchemaField.POST_HOUSE.getPathName().toString())));
        controls.put(SchemaField.CREATIVE_AGENCY.toString(), creativeAgency = new DojoCombo(parent, generateComboBoxLocator(CM.COMMON, SchemaField.CREATIVE_AGENCY.getPathName().toString())));
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

    private By getFormLocator() {
        return By.cssSelector(getRootNode());
    }
}