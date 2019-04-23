package com.adstream.automate.babylon.tests.steps.domain.ordering;

import com.adstream.automate.babylon.JsonObjects.Localization;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.JsonObjects.ordering.Order;
import com.adstream.automate.babylon.JsonObjects.ordering.enums.AccountType;
import com.adstream.automate.babylon.JsonObjects.ordering.enums.OrderReportType;
import com.adstream.automate.babylon.JsonObjects.ordering.enums.ViewDeliveryReport;
import com.adstream.automate.babylon.JsonObjects.ordering.templates.DeliveryOrderReport;
import com.adstream.automate.babylon.JsonObjects.ordering.templates.DeliveryOrderReportView;
import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.data.Logo;
import com.adstream.automate.babylon.sut.pages.ordering.*;
import com.adstream.automate.babylon.sut.pages.ordering.elements.Data;
import com.adstream.automate.babylon.sut.pages.ordering.elements.dictionaries.SubtitlesRequired;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.SchemaField;
import com.adstream.automate.utils.Common;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.DefaultHttpClient;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.openqa.selenium.TimeoutException;
import org.testng.Assert;
import scala.util.parsing.json.JSONObject;

import java.io.IOException;
import java.net.URL;
import java.nio.charset.UnsupportedCharsetException;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static org.bouncycastle.crypto.tls.ConnectionEnd.client;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import static org.hamcrest.Matchers.equalTo;

/*
 * Created by demidovskiy-r on 16.01.14.
 */
public class DraftOrderProceedSteps extends OrderingHelperSteps {

    private static final long billingGenerated=60 * 1000;
    private OrderProceedPage openOrderProceedPage(String orderId) {
        return getSut().getPageNavigator().getOrderProceedPage(orderId);
    }

    private ViewDestinationDetailsPage openOrderViewDestinationDetailsPage(String orderId) {
        return getSut().getPageNavigator().getOrderViewDestinationDetailsPage(orderId);
    }

    private ViewDraftDeliveryReportPage openViewDraftDeliveryReportPage(String orderId, String reportType) {
        return getSut().getPageNavigator().getViewDraftDeliveryReportPage(orderId, reportType);
    }

    private OrderProceedPage getOrderProceedPage() {
        return getSut().getPageCreator().getOrderProceedPage();
    }

    private ViewBillingPage getViewBillingPage() {
        return getSut().getPageCreator().getViewBillingPage();
    }

    private ViewDestinationDetailsPage getOrderViewDestinationDetailsPage() {
        return getSut().getPageCreator().getOrderViewDestinationDetailsPage();
    }

    private OrderEditSummaryPage getOrderEditSummaryPage() {
        return getSut().getPageCreator().getOrderEditSummaryPage();
    }

    private ViewDraftDeliveryReportPage getViewDraftDeliveryReportPage() {
        return getSut().getPageCreator().getViewDraftDeliveryReportPage();
    }

    private String getDeliveryOrderReportType(AccountType accountType) {
        return ViewDeliveryReport.findByAccountType(accountType).toString();
    }

    private byte[] getDefaultDeliveryOrderReportLogo(AccountType accountType) {
        String encodingInfoPart = "data:image/png;base64,";
        switch (accountType) {
            case ADSTREAM:
                return decodeBase64String(String.format("%s%s", encodingInfoPart, Logo.ADSTREAM.getBase64String()));
            case BEAM:
                return decodeBase64String(String.format("%s%s", encodingInfoPart, Logo.BEAM.getBase64String()));
            default:
                throw new IllegalArgumentException("Unknown account type: " + accountType);
        }
    }

    private Map<String, String> prepareOrderProceedPageFields(ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        if (row.containsKey("Manage Format Conversions"))
            row.put("Manage Format Conversions", String.valueOf(row.get("Manage Format Conversions").equals("should")));
        if (row.containsKey("Notify About Delivery"))
            row.put("Notify About Delivery", String.valueOf(row.get("Notify About Delivery").equals("should")));
        if (row.containsKey("Notify About Passed QC"))
            row.put("Notify About Passed QC", String.valueOf(row.get("Notify About Passed QC").equals("should")));
        if (row.containsKey("Recipients") && !row.get("Recipients").isEmpty()) {
            String[] users = row.get("Recipients").split(",");
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < users.length; i++) {
                sb.append(wrapUserEmailWithTestSession(users[i]));
                if (i != users.length - 1) sb.append(",");
            }
            row.put("Recipients", sb.toString());
        }
        if (row.containsKey("Order Confirmed Recipients") && !row.get("Order Confirmed Recipients").isEmpty()) {
            String[] users = row.get("Order Confirmed Recipients").split(",");
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < users.length; i++) {
                sb.append(wrapUserEmailWithTestSession(users[i]));
                if (i != users.length - 1) sb.append(",");
            }
            row.put("Order Confirmed Recipients", sb.toString());
        }
        if (row.containsKey("Order Completed Recipients") && !row.get("Order Completed Recipients").isEmpty()) {
            String[] users = row.get("Order Completed Recipients").split(",");
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < users.length; i++) {
                sb.append(wrapUserEmailWithTestSession(users[i]));
                if (i != users.length - 1) sb.append(",");
            }
            row.put("Order Completed Recipients", sb.toString());
        }
        if (row.containsKey("Order Ingested Recipients") && !row.get("Order Ingested Recipients").isEmpty()) {
            String[] users = row.get("Order Ingested Recipients").split(",");
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < users.length; i++) {
                sb.append(wrapUserEmailWithTestSession(users[i]));
                if (i != users.length - 1) sb.append(",");
            }
            row.put("Order Ingested Recipients", sb.toString());
        }
        if (row.containsKey("Job Number")) row.put("Job Number", wrapVariableWithTestSession(row.get("Job Number")));
        if (row.containsKey("PO Number")) row.put("PO Number", wrapVariableWithTestSession(row.get("PO Number")));
        return row;
    }

    @Given("I am on Order Proceed page for order contains order item with following {clock number|isrc code} '$clockNumber'")
    @When("{I |}go to Order Proceed page for order contains order item with following {clock number|isrc code} '$clockNumber'")
    public OrderProceedPage openOrderProceedPageByItemClockNumber(String clockNumber) {
        return openOrderProceedPage(getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getId());
    }

    @Given("I am on Order Proceed page for order with market '$market' and item with following clock number '$clockNumber'")
    @When("{I |}go to Order Proceed page for order with market '$market' and item with following clock number '$clockNumber'")
    public OrderProceedPage openOrderProceedPageByMarket(String market, String clockNumber) {
        return openOrderProceedPage(getOrderByMarketAndItemClockNumber(market, wrapVariableWithTestSession(clockNumber)).getId());
    }

    @When("{I |}click ViewDestinationDetails button on Order Proceed page")
    public ViewDestinationDetailsPage goToViewDestinationDetailsPage() {
        return getOrderProceedPage().ClickVDD_btn();
    }

    // accountType: Adstream, Beam
    @Given("I am on View Delivery Report of '$accountType' account type for order contains item with following {clock number|isrc code} '$clockNumber'")
    @When("{I |}go to View Delivery Report of '$accountType' account type for order contains item with following {clock number|isrc code} '$clockNumber'")
    public ViewDraftDeliveryReportPage openViewDraftDeliveryReportPageByItemClockNumber(String accountType, String clockNumber) {
        return openViewDraftDeliveryReportPage(getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getId(), getDeliveryOrderReportType(AccountType.findByName(accountType)));
    }

    // | Manage Format Conversions | Notify About Delivery | Notify About Passed QC | Recipients | Job Number | PO Number |
    @When("{I |}fill following fields on Order Proceed page: $fieldsTable")
    public void fillOrderProceedPageFields(ExamplesTable fieldsTable) {
       Map<String, String> row = prepareOrderProceedPageFields(fieldsTable);
        getOrderProceedPage().getOrderDetailsForm().fill(row);
    }

    // check: check, uncheck
    @When("{I |}'$check' checkbox Archive for following clock number{s|} '$clockNumbersList' of QC View summary on Order Proceed page")
    public void checkQcViewSummaryArchiveByClock(String check, String clockNumberList) {
        for (String clockNumber : clockNumberList.split(","))
            getOrderProceedPage().getQcViewItemByClockNumber(wrapVariableWithTestSession(clockNumber)).selectArchive(check.equals("check"));
    }

    // check: check, uncheck
    @When("{I |}'$check' checkbox Archive for item with following title '$title' on QC View summary of Order Proceed page")
    public void checkQcViewSummaryArchiveByTitle(String check, String title) {
        getOrderProceedPage().getQcViewItemByTitle(wrapVariableWithTestSession(title)).selectArchive(check.equals("check"));
    }

    @When("{I |}back to order item page from Order Proceed page")
    public void backToOrderItemPageFromProceedPage() {
        getOrderProceedPage().back();
    }

    @When("{I |}save as draft order on Order Proceed page")
    public void saveAsDraftOrder() {
        getOrderProceedPage().saveAsDraft();
    }

    // | Transfer to | Message |
    @When("{I |}fill following fields for Transfer Order form on Order Proceed page: $fieldsTable")
    public void fillTransferOrderForm(ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        if (row.containsKey("Transfer to"))
            row.put("Transfer to", row.get("Transfer to").contains("email") ? wrapUserEmailWithTestSession(row.get("Transfer to")) : row.get("Transfer to"));
        //getOrderProceedPage().getTransferOrderForm().fill(row);
        getOrderProceedPage().getTransferOrderForm().fillTransfer(row);
    }

    @When("{I |}click Send button on Transfer Order form on Order Proceed page")
    public void sendOrderForTransfer() {
        getOrderProceedPage().getTransferOrderForm().send();
    }

    @When("{I |}confirm order on Order Proceed page")
    public void confirmOrder() {
        getOrderProceedPage().confirm();
    }

    @When("{I |}confirm the order after order edit on Order summary page")
    public void confirmOrderAfterOrderEdit() {
        getOrderProceedPage().confirmAfterOrderEdit();
        getOrderEditSummaryPage().clickDoneButtton();
    }

    @Then("{I |}'$shouldState' see Order Proceed page")
    public void checkVisibilityOrderProceedPage(String shouldState) {
        assertThat("Check is Order Proceed page displayed: ", getSut().getWebDriver().getCurrentUrl(), shouldState.equals("should")
                ? containsString("/proceed")
                : not(containsString("/proceed")));
    }

    @Then("{I |}should see following warning '$warning' for mixture of SD and HD assets on Order Proceed page")
    public void checkWarningForMixtureOfSdHdAssets(String warning) {
        assertThat("Check warning for mixture SD and HD assets: ", getOrderProceedPage().getWarningForMixtureOfSdHdAssets(), equalTo(warning));
    }

    @Then("{I |}'$shouldState' Confirm button on Order Proceed page")
    public void checkVisibilityConfirmButton(String shouldState) {
        assertThat("Check visibility Confirm button: ", getOrderProceedPage().isConfirmButtonVisible(), is(shouldState.equals("should")));
    }

    @Then("{I |}'$shouldState' see QC View Summary info on Order Proceed page")
    public void checkVisibilityQcViewSummaryInfo(String shouldState) {
        assertThat("Check visibility of QC View Summary info: ", getOrderProceedPage().isQcViewSummaryInfoVisible(), is(shouldState.equals("should")));
    }

    @Then("{I |}'$shouldState' see following header{s|} '$headersList' of QC View Summary info on Order Proceed page")
    public void checkQcViewSummaryHeadersVisibility(String shouldState, String headersList) {
        List<String> qcViewSummaryHeaders = getOrderProceedPage().getQcViewSummaryHeaders();
        for (String qcViewHeader : headersList.split(",")) {
            qcViewHeader = Localization.findByKey(qcViewHeader);
            assertThat("Qc View header: " + qcViewHeader, qcViewSummaryHeaders, shouldState.equals("should") ? hasItem(equalToIgnoringCase(qcViewHeader)) : not(hasItem(equalToIgnoringCase(qcViewHeader))));
        }
    }

    @Then("{I |}should see '$count' QC View Summary items on Order Proceed page")
    public void checkQcViewSummaryItemsCount(int count) {
        assertThat("Check QC View Summary items count: ", getOrderProceedPage().getQcViewItemsCount(), equalTo(count));
    }

    // | Clock Number | Advertiser | Title | Duration | Format | Archive |
    @Then("{I |}should see following QC View Summary info on Order Proceed page: $fieldsTable")
    public void checkQcViewSummary(ExamplesTable fieldsTable) {
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            if (row.containsKey("Clock Number"))
                row.put("Clock Number", wrapVariableWithTestSession(row.get("Clock Number")));
            else
                throw new NullPointerException("There is no Clock Number in incoming data, but it's required!");
            OrderProceedPage.QcViewItem qcViewItem = getOrderProceedPage().getQcViewItemByClockNumber(row.get("Clock Number"));
            assertThat("Clock Number: ", qcViewItem.getClockNumber(), equalTo(row.get("Clock Number")));
            if (row.containsKey("Advertiser"))
                assertThat("Advertiser: ", qcViewItem.getAdvertiser(), equalTo(prepareAdvertiser(row.get("Advertiser"))));
            if (row.containsKey("Subtitles Required"))
                assertThat("Subtitles Required: ", qcViewItem.getSubtitlesRequired(), equalTo(row.get("Subtitles Required")));
            if (row.containsKey("Title"))
                assertThat("Title: ", qcViewItem.getTitle(), equalTo(wrapVariableWithTestSession(row.get("Title"))));
            if (row.containsKey("Duration"))
                assertThat("Duration: ", qcViewItem.getDuration(), equalTo(row.get("Duration")));
            if (row.containsKey("Format")) assertThat("Format: ", qcViewItem.getFormat(), equalTo(row.get("Format")));
            if (row.containsKey("Archive"))
                assertThat("Archive: ", qcViewItem.isArchiveSelected(), is(row.get("Archive").equals("should")));
            if (row.containsKey("Editability Archive"))
                assertThat("Editability Archive: ", qcViewItem.isArchiveActive(), is(row.get("Editability Archive").equals("should")));
        }
    }

    @Then("{I |}'$shouldState' see Billing on Order Proceed page")
    public void checkBullingVisibility(String shouldState) {
        assertThat("Check Billing visibility: ", getOrderProceedPage().isBillingVisible(), is(shouldState.equals("should")));
    }

    // Use this step to check if billing information is empty (TRUE if displays)
    @Then("{I |}'$shouldState' see Billing information on Order Proceed page")
    public void checkBullingVisibility_new(String shouldState) {
        assertThat("Check Billing visibility: ", getOrderProceedPage().isBillingVisible_new(), is(shouldState.equals("should")));
    }

    // | Item | QTY | Unit | TotalPerItem | Subtotal | Tax | Total |
    @Then("{I |}should see following Billing data on Order Proceed page: $fieldsTable")
    public void checkBillingData(ExamplesTable fieldsTable) {
        Billing billing = getOrderProceedPage().getBilling();
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            Billing.Item billingItem = billing.getItemByName(row.get("Item"));
            assertThat("Item: ", billingItem.getItem(), containsString(row.get("Item")));
            assertThat("QTY: ", billingItem.getQty(), equalTo(row.get("QTY")));
            assertThat("Unit: ", billingItem.getUnit(), equalTo(row.get("Unit")));
            assertThat("TotalPerItem: ", billingItem.getTotalPerItem(), equalTo(row.get("TotalPerItem")));
            assertThat("Subtotal: ", billing.getSubTotal(), equalTo(row.get("Subtotal")));
            assertThat("Tax: ", billing.getTax(), equalTo(row.get("Tax")));
            assertThat("Total: ", billing.getTotal(), equalTo(row.get("Total")));
        }
    }

    @When("{I |}wait for Billing data on Order Proceed page specific to clock '$clock'")
    public void checkBillingDataSpecifcClock(String clock) {
        long start = System.currentTimeMillis();
        long timeout= 2000;
        Order order = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clock));
        //---------------------------Assert for billing to be generated--------------------------------------------
        try {
          do{
            if(timeout > 0)
                Common.sleep(3000);
              if (System.currentTimeMillis() - start > billingGenerated) {
                  throw new TimeoutException("Timeout while checking the Billing");
              }
        }while(Integer.valueOf(getCoreApi().getHttpStatusCodeWhileGenerateBilling(OrderReportType.findByType("billing"), order.getId()))!=200);
        }catch(Exception e) {
            log.error(Common.exceptionToString(e));
        }
      }

          // | Item | QTY | Unit | TotalPerItem | Subtotal | Tax | Total |
    @Then("{I |}should see following Billing data on Order Proceed page specific to clocks: $fieldsTable")
    public void checkBillingDataSpecifcClock(ExamplesTable fieldsTable) {
        Billing billing = getOrderProceedPage().getBilling();
        Billing.Item billingItem;
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            if(row.get("clock")!=null) {
                billingItem = billing.getItemByName(wrapVariableWithTestSession(row.get("clock")).concat("-").concat(row.get("Item")));
            }else{
                billingItem = billing.getItemByName(row.get("dest").concat("-").concat(row.get("Item")));
            }
            assertThat("Item: ", billingItem.getItem(), containsString(row.get("Item")));
            assertThat("QTY: ", billingItem.getQty(), equalTo(row.get("QTY")));
            assertThat("Unit: ", billingItem.getUnit(), equalTo(row.get("Unit")));
            assertThat("TotalPerItem: ", billingItem.getTotalPerItem(), equalTo(row.get("TotalPerItem")));
            assertThat("Subtotal: ", billing.getSubTotal(), equalTo(row.get("Subtotal")));
            assertThat("Tax: ", billing.getTax(), equalTo(row.get("Tax")));
            assertThat("Total: ", billing.getTotal(), equalTo(row.get("Total")));
        }
    }

    @Then("{I |}should see following Billing data on View Billing page specific to clocks: $fieldsTable")
    public void checkViewBillingDataSpecifcClock(ExamplesTable fieldsTable) {
        ViewBillingPage page = getViewBillingPage();
        page.waitUntilBillingIsVisible();
        ViewBilling viewbilling = page.getBilling();
        ViewBilling.Item billingItem;
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            if(row.get("clock")!=null) {
                billingItem = viewbilling.getItemByName(wrapVariableWithTestSession(row.get("clock")).concat("-").concat(row.get("Item")));
            }else{
                billingItem = viewbilling.getItemByName(row.get("dest").concat("-").concat(row.get("Item")));
            }
            assertThat("Item: ", billingItem.getItem(), containsString(row.get("Item")));
            assertThat("QTY: ", billingItem.getQty(), equalTo(row.get("QTY")));
            assertThat("Unit: ", billingItem.getUnit(), equalTo(row.get("Unit")));
            assertThat("TotalPerItem: ", billingItem.getTotalPerItem(), equalTo(row.get("TotalPerItem")));
            assertThat("Subtotal: ", viewbilling.getSubTotal(), equalTo(row.get("Subtotal")));
            assertThat("Tax: ", viewbilling.getTax(), equalTo(row.get("Tax")));
            assertThat("Total: ", viewbilling.getTotal(), equalTo(row.get("Total")));
        }
    }
    // | Manage Format Conversions | Notify About Delivery | Notify About Passed QC | Recipients | Job Number | PO Number |
    @Then("{I |}should see following data for order on Order Proceed page: $fieldsTable")
    public void checkOrderProceedPageFields(ExamplesTable fieldsTable) {
        Map<String, String> row = prepareOrderProceedPageFields(fieldsTable);
        OrderProceedPage.OrderDetailsForm form = getOrderProceedPage().getOrderDetailsForm();
        for (Map.Entry<String, String> entry : row.entrySet()) {
            assertThat("Check field: " + entry.getKey(), form.getFieldValue(entry.getKey()), equalTo(entry.getValue()));
        }
    }

    // | Manage Format Conversions | Notify About Delivery | Notify About Passed QC | Recipients | Job Number | PO Number |
    @Then("{I |}'$shouldState' see following fields '$fieldNamesList' for order on Order Proceed page")
    public void checkOrderProceedPageFieldsVisibility(String shouldState, String fieldNamesList) {
        OrderProceedPage.OrderDetailsForm form = getOrderProceedPage().getOrderDetailsForm();
        for (String fieldName : fieldNamesList.split(","))
            assertThat("Check field: " + fieldName, form.isFieldVisible(fieldName), is(shouldState.equals("should")));
    }

    @Then("{I |}should see auto complete emails count '$emailsCount' under Recipients on Order Proceed page")
    public void checkAutoCompleteEmailsCount(int emailsCount) {
        assertThat("Check auto complete emails count: ", getOrderProceedPage().getCountAutoCompleteEmails(), equalTo(emailsCount));
    }

    @Then("{I |}should see next invoicing organisation '$agencyName' on order proceed page")
    public void checkInvoicingOrganisationOnProceedPage(String agencyName) {
        assertThat("Check invoicing organisation on order proceed page: ", getOrderProceedPage().getInvoicingOrganisation(),
                containsString(getAgencyName(agencyName)));
    }

    @Then("{I |}'$shouldState' see Invoice To option on order proceed page")
    public void checkInvoiceToVisibility(String shouldState) {
        assertThat("Check Invoice To option visibility: ", getOrderProceedPage().isInvoiceToVisible(), is(shouldState.equals("should")));
    }

    @Then("{I |}should see that View Draft order report opens for order with clock number '$clockNumber'")
    public void checkOpeningViewDraftOrderReport(Order order) {
        assertThat("Check HTTP status code when open draft order report: ",
                getMtApi().getHttpStatusCodeWhileGetOrderReport(OrderReportType.DRAFT, order.getId()), equalTo(200));
    }

    @Then("{I |}'$shouldState' see Save As PDF button on View Delivery Report page")
    public void checkVisibilitySaveAsPDFBtn(String shouldState) {
        assertThat("Check visibility of Save As PDF button: ", getViewDraftDeliveryReportPage().isSaveAsPDFBtnVisible(), is(shouldState.equals("should")));
    }

    @Then("{I |}'$shouldState' see Save As CSV button on View Delivery Report page")
    public void checkVisibilitySaveAsCSVBtn(String shouldState) {
        assertThat("Check visibility of Save As CSV button: ", getViewDraftDeliveryReportPage().isSaveAsCSVBtnVisible(), is(shouldState.equals("should")));
    }

    // | Order # | Date Created |
    @Then("{I |}should see for order contains item with {clock number|isrc code} '$clockNumber' following order summary information on View Delivery Report page: $fieldsTable")
    public void checkViewDeliveryReportSummaryInfo(String clockNumber, ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
        ViewDraftDeliveryReportPage.SummaryInformation summaryInfo = getViewDraftDeliveryReportPage().getOrderSummaryInformation();
        if (row.containsKey("Order #"))
            assertThat("Order #: ", summaryInfo.getOrderReference(), equalTo(String.valueOf(order.getOrderReference())));
        if (row.containsKey("Date Created"))
            assertThat("Date Created: ", summaryInfo.getDateCreated(), equalTo(formatDateToDefaultUserLocale(order.getCreated())));
    }

    // | Clock Number | Station Group | Destination | Service level | Subtitles | Held for approval |
    @Then("{I |}should see following data for order items on View Delivery Report page: $fieldsTable")
    public void checkViewDeliveryReportItemsInfo(ExamplesTable fieldsTable) {
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            if (Data.containsField(SchemaField.CLOCK_NUMBER, row, false))
                row.put("Clock Number", wrapVariableWithTestSession(Data.getField(SchemaField.CLOCK_NUMBER, row)));
            else
                throw new IllegalArgumentException("Clock Number is required field!");
            String destinationName = prepareDestination(row.get("Destination"));
            ViewDraftDeliveryReportPage.OrderItemUnit orderItemUnit = getViewDraftDeliveryReportPage().getOrderItemUnit(row.get("Clock Number"), destinationName);
            assertThat("Clock Number: ", orderItemUnit.getClockNumber(), equalTo(row.get("Clock Number")));
            if (row.containsKey("Station Group"))
                assertThat("Station Group: ", orderItemUnit.getStationGroup(), equalTo(row.get("Station Group")));
            if (row.containsKey("Destination"))
                assertThat("Destination: ", orderItemUnit.getDestination(), equalTo(destinationName));
            if (row.containsKey("Service level"))
                assertThat("Service level: ", orderItemUnit.getServiceLevel(), equalTo(row.get("Service level")));
            if (row.containsKey("Subtitles"))
                assertThat("Subtitles: ", orderItemUnit.getSubtitles(), equalTo(row.get("Subtitles")));
            if (row.containsKey("Held for approval"))
                assertThat("Held for approval: ", orderItemUnit.getHeldForApproval(), equalTo(row.get("Held for approval")));
        }
    }

    // State: checked or unchecked .... Status=editable or not editable
    @Then("{I |}should see Manage Format Conversions field is '$State' and '$Status'")
    public void checkfieldManageFormatConversions(String state, String status) {
        boolean checkbox_checkstate = state.equals("checked") ? true : false;
        boolean checkbox_editStatus = status.equals("editable") ? true : false;
        OrderProceedPage.OrderDetailsForm qcViewItem = getOrderProceedPage().getOrderDetailsForm();
        assertThat("Check Manage Format Conversions checkbox state: ", qcViewItem.isFormatConversionSelected(), is(checkbox_checkstate));
        assertThat("Check Manage Format Conversions checkbox editability: ", qcViewItem.isFormatConversionActive(), is(checkbox_editStatus));
    }

    // | Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country | Spot Code | Advertiser | Brand | Sub Brand | Product | Title | Duration | Format | Delivery Method | Deadline Date | Time Arrived | Master Held At | First Air Date | Archive | Note | Attachments | Subtitles Required | Delivery Points | Destination Group | Destination | Service Level |
    // accountType: Beam, Adstream
    @Then("{I |}should see following data for order items on View '$accountType' Delivery Report page: $fieldsTable")
    public void checkViewDeliveryReportData(String accountType, ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        //--------------------------Validating using Core API-----------------------------------------------------
        if (row.containsKey("Clock Number"))
            row.put("Clock Number", wrapVariableWithTestSession(row.get("Clock Number")));
        else
            throw new NullPointerException("There is no Clock Number in incoming data, but it's required!");
        if (row.containsKey("Job Number")) row.put("Job Number", wrapVariableWithTestSession(row.get("Job Number")));
        if (row.containsKey("PO Number")) row.put("PO Number", wrapVariableWithTestSession(row.get("PO Number")));
        Order order = getOrderByItemClockNumber(row.get("Clock Number"));
        AccountType aType = AccountType.findByName(accountType);
        row.put("Account Type", aType.toString());
        row.put("Language", getCoreApi().getCurrentUser().getLanguage());
        row.put("Order Reference", String.valueOf(order.getOrderReference()));
        row.put("Order Type", order.getSubtype());
        prepareAdvertiserHierarchyWithDescriptions(row);
        if (Data.containsField(SchemaField.TITLE, row, false))
            row.put(SchemaField.TITLE.toString(), wrapVariableByCriteria(Data.getField(SchemaField.TITLE, row)));
        if (row.containsKey("Deadline Date"))
            row.put("Deadline Date", row.get("Deadline Date").isEmpty() ? "" : convertDateToEnGbFormat(row.get("Deadline Date")));
        if (row.containsKey("Master Held At"))
            row.put("Master Held At", row.get("Master Held At").isEmpty() ? "" : wrapUserEmailWithTestSession(row.get("Master Held At")));
        if (Data.containsField(SchemaField.FIRST_AIR_DATE, row, false))
            row.put(SchemaField.FIRST_AIR_DATE.toString(), Data.getField(SchemaField.FIRST_AIR_DATE, row).isEmpty() ? "" : convertDateToEnGbFormat(Data.getField(SchemaField.FIRST_AIR_DATE, row)));
        if (Data.containsField(SchemaField.SUBTITLES_REQUIRED, row, false))
            row.put(SchemaField.SUBTITLES_REQUIRED.toString(), SubtitlesRequired.findByName(Data.getField(SchemaField.SUBTITLES_REQUIRED, row)).toString());
        if (Data.containsField(SchemaField.SUISA, row, false))
            row.put(SchemaField.SUISA.toString(), wrapVariableWithTestSession(Data.getField(SchemaField.SUISA, row)));
        if (row.containsKey("Additional Service Destination"))
            row.put("Additional Service Destination", wrapVariableWithTestSession(row.get("Additional Service Destination")));

        List<String> deliveryOrderReportViewFields = new DeliveryOrderReportView(new DeliveryOrderReport(row)).getReportViewFields();
        String deliveryOrderReportHtml = getCoreApi().getDeliveryOrderReport(order.getId(), getDeliveryOrderReportType(aType), Arrays.asList(getCoreApi().getQcView(order.getId()).getItems()));
        String deliveryOrderReport = convertNonUnicodeCharactersToUTF8(parseHtml(deliveryOrderReportHtml));

        if (row.containsKey("Logo")) {
            Logo logo = Logo.valueOf(row.get("Logo"));
            Pattern p = Pattern.compile("src=\"(.*)\"");
            Matcher m = p.matcher(deliveryOrderReportHtml);
            String src = null;
            if (m.find())
                src = m.group(1);
            byte[] reportLogo = decodeBase64String(src);
            byte[] defaultReportLogo = getDefaultDeliveryOrderReportLogo(aType);
            if (logo.equals(Logo.ADSTREAM) || logo.equals(Logo.BEAM))
                assertThat("Check default report logo: " + logo.toString(), reportLogo.length, equalTo(defaultReportLogo.length));
            else
                assertThat("Check custom report logo: " + logo.toString(), reportLogo.length, not(equalTo(defaultReportLogo.length))); // check that logo is not default after upload new one
        }

        for (String deliveryOrderReportViewField : deliveryOrderReportViewFields)
            assertThat("Check " + accountType + " Delivery Report: ", deliveryOrderReport, containsString(deliveryOrderReportViewField));

    }



    public void verifySaveASDocumentWithAPI(String docType, String orderId, String clockNumber ){
         String draftOrderReportUrl = getCoreApi().getDraftOrderReportUrl(orderId);
        if(docType.equals("csv")) {
            draftOrderReportUrl = draftOrderReportUrl.replace("pdf", "csv");
        }
        JsonObject archive = new JsonObject();
        archive.addProperty(clockNumber,0);
        JsonObject request = new JsonObject();
        request.add("archive", archive);

        HttpResponse response = sendSaveAsDocRequest(draftOrderReportUrl, request.toString());
        assertThat("File is saved", getHeaderData(response,"Content-Disposition").contains("."+docType), is(true));
    }
    public HttpResponse sendSaveAsDocRequest(String draftOrderReportUrl, String body) {
        HttpPost postRequest = new HttpPost(draftOrderReportUrl);
        DefaultHttpClient httpClient = new DefaultHttpClient();
        HttpResponse response;
        StringEntity entity ;
        try {
            entity = new StringEntity(body, "UTF-8");
            entity.setContentType("application/json");
            postRequest.setEntity(entity);
            response = httpClient.execute(postRequest);
        } catch (Exception e) {
            log.error(e);
            return null;
        }

        return response;
    }
    public String getHeaderData(HttpResponse response,String headerType) {
        String downloadedFileName = null;
        if (headerType.equalsIgnoreCase("Content-Disposition")) {
            org.apache.http.Header[] responseHeader = response.getHeaders(headerType);
            int index1 = responseHeader[0].toString().trim().indexOf("=");
            downloadedFileName = responseHeader[0].toString().trim().substring(index1 + 1).replaceAll(";", "");

        }
        return downloadedFileName;
    }

    // | Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country | Spot Code | Advertiser | Brand | Sub Brand | Product | Title | Duration | Format | Delivery Method | Deadline Date | Time Arrived | Master Held At | First Air Date | Archive | Note | Attachments | Subtitles Required | Delivery Points | Destination Group | Destination | Service Level |
    // accountType: Beam, Adstream
    @Then("{I |}should see following data for order items on View '$accountType' Delivery Report page using Core and UI: $fieldsTable")
    public void checkViewDeliveryReportDataUsingUI(String accountType, ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        //--------------------------Validating using Core API-----------------------------------------------------
        if (row.containsKey("Clock Number"))
            row.put("Clock Number", wrapVariableWithTestSession(row.get("Clock Number")));
        else
            throw new NullPointerException("There is no Clock Number in incoming data, but it's required!");
        if (row.containsKey("Job Number")) row.put("Job Number", wrapVariableWithTestSession(row.get("Job Number")));
        if (row.containsKey("PO Number")) row.put("PO Number", wrapVariableWithTestSession(row.get("PO Number")));
        Order order = getOrderByItemClockNumber(row.get("Clock Number"));
        AccountType aType = AccountType.findByName(accountType);
        row.put("Account Type", aType.toString());
        row.put("Language", getCoreApi().getCurrentUser().getLanguage());
        row.put("Order Reference", String.valueOf(order.getOrderReference()));
        row.put("Order Type", order.getSubtype());
        prepareAdvertiserHierarchyWithDescriptions(row);
        if (Data.containsField(SchemaField.TITLE, row, false))
            row.put(SchemaField.TITLE.toString(), wrapVariableByCriteria(Data.getField(SchemaField.TITLE, row)));
        if (row.containsKey("Deadline Date"))
            row.put("Deadline Date", row.get("Deadline Date").isEmpty() ? "" : convertDateToEnGbFormat(row.get("Deadline Date")));
        if (row.containsKey("Master Held At"))
            row.put("Master Held At", row.get("Master Held At").isEmpty() ? "" : wrapUserEmailWithTestSession(row.get("Master Held At")));
        if (Data.containsField(SchemaField.FIRST_AIR_DATE, row, false))
            row.put(SchemaField.FIRST_AIR_DATE.toString(), Data.getField(SchemaField.FIRST_AIR_DATE, row).isEmpty() ? "" : convertDateToEnGbFormat(Data.getField(SchemaField.FIRST_AIR_DATE, row)));
        if (Data.containsField(SchemaField.SUBTITLES_REQUIRED, row, false))
            row.put(SchemaField.SUBTITLES_REQUIRED.toString(), SubtitlesRequired.findByName(Data.getField(SchemaField.SUBTITLES_REQUIRED, row)).toString());
        if (Data.containsField(SchemaField.SUISA, row, false))
            row.put(SchemaField.SUISA.toString(), wrapVariableWithTestSession(Data.getField(SchemaField.SUISA, row)));
        if (row.containsKey("Additional Service Destination"))
            row.put("Additional Service Destination", wrapVariableWithTestSession(row.get("Additional Service Destination")));

        List<String> deliveryOrderReportViewFields = new DeliveryOrderReportView(new DeliveryOrderReport(row)).getReportViewFields();
        String deliveryOrderReportHtml = getCoreApi().getDeliveryOrderReport(order.getId(), getDeliveryOrderReportType(aType), Arrays.asList(getCoreApi().getQcView(order.getId()).getItems()));
        String deliveryOrderReport = convertNonUnicodeCharactersToUTF8(parseHtml(deliveryOrderReportHtml));

        if (row.containsKey("Logo")) {
            Logo logo = Logo.valueOf(row.get("Logo"));
            Pattern p = Pattern.compile("src=\"(.*)\"");
            Matcher m = p.matcher(deliveryOrderReportHtml);
            String src = null;
            if (m.find())
                src = m.group(1);
            byte[] reportLogo = decodeBase64String(src);
            byte[] defaultReportLogo = getDefaultDeliveryOrderReportLogo(aType);
            if (logo.equals(Logo.ADSTREAM) || logo.equals(Logo.BEAM))
                assertThat("Check default report logo: " + logo.toString(), reportLogo.length, equalTo(defaultReportLogo.length));
            else
                assertThat("Check custom report logo: " + logo.toString(), reportLogo.length, not(equalTo(defaultReportLogo.length))); // check that logo is not default after upload new one
        }

        for (String deliveryOrderReportViewField : deliveryOrderReportViewFields)
            assertThat("Check " + accountType + " Delivery Report: ", deliveryOrderReport, containsString(deliveryOrderReportViewField));
        //-----QA-396------------
        verifySaveASDocumentWithAPI("pdf",order.getId(),row.get("Clock Number"));
        verifySaveASDocumentWithAPI("csv",order.getId(),row.get("Clock Number"));

        validateViewDestinationDetailsReportInUI(row);

    }

    // row contains the values retrieved from the fieldsTable
    public void validateViewDestinationDetailsReportInUI(Map<String, String> row){
        if (row.containsKey("Advertiser")) row.put("Advertiser", wrapVariableWithTestSession(row.get("Advertiser")));
        if (row.containsKey("Brand")) row.put("Brand", wrapVariableWithTestSession(row.get("Brand")));
        if (row.containsKey("Sub Brand")) row.put("Sub Brand", wrapVariableWithTestSession(row.get("Sub Brand")));
        if (row.containsKey("Product")) row.put("Product", wrapVariableWithTestSession(row.get("Product")));
        if (row.containsKey("Title")) row.put("Title", wrapVariableWithTestSession(row.get("Title")));

        Assert.assertTrue(getOrderViewDestinationDetailsPage().getDeliveryOrder().contains(getOrderViewDestinationDetailsPage().getOrderNumber()));

        Map<String, String> actualValues = getOrderViewDestinationDetailsPage().getViewDestinationDetailsValues();

        //Checking 24 out of 26 values retrieved from fields table  except the deadline date and OrderItemcount whcih are empty in the fields table
        for (String key : actualValues.keySet()) {
            String expectedValue = row.get(key);
            String actualValue = actualValues.get(key);
            Assert.assertEquals(actualValue, expectedValue, "values are not equal for " + key);
        }

        Assert.assertTrue(getOrderViewDestinationDetailsPage().isSaveAsPDFBtnVisible());
        Assert.assertTrue(getOrderViewDestinationDetailsPage().isSaveAsCSVBtnVisible());
    }


}