package com.adstream.automate.babylon.sut.pages.ordering.elements.lists;

import com.adstream.automate.babylon.sut.pages.ordering.PageElement;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;
import java.util.ArrayList;
import java.util.List;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/*
 * Created by demidovskiy-r on 08.12.2014.
 */
public class DeliveryAccessRulesList extends AbstractList {
    private final static String ROOT_NODE = "[data-role='rulesList']";

    public DeliveryAccessRulesList(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        web.waitUntilElementAppearVisible(getListLocator());
    }

    @Override
    public void isLoaded() throws Error {
        assertTrue(web.isElementVisible(getListLocator()));
    }

    @Override
    protected String getRootNode() {
        return ROOT_NODE;
    }

    public static class DeliveryAccessRule extends PageElement<DeliveryAccessRulesList> {
        private String metadataField;
        private String condition;
        private String metadataValue;
        private String fullRule;
        private Button removeRuleBtn;

        public DeliveryAccessRule(ExtendedWebDriver web, DeliveryAccessRulesList parent, WebElement row) {
            super(web, parent);
            List<WebElement> metadataFilters = row.findElements(By.tagName("span"));
            metadataField = getElementValueByIndex(metadataFilters, 1);
            condition = getElementValueByIndex(metadataFilters, 2);
            metadataValue = getElementValueByIndex(metadataFilters, 3);
            fullRule = String.format("%s %s %s", metadataField, condition, metadataValue);
            removeRuleBtn = new Button(parent, row.findElement(By.className("icon-remove-rule")));
        }

        public String getMetadataField() {
            return metadataField;
        }

        public String getCondition() {
            return condition;
        }

        public String getMetadataValue() {
            return metadataValue;
        }

        public String getFullRule() {
            return fullRule;
        }

        public void removeAccessRule() {
            int accessRulesCount = web.findElements(getDeliveryAccessRuleRowLocator()).size();
            clickRemoveRuleBtn();
            waitUntilAccessRuleWillBeRemoved(accessRulesCount);
        }

        private String getElementValueByIndex(List<WebElement> elements, int index) {
            return elements.get(index).getText().trim();
        }

        private void waitUntilAccessRuleWillBeRemoved(final int accessRulesCount) {
            web.waitUntil(new ExpectedCondition<Boolean>() {
                public Boolean apply(WebDriver webDriver) {
                    return webDriver.findElements(getDeliveryAccessRuleRowLocator()).size() == (accessRulesCount - 1);
                }
            });
        }

        private void clickRemoveRuleBtn() {
            removeRuleBtn.click();
        }
    }

    public DeliveryAccessRule getDeliveryAccessRule(String metadataField) {
        for (DeliveryAccessRule deliveryAccessRule: getDeliveryAccessRules())
            if (deliveryAccessRule.getMetadataField().equals(metadataField))
                return deliveryAccessRule;
        return null;
    }

    public List<String> getVisibleMetadataFields() {
        List<String> metadataFields = new ArrayList<>();
        List<DeliveryAccessRule> deliveryAccessRules = getDeliveryAccessRules();
        if (deliveryAccessRules == null) return metadataFields;
        for (DeliveryAccessRule deliveryAccessRule: deliveryAccessRules)
            metadataFields.add(deliveryAccessRule.getMetadataField());
        return metadataFields;
    }

    private List<DeliveryAccessRule> getDeliveryAccessRules() {
        if (!web.isElementPresent(getDeliveryAccessRuleRowLocator())) return null;
        List<WebElement> rows = web.findElements(getDeliveryAccessRuleRowLocator());
        List<DeliveryAccessRule> deliveryAccessRules = new ArrayList<>();
        for (WebElement row: rows)
            deliveryAccessRules.add(new DeliveryAccessRule(web, this, row));
        return deliveryAccessRules;
    }

    private static By getDeliveryAccessRuleRowLocator() {
        return By.cssSelector(String.format("%s %s", ROOT_NODE, ".pbs"));
    }
}