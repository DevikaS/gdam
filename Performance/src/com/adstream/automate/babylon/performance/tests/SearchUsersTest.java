package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.SearchResult;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.utils.Gen;

/**
 * User: ruslan.semerenko
 * Date: 17.07.12 12:43
 */
public class SearchUsersTest extends CreateUserTest {
    private static boolean usersCreated = false;

    @Override
    public void runOnce() {
        if (usersCreated) return;
        logIn(getParam("login"), getParam("password"));
        int usersCount = getParamInt("usersCount");
        log.info(String.format("Check for %d users", usersCount));
        int usersFound = getUsersCountInDb(usersCount);
        log.info(String.format("Found %d users. Need to create %d users.", usersFound, usersCount - usersFound));
        for (int i = 0; i < usersCount - usersFound; i++) {
            if (i % 1000 == 999) log.info(String.format("Created %d users", i + 1));
            getService().createUser(getCurrentAgency().getId(), getUser());
        }
        usersCreated = true;
        log.info("Users have been created");
    }

    @Override
    public void beforeStart() {
        logIn(getParam("login"), getParam("password"));
    }

    @Override
    public void start() {
        getService().findUsers(getQuery());
    }

    @Override
    public void afterRun() {
    }

    private LuceneSearchingParams getQuery() {
        return new LuceneSearchingParams()
                .setResultsOnPage(7)
                .setPageNumber(1)
                .setQuery(Gen.getHumanReadableString(3));
    }

    private int getUsersCountInDb(int countLimit) {
        LuceneSearchingParams query = new LuceneSearchingParams();
        SearchResult<User> result;
        int usersCount = 0, page = 1;
        do {
            int part = countLimit - usersCount > 100 ? 100 : countLimit - usersCount;
            query.setResultsOnPage(part).setPageNumber(page);
            result = getService().findUsers(query);
            usersCount += result.getResult().size();
            log.info(String.format("Found %d users", usersCount));
            page++;
        } while(countLimit > usersCount && result.hasMore());
        return usersCount;
    }
}
