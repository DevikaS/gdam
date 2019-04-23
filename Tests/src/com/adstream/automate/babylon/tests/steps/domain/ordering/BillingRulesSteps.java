package com.adstream.automate.babylon.tests.steps.domain.ordering;

import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.popupForms.BillingRuleBuilderForm;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.popupForms.BillingRuleForm;
import com.adstream.automate.babylon.tests.steps.domain.AgencyPartnersSteps;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import java.util.List;
import java.util.Map;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.hasItem;
import static org.hamcrest.Matchers.not;

/*
 * Created by demidovskiy-r on 19.03.2015.
 */
public class BillingRulesSteps extends AgencyPartnersSteps {

    private BillingRuleBuilderForm getBillingRuleBuilderForm() {
        return getAgencyPartnersPage().getBillingRuleBuilderForm();
    }

    private List<Map<String, String>> prepareBillingRules(ExamplesTable fieldsTable) {
        List<Map<String, String>> mapsList = parametrizeTableRows(fieldsTable);
        for (Map<String, String> map: mapsList) {
            if (map.containsKey("Partner BU")) map.put("Partner BU", wrapVariableWithTestSession(map.get("Partner BU")));
            if (map.containsKey("Rules Criterias")) {
                StringBuilder sb = new StringBuilder();
                String[] rulesCriterias = map.get("Rules Criterias").split(",");
                for (int i = 0; i < rulesCriterias.length; i++) {
                    String[] rulesCriteria = rulesCriterias[i].split("=");
                    sb.append(rulesCriteria[0]).append("=").append(wrapVariableWithTestSession(rulesCriteria[1]));
                    if (i != rulesCriterias.length - 1) sb.append(",");
                }
                map.put("Rules Criterias", sb.toString());
            }
        }
        return mapsList;
    }

    // | Partner BU | Rules Criterias |
    @Given("{I |}filled following fields for Billing Rule Builder form on agency partners page: $fieldsTable")
    @When("{I |}fill following fields for Billing Rule Builder form on agency partners page: $fieldsTable")
    public void fillBillingRuleBuilderForm(ExamplesTable fieldsTable) {
        getBillingRuleBuilderForm().fill(prepareBillingRules(fieldsTable));
    }

    @Given("{I |}saved billing rules on Billing Rule Builder form")
    @When("{I |}save billing rules on Billing Rule Builder form")
    public void saveBillingRules() {
        getBillingRuleBuilderForm().save();
    }

    // | Partner BU | Rules Criterias |
    @Then("{I |}should see following data on Billing Rule Builder form: $fieldsTable")
    public void checkBillingRulesData(ExamplesTable fieldsTable) {
        List<Map<String, String>> dataMapsList = prepareBillingRules(fieldsTable);
        List<BillingRuleForm> billingRuleForms = getBillingRuleBuilderForm().getBillingRules();
        if (dataMapsList.size() != billingRuleForms.size()) throw new IllegalStateException("Some inconsistency in billing rules data!");
        for (int i = 0; i < dataMapsList.size(); i++) {
            BillingRuleForm form = billingRuleForms.get(i);
            for (Map.Entry<String, String> entry: dataMapsList.get(i).entrySet())
                assertThat("Check field: " + entry.getKey(), form.getFieldValue(entry.getKey()), equalTo(entry.getValue()));
        }
    }

    // metadataFields: Advertiser, Product, Campaign
    @Then("{I |}'$shouldState' see available following metadata fields '$metadataFields' on Billing Rule Builder form")
    public void checkMetadataFieldsAvailability(String shouldState, String metadataFields) {
        BillingRuleBuilderForm form = getBillingRuleBuilderForm();
        for (String metadataField: metadataFields.split(","))
            assertThat("Check availability metadata field: "+ metadataField, form.getBillingRules().get(0).getAvailableMetadataFields(),
                                                                             shouldState.equals("should") ? hasItem(metadataField) : not(hasItem(metadataField)));
    }
}