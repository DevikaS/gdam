package com.adstream.automate.babylon.tests.steps.domain.traffic;

import com.adstream.automate.babylon.sut.pages.traffic.TrafficOrderSummaryPage;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.When;

/**
 * Created by denysb on 30/11/2015.
 */
public class TrafficOrderSummarySteps extends TrafficHelperSteps{

    @Given("{I |}clicked confirm button on Traffic Order Summary page")
    @When("{I |}click confirm button on Traffic Order Summary page")
    public void clickConfirmButtonOnTrafficOrderSummaryPage(){
        TrafficOrderSummaryPage page = getSut().getPageCreator().getTrafficOrderSummaryPage();
        page.clickConfirmButtonOnTrafficOrderSummaryPage();
        Common.sleep(2000);
    }

    @Given("{I |}clicked done button on Traffic Order Summary page")
    @When("{I |}click done button on Traffic Order Summary page")
    public void clickDoneButtonOnTrafficOrderSummaryPage(){
        TrafficOrderSummaryPage page = getSut().getPageCreator().getTrafficOrderSummaryPage();
        page.waitUntilLoadOrderSummarySpinnerDisappears();
        page.clickDoneButtonOnTrafficOrderSummaryPage();
    }

    //Send order delivered/qc passed email to order creator based on orderStatus
    @When("{I |}click notify order creator when entire order has '$orderStatus'")
    public void sendNotificationsByEmailToOrderCreator(String orderStatus){
        TrafficOrderSummaryPage page = getSut().getPageCreator().getTrafficOrderSummaryPage();
        page.clickOrderNotificationsByEmail(orderStatus);
    }

    //Additional email recipients are added
    @Given("{I |}added order '$orderStatus' email recipient{s|} '$emailList' on Traffic Order Summary page")
    @When("{I |}add order '$orderStatus' email recipient{s|} '$emailList' on Traffic Order Summary page")
    public void enterCompletedEmailRecipientsOnTrafficOrderSummaryPage(String orderStatus, String emailsList) {
        TrafficOrderSummaryPage page = getSut().getPageCreator().getTrafficOrderSummaryPage();
        for (String email : emailsList.split(","))
                page.enterOrderRecipientEmail(orderStatus, wrapUserEmailWithTestSession(email));
    }
}
