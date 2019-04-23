package com.adstream.automate.babylon.performance.tests.ordering.stress;

import com.adstream.automate.babylon.BabylonServiceWrapper;
import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.JsonObjects.ordering.*;
import com.adstream.automate.babylon.JsonObjects.ordering.enums.CustomMetadataField;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.core.BabylonCoreService;
import com.adstream.automate.babylon.performance.Executor;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.DateTimeUtils;
import com.adstream.automate.utils.Gen;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.joda.time.DateTime;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeoutException;
import java.util.concurrent.atomic.AtomicInteger;

/*
 * Created by demidovskiy-r on 13.01.2015.
 * ORD-4399
 */
public class CreateSharedCollectionsAndSharedOrdersRelatedToQcAssets {
    private static final Logger log = Logger.getLogger(CreateSharedCollectionsAndSharedOrdersRelatedToQcAssets.class);
    private static final String AGENCY_NAME = "OrdersSharingAgency";
    private static final String GLOBAL_ADMIN_LOGIN = "admin";
    private static final String GLOBAL_ADMIN_PASSWORD = "abcdefghA1";
    private static final String AGENCY_ADMIN_LOGIN = "orders.sharing@test.com";
    private static final String AGENCY_ADMIN_PASSWORD = "1";
    private static final String A4_USER_EMAIL = "alejandra.medina@mccann.com.mx.ua";
    private static final String CORE_URL = "http://10.0.26.12:8080";
    private static final String STORAGE_ID = "543d1f6ce4b044f159f40f13";
    private static final String MARKET_NAME = "Brazil";
    private static final String ORDER_TYPE = "tv_order";
    private static final String ORDER_ITEM_TYPE = "tv_order_item";
    private final static String advertiser = "Advertiser";
    private final static String brand = "Brand";
    private final static String subBrand = "Sub Brand";
    private final static String product = "Product";
    private static final Integer ORDER_ITEMS_COUNT = 5;
    private static final Integer DESTINATIONS_COUNT_IN_EACH_ITEM = 1;
    private static final int THREADS_COUNT = 1;
    private static int QC_ASSETS_COUNT = 200;
    private static final int SHARED_CATEGORIES_COUNT = 1;
    private static List<Destination> destinationsPerMarket;
    private static final AtomicInteger qcAssetsCreated = new AtomicInteger();
    private BabylonServiceWrapper service;

    public static void main(String[] args) throws Exception {
        Properties properties = new Properties();
        properties.setProperty("log4j.rootLogger", "INFO,console");
        properties.setProperty("log4j.appender.console", "org.apache.log4j.ConsoleAppender");
        properties.setProperty("log4j.appender.console.layout", "org.apache.log4j.PatternLayout");
        properties.setProperty("log4j.appender.console.layout.ConversionPattern", "%d %-5p %t %c{1} %m%n");
        properties.setProperty("log4j.logger.com.adstream.automate.babylon.BabylonService", "INFO");
        PropertyConfigurator.configure(properties);
        new CreateSharedCollectionsAndSharedOrdersRelatedToQcAssets().process();
    }

    private static class QcAssetCreator implements Runnable {
        protected BabylonServiceWrapper service;

        private QcAssetCreator(BabylonServiceWrapper service) {
            this.service = service;
        }

        @Override
        public void run() {
            try {
                Order order = createOrderStage();
                completeOrderStage(order);
            } catch (Exception e) {
                e.printStackTrace();
            }
            int qcAssetsCount = qcAssetsCreated.incrementAndGet();
            if (qcAssetsCount % 10 == 0) {
                log.info("Created " + qcAssetsCount + " qc assets");
            }
        }

        private Order createOrderStage() {
            log.info("Creating order...");
            Order order = service.createOrder(MARKET_NAME, ORDER_TYPE);
            log.info("Creating order items in an amount: " + ORDER_ITEMS_COUNT + " , with destinations count in each: " + DESTINATIONS_COUNT_IN_EACH_ITEM);
            log.info("Start creating order item(s)...");
            for (int i = 0; i < ORDER_ITEMS_COUNT; i++) {
                OrderItem orderItem = generateOrderItem(i);
                List<DestinationItem> destinationItems = new ArrayList<>(DESTINATIONS_COUNT_IN_EACH_ITEM);
                for (int k = 0; k < DESTINATIONS_COUNT_IN_EACH_ITEM; k++) {
                    CustomMetadata cmServiceLvl = new CustomMetadata();
                    cmServiceLvl.put("id", new String[]{destinationsPerMarket.get(k).getServiceLevelValues().get(0).getKey()});

                    CustomMetadata cmDestinationItem = new CustomMetadata();
                    cmDestinationItem.put("id", new String[]{destinationsPerMarket.get(k).getKey()});
                    cmDestinationItem.put("serviceLevel", new ServiceLevel(cmServiceLvl));

                    DestinationItem destinationItem = new DestinationItem(cmDestinationItem);
                    destinationItems.add(destinationItem);
                }
                orderItem.setDestinationItems(destinationItems.toArray(new DestinationItem[destinationItems.size()]));
                service.createOrderItem(order.getId(), ORDER_ITEM_TYPE, orderItem);
            }
            log.info("Operation is successful.");
            log.info("Order with following id: " + order.getId() + " created successfully.");
            return order;
        }

        protected void completeOrderStage(Order order) {
            order.setJobNumber("1234");
            order.setPoNumber("1234");
            order.setPin("1111");
            order.setHandleStandardsConversions(false);
            order.setNotifyAboutDelivery(false);
            order.setNotifyAboutQc(false);
            order.setNotificationEmails(new String[]{service.getCurrentUser().getEmail()});
            QcView qcView = service.getQcView(order.getId());

            for (QcOrderItem qcOrderItem : qcView.getItems())
                if (qcOrderItem.getAssets() != null && !qcOrderItem.getAssets().isEmpty())
                    qcOrderItem.getAssets().get(0).setAdbanked(true); // set true by default due to ORD-3353

            log.info("Completing order: " + order.getId());
            Order completeOrder = service.completeOrder(order, qcView);
            if (completeOrder != null)
                log.info("Operation is successful.");
        }

        private OrderItem generateOrderItem(int counter) {
            OrderItem orderItem = new OrderItem();
            DateTime firstAirDateTime = DateTimeUtils.parseDate("08/14/2022", "M/d/yyyy");
            orderItem.setAdditionalInformation("additional information");
            orderItem.setAdvertiser(new String[]{advertiser});
            orderItem.setBrand(new String[]{brand});
            orderItem.setSubBrand(new String[]{subBrand});
            orderItem.setProduct(new String[]{product});
            orderItem.setCampaign("campaign");
            orderItem.setTitle("title");
            orderItem.setDuration("20");
            orderItem.setMetadataSubtitlesRequired(new String[]{"Yes"});
            orderItem.setFirstAirDate(firstAirDateTime);
            orderItem.setFormat(new String[]{"f1:video:master:HD:1920x1080i@25fps:PAL:16x9:MPEG2:TS:I-Frame"});
            mixMarketsSpecificFieldsToOrderItem(orderItem, MARKET_NAME);
            orderItem.setClockNumber("CN_" + counter + "_" + Gen.getHumanReadableString(10, false));
            return orderItem;
        }

        private void mixMarketsSpecificFieldsToOrderItem(OrderItem orderItem, String market) {
            if (market.equals("Brazil")) {
                DateTime dateOfAncineRegistration = DateTimeUtils.parseDate("10/12/2024", "M/d/yyyy");
                orderItem.setType("type");
                orderItem.setMarketSegment("market segment");
                orderItem.setCRT("CRT");
                orderItem.setDateOfAncineReg(dateOfAncineRegistration);
                orderItem.setDirector("director");
                orderItem.setNumberOfVersions("number of versions");
                orderItem.setCNPJ("CNPJ");
            }
        }
    }

    private CreateSharedCollectionsAndSharedOrdersRelatedToQcAssets() throws Exception {
        service = new BabylonServiceWrapper(new BabylonCoreService(new URL(CORE_URL)), null);
    }

    private void process() throws TimeoutException {
        waitTillDone();
        createAgencyAdminIfNotExist(createAgencyIfNotExist(AGENCY_NAME), AGENCY_ADMIN_LOGIN);
        logInAsAgencyAdmin();
        createQcAssets();
        shareCategories();
    }

    private void shareCategories() throws TimeoutException {
        for (int i = 0; i < SHARED_CATEGORIES_COUNT; i++) {
            logInAsGlobalAdmin();
            String agencyName = AGENCY_NAME + "_" + Gen.getHumanReadableString(6);
            String agencyAdminLogin = AGENCY_ADMIN_LOGIN.replace("@", Gen.getHumanReadableString(6) + "@");
            createAgencyAdminIfNotExist(createAgencyIfNotExist(agencyName), agencyAdminLogin);
            logInAsAgencyAdmin(agencyAdminLogin);

            log.info("login as " + agencyAdminLogin + " and Check category");
            AssetFilter category = service.getAssetsFilterByName(agencyName, "", 0);
            if (category == null) {
                log.info("Create and share category");
                Agency agency = service.getAgencyByName(AGENCY_NAME);
                category = service.createAssetFilterCategory(agencyName, new AssetFilterTerms().getQuery().toString());
                log.info("Share category " + category.getName() + " to agency " + agency.getName());

                service.shareAssetFilterToAgency(category.getId(), agency.getId());
                waitTillDone();
                service.createInboxCache(category.getId());
                long startTime = System.currentTimeMillis();
                waitTillDone();
                log.info("Elapsed time: " + Executor.ppMillis(System.currentTimeMillis() - startTime));
                log.info("Assets denormalized: " + QC_ASSETS_COUNT);
            }
        }
    }

    private void createQcAssets() {
        destinationsPerMarket = service.getDestinationsByMarket(MARKET_NAME);
        log.info("Check qc assets existing...");
        SearchResult<Content> qcAssets = service.findAssets(new LuceneSearchingParams().setResultsOnPage(QC_ASSETS_COUNT));
        int actualQcAssetsCount = qcAssets.getResult().size();
        int qcAssetsToCreate = QC_ASSETS_COUNT - actualQcAssetsCount;
        qcAssetsCreated.set(actualQcAssetsCount);

        log.info("Found " + actualQcAssetsCount + "qc assets");
        if (qcAssetsToCreate > 0) {
            log.info("Need to create " + qcAssetsToCreate + " assets");
            ExecutorService executor = Executors.newFixedThreadPool(THREADS_COUNT);
            for (int i = 0; i < qcAssetsToCreate; i++) {
                executor.execute(new QcAssetCreator(service));
            }
            executor.shutdown();
            while (!executor.isTerminated()) {
                Common.sleep(100);
            }
        }
    }

    private Agency createAgencyIfNotExist(String agencyName) {
        logInAsGlobalAdmin();
        log.info("Check agency...");
        Agency agency = service.getAgencyByName(agencyName);
        if (agency == null) {
            log.info("Create agency...");
            agency = new Agency();
            agency.setTimeZone("Europe-Andorra");
            agency.setPin("1");
            agency.setAgencyType("Advertiser");
            agency.setCountry("AF");
            agency.setPasswordExpirationInDays(30);
            agency.setPasswordMinIncludingUppercase(0);
            agency.setPasswordMinTotalLengthOfPassword(1);
            agency.setPasswordMinimumIncludingNumbers(0);
            agency.setA4User(A4_USER_EMAIL);
            agency.setName(agencyName);
            agency.setA4AdvertiserField(CustomMetadataField.ADVERTISER.getPath());
            agency.setA4ProductField(CustomMetadataField.PRODUCT.getPath());
            agency.setA4CampaignField(CustomMetadataField.CAMPAIGN.getPath());
            agency.setStorageId(STORAGE_ID);
            agency = service.createAgency(agency);
            log.info("Has been created agency with name: " + agencyName);
        }
        return agency;
    }

    private User createAgencyAdminIfNotExist(Agency agency, String agencyAdminEmail) {
        log.info("Check agency admin user...");
        User agencyAdminUser = service.getUserByEmail(agencyAdminEmail, 0);
        if (agencyAdminUser == null) {
            log.info("Create agency admin user...");
            agencyAdminUser = new User();
            agencyAdminUser.setPhoneNumber("1234567890");
            agencyAdminUser.setPassword(AGENCY_ADMIN_PASSWORD);
            agencyAdminUser.setFullAccess();
            agencyAdminUser.setRoles(new BaseObject[]{service.getRoleByName("agency.admin")});
            agencyAdminUser.setFirstName(Gen.getHumanReadableString(6, true));
            agencyAdminUser.setLastName(Gen.getHumanReadableString(6, true));
            agencyAdminUser.setEmail(agencyAdminEmail);
            agencyAdminUser.setAgency(agency);
            agencyAdminUser.setAdvertiser(agency.getId());
            agencyAdminUser = service.createUser(agencyAdminUser);
            log.info("Has been created agency admin user: " + agencyAdminEmail);
        }
        return agencyAdminUser;
    }

    private void logInAsGlobalAdmin() {
        log.info("Log in as global admin");
        service.logIn(GLOBAL_ADMIN_LOGIN, GLOBAL_ADMIN_PASSWORD);
    }

    private void logInAsAgencyAdmin() {
        logInAsAgencyAdmin(AGENCY_ADMIN_LOGIN);
    }

    private void logInAsAgencyAdmin(String email) {
        log.info("Log in as agency admin: " + email);
        service.logIn(email, AGENCY_ADMIN_PASSWORD);
    }

    private void waitTillDone() throws TimeoutException {
        long timeout = 15 * 60 * 1000; //15 min
        long pollInterval = 500; //500 ms
        long timeToEnd = System.currentTimeMillis() + timeout;
        do {
            int numOfJobs = service.getInboxCacheStatus();
            if (numOfJobs != 0) {
                log.info("found background jobs: " + numOfJobs);
                Common.sleep(pollInterval);
            } else {
                return;
            }
            if (System.currentTimeMillis() >= timeToEnd) {
                throw new TimeoutException("Task timeout after " + timeout + "ms");
            }
        } while (true);
    }
}