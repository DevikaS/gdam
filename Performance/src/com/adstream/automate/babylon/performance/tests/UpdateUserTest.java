package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.With;
import com.adstream.automate.utils.Gen;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * User: ruslan.semerenko
 * Date: 18.07.12 16:11
 */
public class UpdateUserTest extends SearchUsersTest {
    private List<User> users = new ArrayList<User>();

    @Override
    public void runOnce() {
        super.runOnce();
    }

    @Override
    public void beforeStart() {
        logIn(getParam("login"), getParam("password"));
        LuceneSearchingParams query = new LuceneSearchingParams().setResultsOnPage(25);
        if (users.isEmpty()) {
            for (int i = 0; i < 10; i++) {
                query.setQuery(Gen.getHumanReadableString(2) + "*");
                users.addAll(getService().findUsers(query, new With(true, true, false)).getResult());
            }
            if (users.isEmpty())
                for (int i = 0; i < 10; i++)
                    users.add(getService().createUser(getCurrentAgency().getId(), getUser()));
        }
    }

    @Override
    public void start() {
        User user = users.get(Gen.getInt(users.size()));
        user.setFirstName(Gen.getHumanReadableString(6, true));
        user.setFullName(user.getFirstName() + " " + user.getLastName());
        getService().updateUser(user.getId(), user);
    }

    @Override
    public void afterRun() {
    }
}
