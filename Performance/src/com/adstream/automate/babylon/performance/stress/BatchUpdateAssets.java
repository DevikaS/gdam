package com.adstream.automate.babylon.performance.stress;

import com.adstream.automate.babylon.BabylonServiceWrapper;
import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.core.BabylonCoreService;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.Gen;
import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import java.io.*;
import java.net.URL;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Properties;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeoutException;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * User: alexeys
 * Date: 23.01.14 13:32
 */
public class BatchUpdateAssets {
    private static final Logger log = Logger.getLogger(BatchUpdateAssets.class);
    private static final String AGENCY_NAME = "ForGlobalSearch";
    private static final String GLOBAL_ADMIN_LOGIN = "admin";
    private static final String GLOBAL_ADMIN_PASSWORD = "abcdefghA1";
    private static final String AGENCY_ADMIN_LOGIN = "globalsearch@test.com";
    private static final String AGENCY_ADMIN_PASSWORD = "abcdefghA1";
    private static final String CORE_URL = "http://perfa5-elb-internal.adstream.com:8080";
    private static final int THREADS_COUNT = 4;
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
        properties.setProperty("log4j.logger.com.adstream.automate.babylon.BabylonService", "DEBUG");
        PropertyConfigurator.configure(properties);
        new BatchUpdateAssets().process();
    }

    private static class AssetCreator implements Runnable {
        protected BabylonServiceWrapper service;
        private List<String> assetIdList;


        private AssetCreator(BabylonServiceWrapper service, List<String> assetIdList) {
            this.service = service;
            this.assetIdList = assetIdList;
        }

        @Override
        public void run() {
            try {
                File tmpFile = getFileForUpload();
                String objectId = service.uploadAsset(tmpFile).getId();
                assetIdList.add(objectId);
                tmpFile.delete();
            } catch (Exception e) {
                log.error(e);
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

    private BatchUpdateAssets() throws Exception {
        service = new BabylonServiceWrapper(new BabylonCoreService(new URL(CORE_URL)), null);
    }

    private void process() throws TimeoutException {
        //check if there background operations
        for (int i = 10; i <= 1000; i = i * 10) {
            checkAgency(AGENCY_NAME, AGENCY_ADMIN_LOGIN);
            logInAsAgencyAdmin();
            List<String> assetsList = createAssets(i);
            List<Content> partialUpdateForAssets = generateBatchChange(assetsList);
            String processId = "ff";service.batchTaskApi().updateAssets(partialUpdateForAssets);
            service.batchTaskApi().waitTillDone(processId);
        }
    }

    private List<Content> generateBatchChange(List<String> objectIdList){
        List<Content> partialUpdateAssets = new ArrayList<>(objectIdList.size());
        for (String objectId: objectIdList){
            Content partOfAsset = new Content();
            partOfAsset.setId(objectId);
            partOfAsset.setMediaType("Print");
            partialUpdateAssets.add(partOfAsset);
        }
        return partialUpdateAssets;
    }


    private List<String> createAssets(int count) {
        List<String> assetList = Collections.synchronizedList(new ArrayList<String>(count));
        log.info("Check assets");
        SearchResult<Content> assets = service.findAssets(new LuceneSearchingParams().setResultsOnPage(count));
        for (Content content : assets.getResult()) {
            assetList.add(content.getId());
            if (assetList.size() == count) return assetList;
        }
        int actualAssetsCount = assets.getResult().size();
        int assetsToCreate = count - actualAssetsCount;
        assetsCreated.set(actualAssetsCount);

        log.info("Found " + actualAssetsCount + "assets");
        if (assetsToCreate > 0) {
            log.info("Need to create " + assetsToCreate + " assets");
            ExecutorService executor = Executors.newFixedThreadPool(THREADS_COUNT);
            for (int i = 0; i < assetsToCreate; i++) {
                executor.execute(new AssetCreator(service, assetList));
            }
            executor.shutdown();
            while (!executor.isTerminated()) {
                Common.sleep(100);
            }
        }
        return assetList;
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


}
