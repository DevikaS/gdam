package com.adstream.automate.babylon.sut.pages.ordering.elements.forms.popupForms;

import com.adstream.automate.babylon.sut.pages.admin.agency.AgencyPartnersPage;
import com.adstream.automate.babylon.sut.pages.ordering.elements.popup.AbstractPopUpLayer;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Link;
import com.adstream.automate.page.controls.Span;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebElement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/*
 * Created by demidovskiy-r on 12.03.2015.
 */
public class BillingRuleBuilderForm extends AbstractPopUpLayer {
    public final static String ROOT_NODE = ".a5-modal-message";
    private Link addAnotherRule;

    public BillingRuleBuilderForm(AgencyPartnersPage parent) {
        super(parent);
        addAnotherRule = new Link(parent, generateFormElementLocator("[ng-click='onAddRule()']"));
        action = new Button(parent, generateFormElementLocator("[ng-click='$close()']"));
        close = new Span(parent, generateFormElementLocator(".a5-modal-close"));
        cancel = new Link(parent, generateFormElementLocator(".cancel"));
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

    public void fill(List<Map<String, String>> fieldsList) {
        for (int i = 0; i < fieldsList.size(); i++) {
            List<BillingRuleForm> billingRules = getBillingRules();
            billingRules.get(i).fill(fieldsList.get(i));
            if (i != fieldsList.size() - 1 && fieldsList.size() != billingRules.size()) clickAddAnotherRuleBtn();
        }
    }

    public void save() {
        clickOkBtn();
    }

    public List<BillingRuleForm> getBillingRules() {
        if (!getDriver().isElementVisible(getBillingRuleLocator()))
            throw new NoSuchElementException("There are no any Billing Rules on Billing Rule Builder form!");
        List<WebElement> elements = getDriver().findElements(getBillingRuleLocator());
        List<BillingRuleForm> billingRules = new ArrayList<>();
        for (WebElement el: elements)
            billingRules.add(new BillingRuleForm((AgencyPartnersPage)parent, el));
        return billingRules;
    }

    private void clickAddAnotherRuleBtn() {
        addAnotherRule.click();
    }

    private By getBillingRuleLocator() {
        return generateFormElementLocator(".b-rules-item");
    }

    private By getFormLocator() {
        return By.cssSelector(getRootNode());
    }
}