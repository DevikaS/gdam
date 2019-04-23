package com.adstream.automate.babylon.performance.stress;

import com.adstream.automate.babylon.BabylonServiceWrapper;
import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.core.AbstractTranscodingChecker;
import com.adstream.automate.babylon.core.BabylonCoreService;
import com.adstream.automate.babylon.performance.helper.ObjectsFactory;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.Gen;
import org.apache.log4j.PropertyConfigurator;

import java.io.File;
import java.net.URL;
import java.util.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.atomic.AtomicInteger;

import static java.util.Arrays.asList;

/**
 * User: ruslan.semerenko
 * Date: 07.10.13 18:14
 */
public class SetupDataForProcterAndGambleBusinessUnit {
    private static final String CORE_URL                = "http://10.0.26.56:8080/";
    private static final String FILE_PATH               = "c:\\Work\\Downloads\\find.jpg";
    private static final int DEFAULT_TIMEOUT            = 100;

    private static final String AGENCY_NAME             = "P & G";
    private static final String STORAGE_ID              = "52f12d23e4b0faebacc599c9";
    private static final String GLOBAL_ADMIN_USER_EMAIL = "admin";
    private static final String AGENCY_ADMIN_USER_EMAIL = "admin@png.com";
    private static final String AGENCY_USER_EMAIL       = "user@png.com";
    private static final String DEFAULT_USER_PASSWORD   = "abcdefghA1";

    private static final int THREADS_COUNT              = 8;
    private static final int USERS_COUNT                = 10000;
    private static final int PROJECTS_COUNT             = 1010;
    private static final int FOLDERS_PER_PROJECT        = 100;
    private static final int FILES_PER_FOLDER           = 10;
    private static final int ASSETS_COUNT               = 1000000;
    private static final int LIBRARY_TEAMS_COUNT        = 100;
    private static final int USERS_PER_LIBRARY_TEAM     = 300;
    private static final int CATEGORIES_COUNT           = 100;
    private static final int COLLECTIONS_COUNT          = 100;

    private static BabylonServiceWrapper service;

    private static final List<String> usersIds          = new ArrayList<>();
    private static final List<String> assetsIds         = new ArrayList<>();
    private static final List<String> libraryTeamsIds   = new ArrayList<>();
    private static final List<String> categoriesIds     = new ArrayList<>();

    private static synchronized void collectUsersIds(String userId)               { usersIds.add(userId); }
    private static synchronized void collectAssetsIds(String assetId)             { assetsIds.add(assetId); }
    private static synchronized void collectLibraryTeamsIds(String libraryTeamId) { libraryTeamsIds.add(libraryTeamId); }
    private static synchronized void collectCategoriesIds(String categoryId)      { categoriesIds.add(categoryId); }

    public static void main(String[] args) throws Exception {
        setUpLogger();

        service = new BabylonServiceWrapper(new BabylonCoreService(new URL(CORE_URL)), null);
        service.logIn(GLOBAL_ADMIN_USER_EMAIL, DEFAULT_USER_PASSWORD);
        createBaseAgencyAndUsers();
        service.logIn(AGENCY_ADMIN_USER_EMAIL, DEFAULT_USER_PASSWORD);

        createUsers();
        createAssets();
        createFiles();
        createLibraryTeams();
        addUsersToLibraryTeams();
        createCategories();
        shareCategoriesToAgencyUser();
        createCollectionsByAgencyUser();
    }

    private static void createBaseAgencyAndUsers() {
        System.out.println(String.format("Creating agency: %s", AGENCY_NAME));
        Agency agency = service.getAgencyByName(AGENCY_NAME);

        if (agency == null){
            agency = new Agency();
            agency.setName(AGENCY_NAME);
            agency.setDescription("test agency");
            agency.setAgencyType("Advertiser");
            agency.setSubtype("agency");
            agency.setCountry("AF");
            agency.setTimeZone("Europe-Andorra");
            agency.setStorageId(STORAGE_ID);
            agency.setPin("1");
            service.createAgency(agency);
            agency = service.getAgencyByName(agency.getName());
        }

        System.out.println(String.format("Creating user: %s", AGENCY_ADMIN_USER_EMAIL));
        User adminUser = service.getUserByEmail(AGENCY_ADMIN_USER_EMAIL, 0);

        if (adminUser == null) {
            adminUser = ObjectsFactory.getUser(agency, service.getRoleByName("agency.admin"));
            adminUser.setEmail(AGENCY_ADMIN_USER_EMAIL);
            adminUser.setPassword(DEFAULT_USER_PASSWORD);
            adminUser.setFullAccess();
            service.createUser(adminUser);
            service.getUserByEmail(AGENCY_ADMIN_USER_EMAIL);
        }

        System.out.println(String.format("Creating user: %s", AGENCY_USER_EMAIL));
        User agencyUser = service.getUserByEmail(AGENCY_USER_EMAIL, 0);

        if (agencyUser == null) {
            agencyUser = ObjectsFactory.getUser(agency, service.getRoleByName("agency.user"));
            agencyUser.setEmail(AGENCY_USER_EMAIL);
            agencyUser.setPassword(DEFAULT_USER_PASSWORD);
            agencyUser.setFullAccess();
            service.createUser(agencyUser);
            service.getUserByEmail(AGENCY_USER_EMAIL);
        }
    }

    private static void createUsers() {
        System.out.printf("Creating %d users in %d threads%n", USERS_COUNT, THREADS_COUNT);

        int usersCountInDB = getUsersCountInDB();

        final List<Role> userRoles = asList(service.getRoleByName("guest.user"), service.getRoleByName("agency.user"));
        final Agency agency = service.getCurrentAgency();

        ExecutorService executor = Executors.newFixedThreadPool(THREADS_COUNT);

        final AtomicInteger usersCounter = new AtomicInteger(usersCountInDB);
        for (int i = 0; i < THREADS_COUNT; i++) {
            executor.execute(new Runnable() {
                @Override
                public void run() {
                    int usersCreated;
                    while ((usersCreated = usersCounter.getAndIncrement()) < USERS_COUNT) {
                        if (usersCreated % 100 == 0) {
                            System.out.printf("Created %d/%d users%n", usersCreated, USERS_COUNT);
                        }
                        User userObject = ObjectsFactory.getUser(agency, userRoles.get(Gen.getInt(2)));
                        userObject.setPassword(DEFAULT_USER_PASSWORD);
                        collectUsersIds(service.createUser(userObject).getId());
                    }
                }
            });
        }

        shutdownExecutorService(executor);
    }

    private static int getUsersCountInDB() {
        int page = 1;
        LuceneSearchingParams query = new LuceneSearchingParams().setResultsOnPage(100);
        SearchResult<User> result;
        do {
            result = service.findUsers(query.setPageNumber(page++));
            for (User user : result.getResult())  {
                collectUsersIds(user.getId());
            }
        } while (result.hasMore());
        System.out.printf("Found %d users in db%n", usersIds.size());
        return usersIds.size();
    }

    private static void createFiles() {
        System.out.printf("Creating %d files for each existing folder in %d threads%n", FILES_PER_FOLDER, THREADS_COUNT);

        int projectsCountInDB = getProjectsCountInDB();
        System.out.printf("Found %d projects in db%n", projectsCountInDB);

        ExecutorService executor = Executors.newFixedThreadPool(THREADS_COUNT);

        final AtomicInteger projectsCounter = new AtomicInteger(projectsCountInDB);
        for (int i = 0; i < THREADS_COUNT; i++) {
            executor.submit(new Runnable() {
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
                                String assetId = assetsIds.get(Gen.generateInt(assetsIds.size()));
                                service.addAssetToProjectFolder(assetId, folder.getId());
                            }
                        }
                    }
                }
            });
        }

        shutdownExecutorService(executor);
    }

    private static int getProjectsCountInDB() {
        int page = 1;
        int projectsCountInDB = 0;
        LuceneSearchingParams query = new LuceneSearchingParams().setResultsOnPage(100);
        SearchResult<Project> result;
        do {
            result = service.findProjects(query.setPageNumber(page++));
            projectsCountInDB += result.getResult().size();
        } while (result.hasMore());
        return projectsCountInDB;
    }

    private static void createCategories() {
        System.out.println(String.format("Creating %d categories in %d threads", CATEGORIES_COUNT, THREADS_COUNT));
        for(AssetFilter category : service.getAssetFiltersCategory().getFilters()) collectCategoriesIds(category.getId());

        final String query = new AssetFilterTerms().getQuery().toString();
        ExecutorService executor = Executors.newFixedThreadPool(THREADS_COUNT);

        for (int i = 0; i < CATEGORIES_COUNT - categoriesIds.size(); i++) {
            executor.execute(new Runnable() {
                @Override
                public void run() {
                    String name = Gen.getHumanReadableString(10, true);
                    collectCategoriesIds(service.createAssetFilterCategory(name, query).getId());
                }
            });
        }

        shutdownExecutorService(executor);
    }

    private static void shareCategoriesToAgencyUser() {
        System.out.println(String.format("Share all categories to user %s in %d threads", AGENCY_USER_EMAIL, THREADS_COUNT));

        final String userId = service.getUserByEmail(AGENCY_USER_EMAIL).getId();
        final String roleId = service.getRoleByName("library.user").getId();
        ExecutorService executor = Executors.newFixedThreadPool(THREADS_COUNT);

        for (final String categoriesId : categoriesIds) {
            executor.execute(new Runnable() {
                @Override
                public void run() {
                    service.shareAssetFilter(categoriesId, userId, roleId);
                }
            });
        }

        shutdownExecutorService(executor);
    }

    private static void createCollectionsByAgencyUser() {
        System.out.println(String.format("Creating %d collections by user %s in %d threads", COLLECTIONS_COUNT, AGENCY_USER_EMAIL, THREADS_COUNT));
        service.logIn(AGENCY_USER_EMAIL, DEFAULT_USER_PASSWORD);
        Integer actualCount = service.getAssetFiltersCollection().getFilters().size();

        final String query = new AssetFilterTerms().getQuery().toString();
        ExecutorService executor = Executors.newFixedThreadPool(THREADS_COUNT);

        for (int i = 0; i < COLLECTIONS_COUNT - actualCount; i++) {
            executor.execute(new Runnable() {
                @Override
                public void run() {
                    String name = Gen.getHumanReadableString(10, true);
                    service.createAssetFilterCollection(name, query);
                }
            });
        }

        shutdownExecutorService(executor);
    }

    private static void createAssets() {
        System.out.printf("Creating %d assets in %d threads%n", ASSETS_COUNT, THREADS_COUNT);

        int assetsCountInDB = getAssetsCountInDB();

        if (assetsCountInDB < ASSETS_COUNT) {
            ExecutorService executor = Executors.newFixedThreadPool(THREADS_COUNT);

            final AtomicInteger assetsCounter = new AtomicInteger(assetsCountInDB);
            for (int i = 0; i < THREADS_COUNT; i++) {
                executor.submit(new Runnable() {
                    @Override
                    public void run() {
                        final Content asset = service.uploadAsset(new File(FILE_PATH));
                        Common.sleep(5000);
                        new AbstractTranscodingChecker() {
                            @Override
                            public List<Content> getFiles() {
                                return Arrays.asList(service.getAsset(asset.getId()));
                            }
                        }.process(true);

                        Content assetTemplate = service.getAsset(asset.getId());
                        assetTemplate.setParents(null);
                        assetTemplate.setShortId(null);

                        int assetsCreated;
                        while ((assetsCreated = assetsCounter.getAndIncrement()) < ASSETS_COUNT) {
                            if (assetsCreated % 100 == 0) {
                                System.out.printf("Created %d/%d assets%n", assetsCreated, ASSETS_COUNT);
                            }

                            assetTemplate.setName(Gen.getHumanReadableString(10));
                            for (FileRevision revision : assetTemplate.getRevisions()) {
                                if (revision.getAnnotationProxy() != null) {
                                    revision.getAnnotationProxy().setFileID(Gen.generateGID());
                                }
                                if (revision.getPreview() != null) {
                                    for (FilePreview preview : revision.getPreview()) {
                                        preview.setFileID(Gen.generateGID());
                                    }
                                }
                                revision.getMaster().setFileID(Gen.generateGID());
                            }
                            Content fakeAsset = ((BabylonCoreService) service.getWrappedService()).createAssetWithoutTranscoding(assetTemplate);
                            collectAssetsIds(fakeAsset.getId());
                        }
                    }
                });
            }
            shutdownExecutorService(executor);
        }
    }

    private static int getAssetsCountInDB() {
        int page = 1;
        int createdAssetsCount = 0;
        LuceneSearchingParams query = new LuceneSearchingParams().setResultsOnPage(1000);
        SearchResult<Content> result;
        do {
            result = service.findAssets(query.setPageNumber(page++));
            for (Content asset : result.getResult()) {
                collectAssetsIds(asset.getId());
            }
            createdAssetsCount += result.getResult().size();
            System.out.printf("Found %d assets in db%n", createdAssetsCount);
        } while (result.hasMore());
        return createdAssetsCount;
    }

    private static void createLibraryTeams() {
        System.out.println(String.format("Creating %d library teams in %d threads", LIBRARY_TEAMS_COUNT, THREADS_COUNT));
        for(UserGroup libraryTeam : service.getLibraryTeams(service.getCurrentAgency().getId())) collectLibraryTeamsIds(libraryTeam.getId());

        final String agencyId = service.getCurrentAgency().getId();
        ExecutorService executor = Executors.newFixedThreadPool(THREADS_COUNT);

        for (int i = 0; i < LIBRARY_TEAMS_COUNT - libraryTeamsIds.size(); i++) {
            executor.execute(new Runnable() {
                @Override
                public void run() {
                    String name = Gen.getHumanReadableString(10, true);
                    collectLibraryTeamsIds(service.createLibraryTeam(agencyId, name).getId());
                }
            });
        }

        shutdownExecutorService(executor);
    }

    private static void addUsersToLibraryTeams() {
        System.out.println(String.format("Adding users %d for all existing library teams in %d threads", USERS_PER_LIBRARY_TEAM, THREADS_COUNT));

        ExecutorService executor = Executors.newFixedThreadPool(THREADS_COUNT);

        for (final String libraryTeamId : libraryTeamsIds) {
            Collections.shuffle(usersIds);
            final List<String> usersIdsToAdd = usersIds.subList(0, USERS_PER_LIBRARY_TEAM);

            executor.execute(new Runnable() {
                @Override
                public void run() {
                    service.addUsersToLibraryTeamById(libraryTeamId, usersIdsToAdd);
                }
            });
        }

        shutdownExecutorService(executor);
    }

    private static void shutdownExecutorService(ExecutorService executor) {
        System.out.println("Wait while all threads are terminated");
        executor.shutdown();
        while (!executor.isTerminated()) Common.sleep(DEFAULT_TIMEOUT);
    }

    private static void setUpLogger() {
        Properties properties = new Properties();
        properties.setProperty("log4j.rootLogger", "INFO,console");
        properties.setProperty("log4j.appender.console", "org.apache.log4j.ConsoleAppender");
        properties.setProperty("log4j.appender.console.layout", "org.apache.log4j.PatternLayout");
        properties.setProperty("log4j.appender.console.layout.ConversionPattern", "%d %-5p %t %c{1} %m%n");
        properties.setProperty("log4j.logger.com.adstream.automate.babylon.BabylonService", "INFO");
        PropertyConfigurator.configure(properties);
    }
}