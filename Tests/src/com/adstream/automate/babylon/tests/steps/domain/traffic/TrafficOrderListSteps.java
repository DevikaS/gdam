package com.adstream.automate.babylon.tests.steps.domain.traffic;

import au.com.bytecode.opencsv.CSVReader;
import com.adstream.automate.babylon.JsonObjects.ordering.DestinationItem;
import com.adstream.automate.babylon.JsonObjects.ordering.Order;
import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.sut.pages.traffic.*;
import com.adstream.automate.babylon.sut.pages.traffic.element.ApprovePopUp;
import com.adstream.automate.babylon.sut.pages.traffic.element.Comment;
import com.adstream.automate.babylon.sut.pages.traffic.element.ReassignOrdersInTraffic;
import com.adstream.automate.babylon.sut.pages.traffic.element.TrafficNewTabPopUp;
import com.adstream.automate.babylon.sut.pages.traffic.tableList.TrafficDestinationList;
import com.adstream.automate.babylon.sut.pages.traffic.tableList.TrafficOrderList;
import com.adstream.automate.babylon.sut.pages.traffic.tableList.TrafficOrderNestedList;
import com.adstream.automate.babylon.JsonObjects.ordering.OrderItem;
import com.adstream.automate.babylon.sut.pages.winium.ftp.desktop.WiniumFTPRemote;
import com.adstream.automate.babylon.tests.steps.core.GenericSteps;
import com.adstream.automate.utils.DateTimeUtils;
import org.apache.log4j.Logger;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;
import org.openqa.selenium.By;
import org.openqa.selenium.TimeoutException;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.WebElement;

import java.io.File;
import java.io.FileReader;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import static org.hamcrest.core.Is.is;


/**
 * Created by denysb on 10/11/2015.
 */
public class TrafficOrderListSteps extends TrafficHelperSteps {

    protected final static Logger log = Logger.getLogger(TrafficOrderListSteps.class);
    private final static long statusReplicationToTrafficAsGDN = 60 * 9000; //9min

    public TrafficOrdersListPage getTrafficOrderListPage() {
        return getSut().getPageCreator().getTrafficOrderListPage();
    }

    public TrafficClockDetailsPage getTrafficClockDetailsPage() {
        return getSut().getPageCreator().getTrafficClockDetailsPage();
    }

    public TrafficOrderList getTrafficOrderList() {
        return getTrafficOrderListPage().getTrafficOrderList();
    }

    public TrafficOrderNestedList getTrafficOrderNestedList() {
        return getTrafficOrderList().getTrafficOrderNestedList();
    }

    public TrafficDestinationList getTrafficDestinationList() {
        return getTrafficOrderList().getTrafficOrderNestedList().getTrafficDestinationList();
    }

    @Given("{I |}on Traffic Order List page")
    @When("{I |}open Traffic Order List page")
    @Then("{I |}open Traffic Order List page")
    public TrafficOrdersListPage openTrafficOrderListPage() {
        return getSut().getPageNavigator().getOrdersListPage();
    }

    @Given("{I |}expanded all orders on Traffic Order List page")
    @When("{I |}expand all orders on Traffic Order List page")
    @Then("{I |}expand all orders on Traffic Order List page")
    public void expandOrdersOnTrafficOrderListPage() {
        getSut().getPageNavigator().getTrafficOrderListPage().expandAll();
    }

    @When("{I |}click expand button for orderItem in Traffic List with clockNumber '$clockNumber'")
    public void clickExpandButtonForOrderItem(String clocknumber) {
        try {
            TrafficOrderNestedList.TrafficOrderItem orderItem = getTrafficOrderNestedList().getTrafficOrderItemByClockNumber(wrapVariableWithTestSession(clocknumber));
            orderItem.getExpand();
        } catch (NullPointerException e) {
            throw new NullPointerException("Order with Clock Number" + clocknumber + " was not found");
        }
    }

    @Given("{I |}entered search criteria '$data' in simple search form on Traffic Order List page")
    @When("{I |}enter search criteria '$data' in simple search form on Traffic Order List page")
    @Then("{I |}enter search criteria '$data' in simple search form on Traffic Order List page")
    public void fillSimpleSearchFormOnTrafficOrderListPage(String data) {
        getSut().getPageCreator().getTrafficOrderListPage().enterSearchCriteria(wrapVariableWithTestSession(data));
    }

    @Given("{I |}select all from dropdown on Traffic Order List page")
    @When("{I |}select all from dropdown on Traffic Order List page")
    public void selectAllOnTrafficOrderListPage() {
        getSut().getPageCreator().getTrafficOrderListPage().selectAll();
    }

    @When("{I |}select all from list view at '$type' level on traffic list page")
    public void checkboxSelectAllFromListView(String type) {
        if (type.equalsIgnoreCase("Clock")) {
            getSut().getPageCreator().getTrafficOrderListPage().checkboxSelectAllAtClockLevel();
        } else if (type.equalsIgnoreCase("Send")) {
            getSut().getPageCreator().getTrafficOrderListPage().checkboxSelectAllAtSendLevel();
        }
    }

    @When("{I |}select the following orders on traffic order list:$data")
    public void selectOrder(ExamplesTable data)
    {
        TrafficOrdersListPage trafficListPage = getTrafficOrderListPage();
        TrafficOrderList trafficOrderList = trafficListPage.getTrafficOrderList();
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> map = parametrizeTabularRow(data, i);
            String orderRefference = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(map.get("clockNumber"))).getOrderReference().toString();
            TrafficOrderList.TrafficOrder order = trafficOrderList.getOrderByOrderReference(orderRefference);
            order.selectOrder();
        }
    }

    @When("{I |}click on button '$button' on traffic list page")
    public void clickAppButton(String button) {
        TrafficOrdersListPage orderList = getTrafficOrderListPage();
        getSut().getWebDriver().sleep(3000);
        orderList.clickApprovalButtons(button);
    }


    @When("{I |}select following clocks from list view on traffic list page:$clockList")
    public void selectDestionFromListView(ExamplesTable clockList) {
        for (int i = 0; i < clockList.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(clockList, i);
            TrafficOrderNestedList.TrafficOrderItem tr = getTrafficOrderNestedList().getTrafficOrderItemByClockNumber(wrapVariableWithTestSession(row.get("Clock")));
            tr.selectOrder();
        }


    }

    @Then("{I |}should see the approval buttons '$buttons' on traffic list page")
    public void verifyPresenceOfApprovalButtons(String expButtons) {
        List<String> actuallistOfApprovalButtons = getSut().getPageCreator().getTrafficOrderListPage().getApprovalButtons();
        for (String expBtn : expButtons.split(","))
            assertThat(actuallistOfApprovalButtons, hasItem(expBtn.trim()));
    }


    @Given("{I |}filled the following fields on approval traffic pop up on list page:$data")
    @When("{I |}fill the following fields on approval traffic pop up on list page:$data")
    public void fillApprovalDataForOrderItem(ExamplesTable data) {
        ApprovePopUp popup = getTrafficOrderListPage().getApprovePopUpPage();
        for (Map<String, String> row : parametrizeTableRows(data)) {

            if (row.containsKey("DeselectDestination")) {

                for (String dest : row.get("DeselectDestination").split(",")) {
                    popup.unSelectDestination(wrapVariableWithTestSession(dest));
                }
            }
            if (row.get("Email") != null)
                row.put("Email", wrapUserEmailWithTestSession(row.get("Email")));
            popup.fillApprovalForm(row);
        }
        popup.clickSaveButton();

    }

    @Then("{I |}'$condition' see the destination '$destination' unselected")
    public void VerifyIsDestinationUnselected(String condition, String destination) {
        ApprovePopUp popup = getTrafficOrderListPage().getApprovePopUpPage();
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = popup.verifyIsDestinationUnselected(destination);
        assertThat(actualState, is(expectedState));

    }

    @Then("{I |}'$condition' see '$destination' with clock '$clockNumber'")
    @When("{I |}'$condition' see '$destination' with clock '$clockNumber'")
    public void selectDestination(String condition,String destination,String clockNumber) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        ApprovePopUp popup = getTrafficOrderListPage().getApprovePopUpPage();
        boolean actualState =popup.verifyDestinationWithClock(destination, wrapVariableWithTestSession(clockNumber));
        assertThat(actualState, is(expectedState));
    }

    @When("{I |}should see destination '$destination' for cloned order item with clockNumber '$clockNumber' in traffic order list that have following data:$data")
    @Then("{I |}should see destination '$destination' for cloned order item with clockNumber '$clockNumber' in traffic order list that have following data:$data")
    public void checkDestinationDetailsForClones(String destinationName, String clockNumber, ExamplesTable data) {

        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            TrafficOrdersListPage orderList = getTrafficOrderListPage();
            if (row.containsKey("Broadcaster Approval Status")) {
                assertThat("Broadcaster Approval Status", orderList.verifyDestinationDetailsForClones(destinationName, "Broadcaster Approval Status"), equalTo(row.get("Broadcaster Approval Status")));
            }
        }
    }

    @Given("{I |}clicked on '$downloadType' link on Traffic Order List page")
    @When("{I |}click on '$downloadType' link on Traffic Order List page")
    @Then("{I |}click on '$downloadType' link on Traffic Order List page")
    public void clickDownloadCSVLink(String downloadCSV) {
        if (downloadCSV.equals("DownloadCSV")) {
            getSut().getPageCreator().getTrafficOrderListPage().clickDownloadCSVLink();
        }
    }


    @Given("{I |}cleared search criteria in simple search form on Traffic Order List page")
    @When("{I |}clear search criteria in simple search form on Traffic Order List page")
    @Then("{I |}clear search criteria in simple search form on Traffic Order List page")
    public void clearSimpleSearchFormOnTrafficOrderListPage() {
        getSut().getPageCreator().getTrafficOrderListPage().clearSearchCriteria();
    }

    //searchTypes = "Title", "Advertiser", "Product", "Clock Number", "House Number"
    @Given("{I |}selected exact search by '$searchType' field and entered search criteria '$data' in simple search form on Traffic Order List page")
    @When("{I |}select exact search by '$searchType' field and search criteria '$data' in simple search form on Traffic Order List page")
    @Then("{I |}select exact search by '$searchType' field and search criteria '$data' in simple search form on Traffic Order List page")
    public void fillSimpleSearchFormForPaticularSchemaTypeInTraffic(String searchType, String data) {
        getSut().getPageCreator().getTrafficOrderListPage().enterSearchCriteriaForParticularSchemaType(searchType,
                data.equals("NCS") || data.equals("CS") || data.equals("ECS") ? data : wrapVariableWithTestSession(data));
    }

    @When("{I |}select all from list view in Traffic UI")
    public void selectAll() {
        getSut().getPageCreator().getTrafficOrderListPage().clickAllOption();

    }

    @When("{I |}click on '$button' button in Traffic order list page")
    public void clickButtonOnTrafficOrderListPage(String button)
    {
        getSut().getPageCreator().getTrafficOrderListPage().clickCommonButtons(button);
    }

    @Then("{I |}'$condition' see '$button' button in Traffic order list page")
    public void verifyButtonOnTrafficOrderListPage(String condition,String button)
    {
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getTrafficOrderListPage().verifyCommonButtons(button);
        assertThat(actualState, shouldState ?
                is(true) : is(false));
    }
    @Then("{I |}'$condition' see '$button' button in Traffic order details page")
    public void verifyButtonOnTrafficOrderDetailsPage(String condition,String button)
    {
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getTrafficOrderPage().verifyCommonButtons(button);
        assertThat(actualState, shouldState ? is(true) : is(false));
    }



    @Then("{I |}'$condition' see '$button' button at broadcaster level")
    public void verifyButtonOnOrderDetailsPage(String condition,String button)
    {
        boolean shouldState = condition.equalsIgnoreCase("should");
        TrafficOrdersListPage page = getTrafficOrderListPage();
        boolean actualState=page.verifyButtonsatBroadcasterLevel(button);
        assertThat(actualState, shouldState ? is(true) : is(false));
    }

    @Then("{I |}should see house number grouped on traffic order list page:$groupHouseNumber")
    public void verifyHouseNumberGroupingOnOrderListPage(ExamplesTable groupHouseNumber) {
        TrafficOrdersListPage orderList = getTrafficOrderListPage();
        for (int i = 0; i < groupHouseNumber.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(groupHouseNumber, i);
            if (row.get("House Number").isEmpty()) {
                String actualHouseNumber = orderList.verifyHouseNumberGroupingOnOrderListPage(row.get("Destination"));
                assertThat("Check House Number Grouping", null, equalTo(actualHouseNumber));
            } else {
                String actualHouseNumber = orderList.verifyHouseNumberGroupingOnOrderListPage(row.get("Destination"));
                assertThat("Check House Number Grouping", wrapVariableWithTestSession(row.get("House Number")), equalTo(actualHouseNumber));
            }

        }
    }


    @Then("{I |}should see the service level text colored for ClockNumber $clockNumber:$fields")
    public void verifyColor(String clockNumber, ExamplesTable fields) {
        String actualServiceLevelStatus = "";
        List<TrafficOrderNestedList.TrafficOrderItem> orderItems = getTrafficOrderNestedList().getTrafficOrderItemsByClockNumber(wrapVariableWithTestSession(clockNumber));
        for (TrafficOrderNestedList.TrafficOrderItem orderItem : orderItems) {
            for (int i = 0; i < fields.getRowCount(); i++) {
                Map<String, String> row = parametrizeTabularRow(fields, i);
                String expectedServiceLevelColor = row.get("Color");
                boolean shouldstate = row.get("Condition").equalsIgnoreCase("should");
                orderItem.getExpand();
                try {
                    TrafficDestinationList listpage = getTrafficDestinationList();
                    TrafficDestinationList.TrafficDestination destination = listpage.getDestinationByName(row.get("Destination"), wrapVariableWithTestSession(row.get("Destination")), orderItem);
                    if (destination == null)
                        continue;
                    actualServiceLevelStatus = destination.getServiceLevelTextColor(row.get("Service Level Text"));
                } catch (NullPointerException n) {
                    throw new NullPointerException("Destination " + row.get("Destination") + " is absent");
                }
                assertThat(actualServiceLevelStatus, shouldstate ? is(expectedServiceLevelColor) : not(is(expectedServiceLevelColor)));
            }

        }
    }

    @Then("{I |}'$condition' see '$button' button in clock details page")
    public void verifyButtonOnTrafficClockDetailsPage(String condition,String button)
    {
        TrafficClockDetailsPage clkDetails = getTrafficClockDetailsPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        String[] buttons = button.split(",");
        for (String element : buttons) {
            boolean actualState = clkDetails.verifyCommonButtons(element);
            assertThat(actualState, shouldState ? is(true) : is(false));
        }
    }

    @When("{I |}get traffic order item by clockNumber '$data'")
    public void getTrafficOrderItemByClockNumber(String data) {
        TrafficOrderNestedList.TrafficOrderItem tr = getTrafficOrderNestedList().getTrafficOrderItemByClockNumber(wrapVariableWithTestSession(data));
        String clock = tr.getClockNumber();
    }


    @When("{I |}'$visibility' order item table items:$itemList")
    public void hideItemsInOrderItemTable(String visibility,ExamplesTable itemList) {
        TrafficOrdersListPage orderList = getTrafficOrderListPage();
        orderList.clickConfigureOrderItemTab();
        for (int i = 0; i < itemList.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(itemList, i);
            orderList.hideItemsForOrderItemTable(visibility,row.get("Item Name"));

        }
        orderList.closePopup();
    }

    @Then("{I |}'$condition' see the items on order item table:$items")
    public void verifyOrderItemTableItems(String condition, ExamplesTable items) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        TrafficOrdersListPage orderList = getTrafficOrderListPage();
        List<String> listOfItems = orderList.verifyItemsForOrderItemTable();
        for (int i = 0; i < items.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(items, i);
            assertThat("Check list of Order Item Table Items:", listOfItems, shouldState ? hasItem(row.get("Item Name")) : not(hasItem(row.get("Item Name"))));
        }
    }


    @When("{I |}'$visibility' order table items:$itemList")
    public void hideItemsInOrderTable(String visibility,ExamplesTable itemList) {
        TrafficOrdersListPage orderList = getTrafficOrderListPage();
        orderList.clickConfigureOrderTab();
        for (int i = 0; i < itemList.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(itemList, i);
            orderList.hideItemsForOrderTable(visibility,row.get("Item Name"));
        }
        orderList.clickConfigureOrderTabSaveButton();
    }


    @Then("{I |}'$condition' see the items on order table:$items")
    public void verifyOrderTableItems(String condition, ExamplesTable items) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        TrafficOrdersListPage orderList = getTrafficOrderListPage();
        List<String> listOfItems = orderList.verifyItemsForOrderTable();
        for (int i = 0; i < items.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(items, i);
            assertThat("Check list of Order Table Items:", listOfItems, shouldState ? hasItem(row.get("Item Name")) : not(hasItem(row.get("Item Name"))));
        }
    }

    @Then("{I |} should see ClosedCaption icon $fields")
    public void getTrafficOrderItemByClockNumber(ExamplesTable fields) {
        for (int i = 0; i < fields.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fields, i);
            String clockNumber = row.get("clockNumber");
            String condition = row.get("ShouldSee");
            if (clockNumber != null) {
                String orderId = getCoreApiAdmin().getOrderByItemClockNumber(clockNumber).getId();
                if (orderId == null) {
                    throw new NullPointerException("Order with clocknumber " + clockNumber + " was not found");
                }
                TrafficOrderList trafficOrderList = getSut().getPageCreator().getTrafficOrderListPage().getTrafficOrderList();
                String reference = String.valueOf(getCoreApiAdmin().getOrderByItemClockNumber(clockNumber).getOrderReference());
                if (reference == null)
                    throw new NullPointerException("There is no reference for clockNumber : " + clockNumber);
                Common.sleep(5000);
                TrafficOrderList.TrafficOrder trafficOrder = trafficOrderList.getOrderByOrderReference(reference);
                if (condition != null) {
                    boolean expectedState = condition.equalsIgnoreCase("should");
                    boolean actualState = trafficOrder.closedCaptionCheck();
                    assertThat(actualState, is(expectedState));
                }
            }
        }
    }

    @Then("{I |}'$should' see below information on traffic order page for clock '$clockNumber':$fields")
    public void getTrafficOrderDetailsByClockNumber(String condition, String clockNumber, ExamplesTable fields) {
        if (clockNumber != null) {
            String orderId = getCoreApiAdmin().getOrderByItemClockNumber(clockNumber).getId();
            if (orderId == null) {
                throw new NullPointerException("Order with clocknumber " + clockNumber + " was not found");
            }
        }
        TrafficOrderList trafficOrderList = getSut().getPageCreator().getTrafficOrderListPage().getTrafficOrderList();
        String reference = String.valueOf(getCoreApiAdmin().getOrderByItemClockNumber(clockNumber).getOrderReference());
        if (reference == null)
            throw new NullPointerException("There is no reference for clockNumber : " + clockNumber);
        fillSimpleSearchFormOnTrafficOrderListPage(clockNumber);
        TrafficOrderList.TrafficOrder trafficOrder = trafficOrderList.getOrderByOrderReference(reference);
        for (int i = 0; i < fields.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fields, i);
            for (Map.Entry<String, String> rowEntry : row.entrySet()) {
                assertThat("Check '" + rowEntry.getKey() + "' value on Traffic order page for clockNumber: " + wrapVariableWithTestSession(clockNumber),
                        trafficOrder.getFieldValue(rowEntry.getKey()).equals(rowEntry.getValue()), is(condition.equalsIgnoreCase("should")));
            }
        }
    }

    @When("{I |}fill '$houseNumber' House Number for order item with '$clockNumber' clock number on traffic order list")
    public void fillHouseNumberForOrderItem(String houseNumber, String clockNumber) {
        TrafficOrderNestedList.TrafficOrderItem tr = getTrafficOrderNestedList().getTrafficOrderItemByClockNumber(wrapVariableWithTestSession(clockNumber));
        tr.getExpand();
        Common.sleep(2000);
        TrafficDestinationList listpage = getTrafficDestinationList();
        List<TrafficDestinationList.TrafficDestination> destinations = listpage.getDestinationsForOrderItem(tr);
        destinations.get(0).fillHouseNumberFieldWithValue(wrapVariableWithTestSession(houseNumber));
    }

    @Given("{I |} fill in House Number for order items in Traffic UI: $fields")
    @When("{I |}fill in House Number for order items in Traffic UI: $fields")
    public void fillHouseNumberForClock(ExamplesTable fields) {
        for (int i = 0; i < fields.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fields, i);
            getTrafficOrderListPage().waitUntilPageWillBeLoaded(4000);
            TrafficOrderNestedList.TrafficOrderItem tr = getTrafficOrderNestedList().getTrafficOrderItemByClockNumber(wrapVariableWithTestSession(row.get("clockNumber")));
            tr.getExpand();
            TrafficDestinationList listpage = getTrafficDestinationList();
            List<TrafficDestinationList.TrafficDestination> destinations = listpage.getDestinationsForOrderItem(tr);
            Common.sleep(2000);
            destinations.get(0).fillHouseNumber(row.get("HouseNumber").equals("NCS") ||
                    row.get("HouseNumber").equals("CS") ||
                    row.get("HouseNumber").equals("ECS") ? row.get("HouseNumber")
                    : wrapVariableWithTestSession(row.get("HouseNumber")));
        }
        Common.sleep(1000);
    }

    @When("{I |}get order items with Clock Number '$data'")
    public void getOrderItemsByClockNumber(String data) {
        getTrafficOrderNestedList().getOrderItemByOrderReference(getCoreApiAdmin().getOrderByItemClockNumber(data).getOrderReference().toString());
    }

    @Given("{I |}opened edit page for order with Clock Number '$data' in Traffic")
    @When("{I |}open edit page for order with Clock Number '$data' in Traffic")
    @Then("{I |}open edit page for order with Clock Number '$data' in Traffic")
    public void openEditPageforOrderInTraffic(String data) {
        long start = System.currentTimeMillis();
        String orderId = getCoreApiAdmin().getOrderByItemClockNumber(data).getId();
        if (orderId == null) {
            throw new NullPointerException("Order with clocknumber " + data + " was not found");
        }
        getSut().getPageCreator().getTrafficOrderListPage().openOrderEditPage(orderId);
        //openEditPageforOrderInTrafficWithWaitingForProperPage(data, orderId, start);//workaround for NGN-17503
    }

    @Given("{I |}opened edit page for orderitem with Clock Number '$data' in Traffic")
    @When("{I |}open edit page for orderitem with Clock Number '$data' in Traffic")
    @Then("{I |}open edit page for orderitem with Clock Number '$data' in Traffic")
    public void openEditPageforOrderInTrafficusingOrderitem(String data) {
        long start = System.currentTimeMillis();
        String orderId = getCoreApiAdmin().getOrderByItemClockNumber(data).getId();
        String orderItemId = getCoreApiAdmin().getOrderItemByClockNumber(orderId,wrapVariableWithTestSession(data)).getId();
        if (orderId == null) {
            throw new NullPointerException("Order with clocknumber " + data + " was not found");
        }
        getSut().getPageCreator().getTrafficOrderListPage().openOrderEditPagewithOrderItemId(orderId,orderItemId);
        //openEditPageforOrderInTrafficWithWaitingForProperPage(data, orderId, start);//workaround for NGN-17503
    }


    @When("{I |}select order item with following clock number '$clockNumber' on Edit order page")
    public void selectOrderItemByClockNumberInCoverFlow(String data)
    {
        String orderId = getCoreApiAdmin().getOrderByItemClockNumber(data).getId();
        if (orderId == null) {
            throw new NullPointerException("Order with clocknumber " + data + " was not found");
        }
        String orderItemId = getCoreApiAdmin().getOrderItemByClockNumber(orderId, wrapVariableWithTestSession(data)).getId();
        if (orderItemId == null)
            throw new NullPointerException("Order item was not found by following clock number: " + data + " for order with id: " + orderId);
        getSut().getPageCreator().getOrderItemPage().selectOrderItemInCoverFlowById(orderItemId);
    }

 /*   public void openEditPageforOrderInTrafficWithWaitingForProperPage(String data, String orderId, Long start) {
        if (getSut().getWebDriver().getCurrentUrl().contains("summary")) {
            if (System.currentTimeMillis() - start > 90000) {
                throw new TimeoutException("Timeout during waiting order edit page in Traffic!");
            }
            openTrafficOrderListPage();
            selectParticularTab("All");
            getSut().getPageCreator().getTrafficOrderListPage().openOrderEditPage(orderId);
            //openEditPageforOrderInTrafficWithWaitingForProperPage(data, orderId, start);
        }
    }*/


    //Send clockNumber that will be converted in OrderRefference
    @Given("{I |}entered orderReference '$data' in simple search form on Traffic Order List page")
    @When("{I |}enter orderReference '$data' in simple search form on Traffic Order List page")
    public void fillSimpleSearchFormWithOrderReferenceOnTrafficOrderListPage(String data) {
        String orderRefference = getCoreApiAdmin().getOrderByItemClockNumber(data).getOrderReference().toString();
        getSut().getPageCreator().getTrafficOrderListPage().enterSearchCriteria(orderRefference);
    }

    @Given("{I |} add comment for following orders:$data")
    public void checkColumnInTrafficUI(ExamplesTable data) {
        TrafficOrderList trafficOrderList = getTrafficOrderList();
        TrafficOrdersListPage orderList = getTrafficOrderListPage();
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> map = parametrizeTabularRow(data, i);
            String reference = String.valueOf(getCoreApiAdmin().getOrderByItemClockNumber(map.get("clockNumber")).getOrderReference());
            TrafficOrderList.TrafficOrder trafficOrder = trafficOrderList.getOrderByOrderReference(reference);
            trafficOrder.selectOrder();
            orderList.clickAddComment().getCommentPage().addComment(map.get("comment"));
            trafficOrder.deselectOrder();
        }
    }

    @Given("{I |}selected '$data' tab in Traffic UI")
    @When("{I |}select '$data' tab in Traffic UI")
    public void selectParticularTab(String data) {
        getSut().getPageCreator().getTrafficOrderListPage().selectTab(data);
    }

    @When("{I |}delete the tab")
    public void deleteTab() {
        TrafficOrdersListPage page = getTrafficOrderListPage();
        page.deleteTab();
    }

    @Given("{I |}opened order details with clockNumber '$clockNumber' from Traffic UI")
    @When("{I |}open order details with clockNumber '$clockNumber' from Traffic UI")
    public void openOrderDetailsPage(String clockNumber) {
        Order order = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
        if (order == null) {
            throw new NullPointerException("Order with clockNumber: " + clockNumber + " wans't found");
        }
        getSut().getPageCreator().getTrafficOrderListPage().openOrderDetailsPage(order.getId());
    }

    @When("{I |} add comment '$Comment' on order details page for clockNumber '$clockNumber'")
    public void addCommentOnOrderDetailsPage(String Comment, String clockNumber) {

        TrafficOrderPage page = getSut().getPageCreator().getTrafficOrderPage();
        Comment commentPopUp = page.clickAddCommentOnOrderDetailsPage();
        commentPopUp.addComment(Comment);
    }

    // $fieldName should be one of the following items: mediaAgency, orderItemServiceLevel, title, clockNumber
    @When("{I |}sort Order Items by field '$sortField' in order '$order' from Traffic UI")
    public void sortPresentationList(String sortField, String order) {
        TrafficOrdersListPage page = getTrafficOrderListPage();
        boolean fieldSelected = page.isSortFieldSelected(sortField);
        String orderType = page.getSortFieldOrder(sortField);
        if (sortField.equalsIgnoreCase("Submitted Date")) {
            if (order.equalsIgnoreCase("asc")) {
                page.clickOnSortFieldTitle(sortField);
                waitTillOrderListWillBeLoaded();
            } else {
                page.clickOnSortFieldTitle(sortField);
                page.clickOnSortFieldTitle(sortField);
                waitTillOrderListWillBeLoaded();
            }
        } else {
            if (!fieldSelected || !orderType.equals(order)) {
                page.clickOnSortFieldTitle(sortField);
                waitTillOrderListWillBeLoaded();
                orderType = page.getSortFieldOrder(sortField);
                waitTillOrderListWillBeLoaded();
                if (!orderType.equals(order)) {
                    page.clickOnSortFieldTitle(sortField);
                    waitTillOrderListWillBeLoaded();
                }
            }
        }
    }

    @Given("{I |}created Tab in Traffic with name '$name' and type '$type' and dataRange '$Today'")
    @When("{I |}create Tab in Traffic with name '$name' and type '$type' and dataRange '$Today'")
    public void createNewTabInTraffic(String name, String type, String dataRange) {
        TrafficNewTabPopUp popup = getSut().getPageCreator().getTrafficOrderListPage().openNewTabPopUpWindow();
        popup.fillNameAndTypeForNewTrafficTab(name, type, dataRange);
    }

    @When("{I |} add comment '$Comment' on order item details page for clockNumber '$clockNumber'")
    public void addCommentOnOrderItemDetailsPage(String Comment, String clockNumber) {

        TrafficOrderItemPage page = getSut().getPageCreator().getTrafficOrderItemPage();
        Comment commentPopUp = page.clickAddCommentOnOrderItemDetailsPage();
        commentPopUp.addComment(Comment);
    }

    @When("{I |} add comment '$Comment' at tab level for clockNumber '$clockNumber'")
    public void addCommentAtTabLevel(String Comment, String clockNumber) {

        TrafficOrderItemPage page = getSut().getPageCreator().getTrafficOrderItemPage();
        page.checkInputBox();
        Comment commentPopUp = page.clickAddCommentOnOrderItemDetailsPage();
        commentPopUp.addComment(Comment);
    }

    @Given("{I |}click on back button")
    @When("{I |}clicked on back button")
    public void clickBackButton() {
        TrafficOrderItemPage page = getSut().getPageCreator().getTrafficOrderItemPage();
        page.clickBackButtonButtonOnTrafficOrderItemPage();
    }

    @Given("{I |}waited till order with clockNumber '$clockNumber' will be available in Traffic")
    @When("{I |}wait till order with clockNumber '$clockNumber' will be available in Traffic")
    public void waitTillOrderWillBeInTraffic(String clockNumber) {
        String orderId = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getId();
        OrderItem orderItem = getCoreApiAdmin().getOrderItemByClockNumber(orderId, wrapVariableWithTestSession(clockNumber));
        waitForFinishPlaceOrderFromA4ToTraffic(orderItem.getId(), orderItem.getQCAssetId(), 2000);
    }

    @Given("{I |}waited till order with clockNumber '$clockNumber' will have next status '$status' in Traffic")
    @When("{I |}wait till order with clockNumber '$clockNumber' will have next status '$status' in Traffic")
    public void waitTillOrderWillHaveParticularStatusInTraffic(String clockNumber, String status) {
        String orderId = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getId();
        OrderItem orderItem = getCoreApiAdmin().getOrderItemByClockNumber(orderId, wrapVariableWithTestSession(clockNumber));
        waitForOrderWillHaveParticularStatusInTraffic(orderItem.getId(), orderItem.getQCAssetId(), status, 2000);
    }

    @Given("{I |}waited till order item with clockNumber '$clockNumber' will have next status for '$status' in Traffic")
    @When("{I |}wait till order item with clockNumber '$clockNumber' will have next status '$status' in Traffic")
    public void waitTillOrderItemWillHaveParticularDeliveryStatusInTraffic(String clockNumber, String status) {
        String orderId = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getId();
        OrderItem orderItem = getCoreApiAdmin().getOrderItemByClockNumber(orderId, wrapVariableWithTestSession(clockNumber));
        waitForOrderItemWillHaveParticularStatusInTraffic(orderItem.getId(), orderItem.getQCAssetId(), status, 2000);
    }

    @Given("{I |}waited till order list will be loaded")
    @When("{I |}wait till order list will be loaded")
    public void waitTillOrderListWillBeLoaded() {
        getTrafficOrderListPage().waitUntilPageWillBeLoaded(7000);
    }

    @Given("{I |}waited till cloned order with clockNumber '$clockNumber' will have broadcaster status '$status' in Traffic for destination '$destination'")
    @When("{I |}wait till cloned order with clockNumber '$clockNumber' will have broadcaster status '$status' in Traffic for destination '$destination'")
    public void waitTillClonedOrderWillHaveParticularBroadcasterStatusInTraffic(String clockNumber, String status, String destination) {
        String orderId = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getId();
        OrderItem orderItem = getCoreApiAdmin().getOrderItemByClockNumber(orderId, wrapVariableWithTestSession(clockNumber));
        String qcAssetId = null;
        for (int i = 0; i < orderItem.getDestinationItems().length; i++) {
            if (destination.equalsIgnoreCase(String.valueOf(orderItem.getDestinationItems()[i].getName()))) {

                qcAssetId = orderItem.getDestinationItems()[i].getQcAssetId();
                break;

            }
        }
        waitForOrderItemWillHaveParticularBroadcasterStatusInTraffic(orderItem.getId(), qcAssetId, status, 2000);
    }

    @Given("{I |}waited till order item with clockNumber '$clockNumber' will have broadcaster status '$status' in Traffic")
    @When("{I |}wait till order item with clockNumber '$clockNumber' will have broadcaster status '$status' in Traffic")
    public void waitTillOrderItemWillHaveParticularBroadcasterStatusInTraffic(String clockNumber, String status) {
        String orderId = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getId();
        OrderItem orderItem = getCoreApiAdmin().getOrderItemByClockNumber(orderId, wrapVariableWithTestSession(clockNumber));
        waitForOrderItemWillHaveParticularBroadcasterStatusInTraffic(orderItem.getId(), orderItem.getQCAssetId(), status, 5000);
    }

    @Given("{I |}waited till order item with clockNumber '$clockNumber' will have dubbing service '$destination' with status '$status' in Traffic")
    @When("{I |}wait till order item with clockNumber '$clockNumber' will have dubbing service '$destination' with '$status' in Traffic")
    public void waitTillOrderItemWillHaveParticularAdditionalServicesStatusInTraffic(String clockNumber, String destination,String status) {
        String orderId = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getId();
        OrderItem orderItem = getCoreApiAdmin().getOrderItemByClockNumber(orderId, wrapVariableWithTestSession(clockNumber));
        waitForOrderItemWillHaveParticularAdditionalServicesStatusInTraffic(orderItem.getId(), orderItem.getQCAssetId(),wrapPathWithTestSession(destination), status, "dubbing", 5000);
    }

    @Given("{I |}waited till order item with clockNumber '$clockNumber' will have broadcaster status '$status' in Traffic for destination '$destination'")
    @When("{I |}wait till order item with clockNumber '$clockNumber' will have broadcaster status '$status' in Traffic for destination '$destination'")
    public void waitTillOrderItemWillHaveParticularBroadcasterStatusInTrafficForDestination(String clockNumber, String status, String destination) {
        String orderId = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getId();
        OrderItem orderItem = getCoreApiAdmin().getOrderItemByClockNumber(orderId, wrapVariableWithTestSession(clockNumber));
        waitForOrderItemWillHaveParticularBroadcasterStatusInTrafficForDestination(orderItem.getId(), orderItem.getQCAssetId(), status, 2000, destination);
    }

    @When("{I |}wait till order item with clockNumber '$clockNumber' will have A5 view status '$status' in Traffic")
    public void waitTillOrderItemWillHaveParticularA5StatusInTraffic(String clockNumber, String status) {
        String orderId = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getId();
        OrderItem orderItem = getCoreApiAdmin().getOrderItemByClockNumber(orderId, wrapVariableWithTestSession(clockNumber));
        waitForOrderItemWillHaveParticularA5ViewStatusInTraffic(orderItem.getId(), orderItem.getQCAssetId(), status, 2000);
    }

    @Given("{I |}waited till order item with clockNumber '$clockNumber' with destination '$destination' will have the next Destination Status '$status' in Traffic")
    @When("{I |}wait till order item with clockNumber '$clockNumber' with destination '$destination' will have the next Destination Status '$status' in Traffic")
    public void waitTillOrderItemWillHaveParticularDestinationStatusInTraffic(String clockNumber, String destinationName, String status) {
        String orderId = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getId();
        OrderItem orderItem = getCoreApiAdmin().getOrderItemByClockNumber(orderId, wrapVariableWithTestSession(clockNumber));
        waitTillOrderItemWillHaveParticularDestinationStatusInTraffic(orderItem.getId(), orderItem.getQCAssetId(), wrapVariableWithTestSession(destinationName), status, 2000);
    }

    @Then("{I |}'$condition' see destinations '$destinationName' for order item in Traffic List with clockNumber '$clocknumber' at broadcaster level")
    public void isDestinationAvailableForTrafficOrderAtBroadcasterLevel(String condition, String destinationName, String data){
        String[] expectedDestinations = destinationName.split(",");
        List<String> actualDestinations = new ArrayList<>();
        List<TrafficOrderNestedList.TrafficOrderItem> orderItems = getTrafficOrderNestedList().getTrafficOrderItemsByClockNumber(wrapVariableWithTestSession(data));
        boolean shouldstate = condition.equalsIgnoreCase("should");
        for (TrafficOrderNestedList.TrafficOrderItem orderItem : orderItems) {
            if (!orderItem.isOrderExpanded()) {
                orderItem.getExpand();
                Common.sleep(2000);
            }
            TrafficDestinationList listpage = getTrafficDestinationList();
            List<TrafficDestinationList.TrafficDestination> destinations = listpage.getDestinationsForOrderItem(orderItem);
            try {
                for (int i = 0; i < destinations.size(); i++) {
                    actualDestinations.add(destinations.get(i).getDestinationName());
                }
            } catch (ArrayIndexOutOfBoundsException e) {
                System.out.println("Destinations for Orderitem " + orderItem.getClockNumber() + " are absent or selector is wrong");
            }
        }
        assertThat(actualDestinations, shouldstate ? hasItem(expectedDestinations[0]) : not(hasItem(expectedDestinations[0])));


    }

    @Then("{I |}'$condition' see order '$order' in order list at Traffic UI")
    public void getAvailableOrdersFromTrafficOrderList(String condition, String order) {
        List<String> orders = getSut().getPageCreator().getTrafficOrderListPage().getOrderList();
        boolean shouldState = condition.equalsIgnoreCase("should");
        for (String value : order.split(",")) {
            String orderId;
            try {
                orderId = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(value)).getId();
            } catch (NullPointerException e) {
                throw new NullPointerException("order with clockNumber " + order + " wasn't found in A5");
            }
            assertThat(orders, shouldState ? hasItem(orderId) : not(hasItem(orderId)));
        }
    }


    @Then("{I |}should see that '$data' are sorted by '$field' field and '$order' order in Traffic")
    public void checkSortingInOrderItemList(String type, String field, String order) {
        List<String> actualList = new ArrayList<>();
        TrafficOrdersListPage page = getTrafficOrderListPage();
        actualList = page.getTrafficOrderList().getfieldValues(field);
        List<String> expectedSortingResult = expectedSortingResults(field, actualList, order, type);
        assertThat(expectedSortingResult, equalTo(actualList));
    }


    @Then("{I |}'$condition' see that On Hold status was updated to value '$value' for order with ClockNumber '$data'")
    public void checkThatOnHoldWasUpdated(String condition, String value, String data) {
        String orderReference;
        TrafficOrdersListPage page = getSut().getPageCreator().getTrafficOrderListPage();
        boolean shouldstate = condition.equalsIgnoreCase("should");
        try {
            orderReference = getCoreApiAdmin().getOrderByItemClockNumber(data).getOrderReference().toString();
            String holdStatus = page.checkOnHoldStatusForOrder(orderReference);
            assertThat(holdStatus, shouldstate ? is(value) : not(is(value)));
        } catch (NullPointerException e) {
            throw new NullPointerException("Order with Clock Number" + data + " was not found");
        }
    }

    @Then("{I |}'$condition' see Broadcaster Approval Status '$status' for order item with clock number '$clockNumber'")
    public void checkBroadcasterApprovalStatusForOrderItem(String condition, String status, String clockNumber) {
        String expectedStatus = status;
        List<String> actualStatus = new ArrayList<String>();
        TrafficOrderNestedList.TrafficOrderItem orderItem = getTrafficOrderNestedList().getTrafficOrderItemByClockNumber(wrapVariableWithTestSession(clockNumber));
        boolean shouldstate = condition.equalsIgnoreCase("should");
        TrafficDestinationList listpage = getTrafficDestinationList();
        List<TrafficDestinationList.TrafficDestination> destinations = listpage.getDestinationsForOrderItem(orderItem);
        try {
            for (int i = 0; i < destinations.size(); i++) {
                actualStatus.add(destinations.get(i).getBroadcasterStatus());
            }
        } catch (ArrayIndexOutOfBoundsException e) {
            System.out.println("Destinations for Orderitem " + orderItem.getClockNumber() + " are absent or selector is wrong");
        }

        assertThat(actualStatus, shouldstate ? hasItem(expectedStatus) : not(hasItem(expectedStatus)));
    }


    @Then("{I |}'$condition' see that OrderItem status was updated to value '$value' for order with ClockNumber '$data'")
    public void checkThatOrderItemStatusWasUpdated(String condition, String value, String data) {
        boolean shouldstate = condition.equalsIgnoreCase("should");
        try {
            TrafficOrderNestedList.TrafficOrderItem orderItem = getTrafficOrderNestedList().getTrafficOrderItemByClockNumber(wrapVariableWithTestSession(data));
            String actualStatus = orderItem.getOrderItemStatus();
            //  assertThat(actualStatus, shouldstate ? is(value) : not(is(value))); NIR-603
            assertThat(value.contains(actualStatus), is(shouldstate));
        } catch (NullPointerException e) {
            throw new NullPointerException("Order with Clock Number" + data + " was not found");
        }
    }

    @Then("{I |}'$condition' see that On Hold status was updated to value '$value' for order item destination order with ClockNumber '$data'")
    public void checkThatOnHoldWasUpdatedForDestination(String condition, String value, String data) {
        try {
            TrafficOrderNestedList.TrafficOrderItem orderItem = getTrafficOrderNestedList().getTrafficOrderItemByClockNumber(wrapVariableWithTestSession(data));
            orderItem.getExpand();
            TrafficDestinationList listpage = getTrafficDestinationList();
            List<TrafficDestinationList.TrafficDestination> destination = listpage.getDestinationsForOrderItem(orderItem);
            boolean shouldstate = condition.equalsIgnoreCase("should");
            String holdStatus = destination.get(0).getOnHold();
            assertThat(holdStatus, shouldstate ? is(value) : not(is(value)));
        } catch (NullPointerException e) {
            throw new NullPointerException("Order with Clock Number" + data + " was not found");
        }
    }


    @Then("{I |}'$condition' see destinations '$destinationName' for order item in Traffic List with clockNumber '$clocknumber'")
    public void isDestinationAvailableForTrafficOrder(String condition, String destinationName, String data) {
        String[] expectedDestinations = destinationName.split(",");
        List<String> actualDestinations = new ArrayList<>();
        List<TrafficOrderNestedList.TrafficOrderItem> orderItems = getTrafficOrderNestedList().getTrafficOrderItemsByClockNumber(wrapVariableWithTestSession(data));
        boolean shouldstate = condition.equalsIgnoreCase("should");
        for (TrafficOrderNestedList.TrafficOrderItem orderItem : orderItems) {
            orderItem.getExpand();
            TrafficDestinationList listpage = getTrafficDestinationList();
            List<TrafficDestinationList.TrafficDestination> destinations = listpage.getDestinationsForOrderItem(orderItem);
            try {
                for (int i = 0; i < destinations.size(); i++) {
                    actualDestinations.add(destinations.get(i).getDestinationName());
                }
            } catch (ArrayIndexOutOfBoundsException e) {
                System.out.println("Destinations for Orderitem " + orderItem.getClockNumber() + " are absent or selector is wrong");
            }
        }
        assertThat(actualDestinations, shouldstate ? anyOf(hasItems(expectedDestinations), hasItem(wrapVariableWithTestSession(expectedDestinations[0]))) : not(hasItems(expectedDestinations)));
    }

    @Then("{I |}'$condition' see following tabs:$data")
    public void selectParticularTab(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> map = parametrizeTabularRow(data, i);
            String tabNames = map.get("Tab name");
            if(!tabNames.equalsIgnoreCase("Null")) {
                for (String tabName : tabNames.split(",")) {
                   /* if (tabName == "Null") {
                        continue;
                    }*/
                    assertThat(getTrafficOrderListPage().isTabAvailable(tabName), equalTo(shouldState));
                }
            }
        }
    }

    @Then("{I |}'$condition' see that tab '$tab' is selected")
    public void checkSelectedTab(String condition, String tab) {
        while (getTrafficOrderListPage().isTabAvailable(tab) && !getTrafficOrderListPage().isTabVisible(tab))
            getTrafficOrderListPage().scrollTabRowRight();
        String actualSelectedTab = getTrafficOrderListPage().getSelectedTabName();
        String expectedSelectedTab = tab;
        assertThat("Selected tab differs from expected", actualSelectedTab.equals(tab));
    }


/*
    @Then("{I |}'$condition' see destination '$destinationName' with status '$status' for order item in Traffic List with clockNumber '$clocknumber'")
    public void isDestinationHasParticularStatusForTrafficOrder(String condition, String destinationName, String status, String data) {
        String expectedDestinationStatus = status;
        String actualDestinationStatus = "";
        List<TrafficOrderNestedList.TrafficOrderItem> orderItems = getTrafficOrderNestedList().getTrafficOrderItemsByClockNumber(wrapVariableWithTestSession(data));
        boolean shouldstate = condition.equalsIgnoreCase("should");
        for (TrafficOrderNestedList.TrafficOrderItem orderItem : orderItems) {
            orderItem.getExpand().click();
            try {
                TrafficDestinationList listpage = getTrafficDestinationList();
                TrafficDestinationList.TrafficDestination destination = listpage.getDestinationByName(destinationName, wrapVariableWithTestSession(destinationName), orderItem);
                actualDestinationStatus = destination.getDeliveryStatus();
            } catch (NullPointerException n) {
                throw new NullPointerException("Destination " + destinationName + " is absent");
            }
        }
        assertThat(actualDestinationStatus, shouldstate ? is(expectedDestinationStatus) : not(is(expectedDestinationStatus)));
    }
*/

    @Then("{I |}'$condition' see destination '$destinationName' with Delivery status '$status' for order item in Traffic List with clockNumber '$clocknumber'")
    public void isDestinationHasDeliveryStatusForTrafficOrder(String condition, String destinationName, String
            status, String data) {
        String expectedDestinationStatus = status;
        String actualDestinationStatus = null;
        List<TrafficOrderNestedList.TrafficOrderItem> orderItems;
        boolean shouldstate = condition.equalsIgnoreCase("should");
        long start = System.currentTimeMillis();
        int i = 0;
        orderItems = getTrafficOrderNestedList().getTrafficOrderItemsByClockNumber(wrapVariableWithTestSession(data));
        while (true) {
            TrafficOrderNestedList.TrafficOrderItem orderItem = orderItems.get(i++);
            orderItem.getExpand();
            try {
                TrafficDestinationList listpage = getTrafficDestinationList();
                TrafficDestinationList.TrafficDestination destination = listpage.getDestinationByName(destinationName, wrapVariableWithTestSession(destinationName), orderItem);
                if (destination.getDestinationName().equalsIgnoreCase(destinationName)) {
                    actualDestinationStatus = destination.getDeliveryStatus();
                    if (!expectedDestinationStatus.equalsIgnoreCase(actualDestinationStatus)) {
                        Common.sleep(1000 * 2);
                        if (System.currentTimeMillis() - start > statusReplicationToTrafficAsGDN) {
                            throw new TimeoutException("Timeout during waiting status " + status + " for order item");
                        }
                        getSut().getWebDriver().navigate().refresh();
                        getSut().getPageNavigator().getOrdersListPage().expandAll();
                        i = 0;
                    } else
                        break;
                }
                continue;
            } catch (Exception n) {
                n.printStackTrace();
            }
            assertThat(actualDestinationStatus, shouldstate ? is(expectedDestinationStatus) : not(is(expectedDestinationStatus)));
        }

    }

    @Then("{I |}'$condition' see destination '$destinationName' with house number '$houseNumber' for order item in Traffic List with clockNumber '$clocknumber'")
    public void isDestinationHasHouseNumberGrouped(String condition, String destinationName, String
            houseNumber, String data) {
        String expectedHouseNumber = wrapVariableWithTestSession(houseNumber);
        String actualHouseNumber = "";
        List<TrafficOrderNestedList.TrafficOrderItem> orderItems = getTrafficOrderNestedList().getTrafficOrderItemsByClockNumber(wrapVariableWithTestSession(data));
        boolean shouldstate = condition.equalsIgnoreCase("should");
        for (TrafficOrderNestedList.TrafficOrderItem orderItem : orderItems) {
            try {
                TrafficDestinationList listpage = getTrafficDestinationList();
                TrafficDestinationList.TrafficDestination destination = listpage.getDestinationByName(destinationName, wrapVariableWithTestSession(destinationName), orderItem);
                actualHouseNumber = destination.getHouseNumberValue("");
            } catch (NullPointerException n) {
                throw new NullPointerException("Destination " + destinationName + " is absent");
            }
        }
        assertThat(actualHouseNumber, shouldstate ? is(expectedHouseNumber) : not(is(expectedHouseNumber)));
    }

    @Then("{I |}'$condition' see destination '$destinationName' with service level '$sla' for order item in Traffic List with clockNumber '$clocknumber'")
    public void checkSLAforParticularDestination(String condition, String destinationName, String sla, String
            clockNumber) {
        String expectedDestinationSLA = sla;
        String actualDestinationSLA = "";
        boolean shouldstate = condition.equalsIgnoreCase("should");
        List<TrafficOrderNestedList.TrafficOrderItem> orderItems = getTrafficOrderNestedList().getTrafficOrderItemsByClockNumber(wrapVariableWithTestSession(clockNumber));
        for (TrafficOrderNestedList.TrafficOrderItem orderItem : orderItems) {
            orderItem.getExpand();
            try {
                TrafficDestinationList listpage = getTrafficDestinationList();
                TrafficDestinationList.TrafficDestination destination = listpage.getDestinationByName(destinationName, wrapVariableWithTestSession(destinationName), orderItem);
                actualDestinationSLA = destination.getServiceLevel();
            } catch (NullPointerException n) {
                throw new NullPointerException("Destination " + destinationName + " is absent");
            }
        }
        assertThat(actualDestinationSLA, shouldstate ? is(expectedDestinationSLA) : not(is(expectedDestinationSLA)));
    }

    @Then("{I |}should see internal order appeared on Traffic Order List page:$fields")
    public void verifyInternalOrder(ExamplesTable fields) {
        for (int i = 0; i < fields.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fields, i);
            TrafficOrdersListPage orderList = getTrafficOrderListPage();
            assertThat("Verify Market ", row.get("Market"), is(orderList.getMarketForInternalOrder(row.get("Market"))));
        }
    }



    @Then("{I |}'$condition' see destination '$destinationName' with Delivery status '$status' for internal order in Traffic List with clockNumber '$clocknumber'")
    public void isDestinationHasDeliveryStatusForTrafficInternalOrder(String condition, String destinationName, String
            status, String data) {
        TrafficOrdersListPage orderList = getTrafficOrderListPage();
        assertThat("Verify Internal Order Status", orderList.getInternalOrderStatus(destinationName),equalToIgnoringCase(status));


    }

    @Then("{I |}should see order item details for clones in traffic order list that have following data:$fields")
    public void checkOrderItemDetailsPerDestination(ExamplesTable fields) {
        for (int i = 0; i < fields.getRowCount(); i++) {

            Map<String, String> row = parametrizeTabularRow(fields, i);
            TrafficOrdersListPage orderList = getTrafficOrderListPage();
            if (row.containsKey("Cloned")) {
                assertThat("Cloned", orderList.getOrderItemDetailsForClones(row.get("Destination"), "Cloned"), equalTo(row.get("Cloned")));
            }
            if (row.containsKey("Ads Delivered")) {
                assertThat("Ads Delivered", orderList.getOrderItemDetailsForClones(row.get("Destination"), "Ads Delivered"), equalTo(row.get("Ads Delivered")));
            }
            if (row.containsKey("Order Item Status")) {
                assertThat("Order Item Status", orderList.getOrderItemDetailsForClones(row.get("Destination"), "Order Item Status"), equalTo(row.get("Order Item Status")));
            }


        }

    }

    @Then("{I |}should see the clock details page that have following data:$fields")
    public void verifyMetadataOnClockDetailsPage(ExamplesTable fields) {
        TrafficClockDetailsPage clkDetails = getTrafficClockDetailsPage();
        for (int i = 0; i < fields.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fields, i);
            if (row.containsKey("Advertiser")) {

                assertThat("Advertiser", clkDetails.getAdvertiser(), equalTo(wrapVariableWithTestSession(row.get("Advertiser"))));
            }



            if (row.containsKey("Product")) {
                assertThat("Product", clkDetails.getProduct(), equalTo(wrapVariableWithTestSession(row.get("Product"))));

            }

            if (row.containsKey("ClkNumber")) {
                assertThat("ClkNumber", clkDetails.getClockNumber(), equalTo(wrapVariableWithTestSession(row.get("ClkNumber"))));
            }

            if (row.containsKey("Additional Details")) {
                assertThat("Additional Details", clkDetails.getAdditionalDetails(), equalTo(row.get("Additional Details")));
            }

        }



    }

    // |Destination Name|House Number|Broadcaster Approval Status|Arrival Data|Destination Type|Format|Last Comment|
    @When("{I |}should see destination '$destination' for order item with clockNumber '$clockNumber' in traffic order list that have following data:$data")
    @Then("{I |}should see destination '$destination' for order item with clockNumber '$clockNumber' in traffic order list that have following data:$data")
    public void checkDestinationDetails(String destinationName, String clockNumber, ExamplesTable data) {
        Map<String, String> row = parametrizeTabularRow(data);
        TrafficOrderNestedList.TrafficOrderItem tr = getTrafficOrderNestedList().getTrafficOrderItemByClockNumber(wrapVariableWithTestSession(clockNumber));
        if (!tr.isOrderExpanded()) {
            tr.getExpand();
        }
        TrafficDestinationList listpage = getTrafficDestinationList();
        List<TrafficDestinationList.TrafficDestination> destinations = listpage.getDestinationsForOrderItem(tr);
        for (TrafficDestinationList.TrafficDestination destination : destinations) {
            if (destination.getDestinationName().equals(destinationName)) {
                if (row.containsKey("Destination Name")) {
                    row.put("Destination Name", row.get("Destination Name"));
                    assertThat("Destination Name", destination.getDestinationName(), equalTo(row.get("Destination Name")));
                }
                if (row.containsKey("House Number")) {
                    if (row.get("House Number").equalsIgnoreCase("NCS") || row.get("House Number").equalsIgnoreCase("ECS") || row.get("House Number").equalsIgnoreCase("CS")) {
                        assertThat("House Number", destination.getHouseNumberValue(row.get("House Number")).startsWith(row.get("House Number") + "-00"));
                    } else {
                        row.put("House Number", wrapVariableWithTestSession(row.get("House Number")));
                        assertThat("House Number", destination.getHouseNumberValue(row.get("House Number")), equalTo(row.get("House Number")));
                    }
                }
                if (row.containsKey("Broadcaster Approval Status")) {
                    row.put("Broadcaster Approval Status", row.get("Broadcaster Approval Status"));
                    assertThat("Broadcaster Approval Status", destination.getBroadcasterStatus(), equalTo(row.get("Broadcaster Approval Status")));
                }
                if (row.containsKey("Arrival Date")) {
                    if ("Today".equalsIgnoreCase(row.get("Arrival Date"))) {
                        DateTime current = new DateTime();
                        DateTime arrivalDate = DateTimeUtils.parseDate(destination.getArrivalDate(), "dd/MM/yyyy HH:mm");
                        assertThat("Arrival Date is not set", current.getHourOfDay() == arrivalDate.getHourOfDay() && current.getDayOfYear() == arrivalDate.getDayOfYear());
                    }
                }
                if (row.containsKey("Destination Type")) {
                    assertThat("Destination Type", destination.getDestinationType(), equalTo(row.get("Destination Type")));
                }
                if (row.containsKey("Format")) {
                    assertThat("Format", destination.getFormat(), equalTo(row.get("Format")));
                }
                if (row.containsKey("Last Comment")) {
                    assertThat("Last Comment", destination.getLastComment(), containsString(row.get("Last Comment")));

                }
            }
        }

    }




    @Then("{I |} see the following destination in clock level list in Traffic:$data")
    public void verifyPresenceOfDestination(ExamplesTable data)
    {
        TrafficOrdersListPage orderList = getTrafficOrderListPage();
        for (int i = 0; i <data.getRowCount() ; i++) {
            Map<String, String> map = parametrizeTabularRow(data, i);
            boolean shouldState = map.get("shouldState").equalsIgnoreCase("should");
            TrafficOrderItemsListPage page = getSut().getPageCreator().getTrafficOrderItemsListPage();
            boolean actualState = orderList.verifyPresenceOfDestination(map.get("Destination"));
            assertThat(actualState, shouldState ? is(true) : is(false));


        }
    }

    @Then("{I |}should see the destination '$destination'  with clockNumber '$clockNumber' in traffic clock level list that have following data:$data")
    public void verifyClockDetails(String destination,String clockNumber,ExamplesTable data)
    {
        TrafficOrdersListPage orderList = getTrafficOrderListPage();
        Map<String, String> row = parametrizeTabularRow(data);
        if (row.containsKey("Destination")) {
            String actualValue = orderList.verifyDestinationDetailsAtClockLevel(destination, "DESTINATION");
            assertThat("Destination",actualValue , equalTo(row.get("Destination")));
        }

        if (row.containsKey("Broadcaster Approval Status")) {
            String actualValue = orderList.verifyDestinationDetailsAtClockLevel(destination, "BROADCASTER APPROVAL STATUS");
            assertThat("Broadcaster Approval Status",actualValue , equalTo(row.get("Broadcaster Approval Status")));
        }
    }



    @Given("{I |}clicked on '$button' button on clock details page in traffic")
    @When("{I |}click on '$button' button on clock details page in traffic")
    public void clickOnForceReleaseButton(String button) {
        TrafficClockDetailsPage clkDetails = getTrafficClockDetailsPage();
        switch (button) {
            case "Carousel Right":
                clkDetails.clickRightCarousel();
                break;
        }
    }

    @Then("{I |}should see the supporting documents '$documents' on clock list page")
    public void verifySupportDocsOnClockDetailsPage(String documents) {
        TrafficClockDetailsPage clkDetails = getTrafficClockDetailsPage();
        List<String> expDocs = new ArrayList<>();
        for (String docs : documents.split(",")) {
            expDocs.add(docs);
        }
        List<String> actuallistOfDocs = clkDetails.verifySupportDocs();
        assertThat("List do not match",expDocs.equals(actuallistOfDocs));
    }



    @Then("{I |}should see order item with clockNumber '$clockNumber' in traffic order list that have following data:$data")
    public void checkOrderItemDetails(String clockNumber, ExamplesTable data) {
        Map<String, String> row = parametrizeTabularRow(data);
        TrafficOrderNestedList.TrafficOrderItem orderItem = getTrafficOrderNestedList()
                .getTrafficOrderItemByClockNumber(wrapVariableWithTestSession(clockNumber));
        if (row.containsKey("Clock Number")) {
            row.put("Clock Number", wrapVariableWithTestSession(row.get("Clock Number")));
            assertThat("Clock Number", orderItem.getClockNumber(), equalTo(row.get("Clock Number")));

        }
        if (row.containsKey("Title")) {
            row.put("Title", wrapVariableWithTestSession(row.get("Title")));
            assertThat("Title", orderItem.getTitle(), equalTo(row.get("Title")));

        }
        if (row.containsKey("Advertiser")) {
            row.put("Advertiser", wrapVariableWithTestSession(row.get("Advertiser")));
            assertThat("Advertiser", orderItem.getAdvertiser(), equalTo(row.get("Advertiser")));
        }
        if (row.containsKey("Product")) {
            row.put("Product", wrapVariableWithTestSession(row.get("Product")));
            assertThat("Product", orderItem.getProduct(), equalTo(row.get("Product")));
        }
        if (row.containsKey("Media Agency")) {
            row.put("Media Agency", wrapVariableWithTestSession(row.get("Media Agency")));
            assertThat("Media Agency", orderItem.getMediaAgency(), equalTo(row.get("Media Agency")));
        }
        if (row.containsKey("Duration")) {
            row.put("Duration", row.get("Duration"));
            assertThat("Duration", orderItem.getDuration(), equalTo(row.get("Duration")));
        }
        if (row.containsKey("First Air Date")) {
            row.put("First Air Date", row.get("First Air Date"));
            assertThat("First Air Date", orderItem.getFirstAirDate(), equalTo(convertDateToEnGbFormat(row.get("First Air Date"))));
        }
        if (row.containsKey("Tape number")) {
            row.put("Tape number", row.get("Tape number"));
            assertThat("Tape number", orderItem.getTapeNumber(), equalTo(row.get("Tape number")));
        }
        if (row.containsKey("Master Received Comment")) {
            row.put("Master Received Comment", row.get("Master Received Comment"));
            assertThat("Master Received Comment", orderItem.getMasterReceivedComment(), equalTo(row.get("Master Received Comment")));
        }

        if (row.containsKey("Ads Delivered")) {
            row.put("Ads Delivered", row.get("Ads Delivered"));
            assertThat("Ads Delivered", orderItem.getAdsDelivered(), equalTo(row.get("Ads Delivered")));
        }

        if (row.containsKey("Cloned")) {
            row.put("Cloned", row.get("Cloned"));
            assertThat("Cloned", orderItem.getCloned(), equalTo(row.get("Cloned")));
        }

        if (row.containsKey("Format")) {
            row.put("Format", row.get("Format"));
            assertThat("Format", orderItem.getFormat(), equalTo(row.get("Format")));
        }

        if (row.containsKey("Master Received Date")) {
            if ("Today".equalsIgnoreCase(row.get("Master Received Date"))) {
                DateTime current = new DateTime();
                DateTime masterReceivedDate = DateTimeUtils.parseDate(orderItem.getMasterReceivedDate(), "dd/MM/yyyy HH:mm");
                assertThat("There is no timestamp", current.getHourOfDay() == masterReceivedDate.getHourOfDay() && current.getDayOfYear() == masterReceivedDate.getDayOfYear());
            }
        }
        if (row.containsKey("Order Item Status")) {
            row.put("Order Item Status", row.get("Order Item Status"));
            assertThat("Order Item Status", orderItem.getOrderItemStatus(), equalTo(row.get("Order Item Status")));
        }
    }


    @Then("{I |}'$should' see edit house number pencil icon on order details page in traffic for clock number '$clockNumber'")
    public void isHouseNumberEditIconDisplayedForOrderItem(String should, String clockNumber) {
        TrafficOrderNestedList.TrafficOrderItem tr = getTrafficOrderNestedList().getTrafficOrderItemByClockNumber(wrapVariableWithTestSession(clockNumber));
        tr.getExpand();
        TrafficDestinationList listpage = getTrafficDestinationList();
        boolean expected = should.equals("should");
        List<TrafficDestinationList.TrafficDestination> destinations = listpage.getDestinationsForOrderItem(tr);
        boolean actualResult = destinations.get(0).isEditHouseNumberPencilPresent();
        assertThat("Edit Button is Present", expected == actualResult);
    }


    public List<String> getDestinationNamesFroOrderItem
            (List<TrafficDestinationList.TrafficDestination> destinations) {
        List<String> destinationNames = new ArrayList<>();
        for (TrafficDestinationList.TrafficDestination destination : destinations) {
            destinationNames.add(destination.getDestinationName());
        }
        return destinationNames;
    }

    private class OrderByDate implements Comparator<String> {

        DateFormat f = new SimpleDateFormat("dd/MM/yyyy");

        @Override
        public int compare(String o1, String o2) {
            try {
                return f.parse(o1).compareTo(f.parse(o2));
            } catch (ParseException e) {
                throw new IllegalArgumentException(e);
            }
        }
    }

    private class OrderByNumber implements Comparator<String> {

        @Override
        public int compare(String o1, String o2) {
            Integer i1 = Integer.parseInt(o1);
            Integer i2 = Integer.parseInt(o2);
            return i1.compareTo(i2);


        }
    }

    private class OrderByDateAndTime implements Comparator<String> {

        DateFormat f = new SimpleDateFormat("dd/MM/yyyy HH:mm");

        @Override
        public int compare(String o1, String o2) {
            try {
                return f.parse(o1).compareTo(f.parse(o2));
            } catch (ParseException e) {
                throw new IllegalArgumentException(e);
            }
        }
    }


    public List<String> expectedSortingResults(String field, List rowValues, String order, String type) {
        if (type.equalsIgnoreCase("order item")) {
            if (field.equalsIgnoreCase("First Air Date")) {
                if (order.equals("asc")) {
                    Collections.sort(rowValues, new OrderByDate());
                } else {
                    Collections.sort(rowValues, Collections.reverseOrder(new OrderByDate()));
                }
            } else if (field.equalsIgnoreCase("Service Level Minutes")) {
                if (order.equals("asc")) {
                    Collections.sort(rowValues, new OrderByNumber());
                } else {
                    Collections.sort(rowValues, Collections.reverseOrder(new OrderByNumber()));
                }
            } else if (field.equalsIgnoreCase("Submitted Date")) {
                if (order.equals("asc")) {
                    Collections.sort(rowValues, new OrderByDateAndTime());
                } else {
                    Collections.sort(rowValues, Collections.reverseOrder(new OrderByDateAndTime()));
                }
            } else if (field.equalsIgnoreCase("Title") || field.equalsIgnoreCase("Agency") || field.equalsIgnoreCase("Clock #") || field.equalsIgnoreCase("Clock Service Level") ) {
                if (order.equals("asc")) {
                    Collections.sort(rowValues, String.CASE_INSENSITIVE_ORDER);
                } else {
                    Collections.sort(rowValues, Collections.reverseOrder(String.CASE_INSENSITIVE_ORDER));
                }
            }
        } else if (type.equalsIgnoreCase("order")) {
            if (field.equalsIgnoreCase("Last Comment")) {
                if (order.equals("asc")) {
                    Collections.sort(rowValues, String.CASE_INSENSITIVE_ORDER);
                } else {
                    Collections.sort(rowValues, Collections.reverseOrder(String.CASE_INSENSITIVE_ORDER));
                }
            } else if (field.equalsIgnoreCase("Market")){
                if (order.equals("asc")) {
                    Collections.sort(rowValues, String.CASE_INSENSITIVE_ORDER);
                } else {
                    Collections.sort(rowValues, Collections.reverseOrder(String.CASE_INSENSITIVE_ORDER));
                }
            }
        }
        return rowValues;
    }

    @Given("{I |} add multiple comment '$comment' for following clocks:$data")
    public void addComment(String comment, ExamplesTable data) {
        TrafficOrderItemsListPage trafficListPage = getSut().getPageCreator().getTrafficOrderItemsListPage();
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> map = parametrizeTabularRow(data, i);
            TrafficOrderNestedList.TrafficOrderItem orderItem = getTrafficOrderNestedList().getTrafficOrderItemByClockNumber(wrapVariableWithTestSession(map.get("clockNumber")));
            orderItem.selectOrder();
        }
        trafficListPage.clickAddComment().getCommentPage().addComment(comment);

    }

    @Given("{I |}assigned all users from '$agency' agency for following orders:$data")
    @When("{I |}assign all users from '$agency' agency for following orders:$data")
    public void assignAllUsersToOrder(String agency, ExamplesTable data) {
        TrafficOrdersListPage trafficListPage = getTrafficOrderListPage();
        TrafficOrderList trafficOrderList = trafficListPage.getTrafficOrderList();
        Common.sleep(5000);
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> map = parametrizeTabularRow(data, i);
            String orderRefference = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(map.get("clockNumber"))).getOrderReference().toString();
            TrafficOrderList.TrafficOrder order = trafficOrderList.getOrderByOrderReference(orderRefference);
            order.selectOrder();
        }
        ReassignOrdersInTraffic popup = trafficListPage.clickAndGetAssignOrdersPopUp();
        waitTillOrderListWillBeLoaded();
        popup.enterAgencyDetails(wrapVariableWithTestSession(agency));
        popup.selectParticularAgency(wrapAgencyName(agency));
        popup.clickParticularButton("Highlight All Users");
        popup.clickParticularButton("Assign");
    }

    @Given("{I |} add multiple comment '$comment' for following clocks on traffic Order list:$data")
    @When("{I |} added multiple comment '$comment' for following clocks on traffic Order list:$data")
    public void addCommentOnTrafficOrderList(String comment, ExamplesTable data) {
        TrafficOrdersListPage trafficListPage = getSut().getPageCreator().getTrafficOrderListPage();
        TrafficOrderList trafficOrderList = getSut().getPageCreator().getTrafficOrderListPage().getTrafficOrderList();
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> map = parametrizeTabularRow(data, i);
            String reference = String.valueOf(getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(map.get("clockNumber"))).getOrderReference());
            TrafficOrderList.TrafficOrder trafficOrder = trafficOrderList.getOrderByOrderReference(reference);
            trafficOrder.selectOrder();
        }
        trafficListPage.clickAddComment().getCommentPage().addComment(comment);

    }

    @Given("{I |}add comment '$comment' for '$clock' clock on traffic order item list")
    public void addCommentForParticularClock(String comment, String clock) {
        TrafficOrderItemsListPage trafficListPage = getSut().getPageCreator().getTrafficOrderItemsListPage();
        TrafficOrderNestedList.TrafficOrderItem orderItem = getTrafficOrderNestedList().getTrafficOrderItemByClockNumber(wrapVariableWithTestSession(clock));
        orderItem.selectOrder();
        trafficListPage.clickAddComment().getCommentPage().addComment(comment);
        orderItem.deselectOrder();
    }


    @Then("{I |}should see order with clockNumber '$clockNumber' in traffic list that have following data:$data")
    public void checkOrderDetails(String clockNumber, ExamplesTable data) {
        TrafficOrderList trafficOrderList = getSut().getPageCreator().getTrafficOrderListPage().getTrafficOrderList();
        Common.sleep(2000);
        String reference = String.valueOf(getCoreApiAdmin().getOrderByItemClockNumber(clockNumber).getOrderReference());
        TrafficOrderList.TrafficOrder trafficOrder = trafficOrderList.getOrderByOrderReference(reference);
        Map<String, String> row = parametrizeTabularRow(data);
        if (row.containsKey("Last Comment")) {
            assertThat("Last Comment", trafficOrder.getLastComment(), equalTo(row.get("Last Comment")));
        }
        if (row.containsKey("PO Number")) {
            assertThat("PO Number", trafficOrder.getPoNumber(), equalTo(wrapVariableWithTestSession(row.get("PO Number"))));
        }
        if (row.containsKey("Job Number")) {
            assertThat("Job Number", trafficOrder.getJobNumber(), equalTo(wrapVariableWithTestSession(row.get("Job Number"))));
        }
        if (row.containsKey("Ingested Ads")) {
            assertThat("Ingested Ads", trafficOrder.getIngestedAds(), equalTo(row.get("Ingested Ads")));
        }
        if (row.containsKey("Cloned")) {
            assertThat("Cloned", trafficOrder.getCloned(), equalTo(row.get("Cloned")));
        }
        if (row.containsKey("Format")) {
            assertThat("Cloned", trafficOrder.getFormat(), equalTo(row.get("Format")));
        }
        if (row.containsKey("Order Item Status")) {
            assertThat("Order Item Status", trafficOrder.getOrderItemStatus(), equalTo(row.get("Order Item Status")));
        }


        if (row.containsKey("Traffic assigned to")) {
            if (row.get("Traffic assigned to") != null && !row.get("Traffic assigned to").isEmpty()) {
                String[] users = row.get("Traffic assigned to").split(",");
                for (String email : users) {
                    String fullName = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(email)).getFullName();
                    assertThat("Traffic assigned to", trafficOrder.getTrafficAssignedTo(), containsString(fullName));
                }
            } else {
                assertThat("Traffic assigned to", trafficOrder.getTrafficAssignedTo(), isEmptyOrNullString());
            }
        }
    }

    @Given("{I |}waited till Master Received Date is set for Order with clockNumber '$clockNumber' in Traffic")
    @When("{I |}wait till Master Received Date is set for Order with clockNumber '$clockNumber' in Traffic")
    public void waitTillMasterReceivedDateInTraffic(String clockNumber) {
        String orderId = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getId();
        OrderItem orderItem = getCoreApiAdmin().getOrderItemByClockNumber(orderId, wrapVariableWithTestSession(clockNumber));
        waitForOrderWillHaveMasterReceivedDateInTraffic(orderItem.getId(), orderItem.getQCAssetId(), 2000);
    }

    public List<String> getUserFullNames(String user) {
        String[] users = user.split(",");
        List<String> fullNames = new ArrayList<String>();
        for (String email : users) {
            try {
                String fullName = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(email)).getFullName();
                fullNames.add(fullName);
            } catch (NullPointerException e) {
                throw new NullPointerException("User with email " + wrapUserEmailWithTestSession(email) + " wasn't found");
            }
        }
        return fullNames;
    }


    @Then("{I |}'$condition' see additional service '$additionalService' for order item in Traffic List with clockNumber '$clocknumber'")
    public void isAdditionalServiceAvailableForTrafficOrder(String condition, String additionalService, String data) {
        String[] expectedDestinations = additionalService.split(",");
        List<String> actualDestinations = new ArrayList<>();
        List<TrafficOrderNestedList.TrafficOrderItem> orderItems = getTrafficOrderNestedList().getTrafficOrderItemsByClockNumber(wrapVariableWithTestSession(data));
        boolean shouldstate = condition.equalsIgnoreCase("should");
        for (TrafficOrderNestedList.TrafficOrderItem orderItem : orderItems) {
            orderItem.getExpand();
            TrafficDestinationList listpage = getTrafficDestinationList();
            List<TrafficDestinationList.AdditionalService> destinations = listpage.getAdditionalServiceForOrderItem(orderItem);
            try {
                for (int i = 0; i < destinations.size(); i++) {
                    actualDestinations.add(destinations.get(i).getDestination());
                }
            } catch (ArrayIndexOutOfBoundsException e) {
                System.out.println("Destinations for Orderitem " + orderItem.getClockNumber() + " are absent or selector is wrong");
            }
        }
        assertThat(actualDestinations, shouldstate ? anyOf(hasItems(expectedDestinations), hasItem(wrapVariableWithTestSession(expectedDestinations[0]))) : not(hasItems(expectedDestinations)));
    }


    @Then("{I |} should see below fields changed:$data")
    public void checkLocalisationFields(ExamplesTable data) {
        Map<String, String> row = parametrizeTabularRow(data);
        TrafficOrdersListPage trafficOrderList = getSut().getPageCreator().getTrafficOrderListPage();
        if (row.containsKey("Add New Tab"))
            assertThat("Add new Tab doesn't shows localisation", trafficOrderList.getAddNewTabTitle().equals(row.get("Add New Tab")));
        if (row.containsKey("Configure Order Item"))
            assertThat("Configure Order Item doesn't show localisation", trafficOrderList.getConfigureOrderTitle("Configure Order Item").equals(row.get("Configure Order Item")));
        if (row.containsKey("Download CSV"))
            assertThat("Download CSV doesn't shows localisation", trafficOrderList.getConfigureOrderTitle("Download CSV").equals(row.get("Download CSV")));
        if (row.containsKey("All Tab"))
            assertThat(trafficOrderList.getAllTab(), hasItem(row.get("All Tab")));
    }

    @Then("I '$condition' see same '$field' for the orders with '$clockNumber' for repeated sends for '$destinationName'")
    public void checkArrivalDateForOrdersWithSameClock(String condition, String field, String clockNumber, String destinationName) {
        DateTime arrivalDateSend = null;
        Integer orderRef = null;
        TrafficDestinationList.TrafficDestination destination = null;
        TrafficOrderList trafficOrderList = getSut().getPageCreator().getTrafficOrderListPage().getTrafficOrderList();
        List<Order> orderList = getCoreApiAdmin().getOrderByItemList(wrapVariableWithTestSession(clockNumber));
        for (Order ord : orderList) {
            TrafficOrderList.TrafficOrder trafficOrder = trafficOrderList.getOrderByOrderReference(String.valueOf(ord.getOrderReference()));
            if (orderRef == null)
                orderRef = ord.getOrderReference();
            trafficOrder.getExpander();
            Common.sleep(1000);
            List<TrafficOrderNestedList.TrafficOrderItem> orderItems = getTrafficOrderNestedList().getTrafficOrderItemsByClockNumber(wrapVariableWithTestSession(clockNumber));
            for (TrafficOrderNestedList.TrafficOrderItem orderItem : orderItems) {
                orderItem.getExpand();
                Common.sleep(1000);
                try {
                    TrafficDestinationList listpage = getTrafficDestinationList();
                    destination = listpage.getDestinationsForOrderItem(orderItem).get(0);
                    if (destination.getDeliveryStatus().equals("Awaiting station release")) {
                        if (arrivalDateSend == null)
                            arrivalDateSend = DateTimeUtils.parseDate(destination.getArrivalDate(), "dd/MM/yyyy HH:mm");
                    }
                    orderItem.getExpand();

                } catch (Exception e) {
                    e.printStackTrace();
                }

            }
            trafficOrder.getExpander();
            if (orderRef.intValue() != ord.getOrderReference().intValue()) {
                if (orderRef > ord.getOrderReference())
                    assertThat("Arrival Date for repeated sends set incorrectly", arrivalDateSend.isAfter(DateTimeUtils.parseDate(destination.getArrivalDate(), "dd/MM/yyyy HH:mm")));
                else
                    assertThat("Arrival Date for repeated sends set incorrectly", arrivalDateSend.isBefore(DateTimeUtils.parseDate(destination.getArrivalDate(), "dd/MM/yyyy HH:mm")));
            }
        }
    }

    @Then("{I |} '$condition' see destination '$destinationName' with Arrival Date '$arrivalDate' for order item in Traffic List with clockNumber '$data'")
    public void checkArrivalDate(String condition, String destinationName, String arrivalDate, String data) {
        String actualArrivalDate = "";
        List<TrafficOrderNestedList.TrafficOrderItem> orderItems = getTrafficOrderNestedList().getTrafficOrderItemsByClockNumber(wrapVariableWithTestSession(data));
        boolean shouldstate = condition.equalsIgnoreCase("should");
        for (TrafficOrderNestedList.TrafficOrderItem orderItem : orderItems) {
            orderItem.getExpand();
            try {
                TrafficDestinationList listpage = getTrafficDestinationList();
                TrafficDestinationList.TrafficDestination destination = listpage.getDestinationByName(destinationName, wrapVariableWithTestSession(destinationName), orderItem);
                actualArrivalDate = destination.getArrivalDate();
            } catch (NullPointerException n) {
                throw new NullPointerException("Destination " + destinationName + " is absent");
            }
            assertThat("Arrival Date not set for destination", (DateTimeUtils.formatDate(DateTimeUtils.parseDate(actualArrivalDate, "dd/MM/yyyy HH:mm"), "MM/dd/yyyy HH:mm")).equalsIgnoreCase(arrivalDate));
        }
    }


    @Given("{I |}pin '$data' tab in Traffic UI")
    @When("{I |}pin '$data' tab in Traffic UI")
    public void pinTab(String data) {
        getSut().getPageCreator().getTrafficOrderListPage().pinTab(data);
    }

    @Then("{I |} '$condition' see first tab as '$tabName'")
    @When("{I |}'$condition' see first tab as '$tabName'")
    public void verifyFirstTabInList(String condition, String tabName) {
        boolean cond = "should".equalsIgnoreCase(condition);
        assertThat("Pinned tab is not the first tab", cond == getSut().getPageCreator().getTrafficOrderListPage().checkFirstTabName(tabName));
    }

    @Then("{I |}'$condition' see order '$data' in Traffic order list page")
    public void checkOrderinTrafficOrderList(String condition, String data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        TrafficOrdersListPage page = getSut().getPageCreator().getTrafficOrderListPage();
        List<String> orders = page.getOrderList();
        String reference = null;
      //  TrafficOrderList trafficOrderList = page.getTrafficOrderList();
        for (String clockNumber : data.split(",")) {
            try {
                reference = String.valueOf(getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getId());
                //      TrafficOrderList.TrafficOrder trafficOrder = shouldState?trafficOrderList.getOrderByOrderReference(reference):null;
            } catch (Exception e) {
                throw new NullPointerException("order with clockNumber " + clockNumber + " wasn't found in A5");

            }
        }
        assertThat(orders, shouldState ? hasItem(reference) : not(hasItem(reference)));
    }

    @Then("{I |}'$condition' see SLA color as '$color' for an order '$data' with service level '$servicelevel' in Traffic order list page")
    public void checkSLAColorofClock(String condition,String color, String data,String servicelevel) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        TrafficOrdersListPage page = getSut().getPageCreator().getTrafficOrderListPage();
        List<String> orders = page.getOrderList();
        String slaColor = page.getSLA().getAttribute("class");
        String reference = null;
        TrafficOrderList trafficOrderList = page.getTrafficOrderList();
        for (String clockNumber : data.split(",")) {
            try {
                reference = String.valueOf(getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getId());
            } catch (Exception e) {
                throw new NullPointerException("order with clockNumber " + clockNumber + " wasn't found in A5");

            }
        }
        if(orders.contains(reference)){
            if(!color.contains("black")){
                assertThat("Service level color did not match",slaColor.contains(color));}
            if(color.contains("black")){
                assertThat("Service level color did not match",slaColor.equals("color-"));
            }
        }

    }


    @When("{I |}Edit the tab")
    public void editTab() {
        TrafficOrdersListPage page = getTrafficOrderListPage();
        page.editTab();
    }

    private int getClockNumber(String[] columnData) {
        int position = 0;
        for (int k = 0; k < columnData.length; k++)
            if (columnData[k].equalsIgnoreCase("Clock Number"))
                position = k;
        return position;
    }

    private String[] getCorrectRow(int position, String[][] rowData, String clockNumber) {
        String[] rowWithClock = null;
        for (int k = 0; k < rowData.length; k++) {
            if (rowData[k] != null) {
                if (rowData[k][position].equalsIgnoreCase(clockNumber))
                    rowWithClock = rowData[k];
            } else
                break;
        }
        return rowWithClock;
    }

    @Then("{I |}'$condition' see following data in '$downloadCSV' order item list in Traffic:$data")
    public void getAvailableOrderItemsFromExcel(String condition, String exportCSV, ExamplesTable data) throws Exception {
        Map<String, String> row = parametrizeTabularRow(data);
        WiniumFTPRemote r = new WiniumFTPRemote(getSut().getWebDriver());
        if (r.copyFileFromGridToLocalUsingFTP(exportCSV)) {
            File downloadFile = new File(String.format(TestsContext.getInstance().testDataFolderName + "/" + "files/" + "%s", exportCSV));
            try {
                CSVReader reader = new CSVReader(new FileReader(downloadFile));
                String[] columnData;
                String clockNumber = null;
                int position = 0;
                int i = 0;
                String[][] rowdata = new String[5][10];
                String[] fetchRow;
                if ((columnData = reader.readNext()) != null) {
                    position = getClockNumber(columnData);
                    while ((rowdata[i++] = reader.readNext()) != null) ;
                    rowdata[i][0] = null;
                    fetchRow = getCorrectRow(position, rowdata, wrapVariableWithTestSession(row.get("Clock Number")));
                    for (int j = 0; j < columnData.length; j++) {
                        switch (columnData[j]) {
                            case "Clock Number":
                                if (row.get("Clock Number") != null) {
                                    assertThat("Clock Number in CSV is not matching", wrapPathWithTestSession(row.get("Clock Number")).equals(fetchRow[j]));
                                }
                                break;
                            case "Market":
                                if (row.get("Market") != null) {
                                    assertThat("Market in CSV is not matching", row.get("Market").equals(fetchRow[j]));
                                }
                                break;
                            case "Destination name":
                                if (row.get("Market") != null) {
                                    assertThat("Destination name in CSV is not matching", row.get("Destination name").equals(fetchRow[j]));
                                }
                                break;
                            case "Title":
                                if (row.get("Title") != null) {
                                    assertThat("Title in CSV is not matching", wrapPathWithTestSession(row.get("Title")).equals(fetchRow[j]));
                                }
                                break;
                            case "Advertiser":
                                if (row.get("Advertiser") != null) {
                                    assertThat("Advertiser in CSV is not matching", wrapPathWithTestSession(row.get("Advertiser")).equals(fetchRow[j]));
                                }
                                break;
                            case "Broadcaster Approval Status":
                                if (row.get("Advertiser") != null) {
                                    assertThat("Advertiser in CSV is not matching", row.get("Broadcaster Approval Status").equals(fetchRow[j]));
                                }
                                break;
                        }
                    }
                }

            } catch (Exception ioe)

            {
                ioe.printStackTrace();
            } finally {
                downloadFile.deleteOnExit();
            }

        } else {
            throw new Exception("File not copied");
        }
    }



    @Then("I '$condition' find '$field' for the orders with '$clockNumber' as '$deliveryStatus' for '$destinationName'")
    public void checkDeliveryStatusForDestination(String condition, String field, String clockNumber, String deliveryStatus,String destinationName) {
        DateTime arrivalDateSend = null;
        Integer orderRef = null;
        TrafficDestinationList.TrafficDestination destination = null;
        TrafficOrderList trafficOrderList = getSut().getPageCreator().getTrafficOrderListPage().getTrafficOrderList();
        List<String> orderReferences=trafficOrderList.getfieldValues("Reference");
     //   List<Order> orderList = trafficOrderList.getOrderByOrderReference(wrapVariableWithTestSession(clockNumber));
        for (String ord : orderReferences) {
            TrafficOrderList.TrafficOrder trafficOrder = trafficOrderList.getOrderByOrderReference(String.valueOf(ord));
          /*  if (orderRef == null)
                orderRef = ord.getOrderReference();
         */   trafficOrder.getExpander();
            Common.sleep(1000);
            List<TrafficOrderNestedList.TrafficOrderItem> orderItems = getTrafficOrderNestedList().getTrafficOrderItemsByClockNumber(wrapVariableWithTestSession(clockNumber));
            for (TrafficOrderNestedList.TrafficOrderItem orderItem : orderItems) {
                orderItem.getExpand();
                Common.sleep(1000);
                try {
                    TrafficDestinationList listpage = getTrafficDestinationList();
                    destination = listpage.getDestinationsForOrderItem(orderItem).get(0);
                    if(destination.getDestinationName().equalsIgnoreCase(destinationName)) {
                        assertThat(String.format("Destination %s should have delivery status %s", destinationName, deliveryStatus), destination.getDeliveryStatus().equalsIgnoreCase(deliveryStatus));
                        break;
                    }
                    orderItem.getExpand();

                } catch (Exception e) {
                    e.printStackTrace();
                }
                trafficOrder.getExpander();
            }


            }

        }


    @When("{I |}wait till order item with clockNumber '$clockNumber' will have A5 view status '$status' in Traffic for destination '$destinationName'")
    public void waitTillOrderItemWillHaveParticularA5StatusInTraffic_ForDestination(String clockNumber, String status,String destinationName) {
        String orderId = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getId();
        OrderItem orderItem = getCoreApiAdmin().getOrderItemByClockNumber(orderId, wrapVariableWithTestSession(clockNumber));
        waitForOrderItemWillHaveParticularA5ViewStatusInTraffic(orderItem.getId(), orderItem.getQCAssetId(),destinationName, status, 2000);
    }


    @Then("{I |}check that order item with clockNumber '$clockNumber' has ingest view status '$status' in Traffic")
    public void waitForOrderItemWillHaveIngestViewStatus(String clockNumber, String status) {
        String orderId = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getId();
        OrderItem orderItem = getCoreApiAdmin().getOrderItemByClockNumber(orderId, wrapVariableWithTestSession(clockNumber));
        assertThat(orderItem.getIngestViewStatus()[0], is(status));

    }

     @When("{I |}wait till order item with clockNumber '$clockNumber' has a5 view status '$status' in Traffic for destination '$destinationName' For Clones")
    public void waitForOrderItemWillHaveA5ViewStatusForClones(String clockNumber, String status,String destinationName) {
        String orderId = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getId();
        waitForOrderItemWillHaveParticularA5ViewStatusInTrafficForClones(orderId, destinationName, status, 2000);
    }

}

