package com.adstream.automate.babylon.tests.steps.domain.ordering;

import com.adstream.automate.babylon.sut.pages.admin.metadata.GlobalCommonOrderingMetadataPage;
import com.adstream.automate.babylon.tests.steps.domain.MetadataSteps;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.annotations.Given;
import java.util.List;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.hamcrest.Matchers.not;

/*
 * Created by demidovskiy-r on 25.11.2014.
 */
public class CommonOrderingMetadataSteps extends MetadataSteps {

    private GlobalCommonOrderingMetadataPage openGlobalCommonOrderingMetadataPage(String agencyId, String marketId) {
        return getSut().getPageNavigator().getGlobalCommonOrderingMetadataPage(agencyId, marketId);
    }

    private GlobalCommonOrderingMetadataPage getGlobalCommonOrderingMetadataPage() {
        return getSut().getPageCreator().getGlobalCommonOrderingMetadataPage();
    }

    protected String getMarketKey(String market) {
        return market.equals("ALL") ? market : getCoreApi().getMarketKey(market);
    }

    protected String getAgencyId(String agencyName) {
        return agencyName.isEmpty() ? "" : getAgencyIdByName(agencyName);
    }

    @Given("{I am |}on the global common ordering metadata page of market '$market' for agency '$agencyName'")
    @When("{I |}go to the global common ordering metadata page of market '$market' for agency '$agencyName'")
    public GlobalCommonOrderingMetadataPage toGlobalCommonOrderingMetadataPage(String market, String agencyName) {
        return openGlobalCommonOrderingMetadataPage(getAgencyId(agencyName), getMarketKey(market));
    }

    @Then("{I |}'$shouldState' see available following markets '$marketsList' on the global common ordering metadata page")
    public void checkCommonOrderingMarketsAvailability(String shouldState, String marketsList) {
        List<String> availableMarkets= getGlobalCommonOrderingMetadataPage().getAvailableMarkets();
        for (String market: marketsList.split(","))
            assertThat("Check common ordering market: " + market, availableMarkets, shouldState.equals("should")
                                                                                    ? hasItem(market)
                                                                                    : not(hasItem(market)));
    }
}