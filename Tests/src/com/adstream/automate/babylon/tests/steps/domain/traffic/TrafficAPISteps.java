package com.adstream.automate.babylon.tests.steps.domain.traffic;

import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.JsonObjects.ordering.DestinationItem;
import com.adstream.automate.babylon.JsonObjects.ordering.Order;
import com.adstream.automate.babylon.JsonObjects.ordering.OrderItem;
import com.adstream.automate.babylon.JsonObjects.traffic.DeliveryItem;
import com.adstream.automate.babylon.JsonObjects.traffic.TrafficOrder;
import com.adstream.automate.babylon.JsonObjects.traffic.TrafficOrderItem;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;

/**
 * Created by denysb on 23/06/2016.
 */
public class TrafficAPISteps extends TrafficHelperSteps {

    @Given("{I |}got order item details for '$clock' clock number with '$destination' destination")
    @When("{I |}get order item details for '$clock' clock number with '$destination' destination")
    public void getOrderItemDetailsByA4DeliveryId(String clockNumber, String destination) {
        Order order = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
        DestinationItem[] destinationItems = getCoreApiAdmin().
                getOrderItemByClockNumber(order.getId(), wrapVariableWithTestSession(clockNumber)).getDestinationItems();
        for (DestinationItem item : destinationItems) {
            if (item.getName().equals(destination)) {
                getTrafficCoreApi().getOrderItemByA4DeliveryId(item.getA4Id());
            }
        }
    }

    @Then("{I |}should see order item '$clock' clock number with '$destination' destination with following details: $data")
    public void checkOrderItemViaTrafficOrderApi(String clockNumber, String destination, ExamplesTable data) {
        Order order = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
        Map<String, String> row = parametrizeTabularRow(data);
        DestinationItem[] destinationItems = getCoreApiAdmin().
                getOrderItemByClockNumber(order.getId(), wrapVariableWithTestSession(clockNumber)).getDestinationItems();
        for (DestinationItem item : destinationItems) {
            if (item.getName().equals(destination)) {
                TrafficOrder trafficOrder = getTrafficCoreApi().getOrderItemByA4DeliveryId(item.getA4Id());
                TrafficOrderItem trafficOrderItem = trafficOrder.getOrderItems().get(0);
                if(row.containsKey("Title")){
                    row.put("Title", wrapVariableWithTestSession(row.get("Title")));
                    assertThat("Title", trafficOrderItem.getMetadata().getTitle(), equalTo(row.get("Title")));
                }
                if(row.containsKey("Product")){
                    row.put("Product", wrapVariableWithTestSession(row.get("Product")));
                    assertThat("Product", trafficOrderItem.getMetadata().getProduct(), equalTo(row.get("Product")));
                }
                if(row.containsKey("Approvals Message")){
                    DeliveryItem deliveryItem = trafficOrderItem.getDeliveryItem().get(0);
                    assertThat("Approvals Message", deliveryItem.getApprovals().get(0).getMessage(), equalTo(row.get("Approvals Message")));

                }
            }
        }
    }
}