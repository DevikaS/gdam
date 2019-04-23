package com.adstream.automate.babylon.performance.stress;

import com.adstream.automate.babylon.BabylonServiceWrapper;
import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.core.BabylonCoreService;
import com.adstream.automate.babylon.performance.Executor;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.Gen;
import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import java.io.*;
import java.net.URL;
import java.util.Properties;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeoutException;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * User: Ruslan Semerenko
 * Date: 23.01.14 13:32
 */
public class CreateSharedCollectionsAndTestDenormalization {
    private static final Logger log = Logger.getLogger(CreateSharedCollectionsAndTestDenormalization.class);
    private static final String AGENCY_NAME = "ForGlobalSearch";
    private static final String GLOBAL_ADMIN_LOGIN = "admin";
    private static final String GLOBAL_ADMIN_PASSWORD = "abcdefghA1";
    private static final String AGENCY_ADMIN_LOGIN = "globalsearch@test.com";
    private static final String AGENCY_ADMIN_PASSWORD = "abcdefghA1";
    private static final String CORE_URL = "http://perfa5-elb-internal.adstream.com:8080";
    private static final int THREADS_COUNT = 1;
    private static int ASSETS_COUNT = 100;
    private static final int SHARED_CATEGORIES_COUNT = 1;
    private static final File FILE_FOR_UPLOAD = new File("resources/logo.jpg");
    private static final String FILE_FOR_UPLOAD_EXTENSION = ".jpg";
    private static final File TMP_DIRECTORY = new File(System.getProperty("java.io.tmpdir"));
    private static final AtomicInteger assetsCreated = new AtomicInteger();
    private BabylonServiceWrapper service;

    public static void main(String[] args) throws Exception {
        Properties properties = new Properties();
        properties.setProperty("log4j.rootLogger", "INFO,console");
        properties.setProperty("log4j.appender.console", "org.apache.log4j.ConsoleAppender");
        properties.setProperty("log4j.appender.console.layout", "org.apache.log4j.PatternLayout");
        properties.setProperty("log4j.appender.console.layout.ConversionPattern", "%d %-5p %t %c{1} %m%n");
        properties.setProperty("log4j.logger.com.adstream.automate.babylon.BabylonService", "INFO");
        PropertyConfigurator.configure(properties);
        new CreateSharedCollectionsAndTestDenormalization().process();
    }

    private static class AssetCreator implements Runnable {
        protected BabylonServiceWrapper service;

        private AssetCreator(BabylonServiceWrapper service) {
            this.service = service;
        }

        @Override
        public void run() {
            try {
                File tmpFile = getFileForUpload();
                service.uploadAsset(tmpFile);
                tmpFile.delete();
            } catch (Exception e) {
                e.printStackTrace();
            }
            int assetsCount = assetsCreated.incrementAndGet();
            if (assetsCount % 10 == 0) {
                log.info("Created " + assetsCount + " assets");
            }
        }

        protected File getFileForUpload() throws Exception {
            File tmpFile = new File(TMP_DIRECTORY, Gen.getHumanReadableString(6) + FILE_FOR_UPLOAD_EXTENSION);
            InputStream source = new FileInputStream(FILE_FOR_UPLOAD);
            OutputStream destination = new FileOutputStream(tmpFile);
            IOUtils.copy(source, destination);
            source.close();
            destination.close();
            return tmpFile;
        }
    }

    private CreateSharedCollectionsAndTestDenormalization() throws Exception {
        service = new BabylonServiceWrapper(new BabylonCoreService(new URL(CORE_URL)), null);
    }

    private void process() throws TimeoutException {
        //check if there background operations
        for (int i = 10; i <= 1000;i = i * 10) {
            ASSETS_COUNT = i;
            waitTillDone();
            checkAgency(AGENCY_NAME, AGENCY_ADMIN_LOGIN);
            logInAsAgencyAdmin();
            // create assets in main agency
            //createAssets();
            shareCategories();
        }
    }

    private void shareCategories() throws TimeoutException {
        for (int i = 0; i < SHARED_CATEGORIES_COUNT; i++) {
            logInAsGlobalAdmin();
            String agencyName = AGENCY_NAME + "_" + Gen.getHumanReadableString(6);
            String agencyAdminLogin = AGENCY_ADMIN_LOGIN.replace("@", Gen.getHumanReadableString(6) + "@");
            checkAgency(agencyName, agencyAdminLogin);

            logInAsAgencyAdmin(agencyAdminLogin);

            log.info("login as " + agencyAdminLogin + " and Check category");
            AssetFilter category = service.getAssetsFilterByName(agencyName, "", 0);
            if (category == null) {
                log.info("Create and share category");
                Agency agency = service.getAgencyByName(AGENCY_NAME);
                category = service.createAssetFilterCategory(agencyName, new AssetFilterTerms().getQuery().toString());
                log.info("Share category " + category.getName() + " to agency " + agency.getName());

                service.shareAssetFilterToAgency(category.getId(), agency.getId());
                createAssets();
                waitTillDone();
                service.createInboxCache(category.getId());
                long startTime = System.currentTimeMillis();
                waitTillDone();
                log.info("Elapsed time: " + Executor.ppMillis(System.currentTimeMillis() - startTime));
                log.info("Assets denormalized: " + ASSETS_COUNT);
            }
        }
    }

    private void createAssets() {


        log.info("Check assets");
        SearchResult<Content> assets = service.findAssets(new LuceneSearchingParams().setResultsOnPage(ASSETS_COUNT));
        int actualAssetsCount = assets.getResult().size();
        int assetsToCreate = ASSETS_COUNT - actualAssetsCount;
        assetsCreated.set(actualAssetsCount);

        log.info("Found " + actualAssetsCount + "assets");
        if (assetsToCreate > 0) {
            log.info("Need to create " + assetsToCreate + " assets");
            ExecutorService executor = Executors.newFixedThreadPool(THREADS_COUNT);
            for (int i = 0; i < assetsToCreate; i++) {
                executor.execute(new AssetCreator(service));
            }
            executor.shutdown();
            while (!executor.isTerminated()) {
                Common.sleep(100);
            }
        }
    }

    private void checkAgency(String agencyName, String agencyAdminEmail) {
        logInAsGlobalAdmin();
        log.info("Check agency");
        Agency agency = service.getAgencyByName(agencyName);
        if (agency == null) {
            log.info("Create agency");
            Agency newAgency = new Agency();
            newAgency.setName(agencyName);
            newAgency.setDescription(agencyName);
            newAgency.setSubtype("agency");
            newAgency.setPin("1");
            newAgency.setTimeZone("Europe-Andorra");
            newAgency.setCountry("AF");
            newAgency.setAgencyType("Advertiser");
            newAgency.setStorageId("52d3ec51e4b011bdb451d253");
            agency = service.createAgency(newAgency);
        }
        checkAgencyAdmin(agency, agencyAdminEmail);
    }

    private void checkAgencyAdmin(Agency agency, String agencyAdminEmail) {
        log.info("Check agency admin");
        User agencyAdmin = service.getUserByEmail(agencyAdminEmail, 0);
        if (agencyAdmin == null) {
            log.info("Create agency admin");
            User user = new User();
            user.setAgency(agency);
            user.setPhoneNumber("1234567890");
            user.setAdvertiser(agency.getId());
            user.setPassword(AGENCY_ADMIN_PASSWORD);
            user.setFullAccess();
            user.setRoles(new BaseObject[]{service.getRoleByName("agency.admin")});
            user.setFirstName("admin");
            user.setLastName("agency");
            user.setEmail(agencyAdminEmail);
            service.createUser(user);
        }
    }

    private void logInAsGlobalAdmin() {
        log.info("Log in as global admin");
        service.logIn(GLOBAL_ADMIN_LOGIN, GLOBAL_ADMIN_PASSWORD);
    }

    private void logInAsAgencyAdmin() {
        logInAsAgencyAdmin(AGENCY_ADMIN_LOGIN);
    }

    private void logInAsAgencyAdmin(String email) {
        log.info("Log in as agency admin");
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
