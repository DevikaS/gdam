package com.adstream.automate.babylon.tests.steps.domain.oneDelivery;

import org.jbehave.core.annotations.Given;

public class OneDeliveryOrderCompleteSteps extends OneDeliveryBaseSteps{

    @Given("{I |}placed the order from OneDelivery")
    public void clickPlaceMyOrderButton() {
        getSut().getPageCreator().getOneDeliveryOrderCompletePage().clickPlaceMyOrderButton();
    }
}
