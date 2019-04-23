package com.adstream.automate.babylon.tests.steps.domain.oneDelivery;

import org.jbehave.core.annotations.Given;

public class OneDeliveryOrderBillingSteps extends OneDeliveryBaseSteps{

    @Given("{I |}clicked continue button on OneDelivery billing page")
    public void clickButton() {
        getSut().getPageCreator().getOneDeliveryOrderBillingPage().clickCompleteContinueButton();
    }
}