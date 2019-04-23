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
import org.joda.time.DateTime;
import org.joda.time.Period;

import java.io.*;
import java.net.URL;
import java.util.Properties;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * User: Ruslan Semerenko
 * Date: 23.01.14 13:32
 */
public class CreateProjectsForGlobalSearch {
    private static final Logger log = Logger.getLogger(CreateProjectsForGlobalSearch.class);
    private static final String AGENCY_NAME = "ForGlobalSearch";
    private static final String GLOBAL_ADMIN_LOGIN = "admin";
    private static final String GLOBAL_ADMIN_PASSWORD = "abcdefghA1";
    private static final String AGENCY_ADMIN_LOGIN = "globalsearch@test.com";
    private static final String AGENCY_ADMIN_PASSWORD = "abcdefghA1";
    private static final int THREADS_COUNT = 4;
    private static final int PROJECTS_COUNT = 1000;
    private static final int FOLDERS_COUNT = 10;
    private static final int ASSETS_COUNT = 1000;
    private static final int SHARED_CATEGORIES_COUNT = 5;
    private static final File FILE_FOR_UPLOAD = new File("resources/logo.jpg");
    private static final String FILE_FOR_UPLOAD_EXTENSION = ".jpg";
    private static final File TMP_DIRECTORY = new File(System.getProperty("java.io.tmpdir"));
    private static final AtomicInteger projectsCreated = new AtomicInteger();
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
        new CreateProjectsForGlobalSearch().process();
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

    private static class ProjectCreator extends AssetCreator {
        ProjectCreator(BabylonServiceWrapper service) {
            super(service);
        }

        @Override
        public void run() {
            try {
                Project project = createProject();
                createFolders(project);
            } catch (Exception e) {
                e.printStackTrace();
            }
            int projectsCount = projectsCreated.incrementAndGet();
            if (projectsCount % 10 == 0) {
                log.info("Created " + projectsCount + " projects");
            }
        }

        private void createFolders(Project project) throws Exception {
            for (int i = 0; i < FOLDERS_COUNT; i++) {
                Content folder = service.createFolder(project.getId(), Gen.getHumanReadableString(6, true));
                File tmpFile = getFileForUpload();
                service.uploadFile(tmpFile, folder.getId());
                tmpFile.delete();
            }
        }

        private Project createProject() {
            Project project = new Project();
            project.setMediaType("Broadcast");
            project.setAdministrators(new String[0]);
            project.setSubtype("project");
            project.setLogo("");
            project.setDateStart(new DateTime());
            project.setDateEnd(new DateTime().plus(Period.years(1)));
            project.setName(Gen.getHumanReadableString(6, true));
            project.setJobNumber(Gen.getHumanReadableString(6, true));
            return service.createProject(project);
        }
    }

    private CreateProjectsForGlobalSearch() throws Exception {
        service = new BabylonServiceWrapper(new BabylonCoreService(new URL("http://10.0.26.56:8080")), null);
    }

    private void process() {
        checkAgency(AGENCY_NAME, AGENCY_ADMIN_LOGIN);
        createProjects();
        createAssets();
        shareCategories();
    }

    private void shareCategories() {
        for (int i = 0; i < SHARED_CATEGORIES_COUNT; i++) {
            logInAsGlobalAdmin();
            String agencyName = AGENCY_NAME + "_" + Gen.getHumanReadableString(6);
            String agencyAdminLogin = AGENCY_ADMIN_LOGIN.replace("@", Gen.getHumanReadableString(6) + "@");
            checkAgency(agencyName, agencyAdminLogin);

            logInAsAgencyAdmin(agencyAdminLogin);
            log.info("Check category");
            AssetFilter category = service.getAssetsFilterByName(agencyName, "", 0);
            if (category == null) {
                log.info("Create and share category");
                Agency agency = service.getAgencyByName(AGENCY_NAME);
                category = service.createAssetFilterCategory(agencyName, new AssetFilterTerms().getQuery().toString());
                service.shareAssetFilterToAgency(category.getId(), agency.getId());
            }
        }
    }

    private void createAssets() {
        logInAsAgencyAdmin();

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

    private void createProjects() {
        logInAsAgencyAdmin();

        log.info("Check projects");
        SearchResult<Project> projects = service.findProjects(new LuceneSearchingParams().setResultsOnPage(PROJECTS_COUNT));
        int actualProjectsCount = projects.getResult().size();
        int projectsToCreate = PROJECTS_COUNT - actualProjectsCount;
        projectsCreated.set(actualProjectsCount);

        log.info("Found " + actualProjectsCount + " projects");
        if (projectsToCreate > 0) {
            log.info("Need to create " + projectsToCreate + " projects");
            ExecutorService executor = Executors.newFixedThreadPool(THREADS_COUNT);
            for (int i = 0; i < projectsToCreate; i++) {
                executor.execute(new ProjectCreator(service));
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
            newAgency.setStorageId("52c13ecee4b0db7bff4992db");
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
            user.setRoles(new BaseObject[] {service.getRoleByName("agency.admin")});
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
