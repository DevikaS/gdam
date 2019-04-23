package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.JsonObjects.AssetFilter;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.performance.helper.ObjectsFactory;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class AssetFilterVolumeTest extends AbstractPerformanceTestServiceWrapper {
    private static volatile List<AssetFilter> frontier;
    private static User agencyAdmin;

    private static final int TREE_LEVELS_PER_ITERATION = 2;
    private static final int CHILDREN_PER_LEVEL = 2;
    private static final String AGENCY_ADMIN_ROLE_ID = "4f6acc74dff0676e018e6dcc";

    private void growTree() {
        log.info("Growing category tree");
        for (int i = 0; i < TREE_LEVELS_PER_ITERATION; ++i) {
            addTreeLevel();
        }
    }

    private void addTreeLevel() {
        List<AssetFilter> newFrontier = new ArrayList<>();
        for (AssetFilter category : frontier) {
            for (int i = 0; i < CHILDREN_PER_LEVEL; ++i) {
                newFrontier.add(createChild(category, category.getId() + " child " + i));
            }
        }
        frontier = newFrontier;
    }

    private AssetFilter createChild(AssetFilter parent, String name) {
        String query = String.format("{ \"and\" : [{ \"categories\" : [\"%s\"] }]}", parent.getId());
        return getService().createAssetFilter(name, "asset_filter_category", query);
    }

    private AssetFilter createRoot() {
        return getService().createAssetFilter("root", "asset_filter_category", "{ \"and\": [] }");
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

        log.info("Creating root category");
        frontier = Arrays.asList(createRoot());
    }

    private void loginAsAgencyAdmin() {
        log.info("Login to system by: " + agencyAdmin.getEmail());
        logIn(agencyAdmin.getEmail(), getParam("password"));
    }

    protected Agency generateAgency() {
        return ObjectsFactory.createAgency(getParam("storageId"));
    }

    protected User generateAgencyAdmin(Agency agency) {
        return ObjectsFactory.getUser(agency, getService().getRole(AGENCY_ADMIN_ROLE_ID));
    }

    @Override
    public void beforeStart() {
        loginAsAgencyAdmin();
        growTree();
    }

    @Override
    public void start() {
        getService().getAssetFilters("asset_filter_category");
    }

    @Override
    public void afterRun() {
        log.info("afterRun");
    }
}
