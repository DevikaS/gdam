package com.adstream.automate.babylon.performance.tests.ordering;

import com.adstream.automate.babylon.JsonObjects.ordering.billing.*;
import com.adstream.automate.babylon.performance.billing.Customer;
import com.adstream.automate.babylon.performance.billing.CustomerModel;
import com.adstream.automate.babylon.performance.tests.AbstractPerformanceTestServiceWrapper;
import com.adstream.automate.utils.DateTimeUtils;
import com.adstream.automate.utils.Gen;
import com.google.gson.Gson;
import java.io.FileReader;
import java.util.*;

/*
 * Created by demidovskiy-r on 04.07.2014.
 */
public class GetPriceOrderTest extends AbstractPerformanceTestServiceWrapper {
    protected final static String advertiser = "Advertiser";
    private final static String clockId = "AutoTestClockId-SAP20";
    private final static String a5OrderRef = "A5OrderRef";
    private final static String[] videoFormats = {"SD", "HD"};
    protected static String getPriceEndPointUrl;
    private static CustomerModel customerModel;
    private static String customerModelFile;
    private static List<Customer> customers;

    @Override
    public void runOnce() {
        getPriceEndPointUrl = getParam("getPriceEndPointUrl");
        customerModelFile = System.getProperty("customers") != null ? System.getProperty("customers") : "customers.json";
        try {
            customerModel = new Gson().fromJson(new FileReader(customerModelFile), CustomerModel.class);
        } catch (Exception e) {
            e.printStackTrace();
            System.exit(1);
        }
        customers = getParamBoolean("isMultiCountry") ? customerModel.getItems() : Arrays.asList(customerModel.getItem());
    }

    @Override
    public void beforeStart() {
    }

    @Override
    public void start() {
        BillingView billingView = getBillingView();
        log.info("Getting order prices...");
        Price[] prices = getPrices(billingView, getPriceEndPointUrl);
        if (prices == null || prices.length == 0 || prices[0].getQUOTID() == null)
            fail("Cannot get order price for country: " + billingView.getBillToCountry() + " and customer: " + billingView.getBillToCustomer());
        log.info("Success.");
    }

    @Override
    public void afterRun() {
    }

    protected Price[] getPrices(BillingView billingView, String endPointUrl) {
        return getService().getPrices(billingView, endPointUrl);
    }

    protected BillingView getBillingView() {
        Customer customer = getCustomer();
        String country = customer.getCountry();
        String customerSapId = customer.getCustomer();
        log.info("Preparing billing view for country: " + country + " and customer: " + customerSapId);
        BillingView billingView = prepareBillingView(country, customerSapId);
        log.info("Finished.");
        return billingView;
    }

    private BillingView prepareBillingView(String country, String customerSapId) {
        BillingClockService billingClockService = new BillingClockService();
        billingClockService.setSapServiceID(getParam("sapServiceId"));
        billingClockService.setQuantity(1);
        billingClockService.setType(1);

        List<BillingClock> billingClocks = new ArrayList<>();
        for (int i = 0; i < getParamInt("clocksCount"); i++) {
            BillingClock billingClock = new BillingClock();
            List<BillingClockDestination> billingClockDestinations = generateBillingClockDestinations(country);
            billingClock.setClockID(clockId + "_" + Gen.getHumanReadableString(6, false));
            billingClock.setClockDuration(31);
            billingClock.setDestinations(billingClockDestinations.toArray(new BillingClockDestination[billingClockDestinations.size()]));
            billingClock.setServices(new BillingClockService[] {billingClockService});
            billingClocks.add(billingClock);
        }

        BillingItem billingItem = new BillingItem();
        billingItem.setAdvertiser(advertiser);
        billingItem.setClocks(billingClocks.toArray(new BillingClock[billingClocks.size()]));

        BillingView billingView = new BillingView();
        billingView.setTimeStamp(getCurrentDate());
        billingView.setAgency(customerSapId);
        billingView.setAgencyCountry(country);
        billingView.setBillToCustomer(customerSapId);
        billingView.setBillToCountry(country);
        billingView.setA5OrderRef(a5OrderRef + Gen.generateGID(8));
        billingView.setItems(new BillingItem[]{billingItem});
        return billingView;
    }

    private List<BillingClockDestination> generateBillingClockDestinations(String country) {
        List<BillingClockDestination> billingClockDestinations = new ArrayList<>();
        for (int i = 0; i < getParamInt("clockDestinationsCount"); i++) {
            BillingClockDestination billingClockDestination = new BillingClockDestination();
            billingClockDestination.setVideoFormat(Arrays.asList(videoFormats).get(Gen.getInt(videoFormats.length)));
            billingClockDestination.setSLA(1);
            billingClockDestination.setOriginCountry(country);
            billingClockDestination.setDestinationCountry(country);
            billingClockDestination.setDestinationType(1);
            billingClockDestination.setDestinationID(Gen.getHumanReadableString(6, false));
            billingClockDestination.setProductType(1);
            billingClockDestinations.add(billingClockDestination);
        }
        return billingClockDestinations;
    }

    private String getCurrentDate() {
       return DateTimeUtils.formatDate(new Date(), "yyyy-MM-dd'T'hh:mm:ss");
    }

    private Customer getCustomer() {
        return customers.get(Gen.getInt(customers.size()));
    }
}