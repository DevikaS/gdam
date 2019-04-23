package com.adstream.automate.babylon.tests.steps.domain.ordering;

import com.adstream.automate.babylon.JsonObjects.ordering.BeamTvClock;
import com.adstream.automate.babylon.JsonObjects.ordering.Order;
import com.adstream.automate.babylon.JsonObjects.ordering.OrderItem;
import com.adstream.automate.babylon.JsonObjects.ordering.OrderingSettings;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.DateTimeUtils;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;
import org.joda.time.Period;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/*
 * Created by demidovskiy-r on 12.03.14.
 */
public class BeamTvStatusSteps extends OrderingHelperSteps {

    private final String filterDatePattern = "YYYYMMdd HH:mm:ss";
    private final String beamDatePattern = "YYYYMMdd HH:mm:ss 'UTC'";

    private List<String> getBeamTvClockNumbers(String date) {
        List<String> beamTvClockNumbers = new ArrayList<>();
        List<BeamTvClock> beamTvClocks = getCoreApi().getBeamTvClocks(date);
        if (beamTvClocks == null || beamTvClocks.isEmpty()) return beamTvClockNumbers;
        for (BeamTvClock beamTvClock : beamTvClocks)
            beamTvClockNumbers.add(beamTvClock.getClocknumber());
        return beamTvClockNumbers;
    }

    private String prepareDateFilter(String dateFilter) {
        return dateFilter.equals("Yesterday") ? DateTimeUtils.formatDate(new DateTime().minus(Period.days(1)), filterDatePattern) : dateFilter;
    }

    private Map<String, String> prepareClockData(ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        if (row.containsKey("ClockNumber")) row.put("ClockNumber", wrapVariableWithTestSession(row.get("ClockNumber")));
        if (row.containsKey("Advertiser")) row.put("Advertiser", prepareAdvertiser(row.get("Advertiser")));
        if (row.containsKey("Brand")) row.put("Brand", wrapVariableWithTestSession(row.get("Brand")));
        if (row.containsKey("Product")) row.put("Product", wrapVariableWithTestSession(row.get("Product")));
        if (row.containsKey("Master Held At")) row.put("Master Held At", row.get("Master Held At").isEmpty() ? "" : wrapUserEmailWithTestSession(row.get("Master Held At")));
        if (row.containsKey("Deadline")) row.put("Deadline", row.get("Deadline").isEmpty() ? "" : DateTimeUtils.formatDate(parseDateTime(row.get("Deadline")), beamDatePattern));
        if (row.containsKey("First Air Date")) row.put("First Air Date", DateTimeUtils.formatDate(parseDateWithUTCZone(row.get("First Air Date")), beamDatePattern));
        if (row.containsKey("Title")) row.put("Title", wrapVariableByCriteria(row.get("Title")));
        if (row.containsKey("Job Number")) row.put("Job Number", wrapVariableWithTestSession(row.get("Job Number")));
        if (row.containsKey("PO Number")) row.put("PO Number", wrapVariableWithTestSession(row.get("PO Number")));
        if (row.containsKey("Ingest Only")) row.put("Ingest Only", String.valueOf(row.get("Ingest Only").equals("should")));
        if (row.containsKey("On Hold")) row.put("On Hold", String.valueOf(row.get("On Hold").equals("should")));
        return row;
    }

    // | ClockNumber | Order Reference | Country | Advertiser | Brand | Product | Master Held At | Service Level | Deadline | Format | Title | Duration | Delivery Method | Status | Subtitling | Date | First Air Date | Job Number | PO Number | A4 Order Url | Ingest Only | On Hold |
    @Then("{I |}should see Beam TV clock of market '$market' for date filter begins from '$dateFilter' with following data: $fieldsTable")
    public void checkBeamTVClock(String market, String dateFilter, ExamplesTable fieldsTable) {
        Map<String, String> row = prepareClockData(fieldsTable);
        String clockNumber = row.get("ClockNumber");
        Common.sleep(5000); // for correct setting date submitted
        Order order = getOrderByMarketAndItemClockNumber(market, clockNumber);
        waitForFinishPlaceOrderToA4(order.getId(), sleep);
        OrderItem orderItem = getOrderItemByClockNumber(order.getId(), clockNumber);
        BeamTvClock beamTvClock = getCoreApi().getBeamTvClockByClockNumber(clockNumber, prepareDateFilter(dateFilter));
        assertThat("ClockNumber: ", beamTvClock.getClocknumber(), equalTo(clockNumber));
        assertThat("Order Reference: ", beamTvClock.getOrdernumber(), equalTo(order.getOrderReference()));
        assertThat("Country: ", beamTvClock.getCountry(), equalTo(row.get("Country")));
        assertThat("Advertiser: ", beamTvClock.getAdvertiser(), equalTo(row.get("Advertiser")));
        assertThat("Brand:", beamTvClock.getBrand(), equalTo(row.get("Brand")));
        assertThat("Product: ", beamTvClock.getProduct(), equalTo(row.get("Product")));
        assertThat("Master Held At: ", beamTvClock.getMasterHeldAt(), equalTo(row.get("Master Held At").isEmpty() ? null : row.get("Master Held At")));
        assertThat("Service Level: ", beamTvClock.getServiceLevel(), equalTo(row.get("Service Level").isEmpty() ? null : row.get("Service Level")));
        assertThat("Format: ", beamTvClock.getFormat(), equalTo(row.get("Format")));
        assertThat("Title: ", beamTvClock.getTitle(), equalTo(row.get("Title")));
        assertThat("Duration: ", beamTvClock.getDuration(), equalTo(row.get("Duration")));
        assertThat("Delivery Method: ", beamTvClock.getDeliveryMethod(), equalTo(row.get("Delivery Method").isEmpty() ? null : row.get("Delivery Method")));
        assertThat("Status: ", beamTvClock.getStatus(), equalTo(row.get("Status")));
        assertThat("Subtitling: ", beamTvClock.getSubtitling(), equalTo(row.get("Subtitling")));
        assertThat("Deadline: ", beamTvClock.getDeadline(), equalTo(row.get("Deadline").isEmpty() ? null : row.get("Deadline")));
        assertThat("Date: ", beamTvClock.getDate(), equalTo(DateTimeUtils.formatDate(orderItem.getA4StatusChangedTime(), beamDatePattern)));
        assertThat("First Air Date: ", beamTvClock.getFirstAirDate(), equalTo(row.get("First Air Date")));
        assertThat("Job Number: ", beamTvClock.getJobNumber(), equalTo(row.get("Job Number")));
        assertThat("PO Number: ", beamTvClock.getPoNumber(), equalTo(row.get("PO Number")));
        //assertThat("A4 Order Url: ", beamTvClock.getA4OrderUrl(), equalTo(String.format(OrderingSettings.A4_ORDER_URL, orderItem.getA4OrderId())));
        assertThat("Ingest Only: ", beamTvClock.getIngestOnly(), equalTo(row.get("Ingest Only")));
        assertThat("On Hold: ", beamTvClock.getOnHold(), equalTo(row.get("On Hold")));
    }

    @Then("{I |}'$shouldState' see Beam TV clock{s|} '$clockNumbersList' for date filter begins from '$dateFilter'")
    public void checkBeamTvClocksExisting(String shouldState, String clockNumbersList, String dateFilter) {
        for (String clockNumber: clockNumbersList.split(","))
            assertThat("Check clocks existing: ", getBeamTvClockNumbers(prepareDateFilter(dateFilter)), shouldState.equals("should")
                                                                                                        ? hasItem(wrapVariableWithTestSession(clockNumber))
                                                                                                        : not(hasItem(wrapVariableWithTestSession(clockNumber))));
    }
}