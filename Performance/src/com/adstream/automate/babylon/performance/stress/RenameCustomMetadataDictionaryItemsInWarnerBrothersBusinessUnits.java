package com.adstream.automate.babylon.performance.stress;

import com.adstream.automate.babylon.BabylonServiceWrapper;
import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.JsonObjects.dictionary.*;
import com.adstream.automate.babylon.JsonObjects.dictionary.Dictionary;
import com.adstream.automate.babylon.JsonObjects.schema.AssetElementCommonSchema;
import com.adstream.automate.babylon.JsonObjects.schema.AssetElementProjectCommonSchema;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.core.BabylonCoreService;
import com.adstream.automate.babylon.performance.helper.ObjectsFactory;
import com.adstream.automate.utils.Common;
import org.apache.log4j.PropertyConfigurator;

import java.net.URL;
import java.util.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.atomic.AtomicInteger;

import static java.util.Arrays.asList;

/**
 * User: lynda-k
 * Date: 01.07.14
 * Time: 11:00
 */

/*
 * Automate renaming following dictionary items for CMM catalogue structure field 'Studio/Region'
 *   Warner Bros Entertainment Inc => Warner Bros Home Office
 *   Warner Bros South Korea       => Warner Bros Korea
 *   Warner Bros LatAm             => Warner Bros Latin America
 * Rename these items in following places:
 *   common schema
 *   assets
 *   files
 *   asset filters (collections and categories)
 *   projects (projects and templates)
 *
 * For each 'Studio/Region' field item rename 'Feature Title' items:
 *   her                    => Her
 *   HER                    => Her
 *   The LEGO Movie         => The Lego Movie
 *   The Man from U.N.C.L.E => The Man From U.N.C.L.E.
 *   Into the Storm         => Into The Storm
 *   Anabelle               => Annabelle
 *
 * For each 'Studio/Region' field item add 'Feature Title' items:
 *   "300: Rise of an Empire", "Annabelle", "Blended", "Dolphin Tale 2", "Edge of Tomorrow", "Entourage", "Focus",
 *   "Get Hard", "Godzilla", "Gravity", "Heart of the Sea", "Hidden", "Horrible Bosses 2", "How to Catch a Monster",
 *   "If I Stay", "Inherent Vice", "Interstellar", "Into The Storm", "Island of Lemurs: Madagascar", "Jersey Boys",
 *   "Jupiter Ascending", "Mad Max: Fury Road", "Magic Mike 2", "Midnight Special", "PAN", "Run All Night", "Tammy",
 *   "The Conjuring 2", "The Good Lie", "The Hobbit: The Battle Of The Five Armies", "The Judge", "The Lego Movie",
 *   "The Man From U.N.C.L.E.", "This Is Where I Leave You"
 */
public class RenameCustomMetadataDictionaryItemsInWarnerBrothersBusinessUnits {
    static final int     DEFAULT_TIMEOUT =          1000;
    static final int     THREADS_COUNT =            2;
    static final int     CONTENT_COUNT_BY_REQUEST = 100;

    static final boolean READY_TO_UPDATE =          true;

    static final String  CORE_URL =                 "http://10.64.130.10:8080/";
    static final String  CORE_LOG_LEVEL =           "INFO";
    static final String  GLOBAL_ADMIN_USER_EMAIL =  "admin";
    static final String  DEFAULT_USER_PASSWORD =    "abcdefghA1";
    static final String  AGENCY_NAMES_PATTERN =     "^Warner Bros.*$";
    static final String  DICTIONARY_NAME =          "advertiser";

    static final String  ASSET =                    "asset";
    static final String  FILE =                     "file";
    static final String  PROJECT =                  "project";
    static final String  TEMPLATE =                 "template";
    static final String  COLLECTION =               "collection";
    static final String  ADVERTISER =               "advertiser";
    static final String  BRAND =                    "brand";
    static final String  CLOCK_NUMBER =             "clockNumber";

    static int updatedDictionariesCount = 0;
    static final AtomicInteger updatedAssetsCount = new AtomicInteger(0);
    static final AtomicInteger updatedFilesCount = new AtomicInteger(0);
    static final AtomicInteger updatedProjectsCount = new AtomicInteger(0);
    static final AtomicInteger updatedTemplatesCount = new AtomicInteger(0);
    static final AtomicInteger updatedCategoriesCount = new AtomicInteger(0);
    static final AtomicInteger updatedCollectionsCount = new AtomicInteger(0);

    static final Map<String,String> ADVERTISER_ITEMS_MAP = new HashMap<String,String>() {{
        put("Warner Bros Entertainment Inc", "Warner Bros Home Office");
        put("Warner Bros South Korea",       "Warner Bros Korea");
        put("Warner Bros LatAm",             "Warner Bros Latin America");
    }};

    static final Map<String,String> BRAND_ITEMS_MAP = new HashMap<String,String>(){{
        put("her",                    "Her");
        put("HER",                    "Her");
        put("The LEGO Movie",         "The Lego Movie");
        put("The Man from U.N.C.L.E", "The Man From U.N.C.L.E.");
        put("Into the Storm",         "Into The Storm");
        put("Anabelle",               "Annabelle");
    }};

    static final List<String> BRAND_ITEMS = asList(
            "300: Rise of an Empire",
            "Annabelle",
            "Blended",
            "Dolphin Tale 2",
            "Edge of Tomorrow",
            "Entourage",
            "Focus",
            "Get Hard",
            "Godzilla",
            "Gravity",
            "Heart of the Sea",
            "Hidden",
            "Horrible Bosses 2",
            "How to Catch a Monster",
            "If I Stay",
            "Inherent Vice",
            "Interstellar",
            "Into The Storm",
            "Island of Lemurs: Madagascar",
            "Jersey Boys",
            "Jupiter Ascending",
            "Mad Max: Fury Road",
            "Magic Mike 2",
            "Midnight Special",
            "PAN",
            "Run All Night",
            "Tammy",
            "The Conjuring 2",
            "The Good Lie",
            "The Hobbit: The Battle Of The Five Armies",
            "The Judge",
            "The Lego Movie",
            "The Man From U.N.C.L.E.",
            "This Is Where I Leave You");

    public static void main(String[] args) throws Exception {
        setUpLogger();
        for (final Agency agency : getAgenciesByNamePattern(AGENCY_NAMES_PATTERN)) {
            System.out.printf("\n[%s]\n", agency.getName());
            BabylonServiceWrapper service = getService(agency);

            // following actions need to following correctly updating old assets
            // mark brand field as not required if need
            boolean isBrandFieldUpdated = markBrandFieldAsRequired(false, service);
            // mark clockNumber field as not required if need
            boolean isClockNumberFieldUpdated = markClockNumberFieldAsRequired(false, service);
            // change clockNumber field pattern to allow all values
            changeClockNumberPattern(".*", service);

            if (isBrandFieldUpdated) System.out.printf("[%s] - Marked 'Feature Title' field as not required\n", agency.getName());
            if (isClockNumberFieldUpdated) System.out.printf("[%s] - Marked 'Clock #' field as not required\n", agency.getName());
            System.out.printf("[%s] - Changed 'Clock #' field pattern to '.*' for agency\n", agency.getName());

            // update fields advertiser and brand according to instruction above
            updateCommonFieldsSchema(service);
            updateContentsFields(service, ASSET);
            updateContentsFields(service, FILE);
            updateProjectsFields(service, PROJECT);
            updateProjectsFields(service, TEMPLATE);
            updateAssetFilters(service);

            // following actions need to rollback previously changed brand and clockNumber fields
            if (isBrandFieldUpdated) {
                markBrandFieldAsRequired(true, service);
                System.out.printf("[%s] - Marked back 'Feature Title' field as required for agency\n", agency.getName());
            }

            if (isClockNumberFieldUpdated) {
                markClockNumberFieldAsRequired(true, service);
                System.out.printf("[%s] - Marked back 'Clock #' field as required for agency\n", agency.getName());
            }

            changeClockNumberPattern("\\S*", service);
            System.out.printf("[%s] - Changed back 'Clock #' field pattern to '\\S' for agency\n", agency.getName());
        }

        printStatistics();
    }

    private static void updateCommonFieldsSchema(BabylonServiceWrapper service) {
        Agency agency = service.getCurrentAgency();
        Dictionary dictionary = service.getAgencyDictionaryByName(agency.getId(), DICTIONARY_NAME);

        System.out.printf("[%s] - Start to update 'Studio / Region' and 'Feature Title' fields items by user '%s'\n",
                agency.getName(), service.getCurrentUser().getEmail());

        if (dictionary != null) {
            for (DictionaryItem advItem : dictionary.getValues()) {
                if (ADVERTISER_ITEMS_MAP.get(advItem.getKey()) != null)
                    advItem.setKey(ADVERTISER_ITEMS_MAP.get(advItem.getKey()));

                if (advItem.getValues() != null) {
                    for (DictionaryItem brandItem : advItem.getValues())
                        if (BRAND_ITEMS_MAP.get(brandItem.getKey()) != null)
                            brandItem.setKey(BRAND_ITEMS_MAP.get(brandItem.getKey()));

                    DictionaryValues valuesWithoutDuplicates = new DictionaryValues();
                    for (DictionaryItem brandItem : advItem.getValues())
                        if (!valuesWithoutDuplicates.getKeys().contains(brandItem.getKey()))
                            valuesWithoutDuplicates.add(brandItem);

                    advItem.setValues(valuesWithoutDuplicates);

                    DictionaryValues additionalBrandItems = new DictionaryValues();
                    for (String newBrandItemKey : BRAND_ITEMS)
                        if (!advItem.getValues().getKeys().contains(newBrandItemKey))
                            additionalBrandItems.add(new DictionaryItem().setKey(newBrandItemKey));

                    advItem.getValues().addAll(additionalBrandItems);
                }
            }

            if (READY_TO_UPDATE) service.updateAgencyDictionary(agency.getId(), DICTIONARY_NAME, dictionary.getValues());
            updatedDictionariesCount++;
        }
    }

    private static void updateContentsFields(final BabylonServiceWrapper service, final String type) {
        int initialContentsCount = type.equals(ASSET) ? updatedAssetsCount.get() : updatedFilesCount.get();
        ExecutorService executor = Executors.newFixedThreadPool(THREADS_COUNT);
        printStartUpdatingMessage(service.getCurrentUser(), type);

        for (final String contentId : getContentIdsToUpdate(service, type)) {
            executor.execute(new Runnable() {
                @Override
                public void run() {
                    Content content = type.equals(ASSET) ? service.getAsset(contentId) : service.getContent(contentId);
                    String[] advertisers = content.getCmCommon().getStringArray(ADVERTISER);
                    String[] brands = content.getCmCommon().getStringArray(BRAND);

                    if (content.getCmCommon().get("mediaType") != null
                            && asList(content.getCmCommon().getStringArray("mediaType")).contains("video")
                            && !content.getCm().getOrCreateNode("video").containsKey(CLOCK_NUMBER)) {
                        content.getCm().getOrCreateNode("video").put(CLOCK_NUMBER, "");
                    }

                    if (advertisers != null)
                        for (int i = 0; i < advertisers.length; i++) {
                            if (ADVERTISER_ITEMS_MAP.get(advertisers[i]) != null)
                                advertisers[i] = ADVERTISER_ITEMS_MAP.get(advertisers[i]);
                            content.getCmCommon().put(ADVERTISER, advertisers);
                        }

                    if (brands != null)
                        for (int i = 0; i < brands.length; i++) {
                            if (BRAND_ITEMS_MAP.get(brands[i]) != null)
                                brands[i] = BRAND_ITEMS_MAP.get(brands[i]);
                            content.getCmCommon().put(BRAND, brands);
                        }

                    if (type.equals(ASSET)) {
                        if (READY_TO_UPDATE) service.updateAsset(content);
                        updatedAssetsCount.getAndIncrement();
                    } else {
                        if (READY_TO_UPDATE) service.updateContent(content);
                        updatedFilesCount.getAndIncrement();
                    }
                }
            });
        }
        shutdownExecutorService(executor);
        printFinishUpdatingMessage((type.equals(ASSET) ? updatedAssetsCount.get() : updatedFilesCount.get()) - initialContentsCount, type);
    }

    private static void updateProjectsFields(final BabylonServiceWrapper service, final String type) {
        int initialProjectsCount = type.equals(ASSET) ? updatedProjectsCount.get() : updatedTemplatesCount.get();
        ExecutorService executor = Executors.newFixedThreadPool(THREADS_COUNT);
        printStartUpdatingMessage(service.getCurrentUser(), type);

        for (final String projectId : getProjectIdsToUpdate(service, type)) {
            executor.execute(new Runnable() {
                @Override
                public void run() {
                    Project project = service.getProject(projectId);
                    String[] advertisers = project.getCmCommon().getStringArray(ADVERTISER);
                    String[] brands = project.getCmCommon().getStringArray(BRAND);

                    if (advertisers != null)
                        for (int i = 0; i < advertisers.length; i++) {
                            if (ADVERTISER_ITEMS_MAP.get(advertisers[i]) != null)
                                advertisers[i] = ADVERTISER_ITEMS_MAP.get(advertisers[i]);
                            project.getCmCommon().put(ADVERTISER, advertisers);
                        }

                    if (brands != null)
                        for (int i = 0; i < brands.length; i++) {
                            if (BRAND_ITEMS_MAP.get(brands[i]) != null)
                                brands[i] = BRAND_ITEMS_MAP.get(brands[i]);
                            project.getCmCommon().put(BRAND, brands);
                        }

                    if (READY_TO_UPDATE) service.updateProject(project.getId(), project);

                    if (type.equals(PROJECT))
                        updatedProjectsCount.getAndIncrement();
                    else
                        updatedTemplatesCount.getAndIncrement();
                }
            });
        }
        shutdownExecutorService(executor);
        printFinishUpdatingMessage((type.equals(PROJECT) ? updatedProjectsCount.get() : updatedTemplatesCount.get()) - initialProjectsCount, type);
    }

    private static void updateAssetFilters(final BabylonServiceWrapper service) {
        int initialCollectionsCount = updatedCollectionsCount.get() + updatedCategoriesCount.get();
        ExecutorService executor = Executors.newFixedThreadPool(THREADS_COUNT);
        printStartUpdatingMessage(service.getCurrentUser(), COLLECTION);

        for (final AssetFilter filter : service.getAssetFilters().getFilters()) {
            executor.execute(new Runnable() {
                @Override
                public void run() {
                    String query = (String)filter.getQuery();
                    if (query.contains("_cm.common.advertiser")) {
                        String advertiser = query.replaceAll(".+\"_cm.common.advertiser\":\\s*\\[\\s*\"([^\\]\"]+)\"\\s*].+", "$1");
                        if (ADVERTISER_ITEMS_MAP.get(advertiser) != null) {
                            query = query.replaceAll(String.format("(.+\"_cm.common.advertiser\":\\s*\\[\\s*\")%s(\"\\s*].+)", advertiser),
                                    String.format("$1%s$2", ADVERTISER_ITEMS_MAP.get(advertiser)));
                            filter.setQuery(query);
                        }

                        if (query.contains("_cm.common.brand")) {
                            String brand = query.replaceAll(".+\"_cm.common.brand\":\\s*\\[\\s*\"([^\\]\"]+)\"\\s*].+", "$1");
                            if (BRAND_ITEMS_MAP.get(brand) != null) {
                                query = query.replaceAll(String.format("(.+\"_cm.common.brand\":\\s*\\[\\s*\")%s(\"\\s*].+)", brand),
                                        String.format("$1%s$2", BRAND_ITEMS_MAP.get(brand)));
                                filter.setQuery(query);
                            }
                        }

                        if (READY_TO_UPDATE) service.updateAssetFilter(filter.getId(), filter.getName(), query);

                        if (filter.getSubtype().endsWith("category"))
                            updatedCategoriesCount.getAndIncrement();
                        else
                            updatedCollectionsCount.getAndIncrement();
                    }
                }
            });
        }
        shutdownExecutorService(executor);
        printFinishUpdatingMessage(updatedCollectionsCount.get() + updatedCategoriesCount.get() - initialCollectionsCount, COLLECTION);
    }

    /*
    * helpers methods
    * */

    // if field updated returns true otherwise false
    private static boolean markBrandFieldAsRequired(boolean expectedState, BabylonServiceWrapper service) {
        Agency agency = service.getCurrentAgency();
        AssetElementProjectCommonSchema schema = service.getAssetElementProjectCommonSchema(agency.getId());

        if (schema.getCmSectionProperties("common").getOrCreateNode(BRAND).get("required") != null) {
            boolean actualState = schema.getCmSectionProperties("common").getOrCreateNode(BRAND).getBoolean("required");
            if (actualState != expectedState) {
                schema.getCmSectionProperties("common").getOrCreateNode(BRAND).put("required", expectedState);
                if (READY_TO_UPDATE) service.updateAssetElementProjectCommonSchema(agency.getId(), schema);
                return true;
            }
        }

        return false;
    }

    // if field updated returns true otherwise false
    private static boolean markClockNumberFieldAsRequired(boolean expectedState, BabylonServiceWrapper service) {
        Agency agency = service.getCurrentAgency();
        AssetElementCommonSchema schema = service.getAssetElementCommonSchema(agency.getId());

        if (schema.getCmSectionProperties("video").getOrCreateNode(CLOCK_NUMBER).get("required") != null) {
            boolean actualState = schema.getCmSectionProperties("video").getOrCreateNode(CLOCK_NUMBER).get("required").toString().equalsIgnoreCase("true");
            if (actualState != expectedState) {
                schema.getCmSectionProperties("video").getOrCreateNode(CLOCK_NUMBER).put("required", expectedState);
                if (READY_TO_UPDATE) service.updateAssetElementCommonSchema(agency.getId(), schema);
                return true;
            }
        }

        return false;
    }

    private static void changeClockNumberPattern(String pattern, BabylonServiceWrapper service) {
        Agency agency = service.getCurrentAgency();
        AssetElementCommonSchema schema = service.getAssetElementCommonSchema(agency.getId());

        if (schema.getCmSectionProperties("video").getOrCreateNode(CLOCK_NUMBER).get("pattern") != null) {
            schema.getCmSectionProperties("video").getOrCreateNode(CLOCK_NUMBER).put("pattern", pattern);
            if (READY_TO_UPDATE) service.updateAssetElementCommonSchema(agency.getId(), schema);
        }
    }

    private static List<String> getContentIdsToUpdate(BabylonServiceWrapper service, String type) {
        List<String> assetIds = new ArrayList<>();
        SearchResult<Content> searchResult = new SearchResult<>();
        LuceneSearchingParams query = new LuceneSearchingParams();
        query.setResultsOnPage(CONTENT_COUNT_BY_REQUEST);
        if (type.equals(FILE)) query.setQuery("_subtype:element");

        for (int page = 0; page == 0 || searchResult.getResult().size() > 0; page++) {
            query.setPageNumber(page);
            searchResult = type.equals(ASSET) ? service.findAssets(query) : service.findContentAllProjects(query);
            if (searchResult == null) break;

            for (Content asset : searchResult.getResult()) {
                String[] advertisers = asset.getCmCommon().getStringArray(ADVERTISER);
                String[] brands = asset.getCmCommon().getStringArray(BRAND);

                if (advertisers != null)
                    for (String advertiser : advertisers)
                        if (ADVERTISER_ITEMS_MAP.get(advertiser) != null) {
                            assetIds.add(asset.getId());
                            break;
                        }

                if (brands != null)
                    for (String brand : brands)
                        if (BRAND_ITEMS_MAP.get(brand) != null) {
                            assetIds.add(asset.getId());
                            break;
                        }
            }
        }
        return assetIds;
    }

    private static List<String> getProjectIdsToUpdate(BabylonServiceWrapper service, String type) {
        List<String> projectIds = new ArrayList<>();
        SearchResult<Project> searchResult = new SearchResult<>();
        LuceneSearchingParams query = new LuceneSearchingParams().setQuery(type.equals(PROJECT) ? "_subtype:project" : "_subtype:project_template");
        query.setResultsOnPage(CONTENT_COUNT_BY_REQUEST);

        for (int page = 0; page == 0 || searchResult.getResult().size() > 0; page++) {
            query.setPageNumber(page);
            searchResult = type.equals(PROJECT) ? service.findProjects(query) : service.findTemplates(query);
            if (searchResult == null) break;

            for (Project project : searchResult.getResult()) {
                String[] advertisers = project.getCmCommon().getStringArray(ADVERTISER);
                String[] brands = project.getCmCommon().getStringArray(BRAND);

                if (advertisers != null)
                    for (String advertiser : advertisers)
                        if (ADVERTISER_ITEMS_MAP.get(advertiser) != null) {
                            projectIds.add(project.getId());
                            break;
                        }

                if (brands != null)
                    for (String brand : brands)
                        if (BRAND_ITEMS_MAP.get(brand) != null) {
                            projectIds.add(project.getId());
                            break;
                        }
            }
        }

        return projectIds;
    }

    private static List<Agency> getAgenciesByNamePattern(String pattern) {
        List<Agency> agencies = new ArrayList<>();
        BabylonServiceWrapper service = getService();

        for (Agency agency : service.getAgencies())
            if (agency.getName().trim().matches(pattern))
                    agencies.add(agency);

        return agencies;
    }

    private static BabylonServiceWrapper getService() {
        URL url;

        try {
            url = new URL(CORE_URL);
        } catch (Exception e) {
            throw new IllegalArgumentException(e.getMessage());
        }

        BabylonServiceWrapper service = new BabylonServiceWrapper(new BabylonCoreService(url), null);
        service.logIn(GLOBAL_ADMIN_USER_EMAIL, DEFAULT_USER_PASSWORD);

        return service;
    }

    private static BabylonServiceWrapper getService(Agency agency) {
        BabylonServiceWrapper service = getService();
        String email = String.format("u%s@adstream.com", agency.getId());
        User user = service.getUserByEmail(email, 0);

        if (user == null) {
            User newUser = ObjectsFactory.getUser(agency, service.getRoleByName("agency.admin"));
            newUser.setFirstName("agency");
            newUser.setLastName("admin");
            newUser.setEmail(email);
            newUser.setPassword(DEFAULT_USER_PASSWORD);
            newUser.setFullAccess();
            newUser.setLanguage("en-us");
            newUser.setRegistered(true);

            service.createUser(newUser);
            user = service.getUserByEmail(email);
        }

        service.logIn(user.getEmail(), DEFAULT_USER_PASSWORD);

        return service;
    }

    private static void shutdownExecutorService(ExecutorService executor) {
        executor.shutdown();
        while (!executor.isTerminated()) Common.sleep(DEFAULT_TIMEOUT);
    }

    private static void printStartUpdatingMessage(User user, String type) {
        System.out.printf("[%s] - Start to update %ss by user %s '%s'\n",
                user.getAgency().getName(), type, user.getFullName(), user.getEmail());
    }

    private static void printFinishUpdatingMessage(int updatedObjectsCount, String type) {
        System.out.printf("Total %ss updated: %d\n", type, updatedObjectsCount);
    }

    private static void printStatistics() {
        System.out.println("=========================================");
        System.out.printf("%d advertiser dictionaries was updated\n", updatedDictionariesCount);
        System.out.printf("%d assets was updated\n", updatedAssetsCount.get());
        System.out.printf("%d files was updated\n", updatedFilesCount.get());
        System.out.printf("%d projects was updated\n", updatedProjectsCount.get());
        System.out.printf("%d templates was updated\n", updatedTemplatesCount.get());
        System.out.printf("%d categories was updated\n", updatedCategoriesCount.get());
        System.out.printf("%d collections was updated\n", updatedCollectionsCount.get());

    }

    private static void setUpLogger() {
        Properties properties = new Properties();
        properties.setProperty("log4j.rootLogger", "INFO,console");
        properties.setProperty("log4j.appender.console", "org.apache.log4j.ConsoleAppender");
        properties.setProperty("log4j.appender.console.layout", "org.apache.log4j.PatternLayout");
        properties.setProperty("log4j.appender.console.layout.ConversionPattern", "%d %-5p %t %c{1} %m%n");
        properties.setProperty("log4j.logger.com.adstream.automate.babylon.BabylonService", CORE_LOG_LEVEL);
        PropertyConfigurator.configure(properties);
    }
}