package com.adstream.automate.babylon.performance.stress;

import com.adstream.automate.babylon.BabylonServiceWrapper;
import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.core.BabylonCoreService;
import com.adstream.automate.babylon.performance.helper.ObjectsFactory;
import com.adstream.automate.utils.Gen;
import org.apache.log4j.PropertyConfigurator;

import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * User: ruslan.semerenko
 * Date: 07.10.13 13:17
 */
public class ShareCategoryToLibraryTeam {
    private static final int USERS_COUNT = 300;
    private static final int THREADS_COUNT = 1;
    private static final int CATEGORIES_COUNT = 1;
    private static BabylonServiceWrapper service;

    public static void main(String[] args) throws Exception {
        PropertyConfigurator.configure("log4j.properties");
        service = new BabylonServiceWrapper(new BabylonCoreService(new URL("http://10.0.26.17:8080")), null);
        service.logIn("agencyadmin@test.com", "1");
        final BaseObject libraryTeam = service.addUsersToLibraryTeam(Gen.getHumanReadableString(6, true), createUsers(USERS_COUNT));
        final Role libraryRole = service.getRoleByName("library.user");
        ExecutorService executor = Executors.newFixedThreadPool(THREADS_COUNT);
        for (int i = 0; i < CATEGORIES_COUNT; i++) {
            executor.execute(new Runnable() {
                @Override
                public void run() {
                    AssetFilter category =
                            service.createAssetFilterCategory(Gen.getHumanReadableString(6, true), new AssetFilterTerms().getQuery().toString());
                    long start = System.currentTimeMillis();
                    service.shareAssetFilter(category.getId(), libraryTeam.getId(), libraryRole.getId());
                    System.out.println(String.format("Share category for %d ms" , System.currentTimeMillis() - start));
                }
            });
        }
        executor.shutdown();
    }

    private static List<User> createUsers(int count) {
        List<User> users = new ArrayList<User>();
        Agency agency = service.getCurrentAgency();
        Role guestRole = service.getRoleByName("guest.user");
        for (int i = 0; i < count; i++) {
            if (i % 25 == 24) {
                System.out.println(String.format("Created %d users", i + 1));
            }
            users.add(service.createUser(ObjectsFactory.getUser(agency, guestRole)));
        }
        return users;
    }
}
