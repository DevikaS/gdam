package com.adstream.automate.babylon.tests.steps.domain.ordering;

import com.adstream.automate.babylon.sut.pages.admin.people.UserDeliveryPage;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.popupForms.DeliveryAccessRuleBuilderForm;
import com.adstream.automate.babylon.sut.pages.ordering.elements.lists.DeliveryAccessRulesList;
import com.adstream.automate.babylon.tests.steps.domain.UserSteps;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.openqa.selenium.By;

import javax.swing.*;
import java.awt.*;
import java.awt.event.KeyEvent;
import java.util.List;
import java.util.Map;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.hasItem;
import static org.hamcrest.Matchers.not;

/*
 * Created by demidovskiy-r on 09.12.2014.
 */
public class UserDeliverySteps extends UserSteps {

    private UserDeliveryPage openUserDeliveryPage(String userName) {
        return getSut().getPageNavigator().getUserDeliveryPage(wrapNameAndGetUserId(userName));
    }

    private UserDeliveryPage getUserDeliveryPage() {
        return getSut().getPageCreator().getUserDeliveryPage();
    }

    private DeliveryAccessRulesList getDeliveryAccessRulesList() {
        return getUserDeliveryPage().getDeliveryAccessRulesList();
    }

    private DeliveryAccessRuleBuilderForm getDeliveryAccessRuleBuilderForm() {
        return getUserDeliveryPage().getDeliveryAccessBuilderForm();
    }

    private List<Map<String, String>> prepareDeliveryAccessRules(ExamplesTable fieldsTable) {
        List<Map<String, String>> rowsList = parametrizeTableRows(fieldsTable);
        for (Map<String, String> row: rowsList)
            if (row.containsKey("Metadata Value")) row.put("Metadata Value", wrapVariableWithTestSession(row.get("Metadata Value")));
        return rowsList;
    }

    private List<Map<String, String>> prepareDeliveryAccessRulesWithoutWrappingCurrentSessionID(ExamplesTable fieldsTable) {
        List<Map<String, String>> rowsList = parametrizeTableRows(fieldsTable);
        for (Map<String, String> row: rowsList)
            if (row.containsKey("Metadata Value")) row.put("Metadata Value", row.get("Metadata Value"));
        return rowsList;
    }

    @Given("{I am |}on user '$userName' delivery page in administration area")
    @When("{I |}go to user '$userName' delivery page in administration area")
    public UserDeliveryPage toUserDeliveryPage(String userName) {
        return openUserDeliveryPage(userName);
    }

    // | Metadata Field | Condition | Metadata Value |
    @Given("{I |}filled following fields for Delivery Access Rule Builder form on users delivery page: $fieldsTable")
    @When("{I |}fill following fields for Delivery Access Rule Builder form on users delivery page: $fieldsTable")
    public void fillAccessRuleBuilderForm(ExamplesTable fieldsTable) {
        getDeliveryAccessRuleBuilderForm().fill(prepareDeliveryAccessRules(fieldsTable));
    }

    // | Metadata Field | Condition | Metadata Value |
    @When("{I |}fill following fields for Delivery Access Rule Builder form on users delivery page without wrapping current session ID: $fieldsTable")
    public void fillAccessRuleBuilderFormWithoutWrappingCurrentSession(ExamplesTable fieldsTable) {
        getDeliveryAccessRuleBuilderForm().fill(prepareDeliveryAccessRulesWithoutWrappingCurrentSessionID(fieldsTable));
    }
    @Given("{I |}save delivery access rules on Delivery Access Rule Builder form")
    @When("{I |}save delivery access rules on Delivery Access Rule Builder form")
    public void saveDeliveryAccessRules() {
        getDeliveryAccessRuleBuilderForm().save();
    }

    @Given("{I |}saved delivery access rules on Delivery Access Rule Builder window")
    @When("{I |}save delivery access rules on Delivery Access Rule Builder window")
    public void saveDeliveryAccessRule() {
        getSut().getWebDriver().findElement(By.cssSelector("[data-role='save']")).click();
    }

    @When("{I |}delete delivery access rule with metadata fields '$metadataFieldsList' on users delivery page")
    public void deleteUserDeliveryAccessRules(String metadataFieldsList) {
        DeliveryAccessRulesList deliveryAccessRulesList = getDeliveryAccessRulesList();
        for (String metadataField: metadataFieldsList.split(","))
            deliveryAccessRulesList.getDeliveryAccessRule(metadataField).removeAccessRule();
    }

    @When("{I |}remove delivery access rule with metadata fields '$metadataFieldsList' on Delivery Access Rule Builder form")
    public void removeDeliveryAccessBuilderFormRules(String metadataFieldsList) {
        DeliveryAccessRuleBuilderForm form = getDeliveryAccessRuleBuilderForm();
        for (String metadataField: metadataFieldsList.split(","))
            form.getDeliveryAccessRule(metadataField).removeAccessRule();
    }

    // | Metadata Field | Condition | Metadata Value |
    @Then("{I |}should see following delivery access rules on users delivery page: $fieldsTable")
    public void checkUserDeliveryAccessRules(ExamplesTable fieldsTable) {
        List<Map<String, String>> rowsList = prepareDeliveryAccessRules(fieldsTable);
        DeliveryAccessRulesList deliveryAccessRulesList = getDeliveryAccessRulesList();
        for (Map<String, String> row: rowsList) {
            DeliveryAccessRulesList.DeliveryAccessRule deliveryAccessRule = deliveryAccessRulesList.getDeliveryAccessRule(row.get("Metadata Field"));
            assertThat("Metadata Field: ", deliveryAccessRule.getMetadataField(), equalTo(row.get("Metadata Field")));
            assertThat("Condition: ", deliveryAccessRule.getCondition(), equalTo(row.get("Condition").toLowerCase()));
            assertThat("Metadata Value: ", deliveryAccessRule.getMetadataValue(), equalTo(row.get("Metadata Value")));
        }
    }

    @Then("{I |}'$shouldState' see delivery access rules with following metadata fields '$metadataFieldsList' on users delivery page")
    public void checkUserDeliveryAccessRulesVisibility(String shouldState, String metadataFieldsList) {
        List<String> metadataFields = getDeliveryAccessRulesList().getVisibleMetadataFields();
        boolean should = shouldState.equals("should");
        for (String metadataField: metadataFieldsList.split(","))
            assertThat("Check visibility of metadata field " + metadataField, metadataFields, should ? hasItem(metadataField) : not(hasItem(metadataField)));
    }

    @Then("{I |}should see available following metadata fields '$metadataFieldsList' for Metadata Field on Delivery Access Rule Builder form")
    public void checkAvailabilityMetadataFields(String metadataFieldsList) {
        List<String> availableMetadataFields = getDeliveryAccessRuleBuilderForm().getAvailableMetadataFields();
        for (String metadataField: metadataFieldsList.split(","))
            assertThat("Check availability of metadata field " + metadataField, availableMetadataFields, hasItem(metadataField));
    }

    @Then("{I |}'$shouldState' see delivery tab for '$user' user in administration area")
    public void checkDeliveryTab(String shouldState,String userName)
    {
        boolean expected = shouldState.equals("should");
        boolean actual =getUserDeliveryPage().checkManageAccessRulesButton();
        assertThat("Check visibility of Delivery tab ", actual, equalTo(expected));
    }

    // | Metadata Field | Condition | Metadata Value |
    @Then("{I |}should see following delivery access rules on users delivery page without wrapping current session ID: $fieldsTable")
    public void checkUserDeliveryAccessRulesWithoutWrappingCurrentSession(ExamplesTable fieldsTable) {
        List<Map<String, String>> rowsList = prepareDeliveryAccessRulesWithoutWrappingCurrentSessionID(fieldsTable);
        DeliveryAccessRulesList deliveryAccessRulesList = getDeliveryAccessRulesList();
        for (Map<String, String> row: rowsList) {
            DeliveryAccessRulesList.DeliveryAccessRule deliveryAccessRule = deliveryAccessRulesList.getDeliveryAccessRule(row.get("Metadata Field"));
            assertThat("Metadata Field: ", deliveryAccessRule.getMetadataField(), equalTo(row.get("Metadata Field")));
            assertThat("Condition: ", deliveryAccessRule.getCondition(), equalTo(row.get("Condition").toLowerCase()));
            assertThat("Metadata Value: ", deliveryAccessRule.getMetadataValue(), equalTo(row.get("Metadata Value")));
        }
    }
}