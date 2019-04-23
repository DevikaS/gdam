package com.adstream.automate.babylon.tests.steps.domain.ordering;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.JsonObjects.ordering.*;
import com.adstream.automate.babylon.JsonObjects.ordering.enums.ApprovalStatus;
import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.babylon.sut.pages.ordering.OrderItemPage;
import com.adstream.automate.babylon.sut.pages.ordering.elements.*;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.*;
import com.adstream.automate.babylon.sut.pages.ordering.elements.popup.BSkyBConfirmationPopUp;
import com.adstream.automate.babylon.sut.pages.ordering.elements.popup.ChangeBUOnBehalfOfPopUp;
import com.adstream.automate.babylon.sut.pages.ordering.elements.popup.ChangeBUOnBehalf;
import com.adstream.automate.babylon.sut.pages.ordering.elements.popup.SelectMarketPopUp;
import com.adstream.automate.hamcrest.StringByRegExpCheck;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import java.util.*;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 20.08.13
 * Time: 18:22
 */
public class DraftOrderSteps extends OrderingHelperSteps {

    protected OrderItemPage openOrderItemPage(String orderId, String orderItemId) {
        return getSut().getPageNavigator().getOrderItemPage(orderId, orderItemId);
    }

    protected OrderItemPage getOrderItemPage() {
        return getSut().getPageCreator().getOrderItemPage();
    }

    private Order createTvOrderWithFields(String orderType, String market) {
        Order order = getCoreApi().getOrderByMarket(market);
        if (order == null) {
            order = getCoreApi().createOrder(market, getOrderType(orderType));
            if (order != null) {
                waitForOrderIndex(order.getId(), OrderStatus.VIEW_DRAFT_ORDERS.toString(), sleep);
                getCoreApi().createOrderItem(order.getId(), getItemTypeByOrderType(orderType), new OrderItem());
                return order;
            } else
                throw new NullPointerException("Order is not created!");
        }
        return order;
    }

    protected String[] convertAssigneesToArray(String assignees) {
        String[] assigneesArr = assignees.split(",");
        for (int i = 0; i < assigneesArr.length; i++)
            assigneesArr[i] = wrapUserEmailWithTestSession(assigneesArr[i]);
        return assigneesArr;
    }

    private String prepareMediaRequestCoverText(String request) {
        StringBuilder mediaRequest = new StringBuilder();
        if (!request.isEmpty()) {
            String[] requestParts = request.split(" ");
            for (int i = 0; i < requestParts.length; i++) {
                if (i != requestParts.length - 1) mediaRequest.append(requestParts[i]).append(" ");
                if (i == requestParts.length - 1) mediaRequest.append(prepareAssignees(requestParts[i]));
            }
        }
        return mediaRequest.toString();
    }

    private void prepareOrderToComplete(Map<String, String> row, Order order) {
        if (row.containsKey("Job Number") && !row.get("Job Number").isEmpty())
            row.put("Job Number", wrapVariableWithTestSession(row.get("Job Number")));
        if (row.containsKey("PO Number") && !row.get("PO Number").isEmpty())
            row.put("PO Number", wrapVariableWithTestSession(row.get("PO Number")));
        order.setJobNumber(row.get("Job Number"));
        order.setPoNumber(row.get("PO Number"));
        order.setPin(row.containsKey("Pin") ? row.get("Pin") : "1234");
        order.setHandleStandardsConversions(row.containsKey("Manage Format Convertion") && row.get("Manage Format Convertion").equals("should"));
        order.setNotifyAboutDelivery(row.containsKey("Notify About Delivered") && row.get("Notify About Delivered").equals("should"));
        order.setNotifyAboutQc(row.containsKey("Notify About QC") && row.get("Notify About QC").equals("should"));
        // order.setNotificationEmails(new String[]{getCoreApi().getCurrentUser().getEmail()});
    }

    private void completeOrder(ExamplesTable fieldsTable, Order order) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        prepareOrderToComplete(row, order);
        QcView qcView = getCoreApi().getQcView(order.getId());
        for (QcOrderItem qcOrderItem : qcView.getItems())
            if (qcOrderItem.getAssets() != null && !qcOrderItem.getAssets().isEmpty())
                qcOrderItem.getAssets().get(0).setAdbanked(!(row.containsKey("Adbank") && !row.get("Adbank").isEmpty()) || row.get("Adbank").equals("should")); // set true by default due to ORD-3353
        Order completeOrder = getCoreApi().completeOrder(order, qcView);
        Common.sleep(4000); // little delay to initialize submitted and another fields of confirmed order
        if (completeOrder == null || !completeOrder.getStatus()[0].equals(OrderStatus.VIEW_LIVE_ORDERS.getOrderStatus()[1]))
            throw new IllegalStateException("Order with id " + order.getId() + " wasn't completed!");
    }

    // force completing failed orders by super admin user
    private void forceCompleteOrder(ExamplesTable fieldsTable, Order order) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        prepareOrderToComplete(row, order);
        Order completeOrder = getCoreApiAdmin().forceCompleteOrder(order);
        if (completeOrder == null || !completeOrder.getStatus()[0].equals(OrderStatus.VIEW_LIVE_ORDERS.getOrderStatus()[2]))
            throw new IllegalStateException("Order with id " + order.getId() + " wasn't completed!");
    }

    @Given("{I |}create '$orderType' order")
    public void createOrderOverCore(String orderType) {
        Order order = getCoreApi().createOrder(getOrderType(orderType));
        if (order == null) throw new NullPointerException("Order is not created!");
        waitForOrderIndex(order.getId(), OrderStatus.VIEW_DRAFT_ORDERS.toString(), sleep);
        getCoreApi().createOrderItem(order.getId(), getItemTypeByOrderType(orderType), new OrderItem());
    }

    // | Market |
    @Given("{I |}create '$orderType' orders with following fields: $fieldsTable")
    public void createOrdersWithFieldsOverCore(String orderType, ExamplesTable fieldsTable) {
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            if (row.get("Market").isEmpty() || row.get("Market") == null)
                throw new IllegalArgumentException("Market is not specified!");
            createTvOrderWithFields(orderType, row.get("Market"));
        }
    }

    @Given("{I |}add for order that contains item with clock number '$clockNumber' following invoicing organisation '$agencyName'")
    public void addInvoicingOrganisationToOrder(String clockNumber, String agencyName) {
        Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
        order.setBillingBuId(new String[]{"_" + getAgencyByName(agencyName).getId()});  // core mega feature to avoid lost id
        getCoreApi().updateOrder(order);
    }

    @Given("{I |}add for order that contains item with clock number '$clockNumber' following on behalf of organisation '$agencyName'")
    public void addOnBehalfOfOrganisationToOrder(String clockNumber, String agencyName) {
        Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
        String orderItemType = getOrderItems(order.getId())[0].getSubtype();
        getCoreApi().moveOrderToBU(order.getId(), getAgencyIdByName(agencyName));
        getCoreApi().createOrderItem(order.getId(), orderItemType, new OrderItem());
    }

    @When("{I |}create '$orderType' order with market '$market' and items based on following assets '$assetsNameList' of collection '$collectionName'")
    public void createTVOrderWithItemsBasedOnAssets(String orderType, String market, String assetsNameList, String collectionName) {
        if (market.isEmpty()) throw new IllegalArgumentException("Market is not specified!");
        Order order = getCoreApi().createOrder(market, getOrderType(orderType));
        List<String> assetsIds = new ArrayList<>();
        for (String assetName : assetsNameList.split(","))
            assetsIds.add(getAsset(getCategoryId(wrapCollectionName(collectionName)), wrapVariableByCriteria(assetName)).getId());
        getCoreApi().createOrderItemsAssociatedWithMedia(order.getId(), getItemTypeByOrderType(orderType), assetsIds.toArray(new String[assetsIds.size()]));
    }

    @When("{I |}open order item with following clock number '$clockNumber' for just {created|updated} '$orderStatus' order")
    public void openOrderItemByLastCreatedOrder(String clockNumber, String orderStatus) {
        Order order = getLastCreatedOrder(getAggregateOrderStatus(orderStatus));
        OrderItem orderItem = getOrderItemByClockNumber(order.getId(), wrapVariableWithTestSession(clockNumber));
        openOrderItemPage(order.getId(), orderItem.getId());
    }

    @When("{I |}open order item with {clock number|isrc code} '$clockNumber' for order with market '$market'")
    public void openOrderItemByOrderWithMarket(String clockNumber, String market) {
        Order order = getOrderByMarket(market);
        OrderItem orderItem = getOrderItemByClockNumber(order.getId(), wrapVariableWithTestSession(clockNumber));
        openOrderItemPage(order.getId(), orderItem.getId());
    }

    @When("{I |}open order item with following {clock number|isrc code} '$clockNumber'")
    @Then("{I |}open order item with following {clock number|isrc code} '$clockNumber'")
    public void openOrderItemByClockNumber(String clockNumber) {
        clockNumber = isClockNumberFromARPPSystem(clockNumber) ? clockNumber : wrapVariableWithTestSession(clockNumber);
        Order order = getOrderByItemClockNumber(clockNumber);
        OrderItem orderItem = getOrderItemByClockNumber(order.getId(), clockNumber);
        openOrderItemPage(order.getId(), orderItem.getId());
    }

    @When("{I |}open order item with next title '$title'")
    public void openOrderItemByTitle(String title) {
        Order order = getOrderByItemTitle(wrapVariableWithTestSession(title));
        OrderItem orderItem = getOrderItemByTitle(order.getId(), wrapVariableWithTestSession(title));
        openOrderItemPage(order.getId(), orderItem.getId());
    }


    @When("{I |}open order item with following market '$market'")
    public void openOrderItemByMarket(String market) {
        Order order = getOrderByMarket(market);
        OrderItem orderItem = getOrderItems(order.getId())[0];
        openOrderItemPage(order.getId(), orderItem.getId());
    }

    @When("{I |}open order item with following title '$title' and {isrc code|clock number} '$clockNumber'")
    public void openOrderItemByTitle(String title, String clockNumber) {
        Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
        OrderItem orderItem = getOrderItemByTitle(order.getId(), wrapVariableWithTestSession(title));
        openOrderItemPage(order.getId(), orderItem.getId());
    }

    // | Job Number | PO Number |
    @Given("{I |}complete just created '$orderStatus' order with following fields: $fieldsTable")
    @When("{I |}completed just created '$orderStatus' order with following fields: $fieldsTable")
    public void completeLastCreatedOrderByStatus(String orderStatus, ExamplesTable fieldsTable) {
        Order order = getLastCreatedOrder(getAggregateOrderStatus(orderStatus));
        completeOrder(fieldsTable, order);
    }

    // | Job Number | PO Number |
    @Given("{I |}complete order with market '$market' with following fields: $fieldsTable")
    @When("{I |}completed order with market '$market' with following fields: $fieldsTable")
    public void completeOrderByMarket(String market, ExamplesTable fieldsTable) {
        Order order = getOrderByMarket(market);
        completeOrder(fieldsTable, order);
    }

    // | Job Number | PO Number |
    @Given("{I |}complete order contains item with {clock number|isrc code} '$clockNumber' with following fields: $fieldsTable")
    @When("{I |}completed order contains item with {clock number|isrc code} '$clockNumber' with following fields: $fieldsTable")
    public void completeOrderByItemClockNumber(String clockNumber, ExamplesTable fieldsTable) {
        Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
        completeOrder(fieldsTable, order);
    }

    // used for completing failed orders
    // | Job Number | PO Number |
    @Given("{I |}force complete order contains item with {clock number|isrc code} '$clockNumber' with following fields: $fieldsTable")
    @When("{I |}force completed order contains item with {clock number|isrc code} '$clockNumber' with following fields: $fieldsTable")
    public void forceCompleteOrderByItemClockNumber(String clockNumber, ExamplesTable fieldsTable) {
        Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
        waitForFailingPlaceOrderToA4(order.getId(), sleep);
        forceCompleteOrder(fieldsTable, order);
    }

    @Given("{I |}wait for finish place order with following item clock number{s|} '$clockNumbersList' to A4")
    @When("{I |}waited for finish place order with following item clock number{s|} '$clockNumbersList' to A4")
    public void waitingForFinishPlaceOrderToA4(String clockNumbersList) {
        for (String clockNumber : clockNumbersList.split(","))
            waitForFinishPlaceOrderToA4(getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getId(), sleep);
    }

    @When("{I |}back to ordering page from order item page")
    public void backToOrderingPage() {
        getOrderItemPage().back();
    }

    @When("{I |}select following market '$market' on order item page")
    public void selectMarket(String market) {
        SelectMarketPopUp popUp = getOrderItemPage().getSelectedMarketPopUp();
        popUp.selectMarketByName(market);
        popUp.clickOkBtn();
    }

    //action: create new, copy current
    @When("{I |}'$action' order item by Add Commercial button on order item page")
    public void actionOverOrderItem(String action) {
        if (action.startsWith("create"))
            getOrderItemPage().createNewCommercial();
        else if (action.startsWith("copy"))
            getOrderItemPage().copyExistingCommercial();
        else
            throw new IllegalArgumentException("Unknown action: " + action);
    }

    @Given("{I |}hold for approval '$orderType' order items with following {clock numbers|isrc codes} '$clockNumberList'")
    @When("{I |}held for approval '$orderType' order items with following {clock numbers|isrc codes} '$clockNumberList'")
    public void holdForApprovalOrderItems(String orderType, String clockNumberList) {
        for (String clockNumber : clockNumberList.split(",")) {
            Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
            OrderItem orderItem = getOrderItemByClockNumber(order.getId(), wrapVariableWithTestSession(clockNumber));
            getCoreApi().holdForApprovalOrderItem(order.getId(), orderItem.getId(), getItemTypeByOrderType(orderType), ApprovalStatus.ON_HOLD.toString());
        }
    }

    @When("{I |}hold for approval active order item on cover flow")
    public void holdForApprovalByCoverFlow() {
        getOrderItemPage().getActiveCoverFlowItem().holdForApproval();
    }

    @When("{I |}select order item with following {isrc code|clock number} '$clockNumber' on cover flow")
    public void selectOrderItemByClockNumberInCoverFlow(String clockNumber) {
        clockNumber = isClockNumberFromARPPSystem(clockNumber) ? clockNumber : wrapVariableWithTestSession(clockNumber);
        Order order = getOrderByItemClockNumber(clockNumber);
        OrderItem orderItem = getOrderItemByClockNumber(order.getId(), clockNumber);
        getOrderItemPage().selectOrderItemInCoverFlowById(orderItem.getId());
    }

    @When("{I |}select order item with {clock number|isrc code} '$clockNumber' on cover flow for order with market '$market'")
    public void selectOrderItemByClockNumberInCoverFlow(String clockNumber, String market) {
        Order order = getOrderByMarket(market);
        OrderItem orderItem = getOrderItemByClockNumber(order.getId(), wrapVariableWithTestSession(clockNumber));
        getOrderItemPage().selectOrderItemInCoverFlowById(orderItem.getId());
    }

    // index: starts with 1
    @When("{I |}select '$index' order item with following {clock number|isrc code} '$clockNumber' on cover flow")
    public void selectOrderItemByClockNumberInCoverFlow(int index, String clockNumber) {
        clockNumber = isClockNumberFromARPPSystem(clockNumber) ? clockNumber : wrapVariableWithTestSession(clockNumber);
        Order order = getOrderByItemClockNumber(clockNumber);
        OrderItem orderItem = getOrderItemByIndex(index, order.getId(), clockNumber);
        getOrderItemPage().selectOrderItemInCoverFlowById(orderItem.getId());
    }

    // index: starts with 1
    @When("{I |}select '$index' order item with clock number '$clockNumber' on cover flow for order with market '$market'")
    public void selectOrderItemByClockNumberInCoverFlow(int index, String clockNumber, String market) {
        Order order = getOrderByMarket(market);
        OrderItem orderItem = getOrderItemByIndex(index, order.getId(), wrapVariableWithTestSession(clockNumber));
        getOrderItemPage().selectOrderItemInCoverFlowById(orderItem.getId());
    }

    // index: starts with 1
    @When("{I |}select '$index' order item with following title '$title' on cover flow")
    public void selectOrderItemByTitleInCoverFlow(int index, String title) {
        Order order = getOrderByItemTitle(wrapVariableByCriteria(title));
        OrderItem orderItem = getOrderItemWithTitleByIndex(index, order.getId(), wrapVariableByCriteria(title));
        getOrderItemPage().selectOrderItemInCoverFlowById(orderItem.getId());
    }

    @When("{I |}delete active order item on cover flow")
    public void deleteActiveOrderItemByCoverFlow() {
        OrderItemPage.CoverFlowItem coverFlowItem = getOrderItemPage().getActiveCoverFlowItem();
        coverFlowItem.getDeleteOrderItemPopUp().clickOkBtn();
    }

    // sectionName: Add information, Select Broadcast Destinations, Additional Services
    @When("{I |}copy data from '$sectionNameList' {section|sections} of order item page to all other items")
    public void copySectionsDataToAllOrderItems(String sectionNameList) {
        for (String sectionName : sectionNameList.split(","))
            getOrderItemPage().getCopyToAllPopUpForSection(sectionName).clickOkBtn();
    }

    // sectionName: Add media, Add information, Additional information, Usage rights, Select Broadcast Destinations, Additional Services
    @When("{I |}clear '$sectionName' section on order item page")
    public void clearOrderItemSection(String sectionName) {
        getOrderItemPage().getClearActionPopUpForSection(sectionName).clickOkBtn();
    }

    @When("{I |}clear clock number field on order item page")
    public void clearClockNumberField() {
        getOrderItemPage().clearClockNumber();
    }

    // sectionName: Add media, Add information, Additional information, Usage rights, Select Broadcast Destinations, Additional Services
    @When("{I |}expand '$sectionName' section on order item page")
    public void expandOrderItemSection(String sectionName) {
        getOrderItemPage().expandSection(sectionName);
    }

    @When("{I |}do QC & Ingest Only for active order item at Select Broadcast Destinations")
    public void qcIngestOnlyOrderItem() {
        getOrderItemPage().qcIngestOnly();
    }

    // orderType: tv, music, print
    @Given("{I |}enable QC & Ingest Only for '$orderType' order for {item|items} with following {clock number|isrc code|clock numbers|isrc codes} '$clockNumberList'")
    @When("{I |}enabled QC & Ingest Only for '$orderType' order for {item|items} with following {clock number|isrc codes|clock numbers|isrc codes} '$clockNumberList'")
    public void enabledQcIngestOnly(String orderType, String clockNumberList) {
        for (String clockNumber : clockNumberList.split(",")) {
            clockNumber = wrapVariableWithTestSession(clockNumber);
            Order order = getOrderByItemClockNumber(clockNumber);
            OrderItem orderItem = getOrderItemByClockNumber(order.getId(), clockNumber);
            orderItem.setItemType(OrderItemDeliveryType.INGEST.toString());
            getCoreApi().updateOrderItem(order.getId(), orderItem.getId(), getItemTypeByOrderType(orderType), orderItem);
        }
    }

    @Given("{I |}set view status '$status' for destination with name '$destinationName' for '$orderType' order item with following clock number '$clockNumber'")
    public void setOrderItemViewStatus(String status, String destinationName, String orderType, String clockNumber) {
        clockNumber = wrapVariableWithTestSession(clockNumber);
        Order order = getOrderByItemClockNumber(clockNumber);
        OrderItem orderItem = getOrderItemByClockNumber(order.getId(), clockNumber);
        getDestinationItemByName(orderItem, destinationName).setStatus(DestinationStatus.findByStatus(status).toString());
        getCoreApi().updateOrderItem(order.getId(), orderItem.getId(), getItemTypeByOrderType(orderType), orderItem);
    }

    @When("{I |}changed invoicing organisation to following '$agencyName' on order item page")
    public void changeInvoicingOrganisation(String agencyName) {
        getOrderItemPage().changeInvoicingOrganisation(getAgencyName(agencyName));
    }

    // | On Behalf Of BU | Invoice On Behalf Of BU |
    @When("{I |}fill in following fields for Change BU on behalf of popup on order item page: $fieldsTable")
    public void fillInChangeBUOnBehalfOfPopUp(ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        ChangeBUOnBehalfOfPopUp popUp = getOrderItemPage().getChangeBUOnBehalfOfPopUp().selectOnBehalfOfBU(wrapVariableWithTestSession(row.get("On Behalf Of BU")));
        if (row.containsKey("Invoice On Behalf Of BU"))
            popUp.selectInvoiceOnBehalfOfBU(wrapVariableWithTestSession(row.get("Invoice On Behalf Of BU")));
    }

    // | On Behalf Of BU | Invoice On Behalf Of BU |
    @When("{I |}edit following fields for Change BU on behalf of popup on order item page: $fieldsTable")
    public void changeBUOnBehalfOf(ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        ChangeBUOnBehalfOfPopUp popUp = getOrderItemPage().getChangeBUOnBehalfOfPopUp().selectOnBehalfOfBU(wrapVariableWithTestSession(row.get("On Behalf Of BU")));
        if (row.containsKey("Invoice On Behalf Of BU"))
            popUp.selectInvoiceOnBehalfOfBU(wrapVariableWithTestSession(row.get("Invoice On Behalf Of BU")));
        popUp.changeBU();
    }

    @When("{I |}click Proceed button on order item page")
    public void proceedOrder() {

        getOrderItemPage().proceed();
    }

    @Then("{I |} '$shouldState' see an error '$errorText' on order item page")
    public void verifyError(String shouldState, String errorText) {
        boolean condition = shouldState.equalsIgnoreCase("should");
        String actualErrorText = getOrderItemPage().verifyError();
        if (condition == true) {

            assertThat("Check auto code validation after editing metadata", errorText, equalToIgnoringCase(actualErrorText));
        } else {
            assertThat("Check auto code validation after editing metadata", "false", equalTo(actualErrorText));
        }
    }


    @When("{I |}click {inactive|active} Proceed button on order item page")
    public void clickProceedBtn() {
        getOrderItemPage().clickProceedButton();
    }

    @Then("{I |}'$condition' see warning message '$message' on order item page on click proceed")
    public void checkWarningMessage(String condition, String message) {
        BasePage page = getSut().getPageCreator().getBasePage();
        Common.sleep(3000);
        OrderItemPage orderItemPage= getSut().getPageCreator().getOrderItemPage();
        orderItemPage.clickProceedButton();
        if (!message.trim().isEmpty()) {
            boolean shouldState = condition.equalsIgnoreCase("should");
            List<String> actualMessages = page.getPopUpNotificationMessages();
            if(actualMessages.size()==0){
                orderItemPage.clickProceedButton();
                actualMessages = page.getPopUpNotificationMessages();
            }
            assertThat(actualMessages, shouldState ? hasItem(message) : not(hasItem(message)));
        }
    }


    // action: cancel, close, accept
    @When("{I |}'$action' BSkyB confirmation popup on order item page")
    public void actionOverBSkyBPopUp(String action) {
        BSkyBConfirmationPopUp popUp = getOrderItemPage().getBSkyBConfirmPopUp();
        switch (action) {
            case "cancel":
                popUp.cancel();
                break;
            case "close":
                popUp.close();
                break;
            case "accept":
                popUp.clickOkBtn();
                break;
            default:
                throw new IllegalArgumentException("Unknown action: " + action);
        }
    }

    // confirm: confirm, don't confirm
    @When("{I |}'$confirm' and '$action' reading BSkyB confirmation popup on order item page if pop-up is visible")
    public void confirmReadingBSkyBPopUpIfVisible(String confirm, String action) {
        if (!getSut().getWebDriver().getCurrentUrl().contains("/proceed")) {
            OrderItemPage orderItemPage = getOrderItemPage();
            if (orderItemPage.isBSkyBConfirmPopUpVisible()) {
                orderItemPage.getBSkyBConfirmPopUp().confirmReading(confirm.equals("confirm"));
                actionOverBSkyBPopUp(action);
                orderItemPage.clickProceedButton();
            }
        }
    }

    // confirm: confirm, don't confirm
    @When("{I |}'$confirm' reading BSkyB confirmation popup on order item page")
    public void confirmReadingBSkyBPopUp(String confirm) {
        getOrderItemPage().getBSkyBConfirmPopUp().confirmReading(confirm.equals("confirm"));
    }

    @When("{I |}save as draft order")
    public void saveAsDraftOrder() {
        getOrderItemPage().saveAsDraft();
    }

    @When("{I |}save as draft order without delay")
    public void saveAsDraftOrderWithoutDelay() {
        getOrderItemPage().saveAsDraftWithoutDelay();
    }

    // | Transfer to | Message |
    @When("{I |}fill following fields for Transfer Order form on order item page: $fieldsTable")
    public void fillTransferOrderForm(ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);

        if (row.containsKey("Transfer to"))
            row.put("Transfer to", row.get("Transfer to").contains("email") ? wrapUserEmailWithTestSession(row.get("Transfer to")) : row.get("Transfer to"));
        //getOrderItemPage().getTransferOrderForm().fill(row);
        getOrderItemPage().getTransferOrderForm().fillTransfer(row);
    }

    @When("{I |}click Send button on Transfer Order form on order item page")
    public void sendOrderForTransfer() {
        Common.sleep(3000);
        getOrderItemPage().getTransferOrderForm().send();
    }

    @Then("{I |}'$shouldState' see Back button on order item page")
    public void checkVisibilityBackBtn(String shouldState) {
        assertThat("Check visibility Back button: ", getOrderItemPage().isBackButtonVisible(), is(shouldState.equals("should")));
    }

    @Then("{I |}'$shouldState' see title on order item page")
    public void checkVisibilityOrderItemPageTitle(String shouldState) {
        assertThat("Check visibility title: ", getOrderItemPage().isTitleVisible(), is(shouldState.equals("should")));
    }

    @Then("{I |}should see following title '$title' on order item page")
    public void checkOrderItemPageTitle(String title) {
        assertThat("Check order item page title: ", getOrderItemPage().getTitle(), equalTo(title));
    }

    @Then("{I |}should see selected following {market|flag} '$market' on order item page")
    public void checkSelectedMarketOnOrderItemPage(String market) {
        assertThat("Check selected market: " + market, getOrderItemPage().getSelectedMarket(), containsString(getCoreApi().getMarketByName(market).getCountry()));
    }

    @Then("{I |}'$shouldState' see available following markets '$markets' on Select market popup on order item page")
    public void checkMarketsAvailability(String shouldState, String markets) {
        List<String> availableMarkets = getOrderItemPage().getSelectedMarketPopUp().getAvailableMarkets();
        for (String market : markets.split(","))
            assertThat("Check availability of market: " + market, availableMarkets, shouldState.equals("should")
                    ? hasItem(market)
                    : not(hasItem(market)));
    }

    @Then("{I |}should see following {auto|spot gate} generated code '$autoCodePattern' for active order item on cover flow")
    public void checkCoverFlowItemAutoGeneratedCode(String autoCodePattern) {
        assertThat("Check auto generated code for order item on cover flow: ", getOrderItemPage().getActiveCoverFlowItem().getClockNumber(),
                StringByRegExpCheck.matches(autoCodePattern));
    }

    // | Title | Duration | Clock Number | Counter | Cover Title | Aspect Ratio | Format | Media Request |
    @Then("{I |}should see for active order item on cover flow following data: $fieldsTable")
    public void checkCoverFlowItemInfo(ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        OrderItemPage.CoverFlowItem coverFlowItem = getOrderItemPage().getActiveCoverFlowItem();
        if (row.containsKey("Title"))
            assertThat("Title: ", coverFlowItem.getTitle(), equalTo(wrapVariableByCriteria(row.get("Title"))));
        if (row.containsKey("Duration"))
            assertThat("Duration: ", coverFlowItem.getDuration(), equalTo(row.get("Duration")));
        if (Data.containsField(SchemaField.CLOCK_NUMBER, row, false))
            assertThat("Clock Number: ", coverFlowItem.getClockNumber(), equalTo(wrapVariableWithTestSession(Data.getField(SchemaField.CLOCK_NUMBER, row))));
        if (row.containsKey("Counter"))
            assertThat("Counter: ", coverFlowItem.getCounterContainer(), equalTo(row.get("Counter")));
        if (row.containsKey("Cover Title"))
            assertThat("Cover Title: ", coverFlowItem.getCoverTitle(), equalTo(wrapVariableByCriteria(row.get("Cover Title"))));
        if (row.containsKey("Aspect Ratio"))
            assertThat("Aspect Ratio: ", coverFlowItem.getAspectRatio(), equalTo(row.get("Aspect Ratio")));
        if (row.containsKey("Format"))
            assertThat("Format: ", coverFlowItem.getFormat(), containsString(row.get("Format")));
        if (row.containsKey("Media Request"))
            assertThat("Media Request: ", coverFlowItem.getMediaText(), equalTo(prepareMediaRequestCoverText(row.get("Media Request"))));
    }

    // | Title | Duration | Clock Number | Counter | Cover Title | Aspect Ratio | Format | Media Request |
    @Then("{I |}should see for order item with clock number '$clockNumber' on cover flow following data: $fieldsTable")
    public void checkCoverFlowItemInfo(String clockNumber, ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
        OrderItem orderItem = getOrderItemByClockNumber(order.getId(), wrapVariableWithTestSession(clockNumber));
        OrderItemPage.CoverFlowItem coverFlowItem = getOrderItemPage().getCoverFlowItemById(orderItem.getId());
        if (row.containsKey("Title"))
            assertThat("Title: ", coverFlowItem.getTitle(), equalTo(wrapVariableByCriteria(row.get("Title"))));
        if (row.containsKey("Duration"))
            assertThat("Duration: ", coverFlowItem.getDuration(), equalTo(row.get("Duration")));
        if (Data.containsField(SchemaField.CLOCK_NUMBER, row, false))
            assertThat("Clock Number: ", coverFlowItem.getClockNumber(), equalTo(wrapVariableWithTestSession(Data.getField(SchemaField.CLOCK_NUMBER, row))));
        if (row.containsKey("Counter"))
            assertThat("Counter: ", coverFlowItem.getCounterContainer(), equalTo(row.get("Counter")));
        if (row.containsKey("Cover Title"))
            assertThat("Cover Title: ", coverFlowItem.getCoverTitle(), equalTo(wrapVariableByCriteria(row.get("Cover Title"))));
        if (row.containsKey("Aspect Ratio"))
            assertThat("Aspect Ratio: ", coverFlowItem.getAspectRatio(), equalTo(row.get("Aspect Ratio")));
        if (row.containsKey("Format"))
            assertThat("Format: ", coverFlowItem.getFormat(), containsString(row.get("Format")));
        if (row.containsKey("Media Request"))
            assertThat("Media Request: ", coverFlowItem.getMediaText(), equalTo(prepareMediaRequestCoverText(row.get("Media Request"))));
    }

    @Then("{I |}'$shouldState' see preview asset '$contentName' of collection '$collectionName' for active order item on cover flow")
    public void checkCoverFlowItemPreview(String shouldState, String assetName, String collectionName) {
        Content asset = getAsset(getCategoryId(wrapCollectionName(collectionName)), wrapVariableByCriteria(assetName));
        if (asset == null)
            throw new NullPointerException("There are no any assets in the library with following name: " + wrapVariableByCriteria(assetName));
        assertThat("Check active cover flow item preview for: " + assetName, getOrderItemPage().isCoverFlowItemPreviewVisible(asset.getId()),
                is(shouldState.equals("should")));
    }

    @Then("{I |}should see count '$count' cover flow order items in carousel")
    public void checkCountCoverFlowOrderItems(int count) {
        assertThat("Count cover flow items: ", getOrderItemPage().getCountCoverFlowItems(), equalTo(count));
    }

    @Then("{I |}'$shouldState' see warning icon next active cover flow item")
    public void checkVisibilityWarningIconNextActiveCoverFlow(String shouldState) {
        assertThat("Check visibility warning icon next active cover flow: ", getOrderItemPage().getActiveCoverFlowItem().isWarningIconVisible(),
                is(shouldState.equals("should")));
    }

    @Then("{I |}'$shouldState' see success icon next active cover flow item")
    public void checkVisibilitySuccessIconNextActiveCoverFlow(String shouldState) {
        assertThat("Check visibility success icon next active cover flow: ", getOrderItemPage().getActiveCoverFlowItem().isSuccessIconVisible(),
                is(shouldState.equals("should")));
    }

    @Then("{I |}'$shouldState' see Cross button for active order item on cover flow")
    public void checkVisibilityCoverFlowDeleteItemButton(String shouldState) {
        OrderItemPage.CoverFlowItem coverFlowItem = getOrderItemPage().getActiveCoverFlowItem();
        assertThat("Check visibility Delete item button on cover flow: ", coverFlowItem.isCrossBtnVisible(),
                is(shouldState.equals("should")));
    }

    @Then("{I |}'$shouldState' see Cross button for order item with following clock number '$clockNumber' on cover flow")
    public void checkVisibilityCoverFlowDeleteItemButton(String shouldState, String clockNumber) {
        Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
        OrderItem orderItem = getOrderItemByClockNumber(order.getId(), wrapVariableWithTestSession(clockNumber));
        OrderItemPage.CoverFlowItem coverFlowItem = getOrderItemPage().getCoverFlowItemById(orderItem.getId());
        assertThat("Check visibility Delete item button on cover flow: ", coverFlowItem.isCrossBtnVisible(),
                is(shouldState.equals("should")));
    }

    @Then("{I |}'$shouldState' see order item with following clock number '$clockNumber' on cover flow")
    public void checkVisibilityCoverFlowItem(String shouldState, String clockNumber) {
        assertThat("Check visibility cover flow item with clock number: " + wrapVariableWithTestSession(clockNumber), getOrderItemPage().getVisibleCoverFlowItemClockNumbers(),
                shouldState.equals("should")
                        ? hasItem(wrapVariableWithTestSession(clockNumber))
                        : not(hasItem(wrapVariableWithTestSession(clockNumber))));
    }

    @Then("{I |}'$shouldState' see order item held for approval for active cover flow")
    public void checkIsItemHeldForApprovalOnActiveCoverFlow(String shouldState) {
        assertThat("Check is order item held for approval for active cover flow: ", getOrderItemPage().getActiveCoverFlowItem().isHeldForApproval(),
                is(shouldState.equals("should")));
    }


    @Given("{I |}clicked Held For Approval button on Order Item page via UI")
    @When("{I |}click Held For Approval button on Order Item page via UI")
    public void clickHeldForApprovalButtonOnOrderItemPage() {
        getOrderItemPage().getActiveCoverFlowItem().clickHeldForApprovalButtonOnOrderItemPageUi();
    }

    // state: enabled, disabled
    @Then("{I |}should see '$state' Hold for approval button for active cover flow on order item page")
    public void checkHoldForApprovalBtnStateOnActiveCoverFlow(String state) {
        assertThat("Check Hold for Approval State: ", getOrderItemPage().getActiveCoverFlowItem().isHoldForApprovalEnabled(),
                is(state.equals("enabled")));
    }

    @Then("{I |}'$shouldState' see On Hold button on order item page")
    public void checkVisibilityOnHoldBtn(String shouldState) {
        assertThat("Check visibility On Hold button: ", getOrderItemPage().isOnHoldVisible(), is(shouldState.equals("should")));
    }

    @Then("{I |}'$shouldState' see Add Commercial button on order item page")
    public void checkVisibilityAddCommercialBtn(String shouldState) {
        assertThat("Check visibility Add Commercial button: ", getOrderItemPage().isAddCommercialButtonVisible(), is(shouldState.equals("should")));
    }

    // sectionName: Add media, Add information, Additional information, Usage rights, Select Broadcast Destinations, Additional Services
    @Then("{I |}'$shouldState' see Copy to All link next to following sections '$sectionNameList' on order item page")
    public void checkVisibilityCopyToAllLink(String shouldState, String sectionNameList) {
        for (String sectionName : sectionNameList.split(","))
            assertThat("Check is Copy to All link visible for section: " + sectionName, getOrderItemPage().isCopyToAllVisibleNextToSection(sectionName),
                    is(shouldState.equals("should")));
    }

    // sectionName: Add media, Add information, Additional information, Usage rights, Select Broadcast Destinations, Additional Services
    @Then("{I |}'$shouldState' see expanded following sections '$sectionNameList' on order item page")
    public void checkIsSectionExpanded(String shouldState, String sectionNameList) {
        for (String sectionName : sectionNameList.split(","))
            assertThat("Check is expanded following section: " + sectionName, getOrderItemPage().isSectionExpanded(sectionName),
                    is(shouldState.equals("should")));
    }

    // sectionName: Add media, Add information, Additional information, Usage rights, Select Broadcast Destinations, Additional Services
    @Then("{I |}should see warning tooltip with message '$message' next following section '$sectionName' on order item page")
    public void checkWarningTooltipMessageNextSection(String message, String sectionName) {
        assertThat("Check warning tooltip message for section: " + sectionName, getOrderItemPage().getWarningMessageNextSection(sectionName), equalTo(message));
    }

    // Warning message for DeliveryAccessRuleBuilder Fields
    @Then("{I |}should see warning with message '$message' next following field '$fieldName' on order item page")
    public void checkWarningDeliveryAccessRuleBuilderFields(String message, String fieldName) {
        String actual = null;
        actual = getOrderItemPage().warningMessageDeliveryAccessRuleBuilderFields(fieldName.toLowerCase());
        assertThat("Check warning message for field: " + fieldName, actual, equalTo(message));
    }


    // sectionName: Add media, Add information, Usage rights, Select Broadcast Destinations
    @Then("{I |}'$shouldState' see warning icon next following sections '$sectionNameList'")
    public void checkVisibilityWarningIconNextFollowingSections(String shouldState, String sectionNameList) {
        for (String sectionName : sectionNameList.split(","))
            assertThat("Check visibility warning icon next section: " + sectionName, getOrderItemPage().isWarningIconVisibleNextSection(sectionName),
                    is(shouldState.equals("should")));
    }

    // sectionName: Common Information, Add media, Add information, Additional information, Usage rights, Select Broadcast Destinations, Additional Services
    @Then("{I |}'$shouldState' see following sections '$sectionNameList' on order item page")
    public void checkVisibilitySection(String shouldState, String sectionNameList) {
        for (String sectionName : sectionNameList.split(","))
            assertThat("Check visibility section " + sectionName, getOrderItemPage().isSectionVisible(sectionName), is(shouldState.equals("should")));
    }

    @Then("{I |}'$shouldState' see BSkyB confirmation popup on order item page")
    public void checkBSkyBPopUpVisibility(String shouldState) {
        assertThat("Check BSkyB popup visibility: ", getOrderItemPage().isBSkyBConfirmPopUpVisible(), is(shouldState.equals("should")));
    }

    // state: inactive, active
    @Then("{I |}should see '$state' Select Broadcast Destinations section on order item page")
    public void checkSelectBroadcastDestinationsState(String state) {
        assertThat("Check Select Broadcast Destinations state: ", getOrderItemPage().isSelectBroadcastDestinationsSectionActive(), is(state.equals("active")));
    }

    // state: inactive, active
    @Then("{I |}should see '$state' QC & Ingest Only button on order item page")
    public void checkQcIngestBtnState(String state) {
        assertThat("Check QC & Ingest Only button state: ", getOrderItemPage().isQcIngestOnlyBtnActive(), is(state.equals("active")));
    }

    @Then("{I |}should see following invoicing organisation '$agencyName' on order item page")
    public void checkInvoicingOrganisationOnItemPage(String agencyName) {
        assertThat("Check invoicing organisation on order item page: ", getOrderItemPage().getInvoicingOrganisation(), equalTo(getAgencyName(agencyName)));
    }

    @Then("{I |}'$shouldState' see Invoice To option on order item page")
    public void checkInvoiceToVisibility(String shouldState) {
        assertThat("Check Invoice To option visibility: ", getOrderItemPage().isInvoiceToVisible(), is(shouldState.equals("should")));
    }

    @Then("{I |}should see following on behalf of BU '$agencyName' on order item page")
    public void checkOnBehalfOfBU(String agencyName) {
        assertThat("Check on behalf of BU on order item page: ", getOrderItemPage().getOnBehalfOfBU(), equalTo(getAgencyName(agencyName)));
    }

    @Then("{I |}'$shouldState' see on behalf of BU option on order item page")
    public void checkOnBehalfOfBUOptionVisibility(String shouldState) {
        assertThat("Check on behalf of BU option visibility: ", getOrderItemPage().isOnBehalfOfBUVisible(), is(shouldState.equals("should")));
    }

    @Then("{I |}'$shouldState' see available following invoice on behalf of BUs '$buList' on Change BU on behalf of popup")
    public void checkAvailabilityInvoiceOnBehalfBUs(String shouldState, String buList) {
        List<String> invoiceOnBehalfOfBUs = getOrderItemPage().getChangeBUOnBehalfOfPopUp().getAvailableInvoiceOnBehalfOfBUs();
        for (String invoiceOnBehalfOfBU : buList.split(","))
            assertThat("Check availability invoice on behalf of BU: " + invoiceOnBehalfOfBU, invoiceOnBehalfOfBUs, shouldState.equals("should")
                    ? hasItem(wrapVariableWithTestSession(invoiceOnBehalfOfBU))
                    : not(hasItem(wrapVariableWithTestSession(invoiceOnBehalfOfBU))));
    }


    @Then("{I |}should see following warning message '$warningMessage' on behalf of BU on order item page")
    public void checkWarningMessageOnBehalfOfBU(String warningMessage) {
        assertThat("Check warning message on behalf of BU: ", getOrderItemPage().getOnBehalfOfBUWarningMessage(), equalTo(warningMessage));
    }

    // state: disabled, enabled
    @Then("{I |}should see '$state' Proceed button on order item page")
    public void checkProceedBtnState(String state) {
        assertThat("Check Proceed button state: ", getOrderItemPage().isProceedButtonEnabled(), is(state.equals("enabled")));
    }

    @Then("{I |}'$shouldState' see Proceed button on order item page")
    public void checkProceedBtnVisibility(String shouldState) {
        assertThat("Check Proceed button visibility: ", getOrderItemPage().isProceedButtonVisible(), is(shouldState.equals("should")));
    }

    @When("{I |}fill in following fields for Change BU on behalf of popup on order page: $fieldsTable")
    public void fillInChangeBUOnBehalfOf(ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        ChangeBUOnBehalf popUp = getSut().getPageCreator().getBasePage().getBUChangeOnBehalfOfPopUp().selectOnBehalfOfBU(row.get("On Behalf Of BU"));
        if (row.containsKey("Invoice On Behalf Of BU"))
            popUp.selectInvoiceOnBehalfOfBU(row.get("Invoice On Behalf Of BU"));
        popUp.clickOkBtn();
        //   if (row.containsKey("Invoice On Behalf Of BU")) popUp.selectInvoiceOnBehalfOfBU(row.get("Invoice On Behalf Of BU"));
    }

    // $queueName: Orders not replicated to A4 | Order completion queue
    @Given("I {deleted|cleared} orders struck in '$queueName' queues")
    @When("I {delete|clear} orders struck in '$queueName' queues")
    public void deleteOrdersFromOrderingAdminQueues(String queueName) {
        for (String qName : queueName.split(";")) {
            switch (qName.trim()) {
                case "Orders not replicated to A4":
                    List<Order> struckedOrdersList = getCoreApiAdmin().getOrdersFromOrdersNotReplicatedToA4Queue(5000);
                    List<String> ordersToBeDeleted = new ArrayList<>();
                    if (struckedOrdersList != null && struckedOrdersList.size() > 0) {
                        log.info("\n     ***** DELETING ALL ORDERS STRUCK IN '" + qName + "' QUEUE *****");
                        for (Order order : struckedOrdersList) {
                            OrderItem[] items = order.getDeliverables().getOrderItems();
                            ordersToBeDeleted.add(order.getId());
                            for (OrderItem item : items)
                                log.info("Clock Number: " + item.getClockNumber() +
                                        " .... StatusCode: " + order.getStatusCodeError() + " .... ErrorMessage: " + order.getMessageError());
                        }
                        getCoreApiAdmin().deleteOrdersFromOrdersNotReplicatedToA4Queue(ordersToBeDeleted);
                        Common.sleep(500); // small sync time
                    } else log.info("Found zero orders in '" + qName + "' queue. Nothing to Clear.");
                    break;
                case "Order completion queue":
                    List<String> listOfStruckedOrders = getCoreApiAdmin().getOrdersFromOrderCompletionQueue_id();
                    if (listOfStruckedOrders != null && listOfStruckedOrders.size() > 0) {
                        log.info("\n     ***** DELETING ALL ORDERS STRUCK IN '" + qName + "' QUEUE *****");
                        for (String ord : listOfStruckedOrders) {
                            getCoreApiAdmin().deleteOrdersFromCompletionQueue(ord);
                            log.info("Order " + ord + "is in failed state in Order completion queue");
                        }
                    } else log.info("Found zero orders in '" + qName + "' queue. Nothing to Clear.");
                    break;
                default:
                    throw new IllegalArgumentException("Unknown Queue name: '" + qName + "'. Please check Queue name.");
            }
        }
    }
}