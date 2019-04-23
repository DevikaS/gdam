package com.adstream.automate.babylon.migration.tests.cases;

import com.adstream.automate.babylon.JsonObjects.SearchResult;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.With;
import com.adstream.automate.babylon.migration.tests.BaseTest;
import com.adstream.automate.babylon.migration.utils.FileManager;
import com.adstream.automate.babylon.migration.utils.MongoUtils;
import org.testng.annotations.Test;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 11/15/13
 * Time: 2:12 PM
 */
public class Preparation extends BaseTest {
    private static String fileAgency = "\\migration\\src\\main\\resources\\files\\before_agencies_281113.txt";
    private static String fileUsers = "\\migration\\src\\main\\resources\\files\\before_users_281113.txt";
    private static String usersDir = "\\migration\\src\\main\\resources\\files\\agencies_281113\\";
    private static Map<String, List<User>> usersMap = new HashMap<String, List<User>>();

    public static void main(String[] args) {
        getService().logIn("admin", MongoUtils.getPassword("admin"));
        String agencyName = "Warner Bros UK";
        com.adstream.automate.babylon.JsonObjects.Agency agency = getService().getAgencyByName(agencyName);
        String agencyId = agency.getId();
        String folder = System.getProperty("user.dir");
        String file = folder.concat(usersDir).concat(agencyId).concat(".age");
        List<String> content = FileManager.readTextFile(file);
        for (String email: content) {
            if (!email.contains("@")) continue;
            com.adstream.automate.babylon.JsonObjects.User userApp = getService().getUserByEmail(email);
            if (userApp!= null)
                System.out.println(userApp.getId());
        }
        System.out.println();
    }

    @Test
    public static void getAllAssetsFromDB() {
        getService().logIn("admin", MongoUtils.getPassword("admin"));
        String folder = System.getProperty("user.dir");
        String file = folder.concat(fileAgency);

        for (com.adstream.automate.babylon.JsonObjects.Agency agency: getService().getAgencies()) {
            FileManager.saveIntoFile(file, agency.getName().concat("\n"));
        }
    }

    @Test
    public static void getAllUsersAndAgencies() {
        getService().logIn("admin", MongoUtils.getPassword("admin"));
        String folder = System.getProperty("user.dir");
        String file = folder.concat(fileUsers);
        for (com.adstream.automate.babylon.JsonObjects.Agency agency: getService().getAgencies()) {
            List<User> users = getUsers(agency.getId());
            String newFile = agency.getId().concat(".age");
            String addFile = folder.concat(usersDir).concat(newFile);
            FileManager.saveIntoFile(addFile, "Agency: " + agency.getName() + "\n");
            for (User user: users) {
                FileManager.saveIntoFile(file, agency.getName().concat("#USER#").concat(user.getEmail()).concat("\n"));
                FileManager.saveIntoFile(addFile, user.getEmail().concat("\n"));

            }
        }
    }

    public static List<User> getUsers(String agencyId) {
        if (!usersMap.containsKey(agencyId)) {
            log.info("Get users from core");
            LuceneSearchingParams query = new LuceneSearchingParams()
                    .setQuery("agency._id:" + agencyId)
                    .setSortingField("_cm.common.email.untouched")
                    .setResultsOnPage(1000);
            SearchResult<User> users = getService().getWrappedService().findUsers(query, new With(false, true, false));
            log.info(String.format("Got %d users. Has more: %s", users.getResult().size(), users.hasMore()));
            usersMap.put(agencyId, users.getResult());
        }
        return usersMap.get(agencyId);
    }


}
