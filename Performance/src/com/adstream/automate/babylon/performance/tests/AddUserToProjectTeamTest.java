package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.utils.Gen;
import org.joda.time.DateTime;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Queue;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentLinkedQueue;

/**
 * User: ruslan.semerenko
 * Date: 06.08.13 13:36
 */
public class AddUserToProjectTeamTest extends CreateProjectTest {
    protected static final List<Project> projects = new ArrayList<>();
    protected static final List<User> users = new ArrayList<>();
    protected static final Map<String, Queue<String>> addedUsers = new ConcurrentHashMap<>(); // userId -> Queue[projectId]
    private User defaultUser;

    @Override
    public void runOnce() {
        logIn(getParam("login"), getParam("password"));
        if (projects.isEmpty()) {
            int projectsCount = getParamInt("projectsCount");
            LuceneSearchingParams query = new LuceneSearchingParams().setResultsOnPage(20);
            int i = 1;
            SearchResult<Project> searchResult;
            do {
                query.setPageNumber(i++);
                searchResult = getService().findProjects(query);
                projects.addAll(searchResult.getResult());
            } while (projects.size() < projectsCount && searchResult.hasMore());
            for (i = projects.size(); i < projectsCount; i++) {
                if (i % 100 == 99) {
                    log.info("Created " + (i + 1) + " projects");
                }
                projects.add(getService().createProject(getProject()));
            }
        }
        if (users.isEmpty()) {
            int usersCount = getParamInt("usersCount");
            LuceneSearchingParams query = new LuceneSearchingParams().setResultsOnPage(20);
            int i = 1;
            SearchResult<User> searchResult;
            do {
                query.setPageNumber(i++);
                searchResult = getService().findUsers(query);
                users.addAll(searchResult.getResult());
            } while (users.size() < usersCount && searchResult.hasMore());
            for (i = users.size(); i < usersCount; i++) {
                if (i % 100 == 99) {
                    log.info("Created " + (i + 1) + " users");
                }
                users.add(getService().createUser(getCurrentAgency().getId(), getUser()));
            }
        }
    }

    @Override
    public void start() {
        String projectId = projects.get(Gen.getInt(projects.size())).getId();
        String userId = users.get(Gen.getInt(users.size())).getId();
        if (addedUsers.get(userId) == null) {
            addedUsers.put(userId, new ConcurrentLinkedQueue<String>());
        }
        addedUsers.get(userId).add(projectId);
        Role contributorRole = getRoleByName("project.contributor");
        TeamPermission perm =
                new TeamPermission(projectId, userId, contributorRole.getId(), false, new DateTime().plusDays(10).getMillis());
        getService().addUserToProjectTeam(new TeamPermission[] {perm});
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
