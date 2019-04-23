package com.adstream.automate.babylon.tests.steps.domain.ordering;

import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.JsonObjects.ordering.Order;
import com.adstream.automate.babylon.JsonObjects.ordering.OrderItem;
import com.adstream.automate.babylon.JsonObjects.ordering.enums.UploadRequestType;
import com.adstream.automate.babylon.sut.pages.ordering.BaseOrderingPage;
import com.adstream.automate.babylon.sut.pages.ordering.OrderItemPage;
import com.adstream.automate.babylon.sut.pages.ordering.OrderingPage;
import com.adstream.automate.babylon.sut.pages.ordering.elements.Data;
import com.adstream.automate.babylon.sut.pages.ordering.elements.OrderSlider;
import com.adstream.automate.babylon.sut.pages.ordering.elements.OrderStatus;
import com.adstream.automate.babylon.sut.pages.ordering.elements.StepsOrderType;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.SchemaField;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.popupForms.AssignSomeoneToSupplyMediaForm;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.popupForms.TransferOrderForm;
import com.adstream.automate.babylon.sut.pages.ordering.elements.lists.OrderList;
import com.adstream.automate.babylon.sut.pages.ordering.elements.lists.OrderNestedList;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 31.10.13
 * Time: 16:53
 */
public class ViewOrderSteps extends OrderingHelperSteps {

    private OrderingPage openViewDraftOrders(String orderType){
        return getSut().getPageNavigator().getOrderingPage(OrderStatus.VIEW_DRAFT_ORDERS.toString(), orderType);
    }

    private OrderingPage openViewLiveOrders(String orderType) {
        return getSut().getPageNavigator().getOrderingPage(OrderStatus.VIEW_LIVE_ORDERS.toString(), orderType);
    }

    private OrderingPage openViewHeldOrders(String orderType) {
        return getSut().getPageNavigator().getOrderingPage(OrderStatus.VIEW_HELD_ORDERS.toString(), orderType);
    }

    private OrderingPage openViewCompletedOrders(String orderType) {
        return getSut().getPageNavigator().getOrderingPage(OrderStatus.VIEW_COMPLETED_ORDERS.toString(), orderType);
    }

    @Given("{I |}on Order List page")
    @When("{I |}open Order List page")
    @Then("{I |}open Order List page")
    public BaseOrderingPage getBaseOrderingPage() {
        return getSut().getPageNavigator().getBaseOrderingPage();
    }
    private OrderingPage getOrderingPage() {
        return getSut().getPageCreator().getOrderingPage();
    }

    private OrderList getOrderList() {
        return getOrderingPage().getOrderList();
    }

    private void checkOrderInList(Order order, OrderStatus orderStatus, Map<String, String> row) {
        OrderList.Order ord = getOrderList().getOrderByOrderReference(String.valueOf(order.getOrderReference()), orderStatus);
        if (row.containsKey("Order#"))
            assertThat("Order reference: ", ord.getOrderReference(), equalTo(String.valueOf(order.getOrderReference())));
        if (row.containsKey("DateTime"))
            assertThat("Date & Time: ", formatDateTimeToUTC(ord.getDateTime()), equalTo(orderStatus.equals(OrderStatus.VIEW_DRAFT_ORDERS)
                                                           ? convertDateTimeToDefaultUserLocale(order.getCreated())
                                                           : convertDateTimeToDefaultUserLocale(order.getSubmitted())));
        if (Data.containsField(SchemaField.ADVERTISER, row, false)) assertThat("Advertiser: ", ord.getAdvertiser(), equalTo(prepareAdvertiser(Data.getField(SchemaField.ADVERTISER, row))));
        if (Data.containsField(SchemaField.BRAND, row, false)) assertThat("Brand: ", ord.getBrand(), equalTo(prepareAdvertiserHierarchyValue(Data.getField(SchemaField.BRAND, row))));
        if (Data.containsField(SchemaField.SUB_BRAND, row, false)) assertThat("Sub Brand: ", ord.getSubBrand(), equalTo(prepareAdvertiserHierarchyValue(Data.getField(SchemaField.SUB_BRAND, row))));
        if (Data.containsField(SchemaField.PRODUCT, row, false)) assertThat("Product: ", ord.getProduct(), equalTo(prepareAdvertiserHierarchyValue(Data.getField(SchemaField.PRODUCT, row))));
        if (Data.containsField(SchemaField.CAMPAIGN, row, false)) assertThat("Campaign: ", ord.getCampaign(), equalTo(prepareAdvertiserHierarchyValue(Data.getField(SchemaField.CAMPAIGN, row))));
        if (row.containsKey("Market")) assertThat("Market: ", ord.getMarket(), equalTo(row.get("Market")));
        if (row.containsKey("PO Number")) assertThat("PO Number: ", ord.getPoNumber(), equalTo(wrapVariableWithTestSession(row.get("PO Number"))));
        if (row.containsKey("Job #")) assertThat("Job #:", ord.getJobNumber(), equalTo(wrapVariableWithTestSession(row.get("Job #"))));
        if (row.containsKey("NoClocks")) assertThat("No.Clocks: ", ord.getNo_clocks(), equalTo(row.get("NoClocks")));
        if (row.containsKey("Creator")) {
            User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(row.get("Creator")));
            assertThat("Creator: ", ord.getCreator(), equalTo(user.getFullName()));
        }
        if (row.containsKey("Owner")) {
            User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(row.get("Owner")));
            assertThat("Owner: ", ord.getOwner(), equalTo(user.getFullName()));
        }
        if (row.containsKey("Status")) assertThat("Status:", ord.getStatus(), equalTo(row.get("Status")));
    }

    private void checkOrderItemsInList(Order order, String orderStatus, String orderType, ExamplesTable fieldsTable) {
        OrderList.Order ord = getOrderList().getOrderByOrderReference(String.valueOf(order.getOrderReference()), getOrderStatusByName(orderStatus));
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            if (!Data.containsField(SchemaField.CLOCK_NUMBER, row, false)) throw new NullPointerException("Clock number is not specified!");
            String clockNumber;
            if (isAutoGenerateClockNumber(Data.getField(SchemaField.CLOCK_NUMBER, row)))
                clockNumber = getOrderItemByIndex(order, i).getClockNumber();
            else if (isClockNumberFromARPPSystem(Data.getField(SchemaField.CLOCK_NUMBER, row)))
                clockNumber = Data.getField(SchemaField.CLOCK_NUMBER, row);
            else
                clockNumber = wrapVariableWithTestSession(Data.getField(SchemaField.CLOCK_NUMBER, row));
            OrderNestedList.OrderItem orderItem = ord.getOrderNestedList().getOrderItemByClockNumber(clockNumber, StepsOrderType.findByType(orderType), order.getTvMarket());
            assertThat("Clock Number:", orderItem.getClockNumber(), equalTo(clockNumber));
            if (Data.containsField(SchemaField.ADVERTISER, row, false)) assertThat("Advertiser:", orderItem.getAdvertiser(), equalTo(prepareAdvertiser(Data.getField(SchemaField.ADVERTISER, row))));
            if (Data.containsField(SchemaField.PRODUCT, row, false)) assertThat("Product:", orderItem.getProduct(), equalTo(wrapVariableByCriteria(Data.getField(SchemaField.PRODUCT, row))));
            if (row.containsKey("Title")) assertThat("Title:", orderItem.getTitle(), equalTo(wrapVariableByCriteria(row.get("Title"))));
            if (Data.containsField(SchemaField.CLAVE, row, false)) assertThat("Clave:", orderItem.getClave(), equalTo(Data.getField(SchemaField.CLAVE, row)));
            if (Data.containsField(SchemaField.FIRST_AIR_DATE, row, false)) assertThat("First Air Date:", orderItem.getOnAirDate(), equalTo(!Data.getField(SchemaField.FIRST_AIR_DATE, row).isEmpty() ? convertDateToDefaultUserLocale(Data.getField(SchemaField.FIRST_AIR_DATE, row)) : ""));
            if (row.containsKey("Format")) assertThat("Format:", orderItem.getFormat(), equalTo(row.get("Format")));
            if (Data.containsField(SchemaField.CAMPAIGN, row, false) && StepsOrderType.findByType(orderType).equals(StepsOrderType.MUSIC))
                assertThat("Campaign:", orderItem.getCampaign(), equalTo(wrapVariableWithTestSession(Data.getField(SchemaField.CAMPAIGN, row))));
            if (row.containsKey("Duration") && StepsOrderType.findByType(orderType).equals(StepsOrderType.TV)) assertThat("Duration:", orderItem.getDuration(), equalTo(row.get("Duration")));
            if (row.containsKey("Status")) assertThat("Status:", orderItem.getStatus(), equalTo(row.get("Status")));
        }
    }

    private Map<String, String> prepareAdvancedSearchData(ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        if (row.containsKey("Search By")) {
            StringBuilder sb = new StringBuilder();
            String[] searchBy = row.get("Search By").split(",");
            for (int i = 0; i < searchBy.length; i++) {
                String[] searchByCriteria = searchBy[i].split("=");
                String searchKey = searchByCriteria[0];
                String searchValue = searchKey.equals("Owner") ? wrapUserEmailWithTestSession(searchByCriteria[1]) : wrapVariableWithTestSession(searchByCriteria[1]);
                sb.append(searchKey).append("=").append(searchValue);
                if (i != searchBy.length - 1) sb.append(",");
            }
            row.put("Search By", sb.toString());
        }
        if (row.containsKey("From")) row.put("From", !row.get("From").isEmpty() ? prepareDate(row.get("From")) : "");
        if (row.containsKey("To")) row.put("To", !row.get("To").isEmpty() ? prepareDate(row.get("To")) : "");
        return row;
    }

    @Given("I am on View Draft Orders tab of '$orderType' order on ordering page")
    @When("{I |}go to View Draft Orders tab of '$orderType' order on ordering page")
    public OrderingPage openViewDraftOrdersTab(String orderType) {
        return openViewDraftOrders(getOrderType(orderType));
    }

    @Given("I am on View Live Orders tab of '$orderType' order on ordering page")
    @When("{I |}go to View Live Orders tab of '$orderType' order on ordering page")
    public OrderingPage openViewLiveOrdersTab(String orderType) {
        return openViewLiveOrders(getOrderType(orderType));
    }

    @Given("I am on View Held Orders tab of '$orderType' order on ordering page")
    @When("{I |}go to View Held Orders tab of '$orderType' order on ordering page")
    public OrderingPage openViewHeldOrdersTab(String orderType) {
        return openViewHeldOrders(getOrderType(orderType));
    }

    @Given("I am on View Completed Orders tab of '$orderType' order on ordering page")
    @When("I am on View Completed Orders tab of '$orderType' order on ordering page")
    public OrderingPage openViewCompletedOrdersTab(String orderType) {
        return openViewCompletedOrders(getOrderType(orderType));
    }

    // action: switch, don't switch
    @When("{I |}'$action' to '$orderType' orders on ordering page")
    public void switchByOrderType(String action, String orderType) {
        if (action.equals("switch"))
            getBaseOrderingPage().switchOrdersTab(getOrderType(orderType));
    }

    @When("{I |}create '$orderType' order on View Draft Orders tab on ordering page")
    public OrderItemPage createOrderOverCreateAnOrderButton(String orderType) {
        return openViewDraftOrders(getOrderType(orderType)).createOrder();
    }

    @When("{I |}create '$orderType' order on View Draft Orders tab with following {invoicing organisation|on behalf of BU} '$agencyName'")
    public void createOrderWithInvoicingBu(String orderType, String agencyName) {
        openViewDraftOrders(getOrderType(orderType)).createOrderWithInvoicingOrganisation(getAgencyName(agencyName));
    }

    @When("{I |}select '$tab' tab on ordering page")
    public void selectTabByTitle(String tab) {
        OrderSlider slider = getOrderingPage().getOrderSlider();
        if (tab.equalsIgnoreCase(OrderStatus.VIEW_LIVE_ORDERS.getTitle()))
            slider.getViewLiveOrdersTab().selectTab();
        else if(tab.equalsIgnoreCase(OrderStatus.VIEW_DRAFT_ORDERS.getTitle()))
            slider.getViewDraftOrdersTab().selectTab();
        else if (tab.equalsIgnoreCase(OrderStatus.VIEW_HELD_ORDERS.getTitle()))
            slider.getViewHeldOrdersTab().selectTab();
        else if (tab.equalsIgnoreCase(OrderStatus.VIEW_COMPLETED_ORDERS.getTitle()))
            slider.getViewCompletedOrdersTab().selectTab();
        else
            throw new IllegalArgumentException("Unknown tab: " + tab);
    }

    @When("{I |}{fill|update} Search orders field by value '$value' in '$orderStatus' order list on ordering page")
    public void fillSearchOrdersField(String value, String orderStatus) {
        if (value.equalsIgnoreCase("digit")) {
            Order order = getLastCreatedOrder(getAggregateOrderStatus(orderStatus));
            value = order.getOrderReference().toString();
        } else if (value.isEmpty())
            value = value + Keys.RETURN;
        getOrderingPage().search(value);
    }

    // | Order # | Date & Time | Advertiser | Market | No Clocks | Creator |
    @When("{I |}fill following checkboxes for column filters settings on ordering page: $fieldsTable")
    public void fillTableFiltersSettings (ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        for (Map.Entry<String, String> entry : row.entrySet())
            row.put(entry.getKey(), String.valueOf(entry.getValue().equals("should")));
        getOrderingPage().getTableFilterSettings().fill(row);
    }

    @When("{I |}restore to default column filters settings on ordering page")
    public void restoreToDefaultColumnFiltersSettings() {
        getOrderingPage().getTableFilterSettings().restoreToDefault();
    }

    // sortingOrder: ASC, DESC
    @When("{I |}sort order list by column '$columnTitle' with following sorting order '$sortingOrder' on ordering page")
    public void sortOrders(String columnTitle, String sortingOrder) {
        getOrderList().sortByColumn(columnTitle, sortingOrder);
    }

    @When("{I |}open just created '$orderStatus' order from orders list")
    public void openJustCreatedOrder(String orderStatus) {
        Order order = getLastCreatedOrder(getAggregateOrderStatus(orderStatus));
        getOrderList().getOrderByOrderReference(String.valueOf(order.getOrderReference()), getOrderStatusByName(orderStatus)).openOrderItemPage();
    }

    @When("{I |}open order with '$market' from '$orderStatus' order list")
    public void openOrderByMarket(String market, String orderStatus) {
        Order order = getOrderByMarket(market);
        getOrderList().getOrderByOrderReference(String.valueOf(order.getOrderReference()), getOrderStatusByName(orderStatus)).openOrderItemPage();
    }

    @When("{I |}open order contains item with following clock number '$clockNumber' from '$orderStatus' order list")
    public void openOrderByClockNumber(String clockNumber, String orderStatus) {
        Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
        getOrderList().getOrderByOrderReference(String.valueOf(order.getOrderReference()), getOrderStatusByName(orderStatus)).openOrderItemPage();
    }

    @When("{I |}open summary page for order contains item with following clock number '$clockNumber' in '$orderStatus' order list")
    public void openSummaryPageFromOrderList(String clockNumber, String orderStatus) {
        Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
        getOrderList().getOrderByOrderReference(String.valueOf(order.getOrderReference()), getOrderStatusByName(orderStatus)).openOrderSummaryPage();
    }

    @When("{I |}select just created '$orderStatus' order in order list")
    public void selectOrder(String orderStatus) {
        Order order = getLastCreatedOrder(getAggregateOrderStatus(orderStatus));
        getOrderList().getOrderByOrderReference(String.valueOf(order.getOrderReference()), getOrderStatusByName(orderStatus)).selectOrder();
    }

    @When("{I |}select orders with following markets '$marketList' in '$orderStatus' order list")
    public void selectOrdersByMarket(String marketList, String orderStatus) {
        for (String market : marketList.split(","))
            getOrderList().getOrderByMarket(market, getOrderStatusByName(orderStatus)).selectOrder();
    }

    @When("{I |}select order with following item {clock number|isrc code} '$clockNumbersList' in '$orderStatus' order list")
    public void selectOrderByItemClockNumber(String clockNumbersList, String orderStatus) {
        for (String clockNumber : clockNumbersList.split(",")) {
            Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
            getOrderList().getOrderByOrderReference(String.valueOf(order.getOrderReference()), getOrderStatusByName(orderStatus)).selectOrder();
        }
    }

    @When("{I |}select order item with following clock number '$clockNumber' in '$orderType' order list for just created '$orderStatus' order")
    public void selectOrderItem(String clockNumber, String orderType, String orderStatus) {
        Order order = getLastCreatedOrder(getAggregateOrderStatus(orderStatus));
        OrderList.Order ord = getOrderList().getOrderByOrderReference(String.valueOf(order.getOrderReference()), getOrderStatusByName(orderStatus));
        OrderNestedList.OrderItem orderItem = ord.getOrderNestedList().getOrderItemByClockNumber(wrapVariableWithTestSession(clockNumber), StepsOrderType.findByType(orderType), order.getTvMarket());
        orderItem.selectOrderItem();
    }

    @When("{I |}select order item with following clock number '$clockNumber' in '$orderType' order list for '$orderStatus' order")
    public void selectOrderItemByClockNumber(String clockNumber, String orderType, String orderStatus) {
        Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
        OrderList.Order ord = getOrderList().getOrderByOrderReference(String.valueOf(order.getOrderReference()), getOrderStatusByName(orderStatus));
        OrderNestedList.OrderItem orderItem = ord.getOrderNestedList().getOrderItemByClockNumber(wrapVariableWithTestSession(clockNumber), StepsOrderType.findByType(orderType), order.getTvMarket());
        orderItem.selectOrderItem();
    }

    @When("{I |}select order item with following clock number '$clockNumber' in '$orderStatus' order list for '$orderType' order with following market '$market'")
    public void selectOrderItemByOrderMarket(String clockNumber, String orderStatus, String orderType, String market) {
        OrderList.Order order = getOrderList().getOrderByMarket(market, getOrderStatusByName(orderStatus));
        OrderNestedList.OrderItem orderItem = order.getOrderNestedList().getOrderItemByClockNumber(wrapVariableWithTestSession(clockNumber), StepsOrderType.findByType(orderType), market);
        orderItem.selectOrderItem();
    }

    @When("{I |}approve order item with following clock number '$clockNumber' in '$orderType' order list for '$orderStatus' order")
    public void approveOrderItemInOrderList(String clockNumber, String orderType, String orderStatus) {
        Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
        OrderList.Order ord = getOrderList().getOrderByOrderReference(String.valueOf(order.getOrderReference()), getOrderStatusByName(orderStatus));
        OrderNestedList.OrderItem orderItem = ord.getOrderNestedList().getOrderItemByClockNumber(wrapVariableWithTestSession(clockNumber), StepsOrderType.findByType(orderType), order.getTvMarket());
        orderItem.getApprovalConfirmationPopUp().clickOkBtn();
    }

    @When("{I |}open Transfer Order form on ordering page")
    public void openTransferOrderForm() {
        getOrderingPage().getTransferOrderForm();
    }

    // | Transfer to | Message |
    @When("{I |}fill following fields for Transfer Order form on ordering page: $fieldsTable")
    public void fillTransferOrderForm(ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        if (row.containsKey("Transfer to")) row.put("Transfer to", row.get("Transfer to").contains("email") ? wrapUserEmailWithTestSession(row.get("Transfer to")) : row.get("Transfer to"));
       // getOrderingPage().getTransferOrderForm().fill(row);
        getOrderingPage().getTransferOrderForm().fillTransfer(row);
    }

    @When("{I |}click Send button on Transfer Order form on ordering page")
    public void sendOrderForTransfer() {
        getOrderingPage().getTransferOrderForm().send();
    }

    @Given("{I |}transfered order{s|} contains item with {clock number|isrc code}{s|} '$clockNumbersList' to user '$userEmail' with following message '$message'")
    @When("{I |}transfer order{s|} contains item with {clock number|isrc code}{s|} '$clockNumbersList' to user '$userEmail' with following message '$message'")
    public void assignOrder(String clockNumbersList, String userEmail, String message) {
        List<String> ordersIds = new ArrayList<>();
        for (String clockNumber : clockNumbersList.split(","))
            ordersIds.add(getOrderByItemClockNumber(isClockNumberFromARPPSystem(clockNumber) ? clockNumber : wrapVariableWithTestSession(clockNumber)).getId());
        getCoreApi().assignOrders(ordersIds.toArray(new String[ordersIds.size()]), wrapUserEmailWithTestSession(userEmail), message);
    }

    // | Assignee | Post House | Already Supplied | Message | Deadline Date | Days Before First Air Date | Arrival Time |
    @When("{I |}fill following fields for Assign someone to supply media form that supply via '$uploadRequestType' on ordering page: $fieldsTable")
    public void fillAssignSomeoneToSupplyMediaForm(String uploadRequestType, ExamplesTable fieldsTable) {
        Map<String, String> row = prepareAssignSomeoneToSupplyMediaData(parametrizeTabularRow(fieldsTable));
        AssignSomeoneToSupplyMediaForm form = getOrderingPage().getAssignSomeoneToSupplyMediaForm();
        if (!uploadRequestType.isEmpty()) form.supplyVia(UploadRequestType.findByName(uploadRequestType));

        form.fill(row);
    }

    //check | uncheck
    @When("{I |}'$shouldState' remove previous assignees checkbox on Assign someone to supply media popup")
    public void fillRemovePreviousAssignees(String shouldState) {
       AssignSomeoneToSupplyMediaForm form = getOrderingPage().getAssignSomeoneToSupplyMediaForm();
        form.setRemovePreviousAssignees(shouldState);
    }

    //should | should not
    @Then("{I |}'$shouldState' see remove previous assignees checkbox ticked on Assign someone to supply media popup")
    public void checkRemovePreviousAssigneesState(String shouldState) {
        AssignSomeoneToSupplyMediaForm form = getOrderingPage().getAssignSomeoneToSupplyMediaForm();
        assertThat("Check RemovePreviousAssignees checkbox: ", form.getRemovePreviousAssignees(), is(shouldState.equals("should")));
    }

    @Then("{I |}'$shouldState' see the previous assignee on supply media form on order list page: $fieldsTable")
    public void checkPreviousAssigneeEmailList(String shouldState,ExamplesTable fieldsTable) {
        Map<String, String> row = prepareAssignSomeoneToSupplyMediaData(parametrizeTabularRow(fieldsTable));
        AssignSomeoneToSupplyMediaForm form = getOrderingPage().getAssignSomeoneToSupplyMediaForm();
        if(shouldState.equals("should")) {
            for (Map.Entry<String, String> entry : row.entrySet())
                assertThat("Check field: " + entry.getKey(), form.getFieldValue(entry.getKey()), equalTo(wrapUserEmailWithTestSession(entry.getValue())));
        } else {
            for (Map.Entry<String, String> entry : row.entrySet())
                assertThat("Check field: " + entry.getKey(), form.getFieldValue(entry.getKey()), not(wrapUserEmailWithTestSession(entry.getValue())));
        }
    }


    @Then("{I |}should see the previous assignee on supply media form on order list page: $fieldsTable")
    public void checkPreviousAssignee(ExamplesTable fieldsTable) {
        Map<String, String> row = prepareAssignSomeoneToSupplyMediaData(parametrizeTabularRow(fieldsTable));
        AssignSomeoneToSupplyMediaForm form = getOrderingPage().getAssignSomeoneToSupplyMediaForm();
        for (Map.Entry<String, String> entry : row.entrySet())
        {
            assertThat("Check field: " + entry.getKey(), form.getFieldValue(entry.getKey()), equalTo(wrapUserEmailWithTestSession(entry.getValue())));
        }
    }

    @When("{I |}send order to supply media by someone on ordering page")
    public void sendOrderToSupplyMediaBySomeone() {
        getOrderingPage().getAssignSomeoneToSupplyMediaForm().send();
    }

    // | Search By | From | To | Quick Selection |
    @When("{I |}fill following fields for Advanced Search form on ordering page: $fieldsTable")
    public void fillAdvancedSearchForm(ExamplesTable fieldsTable) {
        Map<String, String> row = prepareAdvancedSearchData(fieldsTable);
        getOrderingPage().getAdvancedSearchForm().fill(row);
    }

    @When("{I |}do searching by selected filters for Advanced Search form on ordering page")
    public void doAdvancedSearching() {
        getOrderingPage().getAdvancedSearchForm().clickOkBtn();
    }

    @When("{I |}delete Search by filter '$filterName' for Advanced Search form on ordering page")
    public void deleteSearchByFilterOfAdvancedSearchForm(String filterName) {
        getOrderingPage().getAdvancedSearchForm().getSearchByByFilterName(filterName).removeSearchBy();
    }

    @When("{I |}delete selected {order|order item|order and order items} in order list")
    public void deleteSelectedOrder() {
        getOrderingPage().getDeleteOrderConfirmationPopUp().clickOkBtn();
    }

    @When("{I |}without delay delete selected {order|order item|order and order items} in order list")
    public void deleteSelectedOrder_withoutDelay(){ getOrderingPage().getDeleteOrderConfirmationPopUp().clickOkBtn_new(); }

    @When("{I |}delete just created '$orderStatus' order")
    public void deleteOrderOverCore(String orderStatus) {
        Order order = getLastCreatedOrder(getAggregateOrderStatus(orderStatus));
        getCoreApi().deleteOrder(order.getId());
        waitForOrderIsNull(order.getId(), sleep);
    }

    @Given("{I |}deleted orders with following markets '$marketList'")
    @When("{I |}delete orders with following markets '$marketList'")
    public void deleteOrderByMarketOverCore(String marketList) {
        for (String market : marketList.split(",")) {
            Order order = getOrderByMarket(market);
            getCoreApi().deleteOrder(order.getId());
            waitForOrderIsNull(order.getId(), sleep);
        }
    }

    @Given("{I |}deleted orders with following clock numbers '$clockNumberList'")
    @When("{I |}delete orders with following clock numbers '$clockNumberList'")
    public void deleteOrderByItemClockNumber(String clockNumberList) {
        for (String clockNumber : clockNumberList.split(",")) {
            Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
            getCoreApi().deleteOrder(order.getId());
            waitForOrderIsNull(order.getId(), sleep);
        }
    }

    @Given("{I |}deleted order items with following clock numbers '$clockNumbers' for '$orderType' order with market '$market'")
    @When("{I |}delete order items with following clock numbers '$clockNumbers' for '$orderType' order with market '$market'")
    public void deleteOrderItemByClockNumberOverCore(String clockNumbers, String orderType, String market) {
        Order order = getOrderByMarket(market);
        for (String clockNumber : clockNumbers.split(",")) {
            OrderItem orderItem = getOrderItemByClockNumber(order.getId(), wrapVariableWithTestSession(clockNumber));
            getCoreApi().deleteOrderItem(order.getId(), orderItem.getId(), getItemTypeByOrderType(orderType));
        }
    }

    @Then("{I |}'$shouldState' see selected '$orderType' switcher on ordering page")
    public void checkOrderingSwitcher(String shouldState, String orderType) {
        assertThat("Check selected ordering switcher: ", getBaseOrderingPage().isSwitcherSelected(getOrderType(orderType)),
                                                         is(shouldState.equals("should")));
    }

    @Then("{I |}'$shouldState' see Create an Order button on ordering page")
    public void checkVisibilityCreateOrderBtn(String shouldState) {
        assertThat("Check visibility Create an Order button: ", getOrderingPage().isCreateOrderBtnVisible(), is(shouldState.equals("should")));
    }

    // tab: View Live Orders, View Draft Orders, View Held Orders, View Completed Orders
    @Then("{I |}'$shouldState' see selected '$tab' tab on ordering page")
    public void checkSelectedSliderTab(String shouldState, String tab) {
        OrderSlider orderSlider = getOrderingPage().getOrderSlider();
        boolean should = shouldState.equals("should");
        if (tab.equalsIgnoreCase(OrderStatus.VIEW_DRAFT_ORDERS.getTitle()))
            assertThat(orderSlider.getViewDraftOrdersTab().isSelected(), equalTo(should));
        else if(tab.equalsIgnoreCase(OrderStatus.VIEW_LIVE_ORDERS.getTitle()))
            assertThat(orderSlider.getViewLiveOrdersTab().isSelected(), equalTo(should));
        else if (tab.equalsIgnoreCase(OrderStatus.VIEW_HELD_ORDERS.getTitle()))
            assertThat(orderSlider.getViewHeldOrdersTab().isSelected(), equalTo(should));
        else if (tab.equalsIgnoreCase(OrderStatus.VIEW_COMPLETED_ORDERS.getTitle()))
            assertThat(orderSlider.getViewCompletedOrdersTab().isSelected(), equalTo(should));
        else
            throw new IllegalArgumentException("Unknown tab: " + tab);
    }

    @Then("{I |}should see count orders '$count' on '$tab' tab in order slider")
    public void checkOrdersCount(String count, String tab) {
        OrderSlider orderSlider = getOrderingPage().getOrderSlider();
        Common.sleep(1000);
        if (tab.equalsIgnoreCase(OrderStatus.VIEW_DRAFT_ORDERS.getTitle()))
            assertThat(orderSlider.getViewDraftOrdersTab().getCount(), equalTo(count));
        else if(tab.equalsIgnoreCase(OrderStatus.VIEW_LIVE_ORDERS.getTitle()))
            assertThat(orderSlider.getViewLiveOrdersTab().getCount(), equalTo(count));
        else if (tab.equalsIgnoreCase(OrderStatus.VIEW_HELD_ORDERS.getTitle()))
            assertThat(orderSlider.getViewHeldOrdersTab().getCount(), equalTo(count));
        else if (tab.equalsIgnoreCase(OrderStatus.VIEW_COMPLETED_ORDERS.getTitle()))
            assertThat(orderSlider.getViewCompletedOrdersTab().getCount(), equalTo(count));
        else
            throw new IllegalArgumentException("Unknown tab: " + tab);
    }

    @Then("{I |}should see orders counter '$counter' above orders list on ordering page")
    public void checkOrdersCounter(String counter) {
        assertThat(getOrderingPage().getOrdersCounter(), containsString(counter));
    }

    @Then("{I |}'$shouldState' see column{s|} '$columnNamesList' for order list on ordering page")
    public void checkVisibilityOrderListTableHeaders(String shouldState, String columnNamesList) {
        List<String> actualColumns = getOrderList().getVisibleColumnTitles();
        for (String columnName : columnNamesList.split(","))
            assertThat("Check visibility table column: " + columnName, actualColumns, shouldState.equals("should") ? hasItem(columnName) : not(hasItem(columnName)));
    }

    @Then("{I |}'$shouldState' see Delete order button on ordering page")
    public void checkVisibilityDeleteOrderButton(String shouldState) {
        assertThat("Check visibility Delete order button: ", getOrderingPage().isDeleteOrderButtonVisible(), is(shouldState.equals("should")));
    }

    @Then("{I |}'$shouldState' see Transfer order button on ordering page")
    public void checkVisibilityTransferOrderButton(String shouldState) {
        assertThat("Check visibility Transfer order button: ", getOrderingPage().isTransferOrderButtonVisible(), is(shouldState.equals("should")));
    }

    @Then("{I |}'$shouldState' see Assign order button on ordering page")
    public void checkVisibilityAssignOrderButton(String shouldState) {
        assertThat("Check visibility Assign order button: ", getOrderingPage().isAssignOrderButtonVisible(), is(shouldState.equals("should")));
    }

    // | Transfer to | Message |
    @Then("{I |}should see following data on Transfer Order form on ordering page: $fieldsTable")
    public void checkTransferOrderFormData(ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        if (row.containsKey("Transfer to") && !row.get("Transfer to").isEmpty()) row.put("Transfer to", wrapUserEmailWithTestSession(row.get("Transfer to")));
        TransferOrderForm form = getOrderingPage().getTransferOrderForm();
        for (Map.Entry<String, String> entry : row.entrySet())
            assertThat("Check field: " + entry.getKey(), form.getFieldValue(entry.getKey()), equalTo(entry.getValue()));
    }

    // state: disabled, enabled
    @Then("{I |}should see '$state' Send button on Transfer Order form")
    public void checkSendBtnState(String state){
        assertThat("Check Send button state: ", getOrderingPage().getTransferOrderForm().isSendButtonEnabled(), is(state.equals("enabled")));
    }

    @Then("{I |}'$shouldState' see Assign someone to supply media form on ordering page")
    public void checkVisibilityAssignSomeoneToSupplyMediaForm(String shouldState) {
        assertThat("Check visibility Assign someone to supply media form: ", getOrderingPage().isAssignSomeoneToSupplyMediaFormVisible(), is(shouldState.equals("should")));
    }

    // | Order Number | Clock Number | Days Before First Air Date |
    @Then("{I |}should see following data on Assign someone to supply media form that supply via '$uploadRequestType' on ordering page: $fieldsTable")
    public void checkAssignSomeoneToSupplyMediaFormData(String uploadRequestType, ExamplesTable fieldsTable) {
        Map<String, String> row = prepareAssignSomeoneToSupplyMediaData(parametrizeTabularRow(fieldsTable));
        AssignSomeoneToSupplyMediaForm form = getOrderingPage().getAssignSomeoneToSupplyMediaForm();
        if (!uploadRequestType.isEmpty()) form.supplyVia(UploadRequestType.findByName(uploadRequestType));
        for (Map.Entry<String, String> entry : row.entrySet())
            assertThat("Check field: " + entry.getKey(), form.getFieldValue(entry.getKey()), equalTo(entry.getValue()));
    }

    @Then("{I |}should see auto complete emails count '$emailsCount' under Assignee for Assign someone to supply media form on ordering page")
    public void checkAutoCompleteEmailsCount(int emailsCount) {
        assertThat("Check auto complete emails count: ", getOrderingPage().getAssignSomeoneToSupplyMediaForm().getCountAutoCompleteEmails(), equalTo(emailsCount));
    }

    @Then("{I |}should see following Search by filters count '$count' for Advanced Search form on ordering page")
    public void checkSearchByFiltersCount(int count) {
        assertThat("Check Search by filters count: ", getOrderingPage().getAdvancedSearchForm().getSearchByFiltersCount(), equalTo(count));
    }

    // | Order# | DateTime | Advertiser | Brand | Sub Brand | Product | Market | PO Number | Job # | NoClocks | Creator | Status |
    @Then("{I |}should see {TV|Music} '$orderStatus' order in order list with following fields: $fieldsTable")
    public void checkLastCreatedOrderInList(String orderStatus, ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        Order order = getLastCreatedOrder(getAggregateOrderStatus(orderStatus));
        checkOrderInList(order, getOrderStatusByName(orderStatus), row);
    }

    // | Order# | DateTime | Advertiser | Brand | Sub Brand | Product | Market | PO Number | Job # | NoClocks | Creator | Status |
    @Then("{I |}should see {TV|Music} order in '$orderStatus' order list with item {isrc code|clock number} '$clockNumber' and following fields: $fieldsTable")
    public void checkOrderInListByItemClock(String orderStatus, String clockNumber, ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
        checkOrderInList(order, getOrderStatusByName(orderStatus), row);
    }

    // NGN-16233 - Check Order can be edited (Pencil icon)
    // LIVE | DRAFTS | COMPLETED | HELD | TV | MUSIC | should | shouldnot | clocknumber
    @Then("{I |}'$should' be able to edit '$orderType' order in '$orderStatus' tab with item {isrc code|clock number} '$clockNumber'")
    public void checkOrderIsEditable(String should, String orderType, String orderStatus, String clockNumber) {
        if(orderStatus.contains("live"))
            openViewLiveOrders(getOrderType(orderType));
        else if(orderStatus.contains("held"))
            openViewHeldOrders(getOrderType(orderType));
        else if(orderStatus.contains("draft"))
            openViewDraftOrders(getOrderType(orderType));
        else if(orderStatus.contains("completed"))
            openViewCompletedOrders(getOrderType(orderType));

        Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
        assertThat("Check Order Edit in: "+orderStatus.toUpperCase(), getOrderingPage().isOrderEditable(), is(should.equals("should")));
    }

    //NGN-16233
    @When("{I |}select '$clockNumbers' for edit in '$orderStatus' tab")
    public void editOrder(String clockNumber, String orderStatus)
    {
        getOrderingPage().clickOrderEditIcon(getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getId());
    }

    @Then("{I |}should see TV order in '$orderStatus' order list with item title '$title' and following fields: $fieldsTable")
    public void checkOrderInListByItemTitle(String orderStatus, String title, ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        Order order = getOrderByItemTitle(wrapVariableByCriteria(title));
        checkOrderInList(order, getOrderStatusByName(orderStatus), row);
    }

    // | Clock Number | Advertiser | Product | Title | First Air Date | Format | Duration | Status |
    @Then("{I |}should see '$orderStatus' order in '$orderType' order list contains items with following fields: $fieldsTable")
    public void checkOrderItemsInList(String orderStatus, String orderType, ExamplesTable fieldsTable) {
        Order order = getLastCreatedOrder(getAggregateOrderStatus(orderStatus));
        checkOrderItemsInList(order, orderStatus, orderType, fieldsTable);
    }

    // | Clock Number | Advertiser | Product | Title | First Air Date | Format | Duration | Status | Approve |
    @Then("{I |}should see '$orderStatus' order in '$orderType' order list contains {isrc code|clock number} '$clockNumber' and items with following fields: $fieldsTable")
    public void checkOrderItemsInListByClock(String orderStatus, String orderType, String clockNumber, ExamplesTable fieldsTable) {
        Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
        checkOrderItemsInList(order, orderStatus, orderType, fieldsTable);
    }

    @Then("{I |}should see '$orderStatus' order in '$orderType' order list contains item title '$title' and items with following fields: $fieldsTable")
    public void checkOrderItemsInListByTitle(String orderStatus, String orderType, String title, ExamplesTable fieldsTable) {
        Order order = getOrderByItemTitle(wrapVariableByCriteria(title));
        checkOrderItemsInList(order, orderStatus, orderType, fieldsTable);
    }

    @Then("{I |}'$shouldState' see order items with following clock numbers '$clockNumbers' in '$orderStatus' order list for '$orderType' order with market '$market'")
    public void checkExistingOfOrderItemsForOrderInList(String shouldState, String clockNumbers, String orderStatus, String orderType, String market) {
        OrderList.Order order = getOrderList().getOrderByMarket(market, getOrderStatusByName(orderStatus));
        for (String clockNumber : clockNumbers.split(",")) {
            assertThat("Check visibility order items by clock numbers in list: ", order.getOrderNestedList().getVisibleOrderItemsClockNumbers(StepsOrderType.findByType(orderType), market), shouldState.equals("should")
                                                                                  ? hasItem(wrapVariableWithTestSession(clockNumber))
                                                                                  : not(hasItem(wrapVariableWithTestSession(clockNumber))));
        }
    }

    @Then("{I |}'$shouldState' see order{s|} with following market{s|} '$marketList' in '$orderStatus' order list")
    public void checkExistingOfOrdersInListByMarket(String shouldState, String marketList, String orderStatus) {
        for (String market : marketList.split(","))
            assertThat("Check visibility orders by market in list: ", getOrderList().getVisibleColumnValues(getOrderStatusByName(orderStatus), "Market"), shouldState.equals("should")
                                                                      ? hasItem(market)
                                                                      : not(hasItem(market)));
    }

    // ownersCriteria: own, not own
    @Then("{I |}'$shouldState' see '$ownersCriteria' order{s|} with following item clock number{s|} '$clockNumberList' in '$orderStatus' order list")
    public void checkExistingOfOrdersInListByClock(String shouldState, String ownersCriteria, String clockNumberList, String orderStatus) {
        for (String clockNumber: clockNumberList.split(",")) {
            clockNumber = wrapVariableWithTestSession(clockNumber);
            Order order = ownersCriteria.equals("own") ? getOrderByItemClockNumber(clockNumber) : getOrderByItemClockNumberByGlobalAdmin(clockNumber);
            String orderReference = String.valueOf(order.getOrderReference());
            assertThat("Check visibility order with item clock number: " + clockNumber, getOrderList().getVisibleColumnValues(getOrderStatusByName(orderStatus), "Order #"),
                                                                                        shouldState.equals("should")
                                                                                        ? hasItem(orderReference)
                                                                                        : not(hasItem(orderReference)));
        }
    }

    // columnName: Advertiser, Brand, Sub Brand, Product, etc
    @Then("{I |}should see following values '$valuesList' for column '$columnName' of advertiser hierarchy in '$orderStatus' order list")
    public void checkAdvertiserHierarchyValues(String valuesList, String columnName, String orderStatus) {
        String[] values = valuesList.split(",");
        for (int i = 0; i < values.length; i++)
            values[i] = wrapVariableWithTestSession(values[i]);
        assertThat("Check values of column: " + columnName, getOrderList().getVisibleColumnValues(getOrderStatusByName(orderStatus), columnName), equalTo(Arrays.asList(values)));
    }

    @Then("{I |}should see orders of markets '$marketList' with correct order references on delete confirmation popup")
    public void checkOrdersReferencesOnDeletePopUp(String marketList) {
        StringBuilder sb = new StringBuilder();
        if (!marketList.isEmpty())
            for (String market : marketList.split(",")) {
                Order order = getOrderByMarket(market);
                sb.append(order.getOrderReference()).append(" ");
            }
        assertThat("Check visibility orders references on delete popup: ", getOrderingPage().getDeleteOrderConfirmationPopUp().getContent(),
                    containsString(!marketList.isEmpty() ? "You are about to delete: order(s): " + sb.toString() + "order item(s):"
                                                         : "You are about to delete: " + sb.toString() + "order item(s):"));
    }

    @Then("{I |}should see order items with following clock numbers '$clockNumbers' on delete confirmation popup")
    public void checkOrderItemsClockNumbersOnDeletePopUp(String clockNumbers) {
        StringBuilder sb = new StringBuilder();
        String[] clockNumbersArray = clockNumbers.split(",");
        for (int i = 0; i < clockNumbersArray.length; i++) {
            sb.append(wrapVariableWithTestSession(clockNumbersArray[i]));
            if (i != clockNumbersArray.length - 1) sb.append(" ");
        }
        assertThat("Check visibility order items clock numbers on delete popup: ", getOrderingPage().getDeleteOrderConfirmationPopUp().getContent(),
                    containsString("order item(s): " + sb.toString()));
    }


    @When("{I |}click on '$orderStatus' order in '$orderType' order list for clockNumber '$clockNumber'")
    public void clickOrderItemInListByClock(String orderStatus,String orderType,String clockNumber) {
        Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
        OrderList.Order ord = getOrderList().getOrderByOrderReference(String.valueOf(order.getOrderReference()), getOrderStatusByName(orderStatus));
        OrderNestedList.OrderItem orderItem = ord.getOrderNestedList().getOrderItemByClockNumber(wrapVariableWithTestSession(clockNumber), StepsOrderType.findByType(orderType), order.getTvMarket());
        orderItem.getClockLink().click();
        }

    @When("{I |}wait till order item with clockNumber '$clockNumber' will have view status '$status'")
    @Given("{I |}wait till order item with clockNumber '$clockNumber' will have view status '$status'")
    public void waitTillOrderItemWillHaveParticularA5StatusInTraffic(String clockNumber, String status) {
        String orderId = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getId();
        waitForOrderItemWillHaveParticularA5ViewStatus(orderId,clockNumber,status,2000);
    }

    @Given("{I |}click on Create Order Link")
    @When("{I |}click on Create Order Link")
    public void openCreateOrderPage() {
        getSut().getWebDriver().findElement(By.cssSelector("[id='ordering_main_createOrder_0']")).click();
    }


}