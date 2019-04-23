package com.adstream.automate.babylon.tests.steps.domain.traffic;

import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.sut.data.MetadataItem;
import com.adstream.automate.babylon.sut.pages.ordering.OrderItemPage;
import com.adstream.automate.babylon.sut.pages.traffic.TrafficOrderEditPage;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;

import static java.util.Arrays.asList;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.not;

/**
 * Created by denysb on 30/11/2015.
 */
public class TrafficOrderEditSteps extends TrafficHelperSteps{



    public TrafficOrderEditPage getTrafficEditPage(){
        return getSut().getPageCreator().getTrafficOrderEditPage();
    }

    @Given("{I |}clicked proceed button on Traffic Order Edit page")
    @When("{I |}click proceed button on Traffic Order Edit page")
    public void clickProceedButtonOnTrafficOrderEditPage(){
        TrafficOrderEditPage page = getSut().getPageCreator().getTrafficOrderEditPage();
        Common.sleep(3000);
        page.clickProceedButton();
    }

    @Given("{I |}clicked Hold For Approval button on Traffic Order Edit page")
    @When("{I |}click Hold For Approval button on Traffic Order Edit page")
    public void clickHoldForApprovalButtonOnTrafficOrderEditPage(){
    TrafficOrderEditPage page = getTrafficEditPage();
        page.clickHoldForApprovalButtonOnTrafficOrderEditPage();
    }

    // this can b used oly if create orders with agencyadmin
    @When("{I |}Edit order item with following {clock number|isrc code} '$clockNumber'")
    @Then("{I |}Edit order item with following {clock number|isrc code} '$clockNumber'")
    public void editOrderItemByClockNumber(String clockNumber) {
        String orderId = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getId();
        String orderItemId = getCoreApiAdmin().getOrderItemByClockNumber(orderId, wrapVariableWithTestSession(clockNumber)).getId();
        User user=getCoreApiAdmin().getUserByEmail(getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getCreatedBy().getEmail());
        String userId = user.getId();
        editOrderItemPage(orderId, orderItemId,userId);
    }

     protected OrderItemPage editOrderItemPage(String orderId, String orderItemId, String userId) {
      return getSut().getPageNavigator().getEditOrderItemPage(orderId, orderItemId,userId);
  }

     @Given("{I |}clicked master arrived button on Traffic Order Edit page")
     @When("{I |}click master arrived button on Traffic Order Edit page")
     public void clickOnMasterArrivedButton(){
        getTrafficEditPage().clickOnMassterArrivedButton();
    }

    @Given("{I |}clicked undo master arrived button on Traffic Order Edit page")
    @When("{I |}click undo master arrived button on Traffic Order Edit page")
    public void clickOnUndoMasterArrivedButton(){
        getTrafficEditPage().clickOnUndoMassterArrivedButton().action.click();
    }

    @When("{I |}expand Add Information section on Traffic Order Edit page")
    public void expandAddInformationSectionOnTrafficOrderEditPage() {
        getTrafficEditPage().expandAddInformationSection();
    }

    @When("{I |}expand delivery section on Traffic Order Edit page")
    public void expandDeliverySectionOnTrafficOrderEditPage(){
        getTrafficEditPage().expandDestinationsSection();
    }

    @When("{I |}click Hold for Approval button for destination")
    public void clickHoldForApprovalDestinationButtonOnTrafficOrderEditPage(){
        getTrafficEditPage().clickHoldForApprovalDeliveryButtonOnTrafficOrderEditPage();
    }

    @When("{I |}click Restart Delivery button for destination")
    public void clickRestartDeliveryDestinationButtonOnTrafficOrderEditPage(){
        getTrafficEditPage().clickRestartDeliveryButtonOnTrafficOrderEditPage();
    }

    @Given("{I |}edit order in traffic with the following fields: $data")
    @When("{I |}edit order in traffic with the following fields: $data")
    public void editOrderInTraffic(ExamplesTable data){
        fillOrderFieldsOnTrafficEditOrderPage(data);
    }

    @Given("{I |}filled order fields in traffic order edit page: $data")
    @When("{I |}fill order fields in traffic order edit page: $data")
    public void fillOrderFieldsOnTrafficEditOrderPage(ExamplesTable data){
        expandAddInformationSectionOnTrafficOrderEditPage();
        for (MetadataItem row : wrapMetadataFields(data, "FieldName", "FieldValue")) {
            if(row.getKey().equalsIgnoreCase("Title")){
                getTrafficEditPage().fillTrafficOrderFieldByName(row.getKey(), wrapVariableWithTestSession(row.getValue()));
            }else{
                getTrafficEditPage().fillTrafficOrderFieldByName(row.getKey(), row.getValue());

            }
        }
    }


    @Then("{I |}'$condition' see Hold For Approval button is active")
    public void checkThatHoldForApprovalButtonIsActive(String condition){
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean isActive = getTrafficEditPage().checkIsHoldForApprovalButtonActive();
        assertThat(isActive,shouldState ? is(true) : is(not(true)));
    }


    protected DateTime parseDateTime(String date) {
        if (date.equalsIgnoreCase("Today")) {
            return DateTime.now();
        } else if (date.equalsIgnoreCase("Yesterday")) {
            return DateTime.now().minusDays(1);
        } else if (date.equalsIgnoreCase("Tomorrow")) {
            return DateTime.now().plusDays(1);
        } else {
            return DateTimeFormat.forPattern(TestsContext.getInstance().storiesDateTimeFormat).parseDateTime(date);
        }
    }

}
