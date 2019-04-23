package com.adstream.automate.babylon.performance.tests.ordering;

import com.adstream.automate.babylon.JsonObjects.ordering.billing.*;
import com.adstream.automate.utils.Gen;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/*
 * Created by demidovskiy-r on 07.07.2014.
 */
public class BillOrderTest extends GetPriceOrderTest {
    private final static String operationName = "ConfQUOT";
    private final static String attributeName = "AttributeName";
    private final static String attributeValue = "AttributeValue";
    private final static String titleClock = "Title";
    private final static String jobNumber = "Job Number";
    private final static String poNumber = "PO Number";
    private final static String[] formats = {"SDPAL/16x9", "HD1080/25"};
    private static String confirmEndPointUrl;
    private static Boolean withMetadataStuff;

    @Override
    public void runOnce() {
        super.runOnce();
        confirmEndPointUrl = getParam("confirmEndPointUrl");
        withMetadataStuff = getParamBoolean("withMetadataStuff");
    }

    @Override
    public void start() {
        BillingView billingView = getBillingView();
        log.info("Preparing order bills...");
        List<Bill> bills = prepareBills(getPrices(billingView, getPriceEndPointUrl), billingView);
        log.info("Finished.");
        long start = System.currentTimeMillis();
        log.info("Bill order...");
        Payment[] payments = getService().billOrder(bills, confirmEndPointUrl);
        if (payments == null || payments.length == 0 || payments[0].getSOID() == null)
            fail("Cannot bill order!");
        addPartialTime("Place order for bill, s: ", System.currentTimeMillis() - start);
        log.info("Success.");
    }

    private List<Bill> prepareBills(Price[] prices, BillingView billingView) {
        List<Bill> bills = new ArrayList<>();
        if (prices == null || prices.length == 0)
            throw new RuntimeException("Cannot get order price for country: " + billingView.getBillToCountry() + " and customer: " + billingView.getBillToCustomer());
        for (Price price : prices) {
            Bill bill = new Bill();
            bill.setTimeStamp(billingView.getTimeStamp());
            bill.setOperation(operationName);
            bill.setQUOTID(price.getQUOTID());
            bill.setRelatedDoc(price.getRelatedDoc());
            bill.setSLD(price.getSLD());
            if (withMetadataStuff) {
                List<ClockMetadata> clocksMetadata = generateClocksMetadata(billingView);
                bill.setOrderMetaData(generateOrderMetadata());
                bill.setClocksMetaData(clocksMetadata.toArray(new ClockMetadata[clocksMetadata.size()]));
            }
            bills.add(bill);
        }
        return bills;
    }

    private List<ClockMetadata> generateClocksMetadata(BillingView billingView) {
        List<ClockMetadata> clocksMetadata = new ArrayList<>();
        for (int i = 0; i < getParamInt("clocksCount"); i++) {
            ClockMetadata clockMetadata = new ClockMetadata();
            List<Catalogue> catalogues = generateCatalogues();
            clockMetadata.setAdvertiser(advertiser);
            clockMetadata.setClockID(billingView.getItems()[0].getClocks()[i].getClockID());
            clockMetadata.setTitle(titleClock + "_" + Gen.getHumanReadableString(6, false));
            clockMetadata.setFormat(Arrays.asList(formats).get(Gen.getInt(formats.length)));
            clockMetadata.setCatalogue(catalogues.toArray(new Catalogue[catalogues.size()]));
            clocksMetadata.add(clockMetadata);
        }
        return clocksMetadata;
    }

    private List<Catalogue> generateCatalogues() {
        List<Catalogue> catalogues = new ArrayList<>();
        for (int i = 0; i < getParamInt("catalogueItemsCount"); i++) {
            Catalogue catalogue = new Catalogue();
            catalogue.setAttributePosition(i);
            catalogue.setAttributeName(attributeName + "_" + Gen.getHumanReadableString(6, false));
            catalogue.setAttributeValue(attributeValue + "_" + Gen.getHumanReadableString(6, false));
            catalogues.add(catalogue);
        }
        return catalogues;
    }

    private OrderMetadata generateOrderMetadata() {
        OrderMetadata orderMetadata = new OrderMetadata();
        orderMetadata.setJobNumber(jobNumber + "_" + Gen.getHumanReadableString(6, false));
        orderMetadata.setPONumber(poNumber + "_" + Gen.getHumanReadableString(6, false));
        return orderMetadata;
    }
}