package com.adstream.automate.babylon.tests.steps.domain.ordering.section;

import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.AddMediaToOrderForm;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.AdditionalInformationForm;
import com.adstream.automate.babylon.tests.steps.domain.ordering.DraftOrderSteps;
import com.adstream.automate.hamcrest.StringByRegExpCheck;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import java.util.Map;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.is;

/*
 * Created by demidovskiy-r on 30.05.2014.
 */
public class AdditionalInformationSteps extends DraftOrderSteps {

    private AdditionalInformationForm getAdditionalInformationForm() {
        return getOrderItemPage().getAdditionalInformationForm();
    }

    @When("{I |}fill following fields for Additional information section on order item page: $fieldsTable")
    public void fillAdditionalInformationForm(ExamplesTable fieldsTable) {
        AdditionalInformationForm form = getAdditionalInformationForm();
        Common.sleep(2000);
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        for (Map.Entry<String, String> entry : row.entrySet())
            form.fillFieldByName(entry.getKey(), entry.getValue());
    }

    //state: disabled
    @Then("{I |}should see '$fieldName' field '$state' on Additional information section of order item page")
    public void checkFieldDisabled(String fieldName,String state) {
        AdditionalInformationForm form = getAdditionalInformationForm();
        if(state.equals("disabled"))
            assertThat("Check Custom Code field: ", form.isCustomFieldDisabled(fieldName), is(state.equals("disabled")));
        else
            throw new IllegalArgumentException("Unknown state: " + state);
    }

    // fieldName: Custom Code, etc
    @When("{I |}generate auto code value for field '$fieldName' on Additional information section of order item page")
    public void generateAdditionalInfoSectionAutoCode(String fieldName) {
        getAdditionalInformationForm().generateAutoCode(fieldName);
    }

    @Then("{I |}should see following data for order item on Additional information section: $fieldsTable")
    public void checkAdditionalInformationData(ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        AdditionalInformationForm form = getAdditionalInformationForm();
        for (Map.Entry<String, String> entry : row.entrySet())
            assertThat("Check field: " + entry.getKey(), form.getFieldValueByName(entry.getKey()), equalTo(entry.getValue()));
    }

    @Then("{I |}should see following auto generated code '$autoCodePattern' for field '$fieldName' on Additional information section of order item page")
    public void checkAdditionalInfoSectionAutoCode(String autoCodePattern, String fieldName) {
        assertThat("Check auto generated code on Additional Information section: ", getAdditionalInformationForm().getFieldValueByName(fieldName),
                                                                                    StringByRegExpCheck.matches(autoCodePattern));
    }
}