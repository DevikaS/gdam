package com.adstream.automate.babylon.sut.pages.ordering.elements.forms.popupForms;

import com.adstream.automate.babylon.sut.pages.admin.people.UserDeliveryPage;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.AbstractForm;
import com.adstream.automate.babylon.sut.pages.ordering.elements.popup.AbstractPopUpLayer;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.DojoSelect;
import com.adstream.automate.page.controls.Link;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/*
 * Created by demidovskiy-r on 09.12.2014.
 */
public class DeliveryAccessRuleBuilderForm extends AbstractPopUpLayer {
    public final static String ROOT_NODE = POPUP_ROOT_NODE + " [data-dojo-type='admin.people.deliveryPopupAccessRulesForm']";
    private Button addAnotherRuleBtn;

    public DeliveryAccessRuleBuilderForm(UserDeliveryPage parent) {
        super(parent);
        addAnotherRuleBtn = new Button(parent, generateFormElementLocator("[data-role='addRule']"));
        action = new Button(parent, generatePopUpElementLocator("+ * .button[name='save']"));
        cancel = new Link(parent, generatePopUpElementLocator("+ * [name='cancel']"));
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
            List<DeliveryAccessRule> deliveryAccessRules = getDeliveryAccessRules();
            deliveryAccessRules.get(i).fill(fieldsList.get(i));
            if (i != fieldsList.size() - 1 && fieldsList.size() != deliveryAccessRules.size()) clickAddAnotherRuleBtn();
        }
    }

    public void save() {
        clickOkBtn();
    }

    public List<String> getAvailableMetadataFields() {
        return getDeliveryAccessRules().get(0).getAvailableMetadataFields();
    }

    public static class DeliveryAccessRule extends AbstractForm {
        private WebElement deliveryAccessRule;
        private DojoSelect metadataField;
        private DojoSelect condition;
        private DojoSelect metadataValue;
        private Button removeRuleBtn;

        public DeliveryAccessRule(UserDeliveryPage parent, WebElement deliveryAccessRule) {
            super(parent);
            this.deliveryAccessRule = deliveryAccessRule;
            removeRuleBtn = new Button(parent, deliveryAccessRule.findElement(generateElementLocatorByDataRole("removeRule")));
        }

        @Override
        protected void initControls() {
            controls.put("Metadata Field", metadataField = new DojoSelect(parent, deliveryAccessRule.findElement(generateElementLocatorByDataRole("metadataField"))));
            controls.put("Condition", condition = new DojoSelect(parent, deliveryAccessRule.findElement(generateElementLocatorByDataRole("condition"))));
            controls.put("Metadata Value", metadataValue = new DojoSelect(parent, deliveryAccessRule.findElement(generateElementLocatorByDataRole("value"))));
        }

        @Override
        protected void loadForm() {
        }

        @Override
        protected void unloadForm() {
        }

        @Override
        protected String getRootNode() {
            return ROOT_NODE;
        }

        public List<String> getAvailableMetadataFields() {
            getControls();
            return metadataField.getLabels();
        }

        public void removeAccessRule() {
            int accessRulesCount = getDriver().findElements(getDeliveryAccessRuleRowLocator()).size();
            clickRemoveRuleBtn();
            waitUntilAccessRuleWillBeRemoved(accessRulesCount);
        }

        private void waitUntilAccessRuleWillBeRemoved(final int accessRulesCount) {
            getDriver().waitUntil(new ExpectedCondition<Boolean>() {
                public Boolean apply(WebDriver webDriver) {
                    return webDriver.findElements(getDeliveryAccessRuleRowLocator()).size() == (accessRulesCount - 1);
                }
            });
        }

        private void clickRemoveRuleBtn() {
            removeRuleBtn.click();
        }

        private By generateElementLocatorByDataRole(String partialLocator) {
            return By.cssSelector("[data-role='" + partialLocator + "']");
        }
    }

    public DeliveryAccessRule getDeliveryAccessRule(String metadataField) {
        for (DeliveryAccessRule deliveryAccessRule: getDeliveryAccessRules())
            if (deliveryAccessRule.getFieldValue("Metadata Field").equals(metadataField))
                return deliveryAccessRule;
        return null;
    }

    private List<DeliveryAccessRule> getDeliveryAccessRules() {
        if (!getDriver().isElementVisible(getDeliveryAccessRuleRowLocator()))
            throw new NoSuchElementException("There are no any Delivery Access Rules on Delivery Access Rule Builder form!");
        List<WebElement> rows = getDriver().findElements(getDeliveryAccessRuleRowLocator());
        List<DeliveryAccessRule> deliveryAccessRules = new ArrayList<>();
        for (WebElement row: rows)
            deliveryAccessRules.add(new DeliveryAccessRule((UserDeliveryPage)parent, row));
        return deliveryAccessRules;
    }

    private void clickAddAnotherRuleBtn() {
        addAnotherRuleBtn.click();
    }

    private static By getDeliveryAccessRuleRowLocator() {
        return By.cssSelector(String.format("%s %s", ROOT_NODE, ".delivery-access-rule-row"));
    }

    private By getFormLocator() {
        return By.cssSelector(getRootNode());
    }
}