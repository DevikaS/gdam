package com.adstream.automate.babylon.tests.steps.domain.ordering;

import com.adstream.automate.babylon.JsonObjects.ordering.Order;
import com.adstream.automate.babylon.sut.pages.ordering.FailedOrderPage;
import com.adstream.automate.babylon.sut.pages.ordering.elements.lists.FailedOrderList;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;

import java.util.Iterator;
import java.util.List;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/*
 * Created by demidovskiy-r on 29.04.14.
 */
public class FailedOrderSteps extends OrderingHelperSteps {

    private FailedOrderPage openFailedOrderPage() {
        return getSut().getPageNavigator().getFailedOrderPage();
    }

    private FailedOrderPage getFailedOrderPage() {
        return getSut().getPageCreator().getFailedOrderPage();
    }

    private FailedOrderList getFailedOrderList() {
        return getFailedOrderPage().getFailedOrderList();
    }

    @Given("I am on Failed Order page")
    @When("{I |}go to Failed Order page")
    public FailedOrderPage toFailedOrderPage() {
        return openFailedOrderPage();
    }

    @Given("I click on Order completion queue")
    @When("{I |}click on Order completion queue")
    public void orderCompletionQueue() {
        openFailedOrderPage().clickCompleteionQueue();
    }



    @When("{I |}resend order with following item clock number '$clockNumber' in failed orders list")
    public void resendFailedOrders(String clockNumber) {
        Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
        getFailedOrderList().getFailedOrderByOrderReference(String.valueOf(order.getOrderReference())).resend();
    }

    @When("{I |}delete order{s|} with following item clock number{s|} '$clockNumbersList' in failed orders list")
    public void deleteFailedOrders(String clockNumbersList) {
        FailedOrderList failedOrderList = getFailedOrderList();
        for (String clockNumber : clockNumbersList.split(",")) {
            Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
            failedOrderList.getFailedOrderByOrderReference(String.valueOf(order.getOrderReference())).getDeleteFailedOrderPopUp().clickOkBtn();
        }
    }

    @When("{I |}delete all orders in failed orders list")
    public void deleteFailedOrders()
    {
        FailedOrderList failedOrderList = getFailedOrderList();
        List<FailedOrderList.Order> FailedOrders = failedOrderList.getFailedOrders();
        while(FailedOrders!=null)
        {
            List<String> visibleOrderReferences=failedOrderList.getVisibleOrderReferences();

            Iterator<String> iterator = visibleOrderReferences.iterator();
            for(int i = 0; i<visibleOrderReferences.size();i++) {
                failedOrderList.getFailedOrderByOrderReference(String.valueOf(visibleOrderReferences.get(i))).getDeleteFailedOrderPopUp().clickOkBtn();
                //Common.sleep(3000);
            }
            FailedOrders = failedOrderList.getFailedOrders();
        }


        }


    @Then("{I |}'$shouldState' see order{s|} with following item clock number{s|} '$clockNumbersList' in failed orders list")
    public void checkVisibilityFailedOrdersByReference(String shouldState, String clockNumbersList) {
        List<String> visibleOrderReferences = getFailedOrderList().getVisibleOrderReferences();
        for (String clockNumber: clockNumbersList.split(",")) {
            Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
            String orderReference = String.valueOf(order.getOrderReference());
            assertThat("Check visibility failed orders by order reference: ", visibleOrderReferences, shouldState.equals("should")
                                                                              ? hasItem(orderReference)
                                                                              : not(hasItem(orderReference)));
        }
    }

    @Then("{I |}'$shouldState' see order{s|} with following market{s|} '$marketsList' in failed orders list")
    public void checkVisibilityFailedOrdersByMarket(String shouldState, String marketsList) {
        List<String> visibleMarkets = getFailedOrderList().getVisibleMarkets();
        for (String market: marketsList.split(","))
            assertThat("Check visibility failed orders by market: ", visibleMarkets, shouldState.equals("should")
                                                                     ? hasItem(market)
                                                                     : not(hasItem(market)));
    }


    @Then("{I |}'$condition' see '$ExpectedFailedOrders' Failed order{s|}")
    public void checkFailedOrderCount(String condition,int ExpectedFailedOrders) {
        int ActualfailedOrders;boolean shouldState = condition.equalsIgnoreCase("should");
        FailedOrderList failedOrderList = getFailedOrderList();
        List<FailedOrderList.Order> FailedOrders = failedOrderList.getFailedOrders();
        if(FailedOrders==null)ActualfailedOrders = 0;
        else ActualfailedOrders = FailedOrders.size();
        assertThat(ActualfailedOrders, shouldState ? equalTo(ExpectedFailedOrders) : not(equalTo(ExpectedFailedOrders)));
    }


}