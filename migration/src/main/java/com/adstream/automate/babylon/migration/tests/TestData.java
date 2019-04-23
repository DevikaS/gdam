package com.adstream.automate.babylon.migration.tests;

import com.adstream.automate.babylon.JsonObjects.dictionary.DictionaryItem;
import com.adstream.automate.babylon.JsonObjects.dictionary.DictionaryType;
import com.adstream.automate.babylon.JsonObjects.usagerights.CountriesUsageRight;
import com.adstream.automate.babylon.JsonObjects.usagerights.UsageCountry;
import com.adstream.automate.babylon.migration.actions.CreateFolder;
import com.adstream.automate.babylon.migration.actions.CreateProject;
import com.adstream.automate.babylon.migration.actions.UsersAction;
import com.adstream.automate.babylon.migration.objects.Agency;
import com.adstream.automate.babylon.migration.objects.Asset;
import com.adstream.automate.babylon.migration.objects.User;
import com.adstream.automate.babylon.migration.utils.DictionaryUtils;
import com.adstream.automate.babylon.migration.utils.MongoUtils;
import com.adstream.automate.babylon.migration.utils.XMLParser;
import com.adstream.automate.utils.Gen;

import java.io.File;
import java.util.*;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/10/13
 * Time: 8:18 AM

 */
public class TestData {
    private Random random = new Random(System.currentTimeMillis());
    private ArrayList<User> administrators;
    private ArrayList<User> agencyUsers;
    private ArrayList<User> agencyUsersWithAssets;
    private static final String[] possibleMediaTypes = {"audio", "video"};
    private ArrayList<Agency> allAgencies;
    private ArrayList<String> allAgenciesGUID;


    public ArrayList getUsersFromXML() {
        ArrayList result = new ArrayList();
        for (User user: XMLParser.getNewDataSet().getUser()) {
            result.add(new Object[] {user});
        }
        return result;
    }

    public ArrayList getUsersFromAgencyID(String agencyID) {
        ArrayList result = new ArrayList();
        for (User user: XMLParser.getNewDataSet().getUser()) {
            if (user.getAgencyGUID().equalsIgnoreCase(agencyID))
                result.add(new Object[] {user});
        }
        return result;
    }

    public ArrayList getAllUsersWithDefineInTheXMLAgencyID() {
        ArrayList result = new ArrayList();
        for (Agency agency: XMLParser.getNewDataSet().getAgency()) {
            result.addAll(getUsersFromAgencyID(agency.getAgencyGUID()));
        }
        return result;
    }

    public ArrayList getAllUsersWithDefineInTheXMLAgency() {
        ArrayList result = new ArrayList();
        for (Agency agency: XMLParser.getNewDataSet().getAgency()) {
            result.addAll(getUsersFromAgency(agency.getAgencyName()));
        }
        return result;
    }

    public ArrayList getUsersFromAgency(String agencyName) {
        ArrayList result = new ArrayList();
        for (User user: XMLParser.getNewDataSet().getUser()) {
            if (user.getAgencyName().equalsIgnoreCase(agencyName))
                result.add(new Object[] {user});
        }
        return result;
    }



    public ArrayList getRandomlyUsers(int count, ArrayList<User> list) {
        ArrayList result = new ArrayList();
        ArrayList allUsers;
        if (list == null) {
            allUsers = getUsersFromXML();
        }
        else {
            allUsers = list;
        }
        count = Math.min(count, allUsers.size());
        for (int i=0; i<count; i++) {
            random.setSeed(System.currentTimeMillis() + 10000*i);
            result.add(allUsers.remove(random.nextInt(allUsers.size())));
        }
        return result;
    }

    public ArrayList getRandomlyAssets(int count, ArrayList<Asset> list) {
        ArrayList result = new ArrayList();
        ArrayList<Asset> allAssets;
        ArrayList<Asset> videoAssets;
        ArrayList<Asset> audioAssets;
        if (list == null) {
            allAssets = getOnlyAssets();
        }
        else {
            allAssets = list;
        }
        count = Math.min(count, allAssets.size());
        int videoCount= 0;
        int audioCount= 0;
        User adminUser = (User)getRandomlyUsers(1, getAdministrators()).get(0);
        videoAssets = getAssetByUserAndType(adminUser, "video");
        audioAssets = getAssetByUserAndType(adminUser, "audio");
        videoCount = Math.min(count, videoAssets.size());
        audioCount = Math.min(count, audioAssets.size());
        for (int i=0; i<videoCount; i++) {
            UsersAction usersAction = new UsersAction();
            random.setSeed(System.currentTimeMillis() + 10000*i);
            usersAction.setCurrentUser(adminUser);
            Asset a = videoAssets.remove(random.nextInt(videoAssets.size()));
            usersAction.setOneAssetFromXML(a);
            result.add(new Object[] {usersAction});
        }
        for (int i=0; i< audioCount; i++) {
            UsersAction usersAction = new UsersAction();
            random.setSeed(System.currentTimeMillis() + 10000*i);
            usersAction.setCurrentUser(adminUser);
            Asset a = audioAssets.remove(random.nextInt(audioAssets.size()));
            usersAction.setOneAssetFromXML(a);
            result.add(new Object[] {usersAction});
        }

        result.addAll(getAgencyUsersWithAssetsForUserActivity());
        return result;
    }

    public ArrayList getProjectAdminActivity(int count) {
        ArrayList result = new ArrayList();
        UsersAction usersAction = new UsersAction();
        usersAction.setCurrentUser((User)getRandomlyUsers(1, getAdministrators()).get(0));
        for (int i=0; i<count; i++) {
            CreateProject createProject = new CreateProject();
            usersAction.addProject(createProject.getProject());
        }
        result.add(new Object[] {usersAction});
        return result;
    }

    public ArrayList getProjectAdminActivity(int count, String agencyName) {
        ArrayList result = new ArrayList();
        UsersAction usersAction = new UsersAction();
        usersAction.setCurrentUser(XMLParser.getFirstDeptAdminFromCurrentXML());
        //List<String> advertisers = DictionaryUtils.getAdvertiserByAgency(agencyName);
        for (int i=0; i<count; i++) {
            //String advertiser = advertisers.get(random.nextInt(advertisers.size()));
            CreateProject createProject = new CreateProject();
            //createProject.setAdvertiser(advertiser);
            usersAction.addProject(createProject.getProject());
        }
        result.add(new Object[] {usersAction});
        return result;

    }

    public ArrayList getProjectNonAdminActivity(int count) {
        ArrayList result = new ArrayList();
        UsersAction usersAction = new UsersAction();
        count = Math.min(count, getAgencyUsers().size());
        ArrayList user_list = getRandomlyUsers(count, getAgencyUsers());
        int i = 0;
        while (user_list.iterator().hasNext()) {
            usersAction.setCurrentUser((User)user_list.get(i));
            CreateProject createProject = new CreateProject();
            usersAction.addProject(createProject.getProject());
            if (i++ == count-1) {break;};
        }
        result.add(new Object[] {usersAction});
        return result;
    }


    public ArrayList getFolderAdminActivity() {
        ArrayList result = new ArrayList();
        UsersAction usersAction = new UsersAction();
        usersAction.setCurrentUser((User)getRandomlyUsers(1, getAdministrators()).get(0));
        CreateProject createProject = new CreateProject();
        usersAction.setProject(createProject.getProject());
        CreateFolder createFolder = new CreateFolder();
        usersAction.setFolderName(Gen.getHumanReadableString(6));
        result.add(new Object[] {usersAction});
        return result;
    }

    public ArrayList getUploadFileActivity() {
        ArrayList result = new ArrayList();
        UsersAction usersAction = new UsersAction();
        usersAction.setCurrentUser((User)getRandomlyUsers(1, getAdministrators()).get(0));
        CreateProject createProject = new CreateProject();
        usersAction.setProject(createProject.getProject());
        CreateFolder createFolder = new CreateFolder();
        usersAction.setFolderName(Gen.getHumanReadableString(6));
        usersAction.setFile();
        result.add(new Object[] {usersAction});
        return result;

    }

    //
    public ArrayList<User> getUserByEmail(String email) {
        ArrayList<User> newList = new ArrayList<User>();
        for (User user: XMLParser.getNewDataSet().getUser()) {
            if (user.getEmail().equalsIgnoreCase(email)) {
                newList.add(user);
            }
        }
        return newList;
    }

    public ArrayList<User> getAdministrators() {
        if (administrators == null) {
            administrators = new ArrayList<User>();
            for (User user: XMLParser.getNewDataSet().getUser()) {
                if (user.getUserTypeID().equals("4") && user.isDeptAdmin() && getAllAgenciesGUID().contains(user.getAgencyGUID()))
                    administrators.add(user);
            }

        }
        return administrators;
    }

    public ArrayList<User> getAgencyUsers() {
        if (agencyUsers == null) {
            agencyUsers = new ArrayList<User>();
            for (User user: XMLParser.getNewDataSet().getUser()) {
                if (user.getUserTypeID().equals("4") && !user.isDeptAdmin() &&  getAllAgenciesGUID().contains(user.getAgencyGUID()))
                    agencyUsers.add(user);
            }
        }
        return agencyUsers;
    }

    public ArrayList<User> getAgencyUsersWithAssets() {
        if (agencyUsersWithAssets == null) {
            Map<User, List<Asset>> map = XMLParser.getUsersAssets();
            agencyUsersWithAssets = new ArrayList<User>();
            for (User user: XMLParser.getNewDataSet().getUser()) {
                if (user.getUserTypeID().equals("4") && !user.isDeptAdmin() && user.getAgencyName().length() > 0) {
                    if (map.containsKey(user)) {
                        List<Asset> list = map.get(user);
                        if (list.size() > 0) {
                            agencyUsersWithAssets.add(user);
                        }
                    }
                }
            }
        }
        return agencyUsersWithAssets;
    }

    public ArrayList<Agency> getAllAgencies() {
        if (allAgencies == null) {
            allAgencies = new ArrayList<Agency>();
            for (Agency agency: XMLParser.getNewDataSet().getAgency()) {
                allAgencies.add(agency);
            }
        }
        return allAgencies;
    }

    public ArrayList<String> getAllAgenciesGUID() {
        if (allAgenciesGUID == null) {
            allAgenciesGUID = new ArrayList<String>();
            for (Agency agency: getAllAgencies()) {
                allAgenciesGUID.add(agency.getAgencyGUID());
            }
        }
        return allAgenciesGUID;
    }

    public ArrayList getAllAssets() {
        ArrayList result = new ArrayList();
        UsersAction usersAction = new UsersAction();
        usersAction.setCurrentUser((User)getRandomlyUsers(1, getAdministrators()).get(0));
        for (Asset asset: XMLParser.getNewDataSet().getAsset()) {
            usersAction.addAssetFromXML(asset);
        }
        result.add(new Object[] {usersAction});
        return result;
    }

    // Method prepares date one admin user - one asset, for all assets in the agency of this user.
    public ArrayList getUsersAndAssets() {
        ArrayList result = new ArrayList();
        User loggedUserAdmin = XMLParser.getFirstDeptAdminFromCurrentXML();
        for (Asset asset: XMLParser.getNewDataSet().getAsset()) {
            boolean ingested = (asset.getAssetTypeID().equals("3") && asset.getSubAssetTypeID().equals("1") && !asset.getStatusID().equals("5"));
            //if (asset.getAgencyGUID().equalsIgnoreCase(loggedUserAdmin.getAgencyGUID()) && (Integer.parseInt(asset.getLifecycleID()) > 1) && !ingested) {
            if ((Integer.parseInt(asset.getLifecycleID()) > 1) && !ingested) {
                UsersAction usersAction = new UsersAction();
                usersAction.setCurrentUser(loggedUserAdmin);
                usersAction.setOneAssetFromXML(asset);
                result.add(new Object[] {usersAction});
            }
        }
        return result;
    }

    public ArrayList getWIPAssets() {
        ArrayList result = new ArrayList();
        User loggedUserAdmin = XMLParser.getFirstDeptAdminFromCurrentXML();
        for (Asset asset: XMLParser.getNewDataSet().getAsset()) {
            boolean ingested = (asset.getAssetTypeID().equals("3") && asset.getSubAssetTypeID().equals("1") && !asset.getStatusID().equals("5"));
            if (asset.getAgencyGUID().equalsIgnoreCase(loggedUserAdmin.getAgencyGUID()) && (Integer.parseInt(asset.getLifecycleID()) == 1) && !ingested) {
                UsersAction usersAction = new UsersAction();
                usersAction.setCurrentUser(loggedUserAdmin);
                usersAction.setOneAssetFromXML(asset);
                result.add(new Object[] {usersAction});
            }
        }
        return result;
    }

    public ArrayList getUsersAndAssetsWithSpecs() {
        ArrayList result = new ArrayList();
        User loggedUserAdmin = XMLParser.getFirstDeptAdminFromCurrentXML();
        for (Asset asset: XMLParser.getNewDataSet().getAsset()) {
            if (Integer.parseInt(asset.getLifecycleID()) > 1) {
                UsersAction usersAction = new UsersAction();
                usersAction.setCurrentUser(loggedUserAdmin);
                usersAction.setOneAssetFromXML(asset);
                result.add(new Object[] {usersAction});
            }
        }
        return result;
    }



    public ArrayList getAllAssetsFromAgency() {
        return null;
    }

    public ArrayList getDataForUploadAsset() {
        ArrayList result = new ArrayList();
        User loggedUserAdmin = XMLParser.getFirstDeptAdminFromCurrentXML();
        String folder = System.getProperty("user.dir");
        folder = folder.concat("\\migration\\src\\main\\resources\\files\\");
        File dir = new File(folder);
        File[] files = UsersAction.getAllFilesFromDir(dir);
        for (File file: files) {
            if (file.isDirectory()) continue;
            UsersAction usersAction = new UsersAction();
            usersAction.setCurrentUser(loggedUserAdmin);
            usersAction.setFile(file);
            result.add(new Object[] {usersAction});
        }
        return result;
    }

    public ArrayList getPreparedFileForUpload() {
        ArrayList result = new ArrayList();
        User loggedUserAdmin = (User)getRandomlyUsers(1, getAdministrators()).get(0);
        String folder = System.getProperty("user.dir");
        folder = folder.concat("\\migration\\src\\main\\resources\\files\\");
        File dir = new File(folder);
        File[] files = UsersAction.getAllFilesFromDir(dir);
        for (File file: files) {
            CreateProject createProject = new CreateProject();
            UsersAction usersAction = new UsersAction();
            usersAction.setCurrentUser(loggedUserAdmin);
            usersAction.addProject(createProject.getProject());
            CreateFolder createFolder = new CreateFolder();
            usersAction.setFolderName(Gen.getHumanReadableString(6));
            usersAction.setFile(file);
            result.add(new Object[] {usersAction});
        }
        return result;
    }

    public ArrayList getPreparedFileForUpload(String agencyName) {
        ArrayList result = new ArrayList();
        User loggedUserAdmin = XMLParser.getFirstDeptAdminFromCurrentXML();
        List<String> advertisers = DictionaryUtils.getAdvertiserByAgency(agencyName);

        String folder = System.getProperty("user.dir");
        folder = folder.concat("\\migration\\src\\main\\resources\\files\\");
        File dir = new File(folder);
        File[] files = UsersAction.getAllFilesFromDir(dir);
        for (File file: files) {
            if (file.isDirectory()) continue;
            CreateProject createProject = new CreateProject();
            UsersAction usersAction = new UsersAction();
            usersAction.setCurrentUser(loggedUserAdmin);
            //createProject.setAdvertiser(advertisers.get(random.nextInt(advertisers.size())));
            usersAction.addProject(createProject.getProject());
            CreateFolder createFolder = new CreateFolder();
            usersAction.setFolderName(Gen.getHumanReadableString(6));
            usersAction.setFile(file);
            result.add(new Object[] {usersAction});
        }
        return result;
    }


    public ArrayList getPreparedRevisionForUpload() {
        ArrayList result = new ArrayList();
        User loggedUserAdmin = (User)getRandomlyUsers(1, getAdministrators()).get(0);
        User loggedUserAgencyUser = (User)getRandomlyUsers(1, getAgencyUsers()).get(0);
        String folder = System.getProperty("user.dir");
        folder = folder.concat("\\migration\\src\\main\\resources\\files\\");
        File dir = new File(folder);
        File[] files = UsersAction.getAllFilesFromDir(dir);
        for (File file: files) {
            CreateProject createProject = new CreateProject();
            UsersAction usersAction = new UsersAction();
            usersAction.setCurrentUser(loggedUserAdmin);
            usersAction.addProject(createProject.getProject());
            CreateFolder createFolder = new CreateFolder();
            usersAction.setFolderName(Gen.getHumanReadableString(6));
            usersAction.setFile(file);
            result.add(new Object[] {usersAction});
        }
        for (File file: files) {
            CreateProject createProject = new CreateProject();
            UsersAction usersAction = new UsersAction();
            usersAction.setCurrentUser(loggedUserAgencyUser);
            usersAction.addProject(createProject.getProject());
            CreateFolder createFolder = new CreateFolder();
            usersAction.setFolderName(Gen.getHumanReadableString(6));
            usersAction.setFile(file);
            result.add(new Object[] {usersAction});
        }

        return result;
    }

    public ArrayList getVideoAssetsFromAgency() {
        ArrayList result = new ArrayList();
        User loggedUserAdmin = XMLParser.getFirstDeptAdminFromCurrentXML();
        for (Asset asset: XMLParser.getNewDataSet().getAsset()) {
            boolean ingested = (asset.getAssetTypeID().equals("3") && asset.getSubAssetTypeID().equals("1") && !asset.getStatusID().equals("5"));
            //if (asset.getAgencyGUID().equalsIgnoreCase(loggedUserAdmin.getAgencyGUID()) && !ingested && (Integer.parseInt(asset.getLifecycleID()) > 1)) {
            if (!ingested && (Integer.parseInt(asset.getLifecycleID()) > 1)) {
                if (asset.getAssetType()!= null && asset.getAssetType().equalsIgnoreCase("video")) {
                    UsersAction usersAction = new UsersAction();
                    usersAction.setCurrentUser(loggedUserAdmin);
                    usersAction.setOneAssetFromXML(asset);
                    result.add(new Object[] {usersAction});
                }
            }
        }

        return result;
    }

    public ArrayList getAudioAssetsFromAgency() {
        ArrayList result = new ArrayList();
        User loggedUserAdmin = XMLParser.getFirstDeptAdminFromCurrentXML();
        for (Asset asset: XMLParser.getNewDataSet().getAsset()) {
            if (asset.getAgencyGUID().equalsIgnoreCase(loggedUserAdmin.getAgencyGUID())) {
                if (asset.getAssetType()!= null && asset.getAssetType().equalsIgnoreCase("audio") && Integer.parseInt(asset.getLifecycleID())> 1) {
                    UsersAction usersAction = new UsersAction();
                    usersAction.setCurrentUser(loggedUserAdmin);
                    usersAction.setOneAssetFromXML(asset);
                    result.add(new Object[] {usersAction});
                }
            }
        }

        return result;
    }

    public ArrayList getDataForCheckAssetForChoosenUser() {
        ArrayList result = new ArrayList();
        ArrayList<User> usersWithAssets = new ArrayList<User>();
        ArrayList<User> allUsers = new ArrayList<User>();
        for (User user : XMLParser.getNewDataSet().getUser()) {
            //if (user.getUserTypeID().equalsIgnoreCase("4")) {
            allUsers.add(user);
            //}
        }
        Map<User, List<Asset>> map = XMLParser.getUsersAssets();
        for (Map.Entry<User, List<Asset>> userListEntry : map.entrySet()) {
            Map.Entry usersAssets = (Map.Entry) userListEntry;
            if (((ArrayList<Asset>) usersAssets.getValue()).size() > 0)
                usersWithAssets.add((User) usersAssets.getKey());
        }
        for (User user: usersWithAssets) {
            UsersAction usersAction = new UsersAction();
            usersAction.setCurrentUser(user);
            usersAction.setAssetFromXML(map.get(user));
            usersAction.setAllAgencyUsers(allUsers);
            result.add(new Object[] {usersAction});

        }
        return result;
    }

    // Prepare data for test usage rights permission
    public ArrayList getDataForUsageRights() {
        ArrayList result = getDataForCheckAssetForChoosenUser();
        Map<User, List<Asset>> map = XMLParser.getUsersAssets();
        ArrayList<Asset> list = getOnlyAssets();
        BaseTest.getService().logIn("admin", MongoUtils.getPassword("admin"));
        List<String> countries = BaseTest.getService().getDictionary(DictionaryType.COUNTRY).getValues().getKeys();
        for (Object object: result) {
            Object[] objArray = (Object[])object;
            UsersAction usersAction = (UsersAction)objArray[0];
            CountriesUsageRight countriesUsageRight = new CountriesUsageRight();
            List<Asset> lalala = map.get(usersAction.getCurrentUser());
            UsageCountry usageCountry = new UsageCountry();
            usageCountry.setUsageCountry(new String[] {countries.get(random.nextInt(countries.size()))});
            countriesUsageRight.setCountries(usageCountry);
            usersAction.addUsageRight(countriesUsageRight);
            Asset randomAsset = lalala.remove(random.nextInt(lalala.size()));
            usersAction.setOneAssetFromXML(randomAsset);

        }
        return result;
    }

    public static String[] getPossibleMediaTypes() {
        return possibleMediaTypes;
    }

    public ArrayList getAgencyUsersWithAssetsForUserActivity() {
        ArrayList result = new ArrayList();
        ArrayList<User> userNotAdminWithAsset = new ArrayList<User>();
        Map<User, List<Asset>> map = XMLParser.getUsersAssets();
        Iterator iteratorA = map.entrySet().iterator();
        while (iteratorA.hasNext()) {
            Map.Entry entry = (Map.Entry)iteratorA.next();
            User user = (User)entry.getKey();
            if (!user.isDeptAdmin()) {
                userNotAdminWithAsset.add(user);
            }
        }
        if (userNotAdminWithAsset.size() == 0)
            return new ArrayList();
        User loggedAgencyUser = userNotAdminWithAsset.get(random.nextInt(userNotAdminWithAsset.size()));
        List<Asset> videoAssets = getAssetByUserAndType(loggedAgencyUser, "video");
        List<Asset> audioAssets = getAssetByUserAndType(loggedAgencyUser, "audio");
        UsersAction usersAction = new UsersAction();
        if (videoAssets.size() > 0) {
            usersAction.setCurrentUser(loggedAgencyUser);
            usersAction.setOneAssetFromXML(videoAssets.get(random.nextInt(videoAssets.size())));
            usersAction.setAdmin(false);
            result.add(new Object[] {usersAction});
        }
        if (audioAssets.size() > 0) {
            usersAction = new UsersAction();
            usersAction.setCurrentUser(loggedAgencyUser);
            usersAction.setOneAssetFromXML(audioAssets.get(random.nextInt(audioAssets.size())));
            usersAction.setAdmin(false);
            result.add(new Object[] {usersAction});
        }
        return result;
    }

    public ArrayList<Asset> getAssetByUserAndType(User user, String assetType) {
        ArrayList<Asset> result = new ArrayList<Asset>();
        List<Asset> assets = XMLParser.getUsersAssets().get(user);
        for (Asset asset: assets) {
            if (asset.getMetadataTable().equalsIgnoreCase(assetType)) {
                result.add(asset);
            }
        }
        return result;
    }


    public ArrayList getUploadRevision() {
        ArrayList result = new ArrayList();
        UsersAction usersAction = new UsersAction();
        User loggedUserAdmin = (User)getRandomlyUsers(1, getAdministrators()).get(0);
        usersAction.setCurrentUser(loggedUserAdmin);
        usersAction.setFile();
        result.add(new Object[] {usersAction});

        return result;
    }

    public ArrayList getDataForDownloadTests() {
        ArrayList result = new ArrayList();
        User loggedUserAdmin = XMLParser.getFirstDeptAdminFromCurrentXML();
        for (Asset asset: XMLParser.getNewDataSet().getAsset()) {
            if (asset.getAgencyGUID().equalsIgnoreCase(loggedUserAdmin.getAgencyGUID()) && asset.getUniqueName().equals("NN-PerfecteOefeningUK-tvc-060")) {
                UsersAction usersAction = new UsersAction();
                usersAction.setCurrentUser(loggedUserAdmin);
                //Asset asset = findAssetByName(assetName);
                usersAction.setOneAssetFromXML(asset);
                result.add(new Object[] {usersAction});

            }
        }

        return result;
    }

    public ArrayList getAllAgencyFromXML() {
        ArrayList result = new ArrayList();
        for (Agency agency: XMLParser.getNewDataSet().getAgency()) {
            result.add(new Object[] {agency});
        }
        return result;
    }

    private ArrayList<Asset> getOnlyAssets() {
        ArrayList<Asset> result = new ArrayList<Asset>();
        for (Asset asset: XMLParser.getNewDataSet().getAsset()) {
            result.add(asset);
        }
        return result;
    }

    private Asset findAssetByName(String name) {
        for (Asset asset: XMLParser.getNewDataSet().getAsset()) {
            if (asset.getUniqueName().equals(name))
                return asset;
        }
        return null;
    }


}
