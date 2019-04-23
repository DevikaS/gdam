package com.adstream.automate.babylon.tests.steps.domain.ordering;

import com.adstream.automate.babylon.sut.pages.admin.metadata.GlobalCommonTrafficMetadataPage;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import java.util.List;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import static org.hamcrest.Matchers.hasItem;

/*
 * Created by demidovskiy-r on 21.11.2014.
 */
public class CommonTrafficMetadataSteps extends CommonOrderingMetadataSteps {

    private GlobalCommonTrafficMetadataPage openGlobalCommonTrafficMetadataPage(String agencyId, String marketId) {
        return getSut().getPageNavigator().getGlobalCommonTrafficMetadataPage(agencyId, marketId);
    }

    private GlobalCommonTrafficMetadataPage getGlobalCommonTrafficMetadataPage() {
        return getSut().getPageCreator().getGlobalCommonTrafficMetadataPage();
    }

    @Given("{I am |}on the global common traffic metadata page of market '$market' for agency '$agencyName'")
    @When("{I |}go to the global common traffic metadata page of market '$market' for agency '$agencyName'")
    public GlobalCommonTrafficMetadataPage toGlobalCommonTrafficMetadataPage(String market, String agencyName) {
        return openGlobalCommonTrafficMetadataPage(getAgencyId(agencyName), getMarketKey(market));
    }

    @When("{I |}select following market '$market' on the global common traffic metadata page")
    public void selectMarket(String market) {
        getGlobalCommonTrafficMetadataPage().selectMarket(market);
    }

    // state: enabled, disabled
    @Then("{I |}should see '$state' Market on common traffic metadata page")
    public void checkMarketState(String state) {
        assertThat("Check Market state: ", getGlobalCommonTrafficMetadataPage().isMarketEnabled(), is(state.equals("enabled")));
    }

    @Then("{I |}should see following market '$market' on common traffic metadata page")
    public void checkMarketValue(String market) {
        assertThat("Check Market value: ", getGlobalCommonTrafficMetadataPage().getMarket(), equalTo(market));
    }

    @Then("{I |}'$shouldState' see available following markets '$marketsList' on the global common traffic metadata page")
    public void checkCommonTrafficMarketsAvailability(String shouldState, String marketsList) {
        List<String> availableMarkets= getGlobalCommonTrafficMetadataPage().getAvailableMarkets();
        for (String market: marketsList.split(","))
            assertThat("Check common traffic market : " + market, availableMarkets, shouldState.equals("should")
                                                                                    ? hasItem(market)
                                                                                    : not(hasItem(market)));
    }
}