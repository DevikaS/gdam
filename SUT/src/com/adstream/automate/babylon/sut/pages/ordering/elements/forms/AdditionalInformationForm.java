package com.adstream.automate.babylon.sut.pages.ordering.elements.forms;

import com.adstream.automate.babylon.sut.pages.ordering.OrderItemPage;
import com.adstream.automate.page.controls.Button;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;

/*
 * Created by sobolev-a on 12.02.14.
 */
public class AdditionalInformationForm extends AbstractCustomFieldsForm {
    public static String ROOT_NODE = "[data-dojo-type='ordering.form.availableFields.Form']";

    public AdditionalInformationForm(OrderItemPage parent) {
        super(parent);
        autoCodeBtn = new Button(parent, generateElementLocatorByDataRole("adCodeAutoButton"));
    }

    @Override
    protected void initControls() {
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

    public void generateAutoCode(final String fieldName) {
        clickAutoCodeBtn();
        getDriver().waitUntil(new ExpectedCondition<Boolean>() {
            public Boolean apply(WebDriver webDriver) {
                return !getFieldValueByName(fieldName).isEmpty();
            }
        });
    }

    private By getFormLocator() {
        return By.cssSelector(getRootNode());
    }
}