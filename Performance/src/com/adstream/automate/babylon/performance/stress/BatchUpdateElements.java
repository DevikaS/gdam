package com.adstream.automate.babylon.performance.stress;

import com.adstream.automate.babylon.BabylonServiceWrapper;
import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.core.BabylonCoreService;
import com.adstream.automate.babylon.performance.Executor;
import com.adstream.automate.babylon.performance.helper.ObjectsFactory;
import com.adstream.automate.utils.Gen;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import java.net.URL;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Properties;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeoutException;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * User: alexeys
 * Date: 23.01.14 13:32
 */
public class BatchUpdateElements {
    private static final Logger log = Logger.getLogger(BatchUpdateElements.class);
    private static final String AGENCY_NAME = "ForGlobalSearch";
    private static final String GLOBAL_ADMIN_LOGIN = "admin";
    private static final String GLOBAL_ADMIN_PASSWORD = "abcdefghA1";
    private static final String AGENCY_ADMIN_LOGIN = "globalsearch@test.com";
    private static final String AGENCY_ADMIN_PASSWORD = "abcdefghA1";
    private static final String CORE_URL = "http://localhost:18080";
    private static final int THREADS_COUNT = 10;
    private BabylonServiceWrapper service;

    private static final int PROJECTS_COUNT = 10;
    private static final int FOLDERS_PER_PROJECT = 10;
    private static final int FILES_PER_FOLDER = 100;

    public static void main(String[] args) throws Exception {
        Properties properties = new Properties();
        properties.setProperty("log4j.rootLogger", "INFO,console");
        properties.setProperty("log4j.appender.console", "org.apache.log4j.ConsoleAppender");
        properties.setProperty("log4j.appender.console.layout", "org.apache.log4j.PatternLayout");
        properties.setProperty("log4j.appender.console.layout.ConversionPattern", "%d %-5p %t %c{1} %m%n");
        properties.setProperty("log4j.logger.com.adstream.automate.babylon.BabylonService", "INFO");
        PropertyConfigurator.configure(properties);
        new BatchUpdateElements().process();
    }


    private BatchUpdateElements() throws Exception {
        service = new BabylonServiceWrapper(new BabylonCoreService(new URL(CORE_URL)), null);
    }

    private void process() throws TimeoutException, InterruptedException {
        //check if there background operations
        // for (int i = 10; i <= 1000; i = i * 10) {
        checkAgency(AGENCY_NAME, AGENCY_ADMIN_LOGIN);
        logInAsAgencyAdmin();
        List<String> filesIdList = createFiles();
        List<Content> partialUpdateForAssets = generateBatchChange(filesIdList);
        String processId = service.batchTaskApi().updateElements(partialUpdateForAssets);
        long startTime = System.currentTimeMillis();
        service.batchTaskApi().waitTillDone(processId);
        log.info("Elapsed time: " + Executor.ppMillis(System.currentTimeMillis() - startTime));
        log.info("files updated: " + filesIdList.size());
        //}
    }

    private List<Content> generateBatchChange(List<String> objectIdList) {
        List<Content> partialUpdateContent = new ArrayList<>(objectIdList.size());
        for (String objectId : objectIdList) {
            Content partOfContend = new Content();
            partOfContend.setId(objectId);
            partOfContend.getCmCommon().put("Campaign", Gen.getHumanReadableString(10));
            //partOfContend.getCmCommon().put("ddddd", Gen.getHumanReadableString(10));
            partialUpdateContent.add(partOfContend);
        }
        return partialUpdateContent;
    }


    private List<String> createFiles() throws InterruptedException {
        final List<String> objectIdList = Collections.synchronizedList(new ArrayList<String>(PROJECTS_COUNT * FOLDERS_PER_PROJECT * FILES_PER_FOLDER));
        ExecutorService executor = Executors.newFixedThreadPool(THREADS_COUNT);
        List<Callable<Object>> todo = new ArrayList<>(THREADS_COUNT);

        final AtomicInteger projectsCounter = new AtomicInteger(0);
        for (int i = 0; i < THREADS_COUNT; i++) {
            todo.add(Executors.callable(new Runnable() {
                @Override
                public void run() {
                    int projectsCreated;
                    while ((projectsCreated = projectsCounter.getAndIncrement()) < PROJECTS_COUNT) {
                        if (projectsCreated % 100 == 0) {
                            System.out.printf("Created %d/%d projects%n", projectsCreated, PROJECTS_COUNT);
                        }
                        Project project = service.createProject(ObjectsFactory.getProject(Gen.getHumanReadableString(10, true)));
                        for (int i = 0; i < FOLDERS_PER_PROJECT; i++) {
                            Content folder = service.createFolder(project.getId(), Gen.getHumanReadableString(10, true));
                            for (int j = 0; j < FILES_PER_FOLDER; j++) {
                                String id = service.createContent(folder.getId(), Gen.getHumanReadableString(6), Gen.getHumanReadableString(6)).getId();
                                objectIdList.add(id);
                            }
                        }
                    }
                }
            }));
        }
        executor.invokeAll(todo);
        return objectIdList;
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
            newAgency.setStorageId("52d9f153e4b0984b6e8840f9");
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
