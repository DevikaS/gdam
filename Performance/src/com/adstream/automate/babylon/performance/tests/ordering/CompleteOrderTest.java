package com.adstream.automate.babylon.performance.tests.ordering;

import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.JsonObjects.BaseObject;
import com.adstream.automate.babylon.JsonObjects.CustomMetadata;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.JsonObjects.ordering.*;
import com.adstream.automate.babylon.JsonObjects.ordering.enums.CustomMetadataField;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.performance.tests.AbstractPerformanceTestServiceWrapper;
import com.adstream.automate.utils.DateTimeUtils;
import com.adstream.automate.utils.Gen;
import org.joda.time.DateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 02.10.13
 * Time: 14:00
 */
public class CompleteOrderTest extends AbstractPerformanceTestServiceWrapper {
    private User defaultUser;
    private OrderItem defaultOrderItem;
    private static Agency defaultAgency;
    protected static List<Destination> destinationsPerMarket;
    private final static String advertiser = "Advertiser";
    private final static String brand = "Brand";
    private final static String subBrand = "Sub Brand";
    private final static String product = "Product";
    private final static String defaultPassword = "1";
    private final static Boolean isArchive  = true;

    @Override
    public void runOnce() {
        log.info("Login as global admin...");
        logIn(getParam("login"), getParam("password"));
        log.info("Creating agency...");
        defaultAgency = getService().createAgency(generateAgency());
        log.info("Agency was created with following user for a4 integration: " + defaultAgency.getA4User());
        log.info(String.format("Creating dictionary for default agency with advertiser: %s, brand: %s, sub brand: %s, product: %s", advertiser, brand, subBrand, product));
        getService().createAgencyDictionary(defaultAgency.getId(), "advertiser", generateAdvertiserDictionary());
        log.info("Creating user has access to ordering...");
        User user = getService().createUser(defaultAgency.getId(), generateAdminUser());
        log.info("Login to system by: " + user.getEmail());
        logIn(user.getEmail(), defaultPassword);
        log.info("Getting destinations per market: " + getParam("market"));
        destinationsPerMarket = getService().getDestinationsByMarket(getTvMarketByName(getParam("market")).getKey(), new LuceneSearchingParams()).getValues();
    }

    @Override
    public void beforeStart() {
        logIn(getParam("login"), getParam("password"));
        log.info("Creating agency admin...");
        User agencyAdminUser = getService().createUser(defaultAgency.getId(), generateAdminUser());
        log.info("Login to system by: " + agencyAdminUser.getEmail());
        logIn(agencyAdminUser.getEmail(), defaultPassword);
        getCurrentAgency();
        log.info("Waiting for starting thread(s)...");
    }

    @Override
    public void start() {
        Order order = createOrderStage();
        completeOrderStage(order);
    }

    @Override
    public void afterRun() {
    }

    protected Order createOrderStage() {
        log.info("Creating order...");
        Order order = getService().createOrder(prepareOrder());
        order.setTVMarketId(new String[]{getTvMarketByName(getParam("market")).getKey()});
        log.info("Updating order by market: " + getParam("market"));
        getService().updateOrder(order);
        int destinationsCount = getParamInt("broadcastDestinationsCount");
        log.info("Creating order items in an amount: " + getParam("orderItemsCount") + " , with destinations count in each: " + destinationsCount);
        log.info("Start creating order item(s)...");
        for (int i = 0; i < getParamInt("orderItemsCount"); i++) {
            OrderItem orderItem = generateOrderItem(i);
            List<DestinationItem> destinationItems = new ArrayList<>(destinationsCount);
            for (int k = 0; k < destinationsCount; k++) {
                CustomMetadata cmServiceLvl = new CustomMetadata();
                cmServiceLvl.put("id", new String[]{destinationsPerMarket.get(k).getServiceLevelValues().get(0).getKey()});

                CustomMetadata cmDestinationItem = new CustomMetadata();
                cmDestinationItem.put("id", new String[]{destinationsPerMarket.get(k).getKey()});
                cmDestinationItem.put("serviceLevel", new ServiceLevel(cmServiceLvl));

                DestinationItem destinationItem = new DestinationItem(cmDestinationItem);
                destinationItems.add(destinationItem);
            }
            orderItem.setDestinationItems(destinationItems.toArray(new DestinationItem[destinationItems.size()]));
            getService().createOrderItem(order.getId(), getParam("orderItemType"), orderItem);
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
        order.setNotificationEmails(new String[]{getService().getCurrentUser().getEmail()});
        QcView qcView = getService().getQcView(order.getId());

        for (QcOrderItem qcOrderItem : qcView.getItems())
            if (qcOrderItem.getAssets() != null && !qcOrderItem.getAssets().isEmpty())
                qcOrderItem.getAssets().get(0).setAdbanked(isArchive); // set true by default due to ORD-3353

        log.info("Completing order: " + order.getId());
        long start = System.currentTimeMillis();
        Order completeOrder = getService().completeOrder(order, qcView);
        if (completeOrder == null)
            fail("Cannot complete order: " + order.getId());
        addPartialTime("Complete order time, s: ", System.currentTimeMillis() - start);
        log.info("Operation is successful.");
    }

    protected User generateAdminUser() {
        if (defaultUser == null) {
            defaultUser = new User();
            defaultUser.setPhoneNumber("1234567890");
            defaultUser.setPassword(defaultPassword);
            defaultUser.setFullAccess();
        }
        defaultUser.setRoles(new BaseObject[]{getRoleByName("agency.admin")});
        defaultUser.setFirstName(Gen.getHumanReadableString(6, true));
        defaultUser.setLastName(Gen.getHumanReadableString(6, true));
        defaultUser.setEmail((defaultUser.getFirstName() + "." + defaultUser.getLastName() + "@test.com").toLowerCase());
        defaultUser.setAgency(defaultAgency);
        defaultUser.setAdvertiser(defaultAgency.getId());
        return defaultUser;
    }

    protected Agency generateAgency() {
        defaultAgency = new Agency();
        defaultAgency.setTimeZone("Europe-Andorra");
        defaultAgency.setPin("1");
        defaultAgency.setAgencyType("Advertiser");
        defaultAgency.setCountry("AF");
        defaultAgency.setPasswordExpirationInDays(30);
        defaultAgency.setPasswordMinIncludingUppercase(0);
        defaultAgency.setPasswordMinTotalLengthOfPassword(1);
        defaultAgency.setPasswordMinimumIncludingNumbers(0);
        defaultAgency.setA4User(A4User.LOCAL.toString());
        defaultAgency.setName(Gen.getHumanReadableString(6, true) + " Agency");
        defaultAgency.setA4AdvertiserField(CustomMetadataField.ADVERTISER.getPath());
        defaultAgency.setA4ProductField(CustomMetadataField.PRODUCT.getPath());
        defaultAgency.setA4CampaignField(CustomMetadataField.CAMPAIGN.getPath());
        defaultAgency.setStorageId(getParam("storageId"));
        return defaultAgency;
    }

    protected List<CustomMetadata> generateAdvertiserDictionary() {
        List<CustomMetadata> customMetadataList = new ArrayList<>();
        CustomMetadata adv = new CustomMetadata();
        adv.put("key", advertiser);

        List<CustomMetadata> brandCMList = new ArrayList<>();
        List<CustomMetadata> subBrandCmList = new ArrayList<>();
        List<CustomMetadata> productCmList = new ArrayList<>();

        CustomMetadata brandCM = new CustomMetadata();
        CustomMetadata subBrandCM = new CustomMetadata();
        CustomMetadata productCM = new CustomMetadata();

        brandCM.put("key", brand);
        subBrandCM.put("key", subBrand);
        productCM.put("key", product);

        productCmList.add(productCM);
        subBrandCmList.add(subBrandCM);
        brandCMList.add(brandCM);

        subBrandCM.put("values", productCmList);
        brandCM.put("values", subBrandCmList);
        adv.put("values", brandCMList);

        customMetadataList.add(adv);
        return customMetadataList;
    }

    protected OrderItem generateOrderItem(int counter) {
        if (defaultOrderItem == null) {
            defaultOrderItem = new OrderItem();
            DateTime firstAirDateTime = DateTimeUtils.parseDate("08/14/2022", "M/d/yyyy");
            defaultOrderItem.setAdditionalInformation("additional information");
            defaultOrderItem.setAdvertiser(new String[]{advertiser});
            defaultOrderItem.setBrand(new String[]{brand});
            defaultOrderItem.setSubBrand(new String[]{subBrand});
            defaultOrderItem.setProduct(new String[]{product});
            defaultOrderItem.setCampaign("campaign");
            defaultOrderItem.setTitle("title");
            defaultOrderItem.setDuration("20");
            defaultOrderItem.setMetadataSubtitlesRequired(new String[]{"Yes"});
            defaultOrderItem.setFirstAirDate(firstAirDateTime);
            defaultOrderItem.setFormat(new String[]{"f1:video:master:HD:1920x1080i@25fps:PAL:16x9:MPEG2:TS:I-Frame"});
            mixOrderItemFieldsDependsOnMarket(getParam("market"));
        }
        defaultOrderItem.setClockNumber("CN_" + counter + "_" + Gen.getHumanReadableString(10, false));
        return defaultOrderItem;
    }

    private void mixOrderItemFieldsDependsOnMarket(String market) {
        if (market.equals("Brazil")) {
            DateTime dateOfAncineRegistration = DateTimeUtils.parseDate("10/12/2024", "M/d/yyyy");
            defaultOrderItem.setType("type");
            defaultOrderItem.setMarketSegment("market segment");
            defaultOrderItem.setCRT("CRT");
            defaultOrderItem.setDateOfAncineReg(dateOfAncineRegistration);
            defaultOrderItem.setDirector("director");
            defaultOrderItem.setNumberOfVersions("number of versions");
            defaultOrderItem.setCNPJ("CNPJ");
        }
    }

    private enum A4User {
        LOCAL("alejandra.medina@mccann.com.mx.ua"),
        LIVE("Adpath@adstream.com");

        private String userEmail;

        private A4User(String userEmail) {
            this.userEmail = userEmail;
        }

        @Override
        public String toString() {
            return userEmail;
        }
    }
}