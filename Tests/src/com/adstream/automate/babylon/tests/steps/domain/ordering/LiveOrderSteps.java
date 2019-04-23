package com.adstream.automate.babylon.tests.steps.domain.ordering;

import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.JsonObjects.ordering.*;
import com.adstream.automate.babylon.JsonObjects.ordering.enums.ApprovalStatus;
import com.adstream.automate.babylon.JsonObjects.ordering.enums.OrderReportType;
import com.adstream.automate.babylon.JsonObjects.ordering.enums.UploadRequestType;
import com.adstream.automate.babylon.sut.pages.ordering.OrderSummaryPage;
import com.adstream.automate.babylon.sut.pages.ordering.ViewBillingPage;
import com.adstream.automate.babylon.sut.pages.ordering.ViewMediaDetailsPage;
import com.adstream.automate.babylon.sut.pages.ordering.elements.Data;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.SchemaField;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.popupForms.AssignSomeoneToSupplyMediaForm;
import com.adstream.automate.babylon.sut.pages.ordering.elements.lists.ClockDeliveryList;
import com.adstream.automate.babylon.sut.pages.ordering.elements.lists.ClockDeliveryNestedList;
import com.adstream.automate.babylon.sut.pages.ordering.elements.lists.DestinationDeliveredList;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.DateTimeUtils;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.openqa.selenium.NoSuchElementException;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 31.10.13
 * Time: 17:22
 */
public class LiveOrderSteps extends OrderingHelperSteps {

    private OrderSummaryPage openOrderSummaryPage(String orderId) {
        return getSut().getPageNavigator().getOrderSummaryPage(orderId);
    }

    private OrderSummaryPage getOrderSummaryPage() {
        return getSut().getPageCreator().getOrderSummaryPage();
    }

    private ViewBillingPage getViewBillingPage() {
        return getSut().getPageCreator().getViewBillingPage();
    }

    private AssignSomeoneToSupplyMediaForm getAssignSomeoneToSupplMediaForm() {
        return getOrderSummaryPage().getAssignSomeoneToSupplyMediaForm();
    }

    private ViewMediaDetailsPage openViewMediaDetailsPage(String contentId, String clockNumber, String orderId) {
        return getSut().getPageNavigator().getViewMediaDetailsPage(contentId, clockNumber, orderId);
    }

    private ViewMediaDetailsPage getViewMediaDetailsPage() {
        return getSut().getPageCreator().getViewMediaDetailsPage();
    }

    private DestinationDeliveredList getDestinationDeliveredList() {
        DestinationDeliveredList destinationDeliveredList = getViewMediaDetailsPage().getDestinationDeliveredList();
        if (destinationDeliveredList == null)
            throw new NoSuchElementException("Destination delivered list is not present on View Media Details page!");
        return destinationDeliveredList;
    }

    private String prepareAssignedToSupplyMedia(String assignedToSupplyMedia) {
        StringBuilder sb = new StringBuilder("Been assigned to supply media: ");
        if (!assignedToSupplyMedia.isEmpty()) {
            String[] assignedToSupplyMediaParts = assignedToSupplyMedia.split(" ");
            for (String assignedToSupplyMediaPart: assignedToSupplyMediaParts) {
                sb.append(wrapUserEmailWithTestSession(assignedToSupplyMediaPart));
                if (!assignedToSupplyMediaPart.equals(assignedToSupplyMediaParts[assignedToSupplyMediaParts.length - 1])) sb.append(" ");
            }
        }
        return sb.toString();
    }

    private void checkDestinationDeliveredList(Order order, Map<String, String> row) {
        String orderReference = String.valueOf(order.getOrderReference());
        DestinationDeliveredList.DestinationDelivered destinationDelivered = getDestinationDeliveredList().getDestinationDeliveredByOrderReference(orderReference);
        if (row.containsKey("Order #"))
            assertThat("Order #: ", destinationDelivered.getOrderReference(), equalTo(orderReference));
            assertThat("Destination: ", destinationDelivered.getDestination(), equalTo(row.get("Destination")));
        if (row.containsKey("Date Ordered"))
            assertThat("Date Ordered: ", formatDateTimeToUTC(destinationDelivered.getDateOrdered()), equalTo(convertDateTimeToDefaultUserLocale(order.getSubmitted())));   // format UI date to UTC format, because core keeps date in UTC
        if (row.containsKey("Ordered by")) {
            User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(row.get("Ordered by")));
            assertThat("Ordered by: ", destinationDelivered.getOrderedBy(), equalTo(user.getFullName()));
        }
        assertThat("Status: ", destinationDelivered.getStatus(), equalTo(row.get("Status")));
    }

    @Given("I am on Order Summary page for order contains item with following {isrc code|clock number} '$clockNumber'")
    @When("{I |}go to Order Summary page for order contains item with following {isrc code|clock number} '$clockNumber'")
    public OrderSummaryPage toOrderSummaryPage(String clockNumber) {
        return openOrderSummaryPage(getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getId());
    }

    @When("I click ViewDeliveryReport button on the Order Summary Page")
    public void clickViewDeliveryReport() {
        getSut().getPageNavigator().getOrderSummaryPage().clickViewDeliveryReportButton();
    }

    @When("I click View Billing button on the Order Summary Page")
    public void clickViewBilling() {
        getSut().getPageNavigator().getOrderSummaryPage().clickViewBillingButton();
    }

    @Given("I am on Order Summary page for order with following market '$market'")
    @When("{I |}go to Order Summary page for order with following market '$market'")
    public OrderSummaryPage toOrderSummaryPageByOrderMarket(String market) {
        return openOrderSummaryPage(getOrderByMarket(market).getId());
    }

    @Given("I am on View Media Details page for order contains item with following clock number '$clockNumber'")
    @When("{I |}go to View Media Details page for order contains item with following clock number '$clockNumber'")
    public ViewMediaDetailsPage toViewMediaDetailsPage(String clockNumber) {
        clockNumber = wrapVariableWithTestSession(clockNumber);
        Order order = getOrderByItemClockNumber(clockNumber);
        OrderItem orderItem = getOrderItemByClockNumber(order.getId(), clockNumber);
        return openViewMediaDetailsPage(getOrderItemContentId(orderItem), clockNumber, order.getId());
    }

    @Given("I am on View Media Details page for order with market '$market' contains item with clock number '$clockNumber'")
    @When("{I |}go to View Media Details page for order with market '$market' contains item with clock number '$clockNumber'")
    public ViewMediaDetailsPage toViewMediaDetailsPage(String market, String clockNumber) {
        clockNumber = wrapVariableWithTestSession(clockNumber);
        Order order = getOrderByMarket(market);
        OrderItem orderItem = getOrderItemByClockNumber(order.getId(), clockNumber);
        return openViewMediaDetailsPage(getOrderItemContentId(orderItem), clockNumber, order.getId());
    }

    @Given("I am on View Media Details page for order that contains QCed asset with following clock number '$clockNumber'")
    @When("{I |}go to View Media Details page for order that contains QCed asset with following clock number '$clockNumber'")
    public ViewMediaDetailsPage toViewMediaDetailsPageOfOrderWithQCedAsset(String clockNumber) {
        clockNumber = wrapVariableWithTestSession(clockNumber);
        Order order = getOrderByItemClockNumber(clockNumber);
        OrderItem orderItem = getOrderItemByClockNumber(order.getId(), clockNumber);
        return openViewMediaDetailsPage(getOrderItemContentIdWithQcedAsset(orderItem), clockNumber, order.getId());
    }

    @When("{I |}back to ordering page from Order Summary page")
    public void backToOrderingPageFromOrderSummaryPage() {
        getOrderSummaryPage().back();
    }

    @When("{I |}fill following fields for Assign someone to supply media form that supply via '$uploadRequestType' on order summary page: $fieldsTable")
    public void fillAssignSomeoneToSupplyMediaForm(String uploadRequestType, ExamplesTable fieldsTable) {
        Map<String, String> row = prepareAssignSomeoneToSupplyMediaData(parametrizeTabularRow(fieldsTable));
        AssignSomeoneToSupplyMediaForm form = getAssignSomeoneToSupplMediaForm();
        if (!uploadRequestType.isEmpty()) form.supplyVia(UploadRequestType.findByName(uploadRequestType));
        form.fill(row);

    }


    @Then("{I |}should see the previous assignee on supply media form on order summary page: $fieldsTable")
    public void checkPreviousAssignee(ExamplesTable fieldsTable) {
        Map<String, String> row = prepareAssignSomeoneToSupplyMediaData(parametrizeTabularRow(fieldsTable));
        AssignSomeoneToSupplyMediaForm form = getAssignSomeoneToSupplMediaForm();
        for (Map.Entry<String, String> entry : row.entrySet()) {
            assertThat("Check field: " + entry.getKey(), form.getFieldValue(entry.getKey()), equalTo(wrapUserEmailWithTestSession(entry.getValue())));
        }
    }

    // | Search Groups | Group Name |
    @When("{I |}fill following fields for Select Group popup of Assign someone to supply media form on order summary page: $fieldsTable")
    public void fillSelectGroupForm(ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        if (row.containsKey("Search Groups")) row.put("Search Groups", wrapVariableWithTestSession(row.get("Search Groups")));
        if (row.containsKey("Group Name")) row.put("Group Name", String.valueOf(row.get("Group Name").equals("should")));
        getAssignSomeoneToSupplMediaForm().getSelectNotificationGroup(row.get("Search Groups")).fill(row);
    }

    @When("{I |}accept selection of specified notification group '$groupName' on Select Group popup of Assign someone to supply media form on order summary page")
    public void acceptSelectionOfNotificationGroup(String groupName) {
        getAssignSomeoneToSupplMediaForm().getSelectNotificationGroup(wrapVariableWithTestSession(groupName)).select();

    }

    @When("{I |}send order to supply media by someone on order summary page")
    public void sendOrderToSupplyMediaBySomeone() {
        getAssignSomeoneToSupplMediaForm().send();
    }

    @Given("{I |}approve '$orderType' order items with following clock numbers '$clockNumberList'")
    @When("{I |}approved '$orderType' order items with following clock numbers '$clockNumberList'")
    public void approvedOrderItems(String orderType, String clockNumberList) {
        for (String clockNumber : clockNumberList.split(",")) {
            Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
            OrderItem orderItem = getOrderItemByClockNumber(order.getId(), wrapVariableWithTestSession(clockNumber));
            waitForFinishPlaceOrderToA4(order.getId(), sleep);
            getCoreApi().holdForApprovalOrderItem(order.getId(), orderItem.getId(), getItemTypeByOrderType(orderType), ApprovalStatus.APPROVED.toString());
        }
    }

    @When("{I |}approve order item with following clock number '$clockNumber' on '$orderStatus' order summary page")
    public void approveOrderItemOnOrderSummaryPage(String clockNumber, String orderStatus) {
        ClockDeliveryList.ClockDelivery clockDelivery = getOrderSummaryPage().getClockDeliveryList().getClockDeliveryByClockNumber(wrapVariableWithTestSession(clockNumber), orderStatus);
        clockDelivery.getApprovalConfirmationPopUp().clickOkBtn();
    }

    @Then("{I |}'$shouldState' see Order Summary page")
    public void checkVisibilityOrderSummaryPage(String shouldState) {
        assertThat("Check visibility of Order Summary page: ", getSut().getWebDriver().getCurrentUrl(), shouldState.equals("should")
                ? containsString("/summary")
                : not(containsString("/summary")));
    }

    //state: enabled, disabled
    @Then("{I |}should see '$state' View Delivery Report button on order summary page")
    public void checkStateViewDeliveryReportButton(String state) {
        assertThat("Check View Delivery Report button state: ", getOrderSummaryPage().isViewDeliveryReportButtonEnabled(), is(state.equals("enabled")));
    }

    @Then("{I |}should see that View '$orderReportType' report opens for order with {isrc code|clock number} '$clockNumber'")
    public void checkOpeningViewReport(String orderReportType, String clockNumber) {
        Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
        //---------------------------Validating View Delivery Report using UI--------------------------------------------
        if(orderReportType.equals("Delivery")) {
            assertThat("Check HTTP status code when open delivery report: ",
                    getMtApi().getHttpStatusCodeWhileGetOrderReport(OrderReportType.findByType(orderReportType), order.getId()), equalTo(200));
            assertThat("Check that delivery report is opened: ",
                    getOrderSummaryPage().checkViewDeliveryReportOpened(), is(true));
            //---------------------------Validating View Billing--------------------------------------------
        }else if(orderReportType.equals("Billing")) {
            assertThat("Check HTTP status code when open billing report: ",
                    getCoreApi().getHttpStatusCodeWhileGetOrderReport(OrderReportType.findByType(orderReportType), order.getId()), equalTo(200));
            assertThat("Check that Billing view is opened: ", getViewBillingPage().checkViewBillingOpened(), is(true));
        }
    }


    // buttonName: View Confirmation Report, View Delivery Report, View Billing, Send New Upload Request
    @Then("{I |}'$shouldState' see '$buttonNamesList' button{s|} on order summary page")
    public void checkViewConfirmationReportBtnVisibility(String shouldState, String buttonNamesList) {
        for (String buttonName: buttonNamesList.split(","))
            assertThat("Check " + buttonName + " button visibility: ", getOrderSummaryPage().isViewButtonVisible(buttonName), is(shouldState.equals("should")));
    }

    @Then("{I |}'$shouldState' see Assign someone to supply media form on order summary page")
    public void checkVisibilityAssignSomeoneToSupplyMediaForm(String shouldState) {
        assertThat("Check visibility Assign someone to supply media form: ", getOrderSummaryPage().isAssignSomeoneToSupplyMediaFormVisible(), is(shouldState.equals("should")));
    }

    // | Order Number | Organisation | Date Submitted | Created By | Job Number | PO Number | Flag | Market | Invoiced Organisation | Assigned To Supply Media |
    @Then("{I |}should see for order contains item with {isrc code|clock number} '$clockNumber' following summary information on order summary page: $fieldsTable")
    public void checkOrderSummaryInformation(String clockNumber, ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
        OrderSummaryPage.OrderSummaryInformation summaryInfo = getOrderSummaryPage().getOrderSummaryInformation();
        if (row.containsKey("Order Number"))
            assertThat("Order Number: ", summaryInfo.getOrderNumber(), equalTo(String.valueOf(order.getOrderReference())));
        if (row.containsKey("Organisation")) assertThat("Organisation: ", summaryInfo.getOrganisation(), equalTo(wrapAgencyName(row.get("Organisation"))));
        if (row.containsKey("Date Submitted")) {
            String[] DateSubList = summaryInfo.getDateSubmitted().split("GMT");
            SimpleDateFormat date12Format = new SimpleDateFormat("DD/MM/YY,hh:mm aa");
            try {
                if(summaryInfo.getDateSubmitted().contains("GMT+01:00")) {
                    assertThat("Date Submitted: ", date12Format.parse(DateSubList[0]).compareTo(date12Format.parse(convertDateTimeToDefaultUserLocale(order.getSubmitted())))==1);
                }else{
                    assertThat("Date Submitted: ", date12Format.parse(DateSubList[0]).toString(), equalTo(date12Format.parse(convertDateTimeToDefaultUserLocale(order.getSubmitted())).toString()));
                }
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        if (row.containsKey("Created By"))
            assertThat("Created By: ", summaryInfo.getCreatedBy(), equalTo(row.get("Created By").equals("CreatedBy") ? order.getSubmittedBy().getUserFullName() : row.get("Created By")));
        if (row.containsKey("Job Number")) assertThat("Job Number: ", summaryInfo.getJobNumber(), equalTo(wrapVariableWithTestSession(row.get("Job Number"))));
        if (row.containsKey("PO Number")) assertThat("PO Number: ", summaryInfo.getPoNumber(), equalTo(wrapVariableWithTestSession(row.get("PO Number"))));
        if (row.containsKey("Flag")) assertThat("Flag: ", summaryInfo.getFlag(), containsString(getCoreApi().getMarketByName(row.get("Flag")).getCountry()));
        if (row.containsKey("Market")) assertThat("Market: ", summaryInfo.getMarket(), equalTo(row.get("Market")));
        if (row.containsKey("Assigned To Supply Media")) assertThat("Assigned To Supply Media: ", summaryInfo.getAssignedToSupplyMedia(), equalTo(prepareAssignedToSupplyMedia(row.get("Assigned To Supply Media"))));
        if (row.containsKey("Invoiced Organisation")) assertThat("Invoiced Organisation: ", summaryInfo.getInvoicedOrganisation(), equalTo(wrapAgencyName(row.get("Invoiced Organisation"))));
    }

    @Then("{I |}should see the following information for {isrc code|clock number} '$clockNumber' on order summary page: $fieldsTable")
    public void checkOrderSummaryInformationWithoutTestSession(String clockNumber, ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
        OrderSummaryPage.OrderSummaryInformation summaryInfo = getOrderSummaryPage().getOrderSummaryInformation();

        if (row.containsKey("Job Number")) assertThat("Job Number: ", summaryInfo.getJobNumber(), equalTo(row.get("Job Number")));
        if (row.containsKey("PO Number")) assertThat("PO Number: ", summaryInfo.getPoNumber(), equalTo(row.get("PO Number")));
    }


    @Then("{I |}'$shouldState' see column{s|} '$columnNamesList' for clock delivery list on order summary page")
    public void checkVisibilityClockDeliveryTableHeaders(String shouldState, String columnNamesList) {
        List<String> actualColumns = getOrderSummaryPage().getClockDeliveryList().getVisibleColumnTitles();
        for (String columnName : columnNamesList.split(","))
            assertThat("Check visibility table column: " + columnName, actualColumns, shouldState.equals("should") ? hasItem(columnName) : not(hasItem(columnName)));
    }

    // | Clock Number | Advertiser | Product | Title | On-air-Date | Format | Duration | Status | Approve |
    @Then("{I |}should see clock delivery with following fields on '$orderStatus' order summary page: $fieldsTable")
    public void checkOrderSummaryClockDelivery(String orderStatus, ExamplesTable fieldsTable) {
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            if (Data.containsField(SchemaField.CLOCK_NUMBER, row, false))
                row.put("Clock Number", wrapVariableWithTestSession(Data.getField(SchemaField.CLOCK_NUMBER, row)));
            else
                throw new IllegalArgumentException("Clock Number is required field!");
            ClockDeliveryList.ClockDelivery clockDelivery = getOrderSummaryPage().getClockDeliveryList().getClockDeliveryByClockNumber(row.get("Clock Number"), orderStatus);
            assertThat("Clock Number: ", clockDelivery.getClockNumber(), equalTo(row.get("Clock Number")));
            if (Data.containsField(SchemaField.ADVERTISER, row, false)) assertThat("Advertiser: ", clockDelivery.getAdvertiser(), equalTo(prepareAdvertiser(Data.getField(SchemaField.ADVERTISER, row))));
            if (Data.containsField(SchemaField.BRAND, row, false)) assertThat("Brand: ", clockDelivery.getBrand(), equalTo(wrapVariableWithTestSession(Data.getField(SchemaField.BRAND, row))));
            if (Data.containsField(SchemaField.SUB_BRAND, row, false)) assertThat("Sub Brand: ", clockDelivery.getSubBrand(), equalTo(wrapVariableWithTestSession(Data.getField(SchemaField.SUB_BRAND, row))));
            if (Data.containsField(SchemaField.PRODUCT, row,false)) assertThat("Product: ", clockDelivery.getProduct(), equalTo(wrapVariableWithTestSession(Data.getField(SchemaField.PRODUCT, row))));
            if (Data.containsField(SchemaField.CAMPAIGN, row, false)) assertThat("Campaign: ", clockDelivery.getCampaign(), equalTo(wrapVariableWithTestSession(Data.getField(SchemaField.CAMPAIGN, row))));
            if (row.containsKey("Title")) assertThat("Title: ", clockDelivery.getTitle(), equalTo(wrapVariableWithTestSession(row.get("Title"))));
            if (Data.containsField(SchemaField.FIRST_AIR_DATE, row, false)) assertThat("First Air Date: ", clockDelivery.getFirstAirDate(), equalTo(convertDateToDefaultUserLocale(Data.getField(SchemaField.FIRST_AIR_DATE, row))));
            if (row.containsKey("Format")) assertThat("Format: ", clockDelivery.getFormat(), equalTo(row.get("Format")));
            if (row.containsKey("Duration")) assertThat("Duration: ", clockDelivery.getDuration(), equalTo(row.get("Duration")));
            if (row.containsKey("Status")) assertThat("Status:", clockDelivery.getStatus(), equalTo(row.get("Status")));
            if (row.containsKey("Approve")) assertThat("Approve:", clockDelivery.getApprove(), equalTo(row.get("Approve")));
        }
    }

    // | Destination | Status | Time of Delivery | Priority |
    @Then("{I |}should see clock delivery '$clockNumber' contains destinations with following fields on '$orderStatus' order summary page: $fieldsTable")
    public void checkOrderSummaryDestinations(String clockNumber, String orderStatus, ExamplesTable fieldsTable) {
        ClockDeliveryList.ClockDelivery clockDelivery = getOrderSummaryPage().getClockDeliveryList().getClockDeliveryByClockNumber(wrapVariableWithTestSession(clockNumber), orderStatus);
        ClockDeliveryNestedList clockDeliveryNestedList = clockDelivery.getClockDeliveryNestedList();
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            String destinationName = prepareDestination(row.get("Destination"));
            ClockDeliveryNestedList.Destination destination = clockDeliveryNestedList.getDestinationByName(destinationName);
            if (row.containsKey("Destination")) assertThat("Destination: ", destination.getDestination(), equalTo(destinationName));
            if (row.containsKey("Status")) assertThat("Status: ", destination.getSelectedStatus(), equalTo(row.get("Status")));
            if (row.containsKey("Time of Delivery")) assertThat("Time of Delivery: ", destination.getTimeDelivery(), equalTo(row.get("Time of Delivery")));
            if (row.containsKey("Priority")) assertThat("Priority: ", destination.getPriority(), equalTo(row.get("Priority")));
        }
    }

    @Then("{I |}'$shouldState' see following destinations '$destinations' for clock delivery '$clockNumber' on '$orderStatus' order summary page")
    public void checkVisibilityOrderSummaryDestinations(String shouldState, String destinations, String clockNumber, String orderStatus) {
        ClockDeliveryList.ClockDelivery clockDelivery = getOrderSummaryPage().getClockDeliveryList().getClockDeliveryByClockNumber(wrapVariableWithTestSession(clockNumber), orderStatus);
        ClockDeliveryNestedList destinationList = clockDelivery.getClockDeliveryNestedList();
        for (String destination : destinations.split(",")){
            assertThat("Check visibility order summary destination: " + destination + " for clock delivery: " + wrapVariableWithTestSession(clockNumber),
                    destinationList.getVisibleDestinations(), shouldState.equals("should") ? hasItem(destination) : not(hasItem(destination)));
        }
    }

    @Then("{I |}'$shouldState' see that following destinations '$destinations' are cancelled for clock delivery '$clockNumber' on '$orderStatus' order summary page")
    public void checkVisibilityOrderSummaryOfCancelledDestinations(String shouldState, String destinations, String clockNumber, String orderStatus) {
        ClockDeliveryList.ClockDelivery clockDelivery = getOrderSummaryPage().getClockDeliveryList().getClockDeliveryByClockNumber(wrapVariableWithTestSession(clockNumber), orderStatus);
        ClockDeliveryNestedList destinationList = clockDelivery.getClockDeliveryNestedList();
        for (String destination : destinations.split(",")){
            assertThat("Check visibility order summary destination: " + destination + " for clock delivery: " + wrapVariableWithTestSession(clockNumber),
                    destinationList.getDestinationByName(destination).getStatusCancelled(), shouldState.equals("should") ? is("This Delivery has been cancelled") : not(is("This Delivery has been cancelled")));
        }
    }

    // | Clock Number | Advertiser | Brand | Sub Brand | Product | Title | Duration | First Air Date | Additional Details | Video Format | Aspect Ratio | Video Standard |
    @Then("{I |}should see following media information on View Media Details page: $fieldsTable")
    public void checkMediaInformation(ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        if (row.containsKey("Title")) row.put("Title", wrapVariableByCriteria(row.get("Title")));
        if (row.containsKey("Clock Number")) row.put("Clock Number", wrapVariableWithTestSession(row.get("Clock Number")));
        if (row.containsKey("Advertiser")) row.put("Advertiser", prepareAdvertiser(row.get("Advertiser")));
        if (row.containsKey("Brand")) row.put("Brand", wrapVariableWithTestSession(row.get("Brand")));
        if (row.containsKey("Sub Brand")) row.put("Sub Brand", wrapVariableWithTestSession(row.get("Sub Brand")));
        if (row.containsKey("Product")) row.put("Product", wrapVariableWithTestSession(row.get("Product")));
        ViewMediaDetailsPage.MediaInformation mediaInformation = getViewMediaDetailsPage().getMediaInformation();
        assertThat("Clock Number: ", mediaInformation.getClockNumber(), equalTo(row.get("Clock Number")));
        assertThat("Advertiser: ", mediaInformation.getAdvertiser(), equalTo(row.get("Advertiser")));
        assertThat("Brand: ", mediaInformation.getBrand(), equalTo(row.get("Brand")));
        assertThat("Sub Brand: ", mediaInformation.getSubBrand(), equalTo(row.get("Sub Brand")));
        assertThat("Product: ", mediaInformation.getProduct(), equalTo(row.get("Product")));
        assertThat("Title: ", mediaInformation.getTitle(), equalTo(row.get("Title")));
        assertThat("Duration: ", mediaInformation.getDuration(), equalTo(row.get("Duration")));
        assertThat("First Air Date: ", mediaInformation.getFirstAirDate(), equalTo(convertDateToDefaultUserLocale(row.get("First Air Date"))));
        assertThat("Additional Details: ", mediaInformation.getAdditionalDetails(), equalTo(row.get("Additional Details")));
        assertThat("Video Format: ", mediaInformation.getVideoFormat(), equalTo(row.get("Video Format")));
        assertThat("Aspect Ratio: ", mediaInformation.getAspectRatio(), equalTo(row.get("Aspect Ratio")));
        assertThat("Video Standard: ", mediaInformation.getVideoStandard(), equalTo(row.get("Video Standard")));
        if (row.containsKey("Other Metadata Values"))
            for (String value: row.get("Other Metadata Values").split(","))
                assertThat("Other Metadata Values: ", mediaInformation.getOtherMetadataValues(), hasItem(value));
    }

    // | Order # | Destination | Date Ordered | Ordered by | Status |
    @Then("{I |}should see destination delivered for order contains item with clock number '$clockNumber' with following fields: $fieldsTable")
    public void checkDestinationDeliveredByItemClockNumber(String clockNumber, ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
        checkDestinationDeliveredList(order, row);
    }

    // | Order # | Destination | Date Ordered | Ordered by | Status |
    @Then("{I |}should see destinations delivered for orders with markets '$marketList' with following fields: $fieldsTable")
    public void checkDestinationDeliveredByOrderMarket(String marketList, ExamplesTable fieldsTable) {
        String [] markets = marketList.split(",");
        if (markets.length != fieldsTable.getRowCount())
            throw new IllegalStateException("Count markets different from count destinations delivered!");
        for (int i = 0;  i < markets.length; i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            Order order = getOrderByMarket(markets[i]);
            checkDestinationDeliveredList(order, row);
        }
    }

    @Then("{I |}'$shouldState' see destinations delivered list on View Media Details page")
    public void checkVisibilityDestinationsDeliveredList(String shouldState) {
        assertThat("Check visibility destinations delivered list: ", getViewMediaDetailsPage().getDestinationDeliveredList(),
                                                                     shouldState.equals("should") ? not(nullValue()) : nullValue());
    }

    // | Clock # | Advertiser | Brand | Sub Brand | Product | Subtitles Required | Title | First Air Date | Format | Duration | Status |
    @When("{I |}fill following checkboxes for column filters settings on order summary page: $fieldsTable")
    public void fillTableFiltersSettings (ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        for (Map.Entry<String, String> entry : row.entrySet())
            row.put(entry.getKey(), String.valueOf(entry.getValue().equals("should")));
        getOrderSummaryPage().getTableFilterSettings().fill(row);
    }

    @Then("{I |}'$shouldState' see following destinations '$destinations' for clock delivery '$clockNumber' on '$orderStatus' order summary page with A5 View status as '$a5ViewStatus'")
    public void checkA5ViewStatusOnOrderSummaryDestinations(String shouldState, String destinations, String clockNumber, String orderStatus,String a5ViewStatus) {
        Boolean condition=shouldState.equals("should");
        ClockDeliveryList.ClockDelivery clockDelivery = getOrderSummaryPage().getClockDeliveryList().getClockDeliveryByClockNumber(wrapVariableWithTestSession(clockNumber), orderStatus);
        Common.sleep(2000);
        ClockDeliveryNestedList destinationList = clockDelivery.getClockDeliveryNestedList();
        for (String status:destinationList.getStatusForDestination(destinations)){
            if(!status.isEmpty()) {
                assertThat("Check A5 View Status for order summary destination: " + destinations + " for clock delivery: " + wrapVariableWithTestSession(clockNumber), condition == status.equalsIgnoreCase(a5ViewStatus));
                break;
            }
        }
    }
}