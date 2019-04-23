package com.adstream.automate.babylon.sut.pages.admin.people.search;

import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.AbstractForm;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Edit;
import org.openqa.selenium.By;

import java.util.Map;

/*
 * Created by demidovskiy-r on 29.04.2015.
 */
public class SearchModelForm extends AbstractForm {
    private final static String ROOT_NODE = "[model='searchModel']";
    private Edit firstName;
    private Edit lastName;
    private Edit email;
    //private Select businessUnit;
    private Edit businessUnit;
    private final String BUSINESS_UNIT = "Business Unit";
    private Button clearChosenBUBtn;
    private Button searchBtn;


    public SearchModelForm(GlobalAdminSearchUsersPage parent) {
        super(parent);
        clearChosenBUBtn = new Button(parent, generateFormElementLocator(".select2-search-choice-close"));
        //businessUnit = new Select(getDriver().findElement(generateFormElementLocatorByNgModel("agency")));
        businessUnit = new Edit(parent,generateFormElementLocatorByNgModel("agency"));
        searchBtn = new Button(parent, generateFormElementLocator(".mtm"));
    }

    @Override
    protected void initControls() {
        controls.put("First Name", firstName = new Edit(parent, generateFormElementLocatorByNgModel("firstName")));
        controls.put("Last Name", lastName = new Edit(parent, generateFormElementLocatorByNgModel("lastName")));
        controls.put("Email", email = new Edit(parent, generateFormElementLocatorByNgModel("email")));
    }

    @Override
    public void fill(Map<String, String> fields) {
        if (fields.containsKey(BUSINESS_UNIT)) {
           //businessUnit.selectByVisibleText(fields.get(BUSINESS_UNIT));
            businessUnit.type(fields.get(BUSINESS_UNIT));
            fields.remove(BUSINESS_UNIT); // because super fill method doesn't know anything about angular controls
        }
        super.fill(fields);
    }

    @Override
    public String getFieldValue(String fieldName) {
      //return fieldName.equals(BUSINESS_UNIT) ? businessUnit.getFirstSelectedOption().getText().trim() : super.getFieldValue(fieldName);
        return fieldName.equals(BUSINESS_UNIT) ? businessUnit.getText().trim() : super.getFieldValue(fieldName);

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

    public void clearChosenBusinessUnit() {
        clickClearChosenBUBtn();
    }

    public UsersList search() {
        clickSearchBtn();
        return new UsersList(getDriver());
    }

    private void clickClearChosenBUBtn() {
        clearChosenBUBtn.click();
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