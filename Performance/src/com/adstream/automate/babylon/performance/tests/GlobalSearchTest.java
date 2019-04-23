package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.utils.Gen;
import org.joda.time.DateTime;
import org.joda.time.Period;

import java.io.File;

/**
 * User: ruslan.semerenko
 * Date: 24.09.12 14:13
 */
public class GlobalSearchTest extends AbstractPerformanceTestServiceWrapper {
    private static boolean usersCreated = false;
    private static boolean projectsCreated = false;
    private User defaultUser;
    private Project defaultProject;

    @Override
    public void runOnce() {
        if (!usersCreated) {
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
        if (!projectsCreated) {
            logIn(getParam("login"), getParam("password"));
            int projectsCount = getParamInt("projectsCount");
            int foldersInProject = getParamInt("foldersInProject");
            int filesInFolder = getParamInt("filesInFolder");
            log.info(String.format("Check for %d projects", projectsCount));
            int projectsFound = getProjectsCountInDb(projectsCount);
            log.info(String.format("Found %d projects. Need to create %d projects.", projectsFound, projectsCount - projectsFound));
            for (int i = 0; i < projectsCount - projectsFound; i++) {
                if (i % 1000 == 999) log.info(String.format("Created %d projects", i + 1));
                Project project = getService().createProject(getProject());
                Content rootFolder = getProjectRootFolder(project.getId());
                for (int j = 0; j < foldersInProject; j++) {
                    Content folder = getService().createContent(rootFolder.getId(), getFolder());
                    for (int k = 0; k < filesInFolder; k++)
                        uploadFile(new File(getParam("filePath")), folder.getId());
                }
            }
            projectsCreated = true;
            log.info("Projects have been created");
        }
    }

    @Override
    public void beforeStart() {
        logIn(getParam("login"), getParam("password"));
    }

    @Override
    public void start() {
        getService().globalSearch(new LuceneSearchingParams().setQuery(Gen.getHumanReadableString(3)));
    }

    @Override
    public void afterRun() {
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

    private int getProjectsCountInDb(int countLimit) {
        LuceneSearchingParams query = new LuceneSearchingParams();
        SearchResult<Project> result;
        int projectsCount = 0, page = 1;
        do {
            int part = countLimit - projectsCount > 100 ? 100 : countLimit - projectsCount;
            query.setResultsOnPage(part).setPageNumber(page);
            result = getService().findProjects(query);
            projectsCount += result.getResult().size();
            log.info(String.format("Found %d projects", projectsCount));
            page++;
        } while(countLimit > projectsCount && result.hasMore());
        return projectsCount;
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

//    protected Content getFileContent() {
//        StringBuilder tmpPath = new StringBuilder();
//        tmpPath.append("/").append(new SimpleDateFormat("yyyyMMdd").format(new Date()));
//        tmpPath.append("/").append(getCurrentUser().getId());
//        tmpPath.append("/").append(System.currentTimeMillis());
//        File file = new File(getParam("filePath"));
//        String fileName = file.getName();
//        String fileExtension = fileName.contains(".") ? fileName.substring(fileName.lastIndexOf(".")) : "";
//        String targetFileName = UUID.randomUUID().toString() + fileExtension;
//        Content fileContent = new Content();
//        String uniqueName = Gen.getHumanReadableString(6, true) + fileExtension;
//        fileContent.setName(uniqueName);
//        fileContent.setSubtype("element");
//        fileContent.setPath(uniqueName);
//        fileContent.setTmpPath(tmpPath.append("/").append(targetFileName).toString());
//        return fileContent;
//    }

    protected Role getGuestRole() {
        return getRoleById("4fba0ec37fec91f70b5a0917");
    }
}
