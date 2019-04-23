package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.Role;
import com.adstream.automate.babylon.JsonObjects.SearchResult;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.utils.Gen;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Deque;
import java.util.List;
import java.util.concurrent.ConcurrentLinkedDeque;

public class UpdateUserRoleTest extends AbstractPerformanceTestServiceWrapper {
    private static final Deque<User> users = new ConcurrentLinkedDeque<>();
    private static final List<Role> roles = new ArrayList<>();

    @Override
    public void runOnce() {
        impersonateAsAgencyAdmin();
        // get users from current agency
        List<User> usersList = new ArrayList<>();
        SearchResult<User> result;
        LuceneSearchingParams usersQuery = new LuceneSearchingParams().setResultsOnPage(100);
        int page = 1;
        do {
            result = getService().findUsers(usersQuery.setPageNumber(page++));
            for (User user : result.getResult()) {
                if (user.getSubtype().equals("user")
                        && user.getAgency().getId().equals(getCurrentAgency().getId())
                        && !user.getEmail().startsWith("x")
                        && !user.getEmail().equals(getParam("agencyAdminLogin"))) {
                    usersList.add(user);
                }
            }
            log.info(String.format("Found %d users", usersList.size()));
        } while(result.hasMore());
        Collections.shuffle(usersList);
        users.addAll(usersList);
        // get global roles from current agency
        LuceneSearchingParams rolesQuery = new LuceneSearchingParams().setQuery("_parents.$id:" + getCurrentAgency().getId());
        for (Role role : getService().findRoles(rolesQuery).getResult()) {
            if (role.getGroup().equals("global")) {
                roles.add(role);
            }
        }
        if (isCoreService()) {
            // get default global roles
            rolesQuery.setQuery("_parents.$id:4ef31ce1766ec96769b399bd");
            for (Role role : getService().findRoles(rolesQuery).getResult()) {
                if (role.getGroup().equals("global")) {
                    roles.add(role);
                }
            }
        }
    }

    @Override
    public void beforeStart() {
        impersonateAsAgencyAdmin();
    }

    @Override
    public void start() {
        User user = null;
        try {
            user = users.removeFirst();
            Role role;
            do {
                role = roles.get(Gen.getInt(roles.size()));
            } while (user.getRoles().length > 0 && user.getRoles()[0].getId().equals(role.getId()));
            if (isCoreService()) {
                getService().setUserRole(getCurrentAgency().getId(), user.getId(), new String[] {role.getId()});
            } else {
                getBabylonMiddlewareService().setUserRole(user, role.getId());
            }
        } finally {
            if (user != null) {
                users.addLast(user);
            }
        }
    }

    @Override
    public void afterRun() {
    }

    private void impersonateAsAgencyAdmin() {
        String globalAdminLogin = getParam("globalAdminLogin");
        String globalAdminPassword = getParam("globalAdminPassword");
        String agencyAdminLogin = getParam("agencyAdminLogin");
        logIn(globalAdminLogin, globalAdminPassword);
        getService().impersonate(agencyAdminLogin, "a5 qaa test");
    }
}
