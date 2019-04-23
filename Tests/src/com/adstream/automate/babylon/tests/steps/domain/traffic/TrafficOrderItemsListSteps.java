package com.adstream.automate.babylon.tests.steps.domain.traffic;

import com.adstream.automate.babylon.JsonObjects.ordering.DestinationItem;
import com.adstream.automate.babylon.JsonObjects.ordering.OrderItem;
import com.adstream.automate.babylon.sut.pages.traffic.TrafficClockDetailsPage;
import com.adstream.automate.babylon.sut.pages.traffic.TrafficOrderItemPage;
import com.adstream.automate.babylon.sut.pages.traffic.TrafficOrderItemsListPage;
import com.adstream.automate.babylon.sut.pages.traffic.TrafficOrdersListPage;
import com.adstream.automate.babylon.sut.pages.traffic.tableList.TrafficOrderItemSendList;
import com.adstream.automate.babylon.sut.pages.traffic.tableList.TrafficOrderList;
import com.adstream.automate.babylon.sut.pages.traffic.tableList.TrafficOrderNestedList;
import com.adstream.automate.babylon.tests.steps.domain.ingest.GdnIngestSteps;
import com.adstream.automate.babylon.tests.steps.domain.ordering.OrderingHelperSteps;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;
import org.openqa.selenium.By;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created by denysb on 25/11/2015.
 */
public class TrafficOrderItemsListSteps extends TrafficHelperSteps{

    public TrafficOrderItemsListPage getTrafficOrderItemListPage(){
        return getSut().getPageCreator().getTrafficOrderItemsListPage();
    }
    public TrafficOrdersListPage getTrafficOrderListPage() {
        return getSut().getPageCreator().getTrafficOrderListPage();
    }

    @Given("{I |}entered search criteria '$data' in simple search form on Traffic Order Item List page")
    @When("{I |}enter search criteria '$data' in simple search form on Traffic Order Item List page")
    public void fillSimpleSearchFormOnTrafficOrderListPage(String data){
        getSut().getPageCreator().getTrafficOrderItemsListPage().enterSearchCriteria(wrapVariableWithTestSession(data));
    }

    @Given("{I |} add comment for following clocks:$data")
    @When("{I |}add comment for following clocks:$data")
    public void checkColumnInTrafficUI(ExamplesTable data){
        TrafficOrderItemSendList trafficOrderItemSendList = getSut().getPageCreator().getTrafficOrderItemsListPage().getTrafficOrderItemsList();
        TrafficOrderItemsListPage trafficListPage = getTrafficOrderItemListPage();
        for (int i = 0; i <data.getRowCount() ; i++) {
            Map<String, String> map = parametrizeTabularRow(data, i);
            TrafficOrderItemSendList.TrafficOrderItemSend trafficOrder = trafficOrderItemSendList.getOrderByClockNumber(wrapPathWithTestSession(map.get("clockNumber"))).get(0);
            trafficOrder.selectOrder();
            trafficListPage.clickAddComment().getCommentPage().addComment(map.get("comment"));
            Common.sleep(2000);
            trafficOrder.deselectOrder();
        }
    }

    @Given("{I |}add comment '$comment' for '$clock' clock on traffic order send list")
    public void addCommentForParticularClock(String comment,String clock){
        TrafficOrderItemSendList trafficOrderItemSendList = getSut().getPageCreator().getTrafficOrderItemsListPage().getTrafficOrderItemsList();
        TrafficOrderItemsListPage trafficListPage = getTrafficOrderItemListPage();
        TrafficOrderItemSendList.TrafficOrderItemSend trafficOrder = trafficOrderItemSendList.getOrderByClockNumber(wrapVariableWithTestSession(clock)).get(0);
        trafficOrder.selectOrder();
        trafficListPage.clickAddComment().getCommentPage().addComment(comment);
        Common.sleep(2000);
        trafficOrder.deselectOrder();
    }

    @Given("{I |}opened order item details page with clockNumber '$clockNumber' and destination '$destinationName'")
    @When("{I |}open order item details page with clockNumber '$clockNumber' and destionation '$destionationName'")
    @Then("{I |}open order item details page with clockNumber '$clockNumber' and destionation '$destionationName'")
    public void openOrderItemDetailOnTrafficPageWithDestination(String clockNumber,String destinationName){
        String orderId = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getId();
        OrderItem orderItem = getCoreApiAdmin().getOrderItemByClockNumber(orderId, wrapVariableWithTestSession(clockNumber));
        DestinationItem[] destinationItem=orderItem.getDestinationItems();
        for(int i=0;i<destinationItem.length;i++)    {
            if(destinationItem[i].getName().equalsIgnoreCase(destinationName)){
                getTrafficOrderItemListPage().openOrderItemUsingAssetId(orderItem.getId(),destinationItem[i].getQcAssetId());
            }

        }

    }

    @Given("{I am |}on cloned order item details page of clockNumber '$clockNumber' for destination '$destination'")
    @When("{I am |}on cloned order item details page of clockNumber '$clockNumber' for destination '$destination'")
    public void orderItemDetailOnTrafficPageClone(String clockNumber,String destination){
        String orderId = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getId();
        String orderItemId = getCoreApiAdmin().getOrderItemByClockNumber(orderId, wrapVariableWithTestSession(clockNumber)).getId();
        OrderItem orderItem = getCoreApiAdmin().getOrderItemByClockNumber(orderId, wrapVariableWithTestSession(clockNumber));
        String qcAssetId = null;

        for (int i = 0; i < orderItem.getDestinationItems().length; i++) {
            if (destination.equalsIgnoreCase(String.valueOf(orderItem.getDestinationItems()[i].getName()))) {

                qcAssetId = orderItem.getDestinationItems()[i].getQcAssetId();
                break;

            }
        }
        TrafficOrderItemPage itemPage = getSut().getPageNavigator().getOrderItemDetailsPage(orderItemId, qcAssetId);

    }

    @Given("{I am |}on clock details page of clockNumber '$clockNumber'")
    @When("{I am |}on clock details page of clockNumber '$clockNumber'")
    public void clockDetailsPage(String clockNumber){
        TrafficClockDetailsPage itemPage = getSut().getPageNavigator().getClockDetailsPage(wrapVariableWithTestSession(clockNumber));
        Common.sleep(3000);
    }


    @Then("{I |} see the following clocknumber in clock level list in Traffic:$data")
    public void verifyClocksInClockLevelList(ExamplesTable data)
    {
        for (int i = 0; i <data.getRowCount() ; i++) {
            Map<String, String> map = parametrizeTabularRow(data, i);
            boolean shouldState = map.get("shouldState").equalsIgnoreCase("should");
            TrafficOrderItemsListPage page = getSut().getPageCreator().getTrafficOrderItemsListPage();
            boolean actualState = page.verifyClocksInClockLevelList(wrapVariableWithTestSession(map.get("ClkNumber")));
            assertThat(actualState, shouldState ? is(true) : is(false));


        }
    }

    @Given("{I |}opened order item details page with clockNumber '$clockNumber'")
    @When("{I |}open order item details page with clockNumber '$clockNumber'")
    @Then("{I |}open order item details page with clockNumber '$clockNumber'")
    public void openOrderItemDetailOnTrafficPage(String clockNumber){
        String orderId = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getId();
        String orderItemId = getCoreApiAdmin().getOrderItemByClockNumber(orderId, wrapVariableWithTestSession(clockNumber)).getId();
        getTrafficOrderItemListPage().openOrderItemUsingClockNumber(orderItemId);
    }

    @Given("{I am|}on order item details page of clockNumber '$clockNumber'")
    @When("{I am|}on order item details page of clockNumber '$clockNumber'")
    public void orderItemDetailOnTrafficPage_AssetId(String clockNumber){
        String orderId = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getId();
        String orderItemId = getCoreApiAdmin().getOrderItemByClockNumber(orderId, wrapVariableWithTestSession(clockNumber)).getId();
        GdnIngestSteps ingest = new GdnIngestSteps();
        String assetId = ingest.getAssetIDAfterIngestA5(clockNumber, orderId);
        TrafficOrderItemPage itemPage = getSut().getPageNavigator().getOrderItemDetailsPage(orderItemId, assetId);
        Common.sleep(3000);
    }


    @Given("{I |}waited till order item list will be loaded in Traffic")
    @When("{I |}wait till order item list will be loaded in Traffic")
    public void waitTillOrderListWillBeLoaded(){
        getTrafficOrderItemListPage().waitUntilPageWillBeLoaded(4000);
    }

    @Then("{I |}'$condition' see orderItems '$data' in order item list in Traffic")
    public void getAvailableOrderItemsFromOrderItemsListTrafficPage(String condition,String data){
        TrafficOrderItemsListPage page = getSut().getPageCreator().getTrafficOrderItemsListPage();
        List<String> orderItems =  page.getOrderItemsList();
        boolean shouldState = condition.equalsIgnoreCase("should");
        for (String clockNumber : data.split(",")) {
            String orderId;
            String orderItemId;
            try{
                orderId = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getId();
                orderItemId = getCoreApiAdmin().getOrderItemByClockNumber(orderId, wrapVariableWithTestSession(clockNumber)).getId();
            }catch (NullPointerException e){
                throw new NullPointerException("order with clockNumber " + clockNumber + " wasn't found in A5");
            }

            assertThat(orderItems, shouldState ? hasItem(orderItemId) : not(hasItem(orderItemId)));
        }

    }

    @When("{I |}sort Order Items by field '$sortField' in order '$order' from Order Level Send")
    public void sortPresentationList(String sortField, String order) {
        TrafficOrderItemsListPage page = getTrafficOrderItemListPage();
        boolean fieldSelected = page.isSortFieldSelected(sortField);
        String orderType = page.getSortFieldOrder(sortField);
        if(!fieldSelected || !orderType.equals(order)){
            page.clickOnSortFieldTitle(sortField);
            waitTillOrderListWillBeLoaded();
            orderType = page.getSortFieldOrder(sortField);
            if(!orderType.equals(order)) {
                page.clickOnSortFieldTitle(sortField);
                waitTillOrderListWillBeLoaded();
            }
        }
    }


    @Then("I '$condition' see the '$topfield' '$fieldvalue' listed at the top in the sorting results")
    public void verifySearchResults(String condition,String topfield, String fieldvalue) {
        TrafficOrderItemsListPage page = getSut().getPageCreator().getTrafficOrderItemsListPage();
        List<TrafficOrderItemSendList.TrafficOrderItemSend> actualOrderItemOrder = new TrafficOrderItemSendList(getSut().getWebDriver()).getOrderSendItems();
        List<String> checkSortList = getActualData(topfield, actualOrderItemOrder);
        String topvalue = checkSortList.get(0);
        assertThat(fieldvalue, equalTo(topvalue));
    }

    @Given("{I |}should see that order items are sorted by '$field' field and '$order' in Clock Level Send")
    @Then("{I |}should see that order items are sorted by '$field' field and '$order' in Clock Level Send")
    public void checkSortingInOrderItemList(String field, String order){
        TrafficOrderItemsListPage page = getSut().getPageCreator().getTrafficOrderItemsListPage();
        List<String> actualList = page.getfieldValues(field);
        List<String> expectedSortingResults = actualList;
        if(order.equals("asc")){
            Collections.sort(expectedSortingResults,String.CASE_INSENSITIVE_ORDER);
        }else{
            Collections.sort(expectedSortingResults, Collections.reverseOrder(String.CASE_INSENSITIVE_ORDER));
        }   assertThat(expectedSortingResults, equalTo(actualList));


    }

    private List<String> getActualData(String field,List<TrafficOrderItemSendList.TrafficOrderItemSend> actualOrderItemOrder) {
        List<String> data = new ArrayList<>();
        if (field.equalsIgnoreCase("Last Comment")) {
            for (TrafficOrderItemSendList.TrafficOrderItemSend orderSendItem : actualOrderItemOrder)
                if(!orderSendItem.getLastComment().equalsIgnoreCase("-"))
                    data.add(orderSendItem.getLastComment());
        }
        if (field.equalsIgnoreCase("Clock Number")) {
            for (TrafficOrderItemSendList.TrafficOrderItemSend orderSendItem : actualOrderItemOrder)
                data.add(orderSendItem.getClockNumber());
        }
        return data;
    }
    @Then("I '$condition' see same '$field' for the orders with '$clockNumber' for repeated sends")
    public void checkArrivalDateForOrdersWithSameClock(String condition,String field,String clockNumber){
        TrafficOrderItemSendList trafficOrderItemSendList = getSut().getPageCreator().getTrafficOrderItemsListPage().getTrafficOrderItemsList();
        List<TrafficOrderItemSendList.TrafficOrderItemSend> trafficOrderList = trafficOrderItemSendList.getOrderByClockNumber(wrapPathWithTestSession(clockNumber));
        if(trafficOrderList.size()==2) {
            if (trafficOrderList.get(0).getDeliveryStatus().equals("Awaiting station release") && trafficOrderList.get(1).getDeliveryStatus().equals("Awaiting station release")) {
                DateTime arrivalDateFirstSend = new DateTime(trafficOrderList.get(0).getArrivalDate());
                DateTime arrivalDateSecondSend = new DateTime(trafficOrderList.get(1).getArrivalDate());
                assertThat("Arrival Date for repeated sends set incorrectly", arrivalDateSecondSend.isBefore(arrivalDateFirstSend));
            }

        }
    }

    @Then("I '$condition' see following fields in Order Item send list for Clock Number '$clockNumber':$data")
    public void checkOrderItemSendData(String condition, String clockNumber, ExamplesTable data) {
        String actual = null;
        TrafficOrderItemSendList trafficOrderItemSendList = getSut().getPageCreator().getTrafficOrderItemsListPage().getTrafficOrderItemsList();
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            List<TrafficOrderItemSendList.TrafficOrderItemSend> trafficOrderList = trafficOrderItemSendList.getOrderByClockNumber(wrapPathWithTestSession(clockNumber));
            for (Map.Entry<String, String> rowEntry : row.entrySet()) {
                switch (rowEntry.getKey()) {
                    case "Last Comment":
                        actual = trafficOrderList.get(0).getLastComment();
                        break;
                    case "Title":
                        actual = trafficOrderList.get(0).getTitle();
                        break;
                    case "Product":
                        actual = trafficOrderList.get(0).getProduct();
                        break;
                    case "Advertiser":
                        actual = trafficOrderList.get(0).getAdvertiser();
                        break;
                    case "Media Agency":
                        actual = trafficOrderList.get(0).getMediaAgency();
                        break;
                }
                Common.sleep(1000);
                if(rowEntry.getKey().equalsIgnoreCase("Last Comment")) {
                    assertThat("Check '" + rowEntry.getKey() + "' value on Traffic order Send list: ",
                            actual.equals((rowEntry.getValue())), is(condition.equalsIgnoreCase("should")));
                }else{
                    assertThat("Check '" + rowEntry.getKey() + "' value on Traffic order Send list: ",
                            actual.equals(wrapVariableWithTestSession(rowEntry.getValue())), is(condition.equalsIgnoreCase("should")));
                }
            }

        }
    }

    @Then("I '$condition' see order with Title '$title' in Order Item send list on searching based on the '$type' whose value is '$houseNo'")
    public void checkOrderItemHouseNumberData(String condition, String title,String type, String houseNo) {
        String actual = null;
        TrafficOrderItemSendList trafficOrderItemSendList = getSut().getPageCreator().getTrafficOrderItemsListPage().getTrafficOrderItemsList();
        List<TrafficOrderItemSendList.TrafficOrderItemSend> trafficOrderList = trafficOrderItemSendList.getOrderByTitle(wrapPathWithTestSession(title));
        getSut().getPageCreator().getTrafficOrderListPage().enterSearchCriteriaForParticularSchemaType(type, trafficOrderList.get(0).getHouseNo());
        Common.sleep(9000);
        List<TrafficOrderItemSendList.TrafficOrderItemSend> trafficOrderList1 = trafficOrderItemSendList.getOrderByTitle(wrapPathWithTestSession(title));
        actual = trafficOrderList1.get(0).getHouseNo();
        assertThat("House Number search doesn't work",
                actual.contains(houseNo), is(condition.equalsIgnoreCase("should")));
    }



    @Given("{I |}go to order item details page with clockNumber '$clockNumber' using destination '$destinationName'")
    @When("{I |}go to order item details page with clockNumber '$clockNumber' using destination '$destinationName'")
    @Then("{I |}go to order item details page with clockNumber '$clockNumber' using destination '$destinationName'")
    public void openOrderItemDetailOnTrafficPage_UsingQcassetId(String clockNumber,String destinationName){
        String orderId = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getId();
        OrderItem orderItem = getCoreApiAdmin().getOrderItemByClockNumber(orderId, wrapVariableWithTestSession(clockNumber));
        TrafficOrderItemsListPage page = getSut().getPageCreator().getTrafficOrderItemsListPage();
        List<TrafficOrderItemSendList.TrafficOrderItemSend> actualOrderItemOrder = new TrafficOrderItemSendList(getSut().getWebDriver()).getOrderSendItems();
        for(TrafficOrderItemSendList.TrafficOrderItemSend sendItem:actualOrderItemOrder){
            if(destinationName.equalsIgnoreCase(sendItem.getDestinationName())) {
                getSut().getWebDriver().getJavascriptExecutor().executeScript("arguments[0].click();", sendItem.getOrderReferenceLink());
                break;
            }
        }
    }

    @When("{I |}filter by date:$dateCriteria")
    public void filterByDate(ExamplesTable dateCriteria) {
        TrafficOrderItemsListPage orderList = getTrafficOrderItemListPage();
        orderList.clickFilterByDateSelector();
        Common.sleep(1000);
        getTrafficOrderItemListPage().filterByDate(parametrizeTabularRow(dateCriteria));
    }

    @When("{I |}edit filter by date:$dateCriteria")
    public void editFilterByDate(ExamplesTable dateCriteria) {
        TrafficOrderItemsListPage orderList = getTrafficOrderItemListPage();
        Common.sleep(1000);
        getTrafficOrderItemListPage().filterByDate(parametrizeTabularRow(dateCriteria));
    }

    @When("{I |}delete filter by date")
    public void delFilterByDate() {
        TrafficOrderItemsListPage orderList = getTrafficOrderItemListPage();
        orderList.delFilterDate();
    }

}
