package com.adstream.automate.babylon.performance.stress;

import com.adstream.automate.babylon.BabylonServiceWrapper;
import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.core.BabylonCoreService;
import com.adstream.automate.babylon.performance.helper.ObjectsFactory;
import com.adstream.automate.utils.Gen;
import org.apache.log4j.PropertyConfigurator;
import org.joda.time.DateTime;

import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import static java.util.Arrays.asList;

/**
 * User: lynda-k
 * Date: 03.09.2014
 * Time: 12:34
 */
public class CreateProjectFromTemplate {
    private static final String CORE_URL = "http://10.0.26.56:8080";
    private static final String USER_EMAIL = "agencyadmin@test.com";
    private static final String USER_PASSWORD = "abcdefghA1";

    private static final int PROJECTS_COUNT = 10;

    private static final int FOLDER_LEVELS = 2;
    private static final int FOLDERS_PER_LEVEL = 5;
    private static final int USERS_PER_FOLDER = 2;
    private static final boolean IS_PROJECTS_PUBLISHED = false;

    public static void main(String[] args) throws Exception {
        setUpLogger();
        String templateNameFormat = "NGN-11895 %d";

        for (int i = 0; i < PROJECTS_COUNT; i++) {
            test(String.format(templateNameFormat, i+1), FOLDER_LEVELS, FOLDERS_PER_LEVEL, USERS_PER_FOLDER + i, IS_PROJECTS_PUBLISHED);
        }
    }

    protected static void test(String templateName, int foldersLevel, int foldersPerLevel, int usersPerFolder, boolean isProjectPublished) {
        try {
            BabylonServiceWrapper service = new BabylonServiceWrapper(new BabylonCoreService(new URL(CORE_URL)), null);
            service.logIn(USER_EMAIL, USER_PASSWORD);
            Project template = createTemplate(service, templateName, foldersLevel, foldersPerLevel, usersPerFolder);

            DateTime dateStart = new DateTime();
            DateTime dateEnd = new DateTime().plusDays(10);

            DateTime startedTime = DateTime.now();
            String processId = service.getWrappedService().createProjectFromTemplate(template.getId(),
                    Gen.getHumanReadableString(6, true),
                    new String[]{"Broadcast"},
                    dateStart,
                    dateEnd,
                    true,
                    true,
                    isProjectPublished);

            service.getWrappedService().batchTaskApi().waitTillDone(processId);

            System.out.printf("Cloned %sproject (with %d users team) in %d millis\n\n", isProjectPublished ? "and published " : "",
                    new Double(Math.pow(foldersPerLevel, foldersLevel)).longValue() * usersPerFolder,
                    DateTime.now().getMillis() - startedTime.getMillis());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected static Project createTemplate(BabylonServiceWrapper service, String templateName, int folderLevels, int foldersPerLevel, int usersPerFolder) {
        Project template = service.createProject(ObjectsFactory.getTemplate(templateName));
        Agency agency = service.getCurrentAgency();
        List<Role> globalRoles = asList(service.getRoleByName("guest.user"), service.getRoleByName("agency.user"));
        List<Role> projectRoles = asList(service.getRoleByName("project.user"), service.getRoleByName("project.contributor"));

        System.out.print("Create folders for template '" + templateName + "'... ");
        List<Content> folders = createFolders(service, template.getId(), foldersPerLevel, 1, folderLevels);
        System.out.println("Done");

        System.out.print("Create and add users to template '" + templateName + "' team users... ");
        long expireTime = new DateTime().plusDays(10).getMillis();
        List<TeamPermission> permissions = new ArrayList<>();

        for (Content folder : folders) {
            for (int userIndex = 0; userIndex < usersPerFolder; userIndex++) {
                permissions.add(new TeamPermission(folder.getId(),
                        service.createUser(ObjectsFactory.getUser(agency, globalRoles.get(Gen.getInt(globalRoles.size())))).getId(),
                        projectRoles.get(Gen.getInt(projectRoles.size())).getId(),
                        false,
                        expireTime));
            }
        }

        service.getWrappedService().addUserToProjectTeam(template.getId(), permissions.toArray(new TeamPermission[permissions.size()]));
        System.out.println("Done");

        return template;
    }

    protected static List<Content> createFolders(BabylonServiceWrapper service, String parentId, int count, int level, int maxLevel) {
        List<Content> folders = new ArrayList<Content>();
        for (int i = 0; i < count; i++) {
            Content folder = service.createFolder(parentId, Gen.getHumanReadableString(6, true));
            folders.add(folder);
            if (level < maxLevel) {
                folders.addAll(createFolders(service, folder.getId(), count, level + 1, maxLevel));
            }
        }
        return folders;
    }

    protected static void setUpLogger() {
        Properties properties = new Properties();
        properties.setProperty("log4j.rootLogger", "INFO,console");
        properties.setProperty("log4j.appender.console", "org.apache.log4j.ConsoleAppender");
        properties.setProperty("log4j.appender.console.layout", "org.apache.log4j.PatternLayout");
        properties.setProperty("log4j.appender.console.layout.ConversionPattern", "%d %-5p %t %c{1} %m%n");
        properties.setProperty("log4j.logger.com.adstream.automate.babylon.BabylonService", "INFO");
        PropertyConfigurator.configure(properties);
    }
}