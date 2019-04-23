package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.JsonObjects.AssetFilter;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.With;
import com.adstream.automate.babylon.performance.helper.ObjectsFactory;

import java.io.File;
import java.util.concurrent.atomic.AtomicInteger;

public class AssetSearchWithPermissionsVolumeTest extends AbstractPerformanceTestServiceWrapper {
    private final static AtomicInteger categoryCount = new AtomicInteger(0);
    private static User agencyAdmin;

    private final static String NON_MATCHING_QUERY = "{ \"and\": [ { \"terms\": { \"_cm.common.name\": [\"NEVERMATCHES\"] } } ] }";
    private final static String MATCHING_QUERY = "{ \"and\": [ {\"terms\": {\"_cm.common.mediaType\":[\"image\"] } } ] }";

    private static final int CATEGORIES_PER_ITERATION = 100;
    private static final int ASSETS_IN_SEARCH_RESULT = 20;
    private static final String AGENCY_ADMIN_ROLE_ID = "4f6acc74dff0676e018e6dcc";
    private static final String EVERYTHING_CATEGORY_ID = "5007b259db016b1bf995274b";

    private void addMoreCategories() {
        log.info("Creating more categories");
        for (int i = 0; i < CATEGORIES_PER_ITERATION; ++i) {
            createCategory();
        }
    }

    private AssetFilter createCategory() {
        int categoryIdx = categoryCount.incrementAndGet();
        String name = "category " + agencyAdmin.getId() + " " + categoryIdx;
        String query = categoryIdx == 1 ? MATCHING_QUERY : NON_MATCHING_QUERY;
        return getService().createAssetFilter(name, "asset_filter_category", query);
    }

    @Override
    public void runOnce() {
        log.info("Login as global admin...");
        logIn(getParam("login"), getParam("password"));
        log.info("Creating agency...");
        Agency agency = getService().createAgency(generateAgency());

        log.info("Creating agency admin...");
        agencyAdmin = getService().createUser(agency.getId(), generateAgencyAdmin(agency));
        loginAsAgencyAdmin();

        String imagePath = getParam("ImageAssetFilePath");

        int assetCount = getParamInt("assetCount");
        log.info(String.format("create %s assets", assetCount));

        for (int i = 0; i < assetCount; i++) {
            uploadAsset(new File(imagePath));
        }
    }

    private void loginAsAgencyAdmin() {
        log.info("Login to system by: " + agencyAdmin.getEmail());
        logIn(agencyAdmin.getEmail(), getParam("password"));
    }

    protected Agency generateAgency() {
        return ObjectsFactory.createAgency(getParam("storageId"));
    }

    protected User generateAgencyAdmin(Agency agency) {
        User user = ObjectsFactory.getUser(agency, getService().getRole(AGENCY_ADMIN_ROLE_ID));
        user.setFullAccess();
        return user;
    }

    @Override
    public void beforeStart() {
        loginAsAgencyAdmin();
        addMoreCategories();
    }

    @Override
    public void start() {
        With with = new With();
        with.setPermissions(true);
        LuceneSearchingParams query = new LuceneSearchingParams().setResultsOnPage(ASSETS_IN_SEARCH_RESULT);
        getService().findAssets(EVERYTHING_CATEGORY_ID, query, with);
    }

    @Override
    public void afterRun() {
        log.info("after run");
    }

}
