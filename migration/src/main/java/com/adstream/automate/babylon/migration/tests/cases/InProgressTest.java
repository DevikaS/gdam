package com.adstream.automate.babylon.migration.tests.cases;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.FilePreview;
import com.adstream.automate.babylon.JsonObjects.dictionary.DictionaryType;
import com.adstream.automate.babylon.JsonObjects.schema.AssetElementCommonSchema;
import com.adstream.automate.babylon.JsonObjects.schema.AssetElementProjectCommonSchema;
import com.adstream.automate.babylon.JsonObjects.schema.ProjectSchema;
import com.adstream.automate.babylon.JsonObjects.usagerights.*;
import com.adstream.automate.babylon.migration.actions.UsersAction;
import com.adstream.automate.babylon.migration.objects.Asset;
import com.adstream.automate.babylon.migration.objects.User;
import com.adstream.automate.babylon.migration.tests.BaseTest;
import com.adstream.automate.babylon.migration.tests.TestData;
import com.adstream.automate.babylon.migration.tests.data.MigrationDataProvider;
import com.adstream.automate.babylon.migration.utils.DictionaryUtils;
import com.adstream.automate.babylon.migration.utils.FileManager;
import com.adstream.automate.babylon.migration.utils.MongoUtils;
import com.adstream.automate.babylon.migration.utils.XMLParser;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.Gen;
import com.adstream.automate.utils.IO;
import com.mongodb.BasicDBObject;
import com.mongodb.DBCollection;
import com.mongodb.DBObject;
import org.apache.commons.codec.digest.DigestUtils;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormatter;
import org.joda.time.format.ISODateTimeFormat;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.ParseException;
import java.util.*;

import static java.util.Arrays.asList;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.isIn;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/6/14
 * Time: 1:32 PM
 */
public class InProgressTest extends BaseTest {
    private Random random = new Random(System.currentTimeMillis());
    private static int testsCount= 0;

    @Test(dataProvider = "allVideoAssets", dataProviderClass = MigrationDataProvider.class)
    public void checkClockNumber(UsersAction usersAction) {
        String password = MongoUtils.getPassword(usersAction.getCurrentUser().getEmail()).trim();
        getService().logIn(usersAction.getCurrentUser().getEmail(), password);
        String a5id = getA5Id(usersAction.getOneAssetFromXML().getAssetGUID());
        if (a5id.isEmpty())
            Assert.fail(usersAction.getOneAssetFromXML().getUniqueName() + " isn't migrated. GUID = " + usersAction.getOneAssetFromXML().getAssetGUID());
        String title = usersAction.getOneAssetFromXML().getTitle();
        Content assetApp = getService().getAsset(a5id);
        int size = assetApp.getCm().getOrCreateNode("video").size();
        assertThat("asset's name: " + title, size, greaterThan(0));
        assertThat(usersAction.getOneAssetFromXML().getUniqueName() + " has wrong. A4ID/A5ID = " + usersAction.getOneAssetFromXML().getAssetGUID() + "/" +   a5id, assetApp.getCm().getOrCreateNode("video").getString("clockNumber"), equalToIgnoringCase(usersAction.getOneAssetFromXML().getUniqueName()));
        /*for (Content assetApp: assetsApp) {
            if (assetApp.getName().equalsIgnoreCase(usersAction.getOneAssetFromXML().getTitle())) {
                assertThat("", assetApp.getCm().getOrCreateNode("video").getString("clockNumber"), equalToIgnoringCase(usersAction.getOneAssetFromXML().getUniqueName()));

            }
        }*/
    }

    @Test(dataProvider = "oneUserOneAsset", dataProviderClass = MigrationDataProvider.class)
    public void checkDuration() {
        // ToDo - вставить проверку на значение - выводя его в лог (низкий)
    }

    @Test(dataProvider = "allAudioAssets", dataProviderClass = MigrationDataProvider.class)
    public void checkClockNumberAA(UsersAction usersAction) {
        String password = MongoUtils.getPassword(usersAction.getCurrentUser().getEmail()).trim();
        getService().logIn(usersAction.getCurrentUser().getEmail(), password);
        String a5id = getA5Id(usersAction.getOneAssetFromXML().getAssetGUID());
        if (a5id.isEmpty())
            Assert.fail(usersAction.getOneAssetFromXML().getUniqueName() + " isn't migrated. GUID = " + usersAction.getOneAssetFromXML().getAssetGUID());
        String title = usersAction.getOneAssetFromXML().getTitle();
        Content assetApp = getService().getAsset(a5id);
        int size = assetApp.getCm().getOrCreateNode("audio").size();
        assertThat("asset's name: " + title, size, greaterThan(0));
        assertThat(usersAction.getOneAssetFromXML().getUniqueName() + " has wrong. A4ID/A5ID = " + usersAction.getOneAssetFromXML().getAssetGUID() + "/" +   a5id, assetApp.getCm().getOrCreateNode("audio").getString("ClockNumber"), equalToIgnoringCase(usersAction.getOneAssetFromXML().getUniqueName()));

    }

    @Test(dataProvider = "oneUserOneAsset", dataProviderClass = MigrationDataProvider.class)
    public void checkAllAssetsExist(UsersAction usersAction) {
        String password = MongoUtils.getPassword(usersAction.getCurrentUser().getEmail()).trim();
        getService().logIn(usersAction.getCurrentUser().getEmail(), password);
        String a5id = getA5Id(usersAction.getOneAssetFromXML().getAssetGUID());
        if (a5id.isEmpty())
            Assert.fail(usersAction.getOneAssetFromXML().getUniqueName() + " isn't migrated. GUID = " + usersAction.getOneAssetFromXML().getAssetGUID());
        Content assetApp = getService().getAsset(a5id);
        String info = usersAction.getOneAssetFromXML().getUniqueName() + " asset. Check existing in A5 ";
        //assertThat(info, assetApp.getName(), equalTo(usersAction.getOneAssetFromXML().getUniqueName()));
        assertThat(info, assetApp, notNullValue());
        //checkAssetMetadata(usersAction.getOneAssetFromXML(), assetApp);

    }

    @Test(dataProvider = "assetToUpload", dataProviderClass = MigrationDataProvider.class)
    public void uploadAsset(UsersAction usersAction) {
        String password = MongoUtils.getPassword(usersAction.getCurrentUser().getEmail());
        getService().logIn(usersAction.getCurrentUser().getEmail(), password);
        //Content newAsset = getService().uploadAssetEasy(usersAction.getFile(), null);
        Content newAsset = getService().uploadAsset(usersAction.getFile(), null);
        log.debug(usersAction.getCurrentUser().getEmail());
        assertThat("", newAsset.getId(), notNullValue());
        assertThat("", newAsset.getName(), equalTo(usersAction.getFile().getName()));

    }


    @Test(dataProvider = "migratedAssetForEditMetadata", dataProviderClass = MigrationDataProvider.class)
    public void editMigratedAssetMetadata(UsersAction usersAction) {
        Map<String, List<String>> advertBrand = DictionaryUtils.getAllAdvertiserAndBrandByAgency(usersAction.getCurrentUser().getAgencyName());
        List<String> advertisers = DictionaryUtils.getAdvertiserByAgency(usersAction.getCurrentUser().getAgencyName());
        String advertiser = advertisers.get(random.nextInt(advertisers.size()));
        List<String> brands = advertBrand.get(advertiser);
        String brand = brands.get(random.nextInt(brands.size()));

        getService().logIn(usersAction.getCurrentUser().getEmail(), MongoUtils.getPassword(usersAction.getCurrentUser().getEmail()));
        String collectionName = usersAction.isAdmin()?"Everything":"My Assets";
        String collectionId = getService().getAssetsFilterByName(collectionName, "").getId();
        List<Content> migratedEditAssets = getService().getAllAssetByName(collectionId, usersAction.getOneAssetFromXML().getUniqueName());
        Content meAsset = null;//migratedEditAssets.get(0);
        List<String> countries = getService().getDictionary(DictionaryType.COUNTRY).getValues().getKeys();
        List<String> screens = getService().getDictionary(DictionaryType.VIDEO_SCREEN).getValues().getKeys();
        String country = countries.get(random.nextInt(countries.size()));
        String screen = screens.get(random.nextInt(screens.size()));

        for (Content asset: migratedEditAssets) {
            if (asset.getRevisions()[0].getMaster().getSpecDbDocID().equals(usersAction.getOneAssetFromXML().getSpecDBDocID())) {
                meAsset = asset;
                break;
            }
        }
        String oldName = meAsset.getName();
        String newName = Gen.getHumanReadableString(10);
        log.info(String.format("Old name: %s, new name: %s", oldName, newName));
        String oldAdvertiser = meAsset.getAdvertiser();
        if (advertisers.size()> 1) {
            while (advertiser.equalsIgnoreCase(oldAdvertiser)) {
                advertiser = advertisers.get(random.nextInt(advertisers.size()));
            }
        }
        String oldBrand = meAsset.getBrand();
        if (oldBrand.equals(brand)) {
            brands = advertBrand.get(advertiser);
            if (brands.size() > 0) {
                while (brands.equals(oldBrand)) {
                    brand = brands.get(random.nextInt(brands.size()));
                }
            }
            else
                brand = "";
        }
        if (meAsset.getMediaType().equalsIgnoreCase("video")) {
            if (!meAsset.getMediaSubType().equalsIgnoreCase("QC-ed master")) {
                meAsset.setAdvertiser(advertiser);
                meAsset.setBrand(brand);
                meAsset.setName(newName);
            }
            else {
                advertiser = oldAdvertiser;
                brand = oldBrand;
                newName = oldName;
            }
            meAsset.getCm().getOrCreateNode("video").put("country", asList(country)); // video assets only, not audio
            meAsset.getCm().getOrCreateNode("video").put("screen", asList(screen)); // video assets only, not audio
        }
        else {
            meAsset.setAdvertiser(advertiser);
            meAsset.setBrand(brand);
            meAsset.setName(newName);
        }

        Content newEditAsset = getService().updateAsset(meAsset);
        Common.sleep(1000);
        assertThat("", newEditAsset.getAdvertiser(), equalTo(advertiser));
        assertThat("", newEditAsset.getBrand(), equalTo(brand));
        assertThat("", newEditAsset.getName(), equalTo(newName));
        if (meAsset.getMediaType().equalsIgnoreCase("video")) {
            assertThat("", newEditAsset.getCm().getOrCreateNode("video").getArrayForClass("country", String.class)[0], equalTo(country));
            assertThat("", newEditAsset.getCm().getOrCreateNode("video").getArrayForClass("screen", String.class)[0], equalTo(screen));
        }
        Common.sleep(1000);
        restoreAssetFromXML(oldName, newName, true);

        // ToDo not finished yet!
    }

    @Test(dataProvider = "usersWithAssets", dataProviderClass = MigrationDataProvider.class)
    public void checkThatUsersViewTheirAssets(UsersAction usersAction) {
        getService().logIn(usersAction.getCurrentUser().getEmail(), MongoUtils.getPassword(usersAction.getCurrentUser().getEmail()));
        //getService().logIn(usersAction.getCurrentUser().getEmail(), "1");
        String collectionId = getService().getAssetsFilterByName("My Assets", "").getId();
        for (Asset assetData: usersAction.getAssetFromXML()) {
            List<Content> assetsApp = getService().getAllAssetByName(collectionId, assetData.getUniqueName());
            boolean existInList = false;
            for (Content assetApp: assetsApp) {
                existInList = assetApp.getName().equals(assetData.getUniqueName());
                if (existInList)
                    break;

            }
            assertThat(usersAction.getCurrentUser().getEmail() + " " + assetData.getUniqueName(), existInList, equalTo(true));
            checkAssetMetadata(assetData, assetsApp);
        }
        com.adstream.automate.babylon.JsonObjects.User userApp = getService().getUserByEmail(usersAction.getCurrentUser().getEmail());
        List<Content> assetsApp = getService().getAllAssetByName(collectionId);
        for (Content assetApp: assetsApp) {
            assertThat("", assetApp.getCreatedBy().getId(), equalTo(userApp.getId()));
        }
        for (User user: usersAction.getAllAgencyUsers()) {
            userApp = getService().getUserByEmail(user.getEmail());
            if (!user.getEmail().equalsIgnoreCase(usersAction.getCurrentUser().getEmail()) && userApp!= null) {
                for (Content assetApp: assetsApp) {
                    assertThat("", assetApp.getCreatedBy().getId(), not(equalTo(userApp.getId())));
                }

            }
        }

    }

    @Test(dataProvider = "preparedFilesToUpload", dataProviderClass = MigrationDataProvider.class)
    public void checkUploadAsset(UsersAction usersAction) {
        getService().logIn(usersAction.getCurrentUser().getEmail(), usersAction.getCurrentUser().getPassword());
        Content newAsset = getService().uploadAsset(usersAction.getFile(), null);
        assertThat("", newAsset.getId(), notNullValue());
        assertThat("", newAsset.getName(), equalTo(usersAction.getFile().getName()));
    }
    @Test(dataProvider = "oneUserOneAsset", dataProviderClass = MigrationDataProvider.class)
    public void checkMasterAndProxyData(UsersAction usersAction) {
        getService().logIn(usersAction.getCurrentUser().getEmail(), usersAction.getCurrentUser().getPassword());
        Asset assetData = usersAction.getOneAssetFromXML();
        String collectionId = getService().getAssetsFilterByName("Everything", "").getId();
        boolean masterCheck = false;
        boolean previewCheck = false;
        String a5id = getA5Id(usersAction.getOneAssetFromXML().getAssetGUID());
        if (a5id.isEmpty())
            Assert.fail(usersAction.getOneAssetFromXML().getUniqueName() + " isn't migrated. GUID = " + usersAction.getOneAssetFromXML().getAssetGUID());
        Content assetApp = getService().getAsset(a5id);
        String fileID = assetApp.getRevisions()[0].getMaster().getFileID();
        masterCheck = (fileID!=null && fileID.length() > 0) || masterCheck;
        if (assetData.getAssetType().equalsIgnoreCase("video")) {
            for (FilePreview filePreview: assetApp.getRevisions()[0].getPreview()) {
                if (filePreview.getA5Type().contains("proxy")) {
                    //ToDo I need criteria for check preview.
                    String previewFileID = filePreview.getFileID();
                    previewCheck = (previewFileID!=null && previewFileID.length() >0) || previewCheck;
                }

            }
        }

        assertThat("master " + assetData.getUniqueName(), masterCheck, equalTo(true));
        if (assetData.getAssetType().equalsIgnoreCase("video")) {
            assertThat("preview " + assetData.getUniqueName(), previewCheck, equalTo(true));
        }
    }

    @Test(dataProvider = "oneUserOneAsset", dataProviderClass = MigrationDataProvider.class)
    public void checkThatAreMigratedOnlyVideoAndAudioAssets(UsersAction usersAction) {
        getService().logIn(usersAction.getCurrentUser().getEmail(), usersAction.getCurrentUser().getPassword());

        Asset assetData = usersAction.getOneAssetFromXML();
        String collectionId = getService().getAssetsFilterByName("Everything", "").getId();
        List<Content> assetsApp = getService().getAllAssetByName(collectionId, assetData.getUniqueName());
        boolean checkAsset = false;
        for (Content assetApp: assetsApp) {
            assertThat("", assetApp.getMediaType(), isIn(TestData.getPossibleMediaTypes()));
        }
    }

    @Test(dataProvider = "downloadAssets", dataProviderClass = MigrationDataProvider.class)
    public void downloadAssets(UsersAction usersAction) {
        getService().logIn(usersAction.getCurrentUser().getEmail(), MongoUtils.getPassword(usersAction.getCurrentUser().getEmail()));
        //getService().logIn(usersAction.getCurrentUser().getEmail(), "1");
        String collectionName = usersAction.isAdmin()?"Everything":"My Assets";
        String collectionId = getService().getAssetsFilterByName(collectionName, "").getId();
        Asset assetData = usersAction.getOneAssetFromXML();
        List<Content> assetsApp = getService().getAllAssetByName(collectionId, assetData.getUniqueName());
        Content assetApp = null;
        for (Content content:assetsApp) {
            if (content.getName().equals(assetData.getUniqueName())) {
                assetApp = content;
                break;
            }
        }
        String a4FileID = assetData.getFileID();
        //String a4FileID = "1d213119-1190-4a2d-ba24-a22600bb3b15";
        String fileId = assetApp.getId();
        //String fileId = "52f24cbfe4b08cb2f005ebf3";

        String fileName = Gen.getHumanReadableString(8);
        String downloadURL = getService().getDownloadUrl(fileId, a4FileID, assetData.getUniqueName());
        //Map<String, String> downloadInfo = getCore().getDownloadInfo(fileId, a4FileID, "NN-PerfecteOefeningUK-tvc-060");
        //Map<String, String> downloadInfo = getCore().getDownloadInfo(fileId, a4FileID, "NN-PerfecteOefeningUK-tvc-060");
        //assertThat("There is not any file's for asset " + assetData.getUniqueName(), downloadInfo, notNullValue());
        //assertThat("There is not any file's for asset " + assetData.getUniqueName(), downloadInfo.get("url"), notNullValue());
        //assertThat("", downloadInfo.get("documentName"), equalTo(assetData.getUniqueName()));
        String folder = System.getProperty("user.dir");
        //folder = folder.concat("\\migration\\src\\main\\resources\\files\\").concat(fileName);
        folder = folder.concat("\\").concat(fileName);
        File file = new File((folder));
        String downloadMD5 = "";

        try {
            //IO.httpsDownload(downloadInfo.get("url"), file);
            IO.httpDownload(downloadURL, file);
            FileInputStream is = new FileInputStream(file);
            downloadMD5 = DigestUtils.md5Hex(is);

        } catch (IOException e) {
            e.printStackTrace();
            Assert.fail("There are problems with download functionality");
        }
        String assetMD5 = assetApp.getRevisions()[0].getMaster().getMD5();
        assertThat("Length of downloaded file is wrong for asset " + assetData.getUniqueName(), file.length(), equalTo(assetApp.getRevisions()[0].getMaster().getFileSize()));
        assertThat("MD5 is null for " + assetData.getUniqueName(), downloadMD5, equalTo(assetMD5));

    }

    @Test
    public void tempTest() throws IOException {

        DBCollection schemaCollection = getMongoDB().getCollection("user");
        DBObject query = new BasicDBObject("_cm.common.email", "admin");
        DBObject filter = new BasicDBObject("_private.password", 1);
        DBObject obj = schemaCollection.findOne(query, filter);
        Iterator iterator = ((BasicDBObject) obj).entrySet().iterator();
        while (iterator.hasNext()) {
            Map.Entry map = (Map.Entry)iterator.next();
            if (map.getKey().toString().equalsIgnoreCase("_private")) {
                String password = map.getValue().toString().split(":")[1].replaceAll("}","").replaceAll("\"", "");
                System.out.println(password);
            }


        }
        getService().logIn("anita.lotten@jwtamsterdam.nl.ua", "1");
        String agencyId = getService().getAgencyByName("JWT Amsterdam Agency").getId();
        AssetElementProjectCommonSchema assetElementProjectCommonSchema = getService().getAssetElementProjectCommonSchema(agencyId);
        AssetElementCommonSchema assetElementCommonSchema = getService().getAssetElementCommonSchema(agencyId);
        ProjectSchema projectSchema = getService().getProjectSchema(agencyId);
        System.out.println();
        //getService().logIn("admin", "1");
        //getService().getAgencies();
        //getCore().auth("anita.lotten@jwtamsterdam.nl.ua", "1");
        //getCore().auth("anita.lotten@jwtamsterdam.nl.ua", "1");
        String collectionId = getService().getAssetsFilterByName("Everything", "").getId();
        //int dsfdf = getService().getAssetCountForCollection(collectionId);
        //Content aaa = getService().getAssetByName(collectionId, "Fish-Ad");
        //Content aaa = getService().getAssetByName(collectionId, "ETOS-NutrilonPuzzel-tag-005");
        Content aaa = getService().getAssetByName(collectionId, "SUPR-Chairs-tvc-020");
        // fileID = baf8f642-b42b-489e-8c1e-a22600bc3cbd
        //String urlo = getService().getDownloadUrl("52736fc8e4b071d973e149da", "a9ff6f73-3c1c-4908-9713-a24500a32740", "AD-KioskVrijdag-rc-015.mp3");
        String urlo = getService().getDownloadUrl("52736fd2e4b071d973e14a63", "1b35aca2-17f3-4682-b491-a22800b03ded", "AD-KioskVrijdag-rc-015.mp3");

        String folder = System.getProperty("user.dir");
        folder = folder.concat("\\migration\\src\\main\\resources\\files\\a1.pou");
        File file = new File((folder));
        try {
            IO.httpsDownload(urlo, file);
        } catch (IOException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
        //String urlo = getCore().getDownloadUrl("5267d364e4b0226294a513e9", "fd2bdb65-c3fe-440e-879b-a2600114a7df", "aaa");
        FileInputStream is = new FileInputStream(file);
        String md5 = DigestUtils.md5Hex(is);
        // d41d8cd98f00b204e9800998ecf8427e
        System.out.println();
    }


    @Test(dataProvider = "oneUserOneAsset", dataProviderClass = MigrationDataProvider.class)
    public void checkUpdateAndCreateTime(UsersAction usersAction) throws ParseException {
        String migrationDate = "2014-07-07";
        String folder = System.getProperty("user.dir");
        folder = folder.concat("\\").concat("check_date.txt");
        File file = new File((folder));
        String password = MongoUtils.getPassword(usersAction.getCurrentUser().getEmail());
        getService().logIn(usersAction.getCurrentUser().getEmail(), password);
        Asset assetData = usersAction.getOneAssetFromXML();
        log.debug(assetData.getUniqueName() + " started ... ");
        DateTimeFormatter parserApp = ISODateTimeFormat.dateTimeNoMillis();
        DateTimeFormatter parserAppModify = ISODateTimeFormat.date();
        DateTimeFormatter parserCreate = ISODateTimeFormat.dateTime();
        DateTimeFormatter parserModify = ISODateTimeFormat.dateTime();
        log.debug(assetData.getUniqueName());
        parserCreate = ISODateTimeFormat.dateTimeNoMillis();
        parserModify = ISODateTimeFormat.date();
        DateTime createData = parserCreate.parseDateTime(removeMSec(assetData.getCreated()));
        DateTime modifyData = parserModify.parseDateTime(removeTime(assetData.getLastUpdated()));
        DateTime createApp = null;
        Date modifyApp = null;
        String a5id = getA5Id(usersAction.getOneAssetFromXML().getAssetGUID());
        if (a5id.isEmpty())
            Assert.fail(usersAction.getOneAssetFromXML().getUniqueName() + " isn't migrated. GUID = " + usersAction.getOneAssetFromXML().getAssetGUID());
        Content assetApp = getService().getAsset(a5id);
        String mofifyAppStr = "";
        try {
            createApp = parserApp.parseDateTime(removeMSec(assetApp.getCreated().toString()));
            modifyApp = parserAppModify.parseDateTime(removeTime(assetApp.getModified().toString())).toDate();
            mofifyAppStr = removeTime(assetApp.getModified().toString());
        }
        catch (Throwable t) {
            t.printStackTrace();
            FileManager.saveIntoFile(file.getName(), "A4GUID = " + assetData.getAssetGUID() + " clock_number = " +  assetData.getUniqueName() + " a5ID = " + a5id + " exception was throwed\n", true);
            Assert.fail();
        }
        String info = "|" + usersAction.getOneAssetFromXML().getAssetGUID()+ "|" + assetData.getUniqueName() + "|" + createApp + "|" + createData + "|\n";
        FileManager.saveIntoFile(file.getName(), info, true);
        assertThat(String.format("Create date from XML: %s. Create date from APP: %s \n Asset name %s", createData, createApp, assetData.getUniqueName()), createData, equalTo(createApp));
        assertThat("", mofifyAppStr, equalTo(migrationDate));
        // assertThat(String.format("Modify date from XML: %s. Modify date from APP: %s \n Asset name %s", modifyData, modifyApp, assetData.getUniqueName()), modifyData, equalTo(modifyApp));
    }

    @Test(dataProvider = "allAudioAssets", dataProviderClass = MigrationDataProvider.class)
    public void ttt(UsersAction usersAction) {
        String password = MongoUtils.getPassword(usersAction.getCurrentUser().getEmail()).trim();
        getService().logIn(usersAction.getCurrentUser().getEmail(), password);
        String a5id = getA5Id(usersAction.getOneAssetFromXML().getAssetGUID());
        if (a5id.isEmpty())
            Assert.fail(usersAction.getOneAssetFromXML().getUniqueName() + " isn't migrated. GUID = " + usersAction.getOneAssetFromXML().getAssetGUID());
        Content content = getService().getAsset(a5id);
        String folder = System.getProperty("user.dir");
        folder = folder.concat("\\").concat("audio_spec.info");
        File file = new File((folder));
        String spec = content.getRevisions()[0].getMaster().getMetadata().get("formatGeneral").toString();
        FileManager.saveIntoFile(file.getName(), spec + "\n");


    }


    @Test(dataProvider = "allVideoAssets", dataProviderClass = MigrationDataProvider.class)
    public void checkMediaSubType(UsersAction usersAction) {
        getService().logIn(usersAction.getCurrentUser().getEmail(), MongoUtils.getPassword(usersAction.getCurrentUser().getEmail()));
        Asset assetData = usersAction.getOneAssetFromXML();
        String mediaSubType = "";
        boolean compareSubType = false;
        String a5id = getA5Id(usersAction.getOneAssetFromXML().getAssetGUID());
        if (a5id.isEmpty())
            Assert.fail(usersAction.getOneAssetFromXML().getUniqueName() + " isn't migrated. GUID = " + usersAction.getOneAssetFromXML().getAssetGUID());
        Content assetApp = getService().getAsset(a5id);

        //List<Content> assetsApp = getService().getAllAssetByName(collectionId, "NN-PerfecteOefeningUK-tvc-060");
        if (assetData.getLifecycleID().equals("2")) {
            mediaSubType = "Generic Master";
        }

        if (assetData.getLifecycleID().equals("3")) {
            mediaSubType = "QC-ed master";

        }
        compareSubType = assetApp.getMediaSubType().equalsIgnoreCase(mediaSubType);
        assertThat("assetData: " + assetData.getUniqueName(), compareSubType, equalTo(true));

    }

    @Test(dataProvider = "allAudioAssets", dataProviderClass = MigrationDataProvider.class)
    public void checkMediaSubTypeOfAudioAssets(UsersAction usersAction) {
        getService().logIn(usersAction.getCurrentUser().getEmail(), MongoUtils.getPassword(usersAction.getCurrentUser().getEmail()));
        //getService().logIn(usersAction.getCurrentUser().getEmail(), "1");
        String collectionId = getService().getAssetsFilterByName("Everything", "").getId();
        Asset assetData = usersAction.getOneAssetFromXML();
        String mediaSubType = "";
        boolean compareSubType = false;
        String a5id = getA5Id(usersAction.getOneAssetFromXML().getAssetGUID());
        if (a5id.isEmpty())
            Assert.fail(usersAction.getOneAssetFromXML().getUniqueName() + " isn't migrated. GUID = " + usersAction.getOneAssetFromXML().getAssetGUID());
        Content assetApp = getService().getAsset(a5id);
        assertThat("assetData: " + assetData.getUniqueName(), assetApp.getMediaSubType(), equalTo("QC-ed master"));
    }

    @Test
    public void checkAssetsCount() {
        Asset[]  assetData = XMLParser.getNewDataSet().getAsset();
        int assetCount= 0;
        for (Asset asset: assetData) {
            if (!asset.getAgencyGUID().equalsIgnoreCase("d5c14ff8-8d86-47c2-9e95-f0e5cc983d98")) continue;
            if (asset.getAssetTypeID().equals(999)) {
                continue;
            }
            if (asset.getAssetType() == null) {
                continue;
            }
            if (asset.getAssetType().equalsIgnoreCase("audio")) {
                assetCount++;
            }
            else {
                if (asset.getAssetType()!= null && asset.getAssetType().equalsIgnoreCase("video")) {
                    assetCount++;
                }
            }
        }
        log.info(assetCount);
        System.out.println();
    }


    @Test(dataProvider = "oneUserOneAsset", dataProviderClass = MigrationDataProvider.class)



    private void restoreAssetFromXML(String assetName, String newAssetName, boolean isAdmin) {
        String collectionName = isAdmin ? "Everything":"My Assets";
        String collectionId = getService().getAssetsFilterByName(collectionName, "").getId();
        for (Asset asset: XMLParser.getNewDataSet().getAsset()) {
            if (asset.getUniqueName().equalsIgnoreCase(assetName)) {
                List<Content> assetsApp = getService().getAllAssetByName(collectionId, newAssetName);
                for (Content assetApp: assetsApp) {
                    if (assetApp.getName().equalsIgnoreCase(newAssetName)) {
                        assetApp.setAdvertiser(asset.getAdvertiser());
                        assetApp.setBrand(asset.getProduct());
                        assetApp.setName(asset.getUniqueName());
                        getService().updateAsset(assetApp);
                    }
                }
            }
        }
    }

    private void checkAssetMetadata(Asset assetData, List<Content> listOfAssetApp) {
        boolean agencyName = false;
        boolean advertiser = false;
        boolean product = false;
        boolean assetType = false;

        for (Content assetApp: listOfAssetApp) {
            advertiser = (assetApp.getAdvertiser().equals(assetData.getAdvertiser()) || advertiser);
            agencyName = (assetApp.getAgency().getName().equals(assetData.getAgencyName()) || agencyName);
            product = (assetApp.getBrand().equals(assetData.getProduct()) || product);
            assetType = (assetApp.getMediaType().equalsIgnoreCase(assetData.getAssetType()) || assetType);
        }
        assertThat("", advertiser, equalTo(true));
        assertThat("", agencyName, equalTo(true));
        assertThat("", product, equalTo(true));
        assertThat("Media type for asset " + assetData.getUniqueName(), assetType, equalTo(true));
    }

    private String removeMSec(String date) {
        if (!date.contains("."))
            return date;
        int point = date.indexOf(".");
        int plus = date.indexOf("+");
        String result = date.substring(0, point);
        if (plus>0)
            result = result.concat(date.substring(plus));
        else
            result = result.concat("+00:00");
        return result;
    }

    private String removeTime(String date) {
        String temp = removeMSec(date);
        return temp.substring(0, temp.indexOf("T"));
    }


}
