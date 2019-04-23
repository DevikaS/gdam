package com.adstream.automate.babylon.performance.stress;

import com.adstream.automate.babylon.BabylonServiceWrapper;
import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.core.BabylonCoreService;
import com.adstream.automate.utils.Gen;
import org.joda.time.DateTime;

import java.net.URL;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * User: ruslan.semerenko
 * Date: 09.08.13 8:34
 */
public class CreateTemplateFromProject extends CreateProjectsWithLargeTeam {
    private static final String PROJECT_NAME = "NGN-7633";
    private static final int THREADS_COUNT = 10;
    private static final int TEMPLATES_COUNT = 30;

    public static void main(String[] args) throws Exception {
        CreateTemplateFromProject test = new CreateTemplateFromProject();
        test.FOLDERS_PER_LEVEL = 5;
        test.FIRST_LEVEL = 1;
        test.MAX_LEVEL = 3;

        BabylonServiceWrapper service = new BabylonServiceWrapper(new BabylonCoreService(new URL("http://10.0.26.17:8080")), null);
        service.logIn("agencyadmin@test.com", "1");
        Project project = service.getProjectByName(PROJECT_NAME, 0);
        if (project == null) {
            project = test.createProject(service, PROJECT_NAME);
        }
        final Project finalProject = project;
        ExecutorService executor = Executors.newFixedThreadPool(THREADS_COUNT);
        final AtomicInteger counter = new AtomicInteger(0);
        for (int i = 0; i < TEMPLATES_COUNT; i++) {
            executor.execute(new Runnable() {
                @Override
                public void run() {
                    try {
                        System.out.println("Create template " + counter.incrementAndGet() + "/" + TEMPLATES_COUNT);
                        BabylonServiceWrapper service = new BabylonServiceWrapper(new BabylonCoreService(new URL("http://10.0.26.17:8080")), null);
                        service.logIn("agencyadmin@test.com", "1");
                        DateTime dateStart = new DateTime();
                        DateTime dateEnd = new DateTime().plusDays(10);
                        service.getWrappedService().createTemplateFromProject(
                                finalProject.getId(), Gen.getHumanReadableString(6, true), new String[] {"Broadcast"}, dateStart, dateEnd, true, true);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            });
        }
        executor.shutdown();
    }
}
