package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.JsonObjects.ordering.Order;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryAssetsDestinationPage;
import com.adstream.automate.babylon.sut.pages.ordering.elements.lists.AssetsDestinationList;
import com.adstream.automate.babylon.sut.pages.ordering.elements.lists.DestinationToDelivery;
import com.adstream.automate.utils.DateTimeUtils;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/*
 * Created by demidovskiy-r on 21.08.2014.
 */
public class AdbankLibraryAssetsDestinationSteps extends LibrarySteps {

    private AdbankLibraryAssetsDestinationPage openAdbankLibraryAssetsDestinationPage(String collectionId, String assetId) {
        return getSut().getPageNavigator().getAdbankLibraryAssetsDestinationPage(collectionId, assetId);
    }

    private AdbankLibraryAssetsDestinationPage getAdbankLibraryAssetsDestinationPage() {
        return getSut().getPageCreator().getAdbankLibraryAssetsDestinationPage();
    }

    private AssetsDestinationList getAssetsDestinationList() {
        return getAdbankLibraryAssetsDestinationPage().getAssetsDestinationList();
    }

    private AssetsDestinationList getAssetsDestList() {
        return getAdbankLibraryAssetsDestinationPage().getAssetsDestList();
    }

    private void checkAssetsDestinations(Order order, Map<String, String> row) throws ParseException {
        String orderReference = String.valueOf(order.getOrderReference());
        AssetsDestinationList.AssetsDestination assetsDestination = getAssetsDestinationList().getAssetsDestinationByOrderReference(orderReference);
        if (row.containsKey("Order #")) assertThat("Order #: ", assetsDestination.getOrderReference(), equalTo(orderReference));
        if (row.containsKey("Destination")) assertThat("Destination: ", assetsDestination.getDestination(), equalTo(row.get("Destination")));
        if (row.containsKey("Date Ordered")) {
            String[] parts = String.valueOf(order.getSubmitted()).split("T");
            SimpleDateFormat sdfIn = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat sdfOut = new SimpleDateFormat("dd/MM/yyyy");
            Date date = sdfIn.parse(parts[0]);
            assertThat("Date Ordered: ", assetsDestination.getDateOrdered(), equalTo(sdfOut.format(date)));
        }
        if (row.containsKey("Ordered by")) {
            User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(row.get("Ordered by")));
            assertThat("Ordered by: ", assetsDestination.getOrderedBy(), equalTo(user.getFullName()));
        }
        if (row.containsKey("Status")) assertThat("Status: ", assetsDestination.getStatus(), equalTo(row.get("Status")));
    }

    private void checkAssetsDestinationsForOrder(Order order, Map<String, String> row) throws ParseException {
        String orderReference = String.valueOf(order.getOrderReference());
        AssetsDestinationList.AssetsDestination assetsDestination = getAssetsDestList().getAssetsDestByOrderReference(orderReference);
        if (row.containsKey("Order #")) assertThat("Order #: ", assetsDestination.getOrderReference(), equalTo(orderReference));
        if (row.containsKey("Destination")) assertThat("Destination: ", assetsDestination.getDestination(), equalTo(row.get("Destination")));
        if (row.containsKey("Date Ordered")) {

                String dateTimeFormat = String.format("%s", getCurrentUserDateTimeFormat());
                String dateTimeUI = DateTimeUtils.getFormattedUTCDate(assetsDestination.getDateOrdered(), dateTimeFormat); // formatting date to UTC format because core date is in UTC
                assertThat("Date Ordered: ", dateTimeUI, equalTo(DateTimeUtils.formatDate(order.getSubmitted(), dateTimeFormat)));

        }

        if (row.containsKey("Ordered by")) {
            User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(row.get("Ordered by")));
            assertThat("Ordered by: ", assetsDestination.getOrderedBy(), equalTo(user.getFullName()));
        }
        if (row.containsKey("Status")) assertThat("Status: ", assetsDestination.getStatus(), equalTo(row.get("Status")));
    }

    private void checkAssetsMultipleDestinationDetails(Order order, Map<String, String> row,String destination) throws ParseException {
        String orderReference = String.valueOf(order.getOrderReference());
        AssetsDestinationList.AssetsDestination assetsDestination = getAssetsDestinationList().getAssetsDestinationByOrderReference(orderReference);
        AdbankLibraryAssetsDestinationPage asset = getAdbankLibraryAssetsDestinationPage();
        if (row.containsKey("Order #"))
        {
           String orderNumber = asset.verifyDestinationDetails(destination, "Order #");
            assertThat("Order #: ", orderNumber, equalTo(orderReference));
        }
        if (row.containsKey("Destination"))
        {
            String destinationName = asset.verifyDestinationDetails(destination, "Destination");
            assertThat("Destination: ", destinationName, equalTo(row.get("Destination")));
        }
        if (row.containsKey("Date Ordered"))
        {
            String dateOrdered = asset.verifyDestinationDetails(destination, "Date Ordered");
            String[] parts = String.valueOf(order.getSubmitted()).split("T");
            SimpleDateFormat sdfIn = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat sdfOut = new SimpleDateFormat("dd/MM/yyyy");
            Date date1 = sdfIn.parse(parts[0]);
            assertThat("Date Ordered: ", dateOrdered, equalTo(sdfOut.format(date1)));
        }
        if (row.containsKey("Ordered by"))
        {
            String orderedBy= asset.verifyDestinationDetails(destination, "Ordered by");
            User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(row.get("Ordered by")));
            assertThat("Ordered by: ", orderedBy, equalTo(user.getFullName()));
        }
        if (row.containsKey("Status"))
        {
            String status = asset.verifyDestinationDetails(destination, "Status");
            assertThat("Status: ", status, equalTo(row.get("Status")));
        }
    }

    @Given("{I am |}on asset '$assetName' destinations info page in Library for collection '$collectionName'")
    @When("{I |}go to asset '$assetName' destinations info page in Library for collection '$collectionName'")
    public AdbankLibraryAssetsDestinationPage openLibraryAssetsDestinationPage(String assetName, String collectionName) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        Content asset = getAsset(collectionId, assetName);
        if (asset == null) throw new NullPointerException("There is no any assets in library with following name: " + assetName);
        return openAdbankLibraryAssetsDestinationPage(collectionId, asset.getId());
    }

    @When("{I |}open order summary page for order with item destination '$destinationName' from assets destinations info page in Library")
    public void openOrderSummaryPageFromAssetsDestinationPage(String destinationName) {
        getAssetsDestinationList().getAssetsDestinationByName(destinationName).openOrderSummaryPage();
    }

    // | Order # | Destination | Date Ordered | Ordered by | Status |
    @Then("{I |}should see following data for destination of order with item clock number '$clockNumber' on assets destinations info page in Library: $fieldsTable")
    public void checkAssetsDestinationsData(String clockNumber, ExamplesTable fieldsTable) throws ParseException {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        Order order = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)); // CoreApiAdmin is used to see orders from another agency users after sharing assets
        checkAssetsDestinations(order, row);
    }

    // | Order # | Destination | Date Ordered | Ordered by | Status |
    @Then("{I |}should see following data for destination of order with item clock number '$clockNumber' on assets destinations page in Library: $fieldsTable")
    public void checkAssetsDestData(String clockNumber, ExamplesTable fieldsTable) throws ParseException {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        Order order = getCoreApiAdmin().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber)); // CoreApiAdmin is used to see orders from another agency users after sharing assets
        checkAssetsDestinationsForOrder(order, row);
    }


    // | Order # | Destination | Date Ordered | Ordered by | Status |
    @Then("{I |}should see following data for destination of orders with markets '$marketList' on assets destinations info page in Library: $fieldsTable")
    public void checkAssetsDestinationsDataByOrdersMarket(String marketList, ExamplesTable fieldsTable) throws ParseException {
        String [] markets = marketList.split(",");
        if (markets.length != fieldsTable.getRowCount())
            throw new IllegalStateException("Count markets different from count assets destinations!");
        for (int i = 0;  i < markets.length; i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            Order order = getCoreApi().getOrderByMarket(markets[i]);
            checkAssetsDestinations(order, row);
        }
    }

    @Then("{I |}should see following data for destination '$destination' of orders with markets '$marketList' on assets destinations info page in Library: $fieldsTable")
    public void checkAssetsDestinationsDataByOrdersMarketDestination(String destination,String marketList, ExamplesTable fieldsTable) throws ParseException {
        String [] markets = marketList.split(",");
        if (markets.length != fieldsTable.getRowCount())
            throw new IllegalStateException("Count markets different from count assets destinations!");
        for (int i = 0;  i < markets.length; i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            Order order = getCoreApi().getOrderByMarket(markets[i]);
            checkAssetsMultipleDestinationDetails(order, row, destination);
        }
    }

    @Then("{I |}'$shouldState' see assets destinations list on assets destinations info page in Library")
    public void checkVisibilityAssetsDestinationsList(String shouldState) {
        assertThat("Check visibility assets destinations list: ", getAssetsDestinationList(), shouldState.equals("should") ? not(nullValue()) : nullValue());
    }

    @Then("{I |}'$shouldState' see order reference link for destination '$destinationName' on assets destinations info page in Library")
    public void checkVisibilityOrderReferenceLink(String shouldState, String destinationName) {
        assertThat("Check visibility order reference link for destination " + destinationName, getAssetsDestinationList().getAssetsDestinationByName(destinationName).isOrderReferenceLinkVisible(),
                                                                                                          is(shouldState.equals("should")));
    }

    @Then("{I |}'$shouldState' see order reference link for destination '$destinationName' on assets destinations page in Library")
    public void checkVisibilityOrderRefLink(String shouldState, String destinationName) {
        assertThat("Check visibility order reference link for destination " + destinationName, getAssetsDestList().getAssetsDestByName(destinationName).isOrderReferenceLinkVisible(),
                is(shouldState.equals("should")));
    }
}