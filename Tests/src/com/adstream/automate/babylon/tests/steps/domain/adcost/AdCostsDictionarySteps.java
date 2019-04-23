package com.adstream.automate.babylon.tests.steps.domain.adcost;

import com.adstream.automate.babylon.sut.pages.adcost.AdCostsCurrencyPage;
import com.adstream.automate.babylon.sut.pages.adcost.AdCostsDictionaryPage;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.util.Map;


public class AdCostsDictionarySteps extends AdCostsHelperSteps {

    @Given("{I am} on dictionary section under admin page")
    @When("{I am} on dictionary section under admin page")
    protected AdCostsDictionaryPage openAdCostsDictionaryPage() {
        return getSut().getPageNavigator().getAdCostsDictionaryPage();
    }

    // action = created|updated|create|update
    @Given("{I |}updated following item on dictionary page under admin section:$data")
    @When("{I |}update following item on dictionary page under admin section:$data")
    public void updateDictionaryValues(ExamplesTable data){
        AdCostsDictionaryPage dictionaryPage = getSut().getPageNavigator().getAdCostsDictionaryPage();
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data,i);
            String item = row.get("Item");
            String value = wrapVariableWithTestSession(row.get("Value"));
            dictionaryPage.updateDictionary(item,value);
        }
    }

    @Given("{I |}enabled add on fly feature for '$fieldName' field on dictionary page under admin section")
    @When("{I |}enable add on fly feature for '$fieldName' field on dictionary page under admin section")
    public void enableAddOnFlyDictionaryValue(String fieldName){
        AdCostsDictionaryPage dictionaryPage = getSut().getPageNavigator().getAdCostsDictionaryPage();
        dictionaryPage.updateAddOnFlyFeature(fieldName);
    }
}