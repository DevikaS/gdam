package com.adstream.automate.babylon.performance.stress;

import com.adstream.automate.babylon.BabylonServiceWrapper;
import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.core.BabylonCoreService;
import com.adstream.automate.babylon.performance.helper.ObjectsFactory;
import com.adstream.automate.utils.Gen;
import org.joda.time.DateTime;

import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * User: ruslan.semerenko
 * Date: 09.12.13 12:45
 */
public class CreateProjectsWithLargeTeam {
    private static final int PROJECTS_COUNT = 100;
    protected int FOLDERS_PER_LEVEL = 5;
    protected int FIRST_LEVEL = 1;
    protected int MAX_LEVEL = 3;

    public static void main(String[] args) throws Exception {
        final CreateProjectsWithLargeTeam test = new CreateProjectsWithLargeTeam();
        ExecutorService executor = Executors.newFixedThreadPool(8);
        final AtomicInteger counter = new AtomicInteger();
        for (int i = 0; i < PROJECTS_COUNT; i++) {
            executor.execute(new Runnable() {
                @Override
                public void run() {
                    try {
                        BabylonServiceWrapper service = new BabylonServiceWrapper(new BabylonCoreService(new URL("http://10.64.130.10:8080")), null);
                        service.logIn("agencyadmin@test.com", "abcdefghA1");
                        test.createProject(service, "NGN-8909-" + System.currentTimeMillis() + "-" + counter.getAndIncrement());
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            });
        }
        executor.shutdown();
    }

    protected Project createProject(BabylonServiceWrapper service, String projectName) {
        String threadName = Thread.currentThread().getName();
        Project project = service.createProject(ObjectsFactory.getProject(projectName));

        System.out.print(threadName + ": Create folders... ");
        List<Content> folders = createFolders(service, project.getId(), FOLDERS_PER_LEVEL, FIRST_LEVEL, MAX_LEVEL);
        System.out.println(threadName + ": Done");

        Agency agency = service.getCurrentAgency();
        Role contributorRole = service.getRoleByName("project.contributor");
        Role guestRole = service.getRoleByName("guest.user");
        long expireTime = new DateTime().plusDays(10).getMillis();
        TeamPermission[] permissions = new TeamPermission[folders.size()];

        System.out.print(threadName + ": Create users... ");
        for (int i = 0; i < permissions.length; i++) {
            User user = service.createUser(ObjectsFactory.getUser(agency, guestRole));
            Content folder = folders.get(i);
            TeamPermission permission =
                    new TeamPermission(folder.getId(), user.getId(), contributorRole.getId(), false, expireTime);
            permissions[i] = permission;
        }
        System.out.println(threadName + ": Done");

        System.out.print(threadName + ": Add users to project team... ");
        service.addUserToProjectTeam(permissions);
        System.out.println(threadName + ": Done");

        return project;
    }

    protected List<Content> createFolders(BabylonServiceWrapper service, String parentId, int count, int level, int maxLevel) {
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
}
