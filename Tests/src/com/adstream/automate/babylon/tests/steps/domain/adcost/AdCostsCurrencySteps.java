package com.adstream.automate.babylon.tests.steps.domain.adcost;

import com.adstream.automate.babylon.JsonObjects.adcost.*;
import com.adstream.automate.babylon.sut.pages.adcost.AdCostsCurrencyPage;
import com.adstream.automate.babylon.sut.pages.adcost.AdCostsVendorPage;
import com.adstream.automate.babylon.sut.pages.adcost.elements.AdCostsData;
import com.adstream.automate.babylon.sut.pages.adcost.elements.AdCostsSchemaField;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.is;


public class AdCostsCurrencySteps extends AdCostsHelperSteps {

    @Given("{I am} on currency section under admin page")
    @When("{I am} on currency section under admin page")
    protected AdCostsCurrencyPage openAdCostsCurrencyPage() {
        return getSut().getPageNavigator().getAdCostsCurrencyPage();
    }

    // action = created|updated|create|update
    @Given("{I |}updated following currency on Currency page under admin section:$data")
    @When("{I |}update following currency on Currency page under admin section:$data")
    public void updateCurrency(ExamplesTable data){
        Map<String, String> row = parametrizeTabularRow(data);
        AdCostsCurrencyPage currencyPage = getSut().getPageNavigator().getAdCostsCurrencyPage();
        String currencyTitle = row.get("Currency title");
        String exchangeRate = row.get("Exchange rate");
        currencyPage.updateCurrency(currencyTitle, exchangeRate);
        Common.sleep(9999);
    }
}