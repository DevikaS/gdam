package com.adstream.automate.babylon.sut.pages.ordering.elements.forms.popupForms;

import com.adstream.automate.babylon.sut.pages.admin.agency.AgencyPartnersPage;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.AbstractForm;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Edit;
import com.adstream.automate.page.controls.Link;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.Select;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*
 * Created by demidovskiy-r on 13.03.2015.
 */
public class BillingRuleForm extends AbstractForm {
    private WebElement billingRule;
    private Select partnerBU;
    private Button addRuleCriteriaBtn;
    private Link removeThisRule;
    private static final String PARTNER_BU = "Partner BU";
    private static final String RULES_CRITERIAS = "Rules Criterias";

    public BillingRuleForm(AgencyPartnersPage parent, WebElement billingRule) {
        super(parent);
        this.billingRule = billingRule;
        partnerBU = new Select(billingRule.findElement(By.cssSelector("[ng-model='rule.partner']")));
        addRuleCriteriaBtn = new Button(parent, billingRule.findElement(By.className("b-add-btn")));
        removeThisRule = new Link(parent, billingRule.findElement(By.cssSelector("[ng-click='onRemoveRule()']")));
    }

    @Override
    public void fill(Map<String, String> fields) {
        if (fields.containsKey(PARTNER_BU)) partnerBU.selectByVisibleText(fields.get(PARTNER_BU));
        if (fields.containsKey(RULES_CRITERIAS)) {
            final String[] rulesCriterias = fields.get(RULES_CRITERIAS).split(",");
            for (int i = 0; i < rulesCriterias.length; i++) {
                final String[] rulesCriteria = rulesCriterias[i].split("=");
                Map<String, String> rulesCriteriaMap = new HashMap<String, String>(){{ put(rulesCriteria[0], rulesCriteria[1]);}};
                List<BillingRuleItem> billingRuleItems = getBillingRuleItems();
                billingRuleItems.get(i).fill(rulesCriteriaMap);
                if (i != rulesCriterias.length - 1) clickAddRuleCriteriaBtn();
            }
        }
    }

    @Override
    public String getFieldValue(String fieldName) {
        if (fieldName.equals(PARTNER_BU)) return partnerBU.getFirstSelectedOption().getText().trim();
        if (fieldName.equals(RULES_CRITERIAS)) {
            List<BillingRuleItem> billingRuleItems = getBillingRuleItems();
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < billingRuleItems.size(); i++) {
                sb.append(billingRuleItems.get(i).getMetadataField()).append("=").append(billingRuleItems.get(i).getMetadataValue());
                if (i != billingRuleItems.size() - 1) sb.append(",");
            }
            return sb.toString();
        }
        throw new IllegalArgumentException("Unknown field name: " + fieldName);
    }

    @Override
    protected void initControls() {
    }

    @Override
    protected void loadForm() {
    }

    @Override
    protected void unloadForm() {
    }

    @Override
    protected String getRootNode() {
        return BillingRuleBuilderForm.ROOT_NODE;
    }

    public List<String> getAvailableMetadataFields() {
        return getBillingRuleItems().get(0).getAvailableMetadataFields();
    }

    public static class BillingRuleItem extends AbstractForm {
        private WebElement billingRuleItem;
        private Select metadataField;
        private Object metadataValue;
        private Button removeRuleCriteriaBtn;

        public BillingRuleItem(AgencyPartnersPage parent, WebElement billingRuleItem) {
            super(parent);
            this.billingRuleItem = billingRuleItem;
            metadataField = new Select(billingRuleItem.findElement(By.cssSelector("[ng-model='data.field']")));
            removeRuleCriteriaBtn = new Button(parent, billingRuleItem.findElement(By.cssSelector("[ng-click='onRemoveCriteria()']")));
        }

        @Override
        public void fill(Map<String, String> fields) {
            for (Map.Entry<String, String> entry: fields.entrySet()) {
                metadataField.selectByVisibleText(entry.getKey());
                initMetadataValueField();
                if (metadataValue instanceof Edit)
                    ((Edit) metadataValue).type(entry.getValue());
                else if (metadataValue instanceof Select)
                    ((Select) metadataValue).selectByVisibleText(entry.getValue());
                else
                    throw new IllegalArgumentException("Unknown Metadata value field: " + metadataValue.toString());
            }
        }

        public String getMetadataField() {
            return metadataField.getFirstSelectedOption().getText().trim();
        }

        public String getMetadataValue() {
            initMetadataValueField();
            if (metadataValue instanceof Edit)
                return ((Edit) metadataValue).getValue();
            else if (metadataValue instanceof Select)
                return ((Select) metadataValue).getFirstSelectedOption().getText().trim();
            else
                throw new IllegalArgumentException("Unknown Metadata value field: " + metadataValue.toString());
        }

        public List<String> getAvailableMetadataFields() {
            List<String> availableMetadataFields = new ArrayList<>();
            for (WebElement metadataOption: metadataField.getOptions())
                availableMetadataFields.add(metadataOption.getText().trim());
            return availableMetadataFields;
        }

        @Override
        protected void initControls() {
        }

        @Override
        protected void loadForm() {
        }

        @Override
        protected void unloadForm() {
        }

        @Override
        protected String getRootNode() {
            return BillingRuleBuilderForm.ROOT_NODE;
        }

        private void initMetadataValueField() {
            getDriver().waitUntilElementAppearVisible(getMetadataValueFieldLocator());
            WebElement metadataValueElement = billingRuleItem.findElement(getMetadataValueFieldLocator());
            if (metadataValueElement.getAttribute("class").contains("ui-input"))
                metadataValue = new Edit(parent, metadataValueElement);
            else if (metadataValueElement.getAttribute("class").contains("select2-offscreen"))
                metadataValue = new Select(metadataValueElement);
            else
                throw new NoSuchElementException("There are no any active Metadata value controls on the page!");
        }

        private void clickRemoveRuleCriteriaBtn() {
            removeRuleCriteriaBtn.click();
        }

        private By getMetadataValueFieldLocator() {
            return By.cssSelector("[ng-model='data.value']");
        }
    }

    private List<BillingRuleItem> getBillingRuleItems() {
        if (!getDriver().isElementVisible(getBillingRuleItemLocator()))
            throw new NoSuchElementException("There are no any Billing Rule Items on Billing Rule Builder form!");
        List<WebElement> elements = billingRule.findElements(getBillingRuleItemLocator());
        List<BillingRuleItem> billingRuleItems = new ArrayList<>();
        for (WebElement el: elements)
            billingRuleItems.add(new BillingRuleItem((AgencyPartnersPage)parent, el));
        return billingRuleItems;
    }

    private void clickAddRuleCriteriaBtn() {
        scrollDownBillingsrulepopup();
        addRuleCriteriaBtn.click();
    }

    public void scrollDownBillingsrulepopup() {
       //Alternate scroll code if needed
        //        WebElement element = getDriver().findElement(By.cssSelector(".inline-display.mtm"));
        //        getDriver().getJavascriptExecutor().executeScript("arguments[0].scrollIntoView(true);", element);
        //        Common.sleep(500);
        getDriver().scrollToElement(getDriver().findElement(By.xpath("//a[contains(.,'Remove this rule')]")));
        getDriver().sleep(2000);
    }

    private void clickRemoveThisRule() {
        removeThisRule.click();
    }

    private By getBillingRuleItemLocator() {
        return By.className("b-rules__criterias-item");
    }
}