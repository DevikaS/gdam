package com.adstream.automate.babylon.tests.steps.domain.ordering.section;

import com.adstream.automate.babylon.sut.pages.ordering.elements.Data;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.CommonInformationForm;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.SchemaField;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import java.util.Map;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.containsString;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.is;

/*
 * Created by demidovskiy-r on 19.03.2015.
 */
public class CommonInformationSteps extends AddInformationSteps {

    private CommonInformationForm getCommonInformationForm() {
        return getOrderItemPage().getCommonInformationForm();
    }

    // | Advertiser | Brand | Sub Brand | Product | Campaign |
    @When("{I |}fill following fields for Common Information section on order item page: $fieldsTable")
    public void fillCommonInformationForm(ExamplesTable fieldsTable) {
        Map<String, String> row = prepareAddInformationFields(fieldsTable);
        getCommonInformationForm().fill(row);
    }

    // | Advertiser Custom | Brand Custom | Sub Brand Custom | Product Custom |
    @When("{I |}fill following custom advertiser hierarchy fields for Common Information section on order item page: $fieldsTable")
    public void fillCommonInformationFormCustomAdvertiserHierarchyFields(ExamplesTable fieldsTable) {
        Map<String, String> row = prepareAddInformationCustomFields(fieldsTable);
        getCommonInformationForm().fillAdvertiserHierarchyCustomFields(row);
    }

    // | Advertiser | Brand | Sub Brand | Product | Campaign |
    @Then("{I |}should see following data for order item on Common Information section: $fieldsTable")
    public void checkCommonInformationFormData(ExamplesTable fieldsTable) {
        Map<String, String> row = prepareAddInformationFields(fieldsTable);
        CommonInformationForm form = getCommonInformationForm();
        for (Map.Entry<String, String> entry : row.entrySet())
            assertThat("Check field: " + entry.getKey(), form.getFieldValue(entry.getKey()), equalTo(entry.getValue()));
    }

    @Then("{I |}'$shouldState' see following fields '$fields' for order item on Common Information section")
    public void checkCommonInformationFieldsVisibility(String shouldState, String fields) {
        CommonInformationForm form = getCommonInformationForm();
        for (String fieldName : fields.split(","))
            assertThat("Check visibility field: " + fieldName, form.isFieldVisible(Data.getPrimaryFieldName(SchemaField.findByName(fieldName))), is(shouldState.equals("should")));
    }

    // state: enabled, disabled
    @Then("{I |}should see '$state' following fields '$fields' for order item on Common Information section")
    public void checkCommonInformationFormFieldsState(String state, String fields) {
        CommonInformationForm form = getCommonInformationForm();
        for (String fieldName : fields.split(","))
            assertThat("Check Add information form field: " + fieldName,
                        form.isFieldEnabled(Data.getPrimaryFieldName(SchemaField.findByName(fieldName))), is(state.equals("enabled")));
    }

    @Then("{I |}'$shouldState' see validation errors next to following fields '$fields' for order item on Common Information section")
    public void checkCommonInformationFormFieldsValidation(String shouldState, String fields) {
        CommonInformationForm form = getCommonInformationForm();
        for (String fieldName : fields.split(","))
            assertThat("Check is field required: " + fieldName, form.isValidationFieldErrorVisible(Data.getPrimaryFieldName(SchemaField.findByName(fieldName))),
                                                                is(shouldState.equals("should")));
    }

    @Then("{I |}'$shouldState' see following fields '$fields' in sorted order on order item in Common Information section")
    public void checkCommonInformationFieldsSorted(String shouldState, String fields) {
        CommonInformationForm form = getCommonInformationForm();
        if(shouldState.equals("should")){
        for (String fieldName : fields.split(",")) {
            String elementName=Data.getPrimaryFieldName(SchemaField.findByName(fieldName));
            assertThat("Check field sorting: " + fieldName, form.getFieldsLabel(elementName).equals("Posthouse") ? "Post House" : form.getFieldsLabel(elementName), containsString(elementName));
        }
    }}
}