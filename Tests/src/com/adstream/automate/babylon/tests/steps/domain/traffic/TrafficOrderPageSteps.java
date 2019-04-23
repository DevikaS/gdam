package com.adstream.automate.babylon.tests.steps.domain.traffic;

import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.JsonObjects.gdn.IngestDoc;
import com.adstream.automate.babylon.JsonObjects.ordering.OrderItem;
import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.babylon.sut.pages.traffic.TrafficOrderItemPage;
import com.adstream.automate.babylon.sut.pages.traffic.TrafficOrderItemsListPage;
import com.adstream.automate.babylon.sut.pages.traffic.TrafficOrderPage;
import com.adstream.automate.babylon.sut.pages.traffic.element.DubbingService;
import com.adstream.automate.babylon.sut.pages.traffic.element.ProductionService;
import com.adstream.automate.babylon.sut.pages.traffic.tableList.TrafficDestinationList;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.DateTimeUtils;
import org.apache.commons.lang.NullArgumentException;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.junit.Assert;
import org.openqa.selenium.TimeoutException;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Map;
import org.joda.time.DateTime;
import java.util.List;
import java.util.ArrayList;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created by denysb on 17/03/2016.
 */
public class TrafficOrderPageSteps extends TrafficHelperSteps {

    private DateTime proxyCreatedDate = null;
    final long statusReplicationToTrafficAsGDN = 60 * 2000;
    public TrafficOrderPage getTrafficOrderPage() {
        return getSut().getPageCreator().getTrafficOrderPage();
    }

    public TrafficOrderItemPage getTrafficOrderItemPage() {
        return getSut().getPageCreator().getTrafficOrderItemPage();
    }

    @Given("{I |}am on order details page of clockNumber '$clockNumber'")
    @When("{I |}am on order details page of clockNumber '$clockNumber'")
    public TrafficOrderPage openTrafficOrderDetailsPage(String clockNumber){
        Common.sleep(2000); // Temp sleep. To be removed anytime, whoever reads this line first.
        String orderId = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getId();
        return getSut().getPageNavigator().getTrafficOrderPage(orderId);
    }

    @Given("{I |}opened order item details page with clockNumber '$clockNumber' from traffic order details page")
    @When("{I |}open order item details page with clockNumber '$clockNumber' from traffic order details page")
    @Then("{I |}open order item details page with clockNumber '$clockNumber' from traffic order details page")
    public void openOrderItemDetailOnTrafficPage(String clockNumber) {
        getTrafficOrderPage().openOrderItemUsingClockNumber(wrapVariableWithTestSession(clockNumber));
    }

    @Then("{I |}should see '$numberOfClones' cloned orders for clocknumber '$clockNumber'")
    public void checkClonedOrderCount(int numberOfClones, String clockNumber) {
        assertThat("Clones are not generated", getTrafficOrderPage().cloneCounts(wrapVariableWithTestSession(clockNumber)) == numberOfClones);
    }

    @Given("{I |}opened Clone order item details page with clockNumber '$clockNumber' from traffic order details page and validate cloned orders and Destinations '$DestinationName'")
    @When("{I |}open Clone order item details page with clockNumber '$clockNumber' from traffic order details page and validate cloned orders and Destinations '$DestinationName'")
    @Then("{I |}open Clone order item details page with clockNumber '$clockNumber' from traffic order details page and validate cloned orders and Destinations '$DestinationName'")
    public void openClonedOrderItemDetailOnTrafficPage(String clockNumber, String DestinationName) {
        Common.sleep(1);
        getTrafficOrderPage().openClonedOrderItemUsingClockNumber(wrapVariableWithTestSession(clockNumber), DestinationName);
    }


    @Given("{I |}clicked on '$button' button on order details page in traffic")
    @When("{I |}click on '$button' button on order details page in traffic")
    public void clickButtonOnOrderPageInTraffic(String button) {
        getTrafficOrderPage().clickCommonButtons(button);

    }

    @When("{I |}edit and '$action' Job Number with '$jobNumber' on traffic order details page for clock '$clockNumber'")
    public void enterJobNumber(String action, String jobNumber, String clockNumber) {
        TrafficOrderPage trafficOrderPage = getTrafficOrderPage();
        trafficOrderPage.inputJobNumber(jobNumber);
        if (action.equalsIgnoreCase("save")) {
            trafficOrderPage.clickSaveButton();
        }
        else if(action.equalsIgnoreCase("cancel")) {
            trafficOrderPage.clickCancelButton();
        }
    }

    @When("{I |}edit and '$action' PO Number with '$poNumber' on traffic order details page for clock $clockNumber")
    public void enterPONumber(String action, String poNumber, String clockNumber) {
        TrafficOrderPage trafficOrderPage = getTrafficOrderPage();
        trafficOrderPage.inputPONumber(poNumber);
        if (action.equalsIgnoreCase("save")) {
            trafficOrderPage.clickSaveButton();
        }
        else if(action.equalsIgnoreCase("cancel")) {
            trafficOrderPage.clickCancelButton();
        }
    }


    @Then("{I |} '$condition' see success message as '$successMessage' displayed on order details page is Traffic")
    public void checkSuccessMessage(String condition, String successMessage) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        assertThat("Success message must be displayed", shouldState ? getTrafficOrderPage().isSuccessMessageDisplayed(successMessage) : !getTrafficOrderPage().isSuccessMessageDisplayed(successMessage));
    }

    @Then("{I |}'$condition' see warning message '$message' for clockNumber '$clockNumber' on traffic order details page")
    public void checkWarningMessage(String condition, String message, String clockNumber) {
        String expectedMessage = "WARNING!" + " " + wrapVariableWithTestSession(clockNumber) + " " + message;
        String actualMessage = getTrafficOrderPage().checkWarningMessage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        assertThat(actualMessage, condition.equalsIgnoreCase("should") ? containsString(expectedMessage.trim()) : not(containsString(expectedMessage.trim())));


    }

    @Given("{I |}waited till order will be loaded in Traffic UI")
    @When("{I |}wait till order will be loaded in Traffic UI")
    public void waitTillOrderListWillBeLoaded() {
        getTrafficOrderPage().waitUntilPageWillBeLoaded(2000);
    }

    @Then("{I |}should see following fields on order page in Traffic UI:$date")
    public void checkFieldsOnOrderPage(ExamplesTable data)
    {
        Map<String, String> row = parametrizeTabularRow(data);

        TrafficOrderPage.Order order = getTrafficOrderPage().getOrderFromTrafficOrderPage();
        if (row.containsKey("Assigned to")) {
            if (!row.get("Assigned to").equalsIgnoreCase("Unassigned")&& !row.get("Assigned to").isEmpty())
            {
                String[] users = row.get("Assigned to").split(",");
                for (String email : users) {
                    String userEmail;
                    try {

                        userEmail = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(email)).getEmail();
                    } catch (NullPointerException e) {
                        throw new NullPointerException("User with email " + wrapUserEmailWithTestSession(email) + " is absent");
                    }
                    assertThat("Assigned to", order.getEmailsOfAssignedToUsers(), hasItem(userEmail));
                }
            }
            else {
                assertThat("Not assigned to anyone", order.getEmailsOfAssignedToUsers().isEmpty());
            }


        }
    }

    @Then("{I |}should see '$clockNumber' in delivery status '$status' in order details page for destination '$destinationName'")
    public void checkStatusInOrderDetails(String clockNumber, String status, String destinationName) {
        final long timeOut = 2000;
        TrafficOrderPage.DeliveryItem trafficOrder;
        String reference = String.valueOf(getCoreApiAdmin().getOrderByItemClockNumber(clockNumber).getOrderReference());
        long start = System.currentTimeMillis();
        do {
            if (timeOut > 0)
                Common.sleep(timeOut * 2);
            if (System.currentTimeMillis() - start > statusReplicationToTrafficAsGDN) {
                throw new TimeoutException("Timeout during waiting status " + status + " for order item");
            }
            TrafficOrderPage trafficOrderPage = getSut().getPageCreator().getTrafficOrderPage();
            trafficOrder = trafficOrderPage.getDeliveryItemByReference(wrapVariableWithTestSession(clockNumber), destinationName);
        } while (!trafficOrder.getDeliveryStatus().equalsIgnoreCase(status));
        assertThat("Delivery status set incorrectly", trafficOrder.getDeliveryStatus().equalsIgnoreCase(status));
    }

    @Then("{I |}should see '$clockNumber' with value '$status' for on Hold Dest in order details page for destination '$destinationName'")
    public void checkonHoldDestInOrderDetails(String clockNumber, String status, String destinationName) {
        TrafficOrderPage trafficOrderPage = getSut().getPageCreator().getTrafficOrderPage();
        Common.sleep(2000);
        String reference = String.valueOf(getCoreApiAdmin().getOrderByItemClockNumber(clockNumber).getOrderReference());
        TrafficOrderPage.DeliveryItem trafficOrder = trafficOrderPage.getDeliveryItemByReference(wrapVariableWithTestSession(clockNumber), destinationName);
        assertThat("On Hold value set incorrectly", trafficOrder.getOnHoldDest().equalsIgnoreCase(status));
    }


    @Then("I should see comment '$lastComment' for clockNumber '$clockNumber' in order details page")
    public void checkComment(String lastComment, String clockNumber) {
        String orderId = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getId();
        String orderItemId = getCoreApiAdmin().getOrderItemByClockNumber(orderId, wrapVariableWithTestSession(clockNumber)).getId();
        assertThat("Last Comment from Clock Level is not updated at Order Level", lastComment.equalsIgnoreCase(getTrafficOrderPage().getComment(orderItemId)));

    }

    @Then("I should see comment '$Comment' on order details page")
    public void checkCommentOnOrderDetailsPage(String Comment) {
        String actualComment = getTrafficOrderPage().getCommentOnOrdetailsPage(Comment);
        assertThat("Comment is not shown on order details page", Comment.equalsIgnoreCase(actualComment));

    }

    @Then("I '$should' see Support Document '$fileName' for clockNumber '$clockNumber' in order details page")
    @When("I '$should' see Support Document '$fileName' for clockNumber '$clockNumber' in order details page")
    public void checkSupportingDoc(String should, String fileName, String clockNumber) {
        String orderId = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getId();
        String orderItemId = getCoreApiAdmin().getOrderItemByClockNumber(orderId, wrapVariableWithTestSession(clockNumber)).getId();
        assertThat("Supporting Document for a clock is not available", (getTrafficOrderItemPage().getSupportingDocument(fileName)), is(should.equals("should")));

    }

    @Then("I '$should' see Support Document '$fileName' for clockNumber '$clockNumber' is downloaded from order details page")
    public void checkSupportingDocDownload(String should, String fileName, String clockNumber) {
        String orderId = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getId();
        String orderItemId = getCoreApiAdmin().getOrderItemByClockNumber(orderId, wrapVariableWithTestSession(clockNumber)).getId();
        String hreflocation = getTrafficOrderItemPage().getSupportingDocumentdownloadUrl(fileName);
        String suppDocDownloadCall = hreflocation.substring(hreflocation.indexOf("/api"), hreflocation.indexOf("&redirect"));
        String encodedSuppDocDownloadCall = StringEscapeUtils.unescapeXml(suppDocDownloadCall).replaceFirst("download", "v1");
        encodedSuppDocDownloadCall = encodedSuppDocDownloadCall.replace("qcAssetId", "qc-asset-id");
        String decodedSuppDocDownloadCall = StringEscapeUtils.escapeXml(encodedSuppDocDownloadCall);
        String downloadLocation = TestsContext.getInstance().deliveryServerUrl + decodedSuppDocDownloadCall;
        User user = getCoreApi().getCurrentUser();
        String headerValue = user.getId();
        try {
            HttpResponse response = sendDownloadrequest(headerValue, downloadLocation);
            assertThat("Supporting Document for a clock is not downloaded", (checkzipHeaders(response, "Content-Disposition")).contains(fileName), is(should.equals("should")));
        }
        catch (IOException e) {
            e.printStackTrace();
        }
    }


    @Then("I '$should' be able to download Delivery report for clockNumber '$clockNumber' in order Details page")
    public void checkDeliveryReportDownload(String should, String clockNumber) {
        String orderId = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getId();
        String downloadLocation = getSut().getPageCreator().getTrafficOrderPage().downloaDeliveryRptDwldUrl(orderId);
        User user = getCoreApi().getCurrentUser();
        String headerValue = user.getId();
        try {
            HttpResponse response = sendDownloadrequest(headerValue, downloadLocation);
            assertThat("Delivery Report for a clock is not downloaded", response.toString().contains("200 OK"), is(should.equals("should")));
        }
        catch (IOException e) {
            e.printStackTrace();
        }
    }


    @Then("I '$should' download csv report from tab with specific filter on Traffic Order Item List page and verify for data:$data")
    public void checkCsvReportDownload(String should, ExamplesTable data) {
        boolean status = true;
        String expectedValue = null;
        TrafficOrderItemsListPage page = getSut().getPageCreator().getTrafficOrderItemsListPage();
        String hreflocation = getSut().getWebDriver().getCurrentUrl();
        String csvReportDownloadCall = hreflocation.substring(hreflocation.indexOf("tabId="), hreflocation.indexOf("&page="));
        String csvDownloadurl = csvReportDownloadCall.replaceFirst("tabId=", "/api/traffic/v1/export/tab/") + "/csv?search=";
        String downloadLocation = TestsContext.getInstance().deliveryServerUrl + csvDownloadurl;
        User user = getCoreApi().getCurrentUser();
        String headerValue = user.getId();
        try {
            HttpResponse response = sendDownloadrequest(headerValue, downloadLocation);
            assertThat("CSV Report is not downloaded", (response.toString().contains("200 OK") && response.toString().contains("text/csv")), is(status));
            String content = getresponseBody(headerValue, downloadLocation);
            for (int i = 0; i < data.getRowCount(); i++) {
                for (Map<String, String> row : parametrizeTableRows(data)) {
                    if (row.get("VerfyData") != null)
                        expectedValue = row.get("VerfyData");
                    else if ((row.get("HouseNumber") != null) && (row.get("Suffix") != null)) {
                        expectedValue = wrapVariableWithTestSession(row.get("HouseNumber")) + row.get("Suffix");
                        assertThat("CSV Report is not downloaded with valid filters", content.contains(expectedValue), is(should.equals("should")));
                    }
                }

                assertThat("CSV Report is not downloaded with valid filters", content.contains(expectedValue), is(should.equals("should")));
            }

            }
        catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Then("I '$should' see Proxy file '$fileName' for clockNumber '$clockNumber' is downloaded from order details page with duration '$duration'")
    public void checkProxyFileDownload(String should, String fileName, String clockNumber, String duration) {
        String hreflocation = getTrafficOrderPage().getProxyFiledownloadUrl();
        boolean shouldState = should.equalsIgnoreCase("should");
        if (shouldState) {
            String orderId = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getId();
            String orderItemId = getCoreApiAdmin().getOrderItemByClockNumber(orderId, wrapVariableWithTestSession(clockNumber)).getId();

            String proxyDownloadCall = hreflocation.substring(hreflocation.indexOf("/api"), hreflocation.indexOf("&"));
            String encodedSuppDocDownloadCall = StringEscapeUtils.unescapeXml(proxyDownloadCall).replaceFirst("download", "v1");
            encodedSuppDocDownloadCall = encodedSuppDocDownloadCall.replace("qcAssetId", "qc-asset-id");
            String decodedSuppDocDownloadCall = StringEscapeUtils.escapeXml(encodedSuppDocDownloadCall);
            String downloadLocation = TestsContext.getInstance().deliveryServerUrl + decodedSuppDocDownloadCall;
            User user = getCoreApi().getCurrentUser();
            String headerValue = user.getId();
            try {
                HttpResponse response = sendDownloadrequest(headerValue, downloadLocation);
                String targetfilenameWithTestSession = wrapVariableWithTestSession(fileName) + "_" + wrapVariableWithTestSession(clockNumber) + "_" + duration + ".mp4";
                assertThat("Proxy File for a clock is not downloaded", (checkzipHeaders(response, "Content-Disposition")).contains(targetfilenameWithTestSession), is(should.equals("should")));
        }
        catch (IOException e) {
                e.printStackTrace();
        }} else {
            assertThat("Proxy File is available", hreflocation.equals("proxyFileDownloadUrlNotVisibleOnPage"));
        }
    }

    @Then("I '$should' see Support Document for clockNumber '$clockNumber' in order details page")
    public void checkSuppoetingDocVisible(String should, String clockNumber) {
        assertThat("Supporting Document for a clock is not available", (getTrafficOrderPage().isSupportingDocumentVisible()), is(should.equals("should")));

    }

    public HttpResponse sendDownloadrequest(String headerValue, String endpoint) throws IOException {
        DefaultHttpClient httpClient = new DefaultHttpClient();
        HttpGet getRequest = new HttpGet(endpoint);
        getRequest.setHeader("X-User-Id", headerValue);
        getRequest.addHeader("Content-Type", "application/json");
        HttpResponse response = httpClient.execute(getRequest);
        getRequest.releaseConnection();
        return response;
    }
    public String getresponseBody(String headerValue, String endpoint) throws IOException {
        DefaultHttpClient httpClient = new DefaultHttpClient();
        HttpGet getRequest = new HttpGet(endpoint);
        getRequest.setHeader("X-User-Id", headerValue);
        getRequest.addHeader("Content-Type", "application/json");
        HttpResponse response = httpClient.execute(getRequest);
        HttpEntity entity = response.getEntity();
        String content = EntityUtils.toString(entity);
        getRequest.releaseConnection();
        return content;
    }
    public String checkzipHeaders(HttpResponse response, String headerType) {
        String downloadedFileName = null;
        try {
            if (headerType.equalsIgnoreCase("Content-Disposition")) {
                org.apache.http.Header[] responseHeader = response.getHeaders(headerType);
                int index1 = responseHeader[0].toString().trim().indexOf("=");
                downloadedFileName = responseHeader[0].toString().trim().substring(index1 + 1).replaceAll("\"", "");
            }
        } catch (ArrayIndexOutOfBoundsException e) {
            return "NoFileToDownload";
        }

        return downloadedFileName;
    }

    @When("{I |}revision file ID for clockNumber '$clockNumber' '$condition' be empty in Traffic")
    @Then("{I |}revision file ID for clockNumber '$clockNumber' '$condition' be empty in Traffic")
    public void waitTillOrderWillHaveParticularStatusInTraffic(String clockNumber, String condition) throws MalformedURLException, UnsupportedEncodingException {
        String orderId = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)).getId();
        boolean expectedState = condition.equalsIgnoreCase("should not");
        OrderItem orderItem = getCoreApiAdmin().getOrderItemByClockNumber(orderId, wrapVariableWithTestSession(clockNumber));
        //   A5RestService a5RestService = new A5RestService(new URL(TestsContext.getInstance().coreUrl[0] + "/"));
        IngestDoc ingestdoc = getCoreApi().getIngestId(orderItem.getQCAssetId());
        String fileID = ingestdoc.getAsset().getRevision().getFileID();
        assertThat("Revision count " + condition + " be empty", checkFileID(fileID) == expectedState);
    }

    private boolean checkFileID(String fileID) {
        return (fileID != null ? true : false);
    }


    @When("{I |}should store created date for proxy document with clockNumber '$clockNumber' in traffic order item list")
    public void setProxyDate(String clockNumber) {
        proxyCreatedDate = DateTimeUtils.parseDate(getTrafficOrderPage().getProxyCreatedDate(wrapVariableWithTestSession(clockNumber)), "dd/MM/yyyy HH:mm");
    }

    @Then("{I |}should clear created date for proxy document with clockNumber '$clockNumber' in traffic order item list")
    public void resetProxyDate(String clockNumber) {
        proxyCreatedDate = null;
    }

    @Then("{I |}should verify proxy created date for clockNumber '$clockNumber' in traffic order item list is updated")
    public void verifyUpdatedProxyDate(String clockNumber) {
        String presentDate = getTrafficOrderPage().getProxyCreatedDate(wrapVariableWithTestSession(clockNumber));
        assertThat("Proxy is not Update", proxyCreatedDate.isBefore(DateTimeUtils.parseDate(getTrafficOrderPage().getProxyCreatedDate(wrapVariableWithTestSession(clockNumber)), "dd/MM/yyyy HH:mm")));
    }


    @Then("{I |}'$should' see following fields on order details page in Traffic UI:$fields")
    public void checkFieldsOnOrderdetailsPage(String condition, ExamplesTable fields) {
        String actual = null;
        TrafficOrderPage.OrderReferenceSection orderDetails = getTrafficOrderPage().getOrderReferenceSection();
        for (int i = 0; i < fields.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fields, i);
            for (Map.Entry<String, String> rowEntry : row.entrySet()) {
                switch (rowEntry.getKey()) {
                    case "Submitted":
                        actual = orderDetails.getSubmitted();
                        break;
                    case "Po Number":
                        actual = orderDetails.getPoNumber();
                        break;
                    case "Order Item Ingest Status":
                        actual = orderDetails.getOrderItemIngestStatus();
                        break;
                    case "order Subtitles Required":
                        actual = orderDetails.getOrderSubtitlesRequired();
                        break;
                    case "On Hold":
                        actual = orderDetails.getOnHold();
                        break;
                    case "Agency Name":
                        actual = orderDetails.getAgencyName();
                        break;
                    case "Order Assigned To":
                        actual = orderDetails.getOrderAssignedTo();
                        break;
                    case "Tape Numbers":
                        actual = orderDetails.getTapeNumbers();
                        break;
                    case "Order Service Level Minutes":
                        actual = orderDetails.getOrderServiceLevelMinutes();
                        break;
                    case "Job Number":
                        actual = orderDetails.getJobNumber();
                        break;
                    case "Market Country":
                        actual = orderDetails.getMarketCountry();
                        break;
                    case "Order Billed To":
                        actual = orderDetails.getOrderBilledTo();
                        break;
                    case "Production Services Status":
                        actual = orderDetails.getProductionServicesStatus();
                        break;
                    case "Market":
                        actual = orderDetails.getMarket();
                        break;
                    case "Has Additional Services":
                        actual = orderDetails.getHasAdditionalServices();
                        break;
                    case "Submitted By":
                        actual = orderDetails.getSubmittedBy();
                        break;
                    case "Country":
                        actual = orderDetails.getCountry();
                        break;
                    case "Dubbing Services Status":
                        actual = orderDetails.getDubbingServicesStatus();
                        break;
                    case "Status":
                        actual = orderDetails.getStatus();
                        break;
                    case "Order Service Level":
                        actual = orderDetails.getOrderServiceLevel();
                        break;
                    case "Ingest Location":
                        actual = orderDetails.getIngestLocation();
                        break;
                    case "Order Reference":
                        actual = orderDetails.getOrderReference();
                        break;
                    case "Order Last Comment":
                        actual = orderDetails.getOrderLastComment();
                        break;
                    case "Subtitles Required":
                        actual = orderDetails.getOrderSubtitlesRequired();
                        break;
                    default:
                        throw new NullPointerException("No Field with name '" + rowEntry.getKey() + "' on Traffic Order details Page");
                }

                if (rowEntry.getKey().equalsIgnoreCase("Agency Name") || rowEntry.getKey().equalsIgnoreCase("Ingest Location"))
                    assertThat("Check '" + rowEntry.getKey() + "' value on Traffic order details page: ",
                            actual.contains(rowEntry.getValue()));
                else if (rowEntry.getKey().equalsIgnoreCase("Job Number") || rowEntry.getKey().equalsIgnoreCase("Po Number"))
                    assertThat("Check '" + rowEntry.getKey() + "' value on Traffic order details page: ",
                            actual.equals(wrapVariableWithTestSession(rowEntry.getValue())), is(condition.equalsIgnoreCase("should")));
                else
                    assertThat("Check '" + rowEntry.getKey() + "' value on Traffic order details page: ",
                            actual.equals(rowEntry.getValue()), is(condition.equalsIgnoreCase("should")));
            }
        }
    }
    @Then("{I |}'$should' see following Order Item data for Clones for Clock Number '$clockNumber':$fields")
    public void checkOrderItemClonesInOrderPage(String condition, String clockNumber, ExamplesTable fields) {
        String actual = null;
        List<TrafficOrderPage.OrderItem> trafficOrderItemList = new ArrayList<TrafficOrderPage.OrderItem>();
        for (int i = 0; i < fields.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fields, i);
            Common.sleep(3000);
            TrafficOrderPage trafficOrderPage = getSut().getPageCreator().getTrafficOrderPage();
            trafficOrderItemList = trafficOrderPage.getOrderItemForClones(wrapVariableWithTestSession(row.get("Clock Number")));
            for (TrafficOrderPage.OrderItem trafficOrderItem : trafficOrderItemList) {
                for (Map.Entry<String, String> rowEntry : row.entrySet()) {
                    switch (rowEntry.getKey()) {
                        case "Clock Number":
                            actual = trafficOrderItem.getClockNumber();
                            break;
                        case "Advertiser":
                            actual = trafficOrderItem.getAdvertiser();
                            break;
                        case "Status":
                            actual = trafficOrderItem.getStatus();
                            break;
                        case "Title":
                            actual = trafficOrderItem.getTitle();
                            break;
                        case "Product":
                            actual = trafficOrderItem.getProduct();
                            break;
                        case "On Hold":
                            actual = trafficOrderItem.getOnHold();
                            break;
                    }
                    if (rowEntry.getKey().equalsIgnoreCase("Status") || rowEntry.getKey().equalsIgnoreCase("On Hold"))
                        assertThat("Check '" + rowEntry.getKey() + "' value on Traffic order details page: ",
                                actual.equals(rowEntry.getValue()), is(condition.equalsIgnoreCase("should")));
                    else
                        assertThat("Check '" + rowEntry.getKey() + "' value on Traffic order details page: ",
                                actual.equals(wrapVariableWithTestSession(rowEntry.getValue())), is(condition.equalsIgnoreCase("should")));

                }
            }
        }
    }


    @Then("{I |}'$should' see following Order Item data for Clock Number '$clockNumber':$fields")
    public void checkOrderItemInOrderPage(String condition, String clockNumber, ExamplesTable fields) {
        String actual = null;
        TrafficOrderPage.OrderItem trafficOrderItem;
        for (int i = 0; i < fields.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fields, i);
            Common.sleep(3000);
            TrafficOrderPage trafficOrderPage = getSut().getPageCreator().getTrafficOrderPage();
            trafficOrderItem = trafficOrderPage.getOrderItemByReference(wrapVariableWithTestSession(row.get("Clock Number")));
            for (Map.Entry<String, String> rowEntry : row.entrySet()) {
                switch (rowEntry.getKey()) {
                    case "Clock Number":
                        actual = trafficOrderItem.getClockNumber();
                        break;
                    case "Advertiser":
                        actual = trafficOrderItem.getAdvertiser();
                        break;
                    case "Status":
                        actual = trafficOrderItem.getStatus();
                        break;
                    case "Title":
                        actual = trafficOrderItem.getTitle();
                        break;
                    case "Product":
                        actual = trafficOrderItem.getProduct();
                        break;
                    case "On Hold":
                        actual = trafficOrderItem.getOnHold();
                        break;
                }
                if (rowEntry.getKey().equalsIgnoreCase("Status") || rowEntry.getKey().equalsIgnoreCase("On Hold"))
                    assertThat("Check '" + rowEntry.getKey() + "' value on Traffic order details page: ",
                            actual.equals(rowEntry.getValue()), is(condition.equalsIgnoreCase("should")));
                else
                    assertThat("Check '" + rowEntry.getKey() + "' value on Traffic order details page: ",
                            actual.equals(wrapVariableWithTestSession(rowEntry.getValue())), is(condition.equalsIgnoreCase("should")));


            }
        }
    }


    @Then("{I |}'$should' see following delivery item in order details page:$fields")
    public void checkDeliveryItemOrderDetails(String condition, ExamplesTable fields) {
        String actual = null;
        TrafficOrderPage.DeliveryItem deliveryItem;
        for (int i = 0; i < fields.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fields, i);
            Common.sleep(3000);
            TrafficOrderPage trafficOrderPage = getSut().getPageCreator().getTrafficOrderPage();
            deliveryItem = trafficOrderPage.getDeliveryItemByReference(wrapVariableWithTestSession(row.get("Clock Number")), row.get("Destination Name"));
            for (Map.Entry<String, String> rowEntry : row.entrySet()) {
                switch (rowEntry.getKey()) {
                    case "Clock Number":
                        actual = deliveryItem.getClockNumber();
                        break;
                    case "Destination Name":
                        actual = deliveryItem.getDestinationName();
                        break;
                    case "Delivery Status":
                        actual = deliveryItem.getDeliveryStatus();
                        break;
                    case "On Hold Dest":
                        actual = deliveryItem.getOnHoldDest();
                        break;
                    case "Service Level":
                        actual = deliveryItem.getServiceLevel();
                        break;

                }
                if (rowEntry.getKey().equalsIgnoreCase("Clock Number"))
                    assertThat("Check '" + rowEntry.getKey() + "' value on Traffic order details page: ",
                            actual.equals(wrapVariableWithTestSession(rowEntry.getValue())), is(condition.equalsIgnoreCase("should")));
                else
                    assertThat("Check '" + rowEntry.getKey() + "' value on Traffic order details page: ",
                            actual.equals(rowEntry.getValue()), is(condition.equalsIgnoreCase("should")));

            }

        }
    }


    @Then("{I |}'$should' see following production services in order details page:$fields")
    public void checkProductionServicesOrderDetails(String condition, ExamplesTable fields) {
        String actual = null;
        TrafficOrderPage trafficOrderPage = getSut().getPageCreator().getTrafficOrderPage();
        for (int i = 0; i < fields.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fields, i);
            Common.sleep(3000);
            ProductionService additionalService = trafficOrderPage.getProductionService(wrapVariableWithTestSession(row.get("Clock Number")), row.get("Type"));
            for (Map.Entry<String, String> rowEntry : row.entrySet()) {
                switch (rowEntry.getKey()) {
                    case "Clock Number":
                        actual = additionalService.getClockNumber();
                        break;
                    case "Destination":
                        actual = additionalService.getDestination();
                        break;
                    case "Delivery Status":
                        actual = additionalService.getDeliveryStatus();
                        break;
                    case "Service Level":
                        actual = additionalService.getServiceLevel();
                        break;
                    case "Notes":
                        actual = additionalService.getNotes();
                        break;
                    case "Type":
                        actual = additionalService.getType();
                        break;
                    case "Format":
                        actual = additionalService.getFormat();
                        break;
                    case "Specification":
                        actual = additionalService.getSpecification();
                        break;
                    case "No. Copies":
                        actual = additionalService.getNoOfCopies();
                        break;

                }
                if (rowEntry.getKey().equalsIgnoreCase("Clock Number") || rowEntry.getKey().equalsIgnoreCase("Destination"))
                    assertThat("Check '" + rowEntry.getKey() + "' value on Traffic order details page: ",
                            actual.equals(wrapVariableWithTestSession(rowEntry.getValue())), is(condition.equalsIgnoreCase("should")));
                else
                    assertThat("Check '" + rowEntry.getKey() + "' value on Traffic order details page: ",
                            actual.equals(rowEntry.getValue()), is(condition.equalsIgnoreCase("should")));

            }

        }

    }

    @Then("{I |}'$should' see following dubbing services in order details page:$fields")
    public void checkDubbingServicesOrderDetails(String condition, ExamplesTable fields) {
        String actual = null;
        TrafficOrderPage trafficOrderPage = getSut().getPageCreator().getTrafficOrderPage();
        for (int i = 0; i < fields.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fields, i);
            Common.sleep(3000);
            DubbingService additionalService = trafficOrderPage.getDubbingService(wrapVariableWithTestSession(row.get("Clock Number")), row.get("Type"));
            for (Map.Entry<String, String> rowEntry : row.entrySet()) {
                switch (rowEntry.getKey()) {
                    case "Clock Number":
                        actual = additionalService.getClockNumber();
                        break;
                    case "Destination":
                        actual = additionalService.getDestination();
                        break;
                    case "Delivery Status":
                        actual = additionalService.getDeliveryStatus();
                        break;
                    case "Service Level":
                        actual = additionalService.getServiceLevel();
                        break;
                    case "Notes":
                        actual = additionalService.getNotes();
                        break;
                    case "Type":
                        actual = additionalService.getType();
                        break;
                    case "Format":
                        actual = additionalService.getFormat();
                        break;
                    case "Specification":
                        actual = additionalService.getSpecification();
                        break;
                    case "No. Copies":
                        actual = additionalService.getNoOfCopies();
                        break;

                }
                if (rowEntry.getKey().equalsIgnoreCase("Clock Number") || rowEntry.getKey().equalsIgnoreCase("Destination"))
                    assertThat("Check '" + rowEntry.getKey() + "' value on Traffic order details page: ",
                            actual.equals(wrapVariableWithTestSession(rowEntry.getValue())), is(condition.equalsIgnoreCase("should")));
                else
                    assertThat("Check '" + rowEntry.getKey() + "' value on Traffic order details page: ",
                            actual.equals(rowEntry.getValue()), is(condition.equalsIgnoreCase("should")));

            }

        }

    }

    @When("{I |}select '$deliveryStatus' for the following dubbing Service '$serviceName' for Clock Number '$clockNumber':$fields")
    public void selectDeliveryStatusForDubbingService(String deliveryStatus, String serviceName,String clockNumber,ExamplesTable fields) {
        String actual = null;
        TrafficOrderPage trafficOrderPage = getSut().getPageCreator().getTrafficOrderPage();
        DateTimeFormatter dateTimeFormatter = DateTimeFormat.forPattern("dd-MMMM-yyyy");
        Map<String, String> row = parametrizeTabularRow(fields);
        row.put("date", parseDateTime(row.get("date"), TestsContext.getInstance().storiesDateTimeFormat).toString(dateTimeFormatter));
        trafficOrderPage.selectDeliveryStatus(deliveryStatus,wrapVariableWithTestSession(clockNumber),serviceName, row);
       }
    }

