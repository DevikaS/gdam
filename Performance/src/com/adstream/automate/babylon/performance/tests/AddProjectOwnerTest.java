package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.utils.Gen;
import org.joda.time.DateTime;
import org.joda.time.Period;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Queue;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentLinkedQueue;

public class AddProjectOwnerTest extends AbstractPerformanceTestServiceWrapper {
    protected static final List<String> users = new ArrayList<>();
    protected static final List<String> projects = new ArrayList<>();
    protected static final Map<String, Queue<String>> addedOwners = new ConcurrentHashMap<>(); // userId -> Queue[projectId]
    private User defaultUser;
    private Project defaultProject;

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
                getService().createUser(getCurrentAgency().getId(), getUser());
            }
            log.info("Users have been created");
        }
        if (projects.isEmpty()) {
            logIn(getParam("login"), getParam("password"));
            int projectsCount = getParamInt("projectsCount");
            int foldersInProject = getParamInt("foldersInProject");
            int filesInFolder = getParamInt("filesInFolder");
            log.info(String.format("Check for %d projects", projectsCount));
            getProjectsFromCore(projectsCount);
            log.info(String.format("Found %d projects. Need to create %d projects.", projects.size(), projectsCount - projects.size()));
            for (int i = 0; i < projectsCount - projects.size(); i++) {
                if (i % 1000 == 999) log.info(String.format("Created %d projects", i + 1));
                Project project = getService().createProject(getProject());
                for (int j = 0; j < foldersInProject; j++) {
                    Content folder = getService().createContent(project.getId(), getFolder());
                    for (int k = 0; k < filesInFolder; k++)
                        uploadFile(new File(getParam("filePath")), folder.getId());
                }
            }
            log.info("Projects have been created");
        }
    }

    @Override
    public void beforeStart() {
        logIn(getParam("login"), getParam("password"));
    }

    @Override
    public void start() {
        String userId;
        String projectId;
        long start = System.currentTimeMillis();
        do {
            userId = users.get(Gen.getInt(users.size()));
            projectId = projects.get(Gen.getInt(projects.size()));
            if (System.currentTimeMillis() - start > 1000) {
                fail("Could not retrieve userId and projectId for a second");
            }
        } while (addedOwners.get(userId) != null && addedOwners.get(userId).contains(projectId));
        if (addedOwners.get(userId) == null) {
            addedOwners.put(userId, new ConcurrentLinkedQueue<String>());
        }
        addedOwners.get(userId).add(projectId);
        if (isCoreService()) {
            TeamPermission[] permissions = new TeamPermission[] {
                    new TeamPermission(projectId, userId, getProjectAdminRole().getId(), true, null)
            };
            getService().addUserToProjectTeam(projectId, permissions);
        } else {
            getBabylonMiddlewareService().addProjectOwner(projectId, userId);
        }
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

    private void getProjectsFromCore(int countLimit) {
        LuceneSearchingParams query = new LuceneSearchingParams();
        SearchResult<Project> result;
        int page = 1;
        do {
            int part = countLimit - projects.size() > 100 ? 100 : countLimit - projects.size();
            query.setResultsOnPage(part).setPageNumber(page);
            result = getService().findProjects(query);
            for (Project project : result.getResult()) {
                projects.add(project.getId());
            }
            log.info(String.format("Found %d projects", projects.size()));
            page++;
        } while(countLimit > projects.size() && result.hasMore());
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

    protected Project getProject() {
        if (defaultProject == null) {
            Project project = new Project();
            project.setMediaType("Broadcast");
            project.setAdministrators(new String[0]);
            project.setSubtype("project");
            project.setLogo("");
            project.setDateStart(new DateTime());
            project.setDateEnd(new DateTime().plus(Period.days(1)));
            defaultProject = project;
        }
        defaultProject.setName(Gen.getHumanReadableString(8, true));
        defaultProject.setJobNumber(Gen.getHumanReadableString(8, true));
        return defaultProject;
    }

    protected Content getFolder() {
        Content content = new Content();
        content.setName(Gen.getHumanReadableString(6, true));
        content.setSubtype("folder");
        return content;
    }

    protected Role getGuestRole() {
        return getRoleByName("guest.user");
    }

    protected Role getProjectAdminRole() {
        return getRoleByName("project.admin");
    }
}
