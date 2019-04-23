package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.utils.Gen;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Queue;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentLinkedQueue;

public class AddUserToCategoryTest extends AbstractPerformanceTestServiceWrapper {
    protected static final List<String> users = new ArrayList<>();
    protected static final List<String> categories = new ArrayList<>();
    protected static final Map<String, Queue<String>> addedUsers = new ConcurrentHashMap<>(); // userId -> Queue[categoryId]
    private User defaultUser;

    @Override
    public void runOnce() {
        if (users.isEmpty()) {
            logIn(getParam("login"), getParam("password"));
            int usersCount = getParamInt("usersCount");
            log.info(String.format("Check for %d users", usersCount));
            getUsersFromCore(usersCount);
            log.info(String.format("Found %d users. Need to create %d users.", users.size(), usersCount - users.size()));
            for (int i = 0; i < usersCount - users.size(); i++) {
                if (i % 100 == 99) {
                    log.info(String.format("Created %d users", i + 1));
                }
                users.add(getService().createUser(getCurrentAgency().getId(), getUser()).getId());
            }
            log.info("Users have been created");
        }
        if (categories.isEmpty()) {
            logIn(getParam("login"), getParam("password"));
            int categoriesCount = getParamInt("categoriesCount");
            log.info(String.format("Check for %d users", categoriesCount));
            getCategoriesFromCore();
            log.info(String.format("Found %d categories. Need to create %d categories.", categories.size(), categoriesCount - categories.size()));
            String assetFilterTerms = new AssetFilterTerms().getQuery().toString();
            for (int i = 0; i < categoriesCount - categories.size(); i++) {
                if (i % 100 == 99) {
                    log.info(String.format("Created %d categories", i + 1));
                }
                AssetFilter filter =
                        getService().createAssetFilter(Gen.getHumanReadableString(6, true), "asset_filter_category", assetFilterTerms);
                categories.add(filter.getId());
            }
        }
    }

    @Override
    public void beforeStart() {
        logIn(getParam("login"), getParam("password"));
    }

    @Override
    public void start() {
        String userId;
        String categoryId;
        long start = System.currentTimeMillis();
        do {
            userId = users.get(Gen.getInt(users.size()));
            categoryId = categories.get(Gen.getInt(categories.size()));
            if (System.currentTimeMillis() - start > 1000) {
                fail("Could not retrieve userId and categoryId for a second");
            }
        } while (addedUsers.get(userId) != null && addedUsers.get(userId).contains(categoryId));
        if (addedUsers.get(userId) == null) {
            addedUsers.put(userId, new ConcurrentLinkedQueue<String>());
        }
        addedUsers.get(userId).add(categoryId);
        getService().shareAssetFilter(categoryId, userId, getRoleByName("library.user").getId());
    }

    @Override
    public void afterRun() {
    }

    private void getUsersFromCore(int countLimit) {
        LuceneSearchingParams query = new LuceneSearchingParams();
        SearchResult<User> result;
        int page = 1;
        do {
            int part = countLimit - users.size() > 100 ? 100 : countLimit - users.size();
            query.setResultsOnPage(part).setPageNumber(page);
            result = getService().findUsers(query);
            for (User user : result.getResult()) {
                users.add(user.getId());
            }
            log.info(String.format("Found %d users", users.size()));
            page++;
        } while(countLimit > users.size() && result.hasMore());
    }

    private void getCategoriesFromCore() {
        for (AssetFilter filter : getService().getAssetFilters("asset_filter_category").getFilters()) {
            if (!filter.isDefault()) {
                categories.add(filter.getId());
            }
        }
    }

    protected User getUser() {
        if (defaultUser == null) {
            defaultUser = new User();
            defaultUser.setAgency(getCurrentAgency());
            defaultUser.setPhoneNumber("1234567890");
            defaultUser.setAdvertiser(getCurrentAgency().getId());
            defaultUser.setPassword("abcdefghA1");
            defaultUser.setAccess();
            defaultUser.setRoles(new BaseObject[] {getGuestRole()});
        }
        defaultUser.setFirstName(Gen.getHumanReadableString(6, true));
        defaultUser.setLastName(Gen.getHumanReadableString(6, true));
        defaultUser.setEmail((defaultUser.getFirstName() + "." + defaultUser.getLastName() + "@test.com").toLowerCase());
        return defaultUser;
    }

    protected Role getGuestRole() {
        return getRoleById("4fba0ec37fec91f70b5a0917");
    }
}
