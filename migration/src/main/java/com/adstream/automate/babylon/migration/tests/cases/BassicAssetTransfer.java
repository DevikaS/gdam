package com.adstream.automate.babylon.migration.tests.cases;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.JsonObjects.OdtElement;
import com.adstream.automate.babylon.JsonObjects.dictionary.DictionaryType;
import com.adstream.automate.babylon.JsonObjects.schema.AssetElementCommonSchema;
import com.adstream.automate.babylon.JsonObjects.schema.AssetElementProjectCommonSchema;
import com.adstream.automate.babylon.JsonObjects.schema.ProjectSchema;
import com.adstream.automate.babylon.JsonObjects.usagerights.*;
import com.adstream.automate.babylon.migration.actions.UsersAction;
import com.adstream.automate.babylon.migration.objects.*;
import com.adstream.automate.babylon.migration.objects.Asset;
import com.adstream.automate.babylon.migration.tests.BaseTest;
import com.adstream.automate.babylon.migration.tests.BaseTestGroups;
import com.adstream.automate.babylon.migration.tests.TestData;
import com.adstream.automate.babylon.migration.tests.data.AssetType;
import com.adstream.automate.babylon.migration.tests.data.MigrationDataProvider;
import com.adstream.automate.babylon.migration.tests.data.TestBugInfo;
import com.adstream.automate.babylon.migration.utils.*;
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

import javax.xml.bind.JAXB;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.ParseException;
import java.util.*;

import static org.hamcrest.MatcherAssert.*;
import static org.hamcrest.Matchers.*;
import static java.util.Arrays.asList;
/**
 * Created with IntelliJ IDEA.
 * User: User
 * Date: 11.10.13
 * Time: 16:50

 */
public class BassicAssetTransfer extends BaseTestGroups {

    private static List<AssetInfo> assetInfoList = new ArrayList<>();
    private static int countOfExamples;
    private static int countOfOdtA5;
    private static int countOfOdtXML;



    public static void main(String[] args) {
        BassicAssetTransfer bassicAssetTransfer = new BassicAssetTransfer();
        List<Asset> list = bassicAssetTransfer.getRelations("32544541-1cfb-4a03-b9ed-e0bc22b7cb66");
        System.out.println();
    }

    @Test(dataProvider = "oneUserOneAsset", dataProviderClass = MigrationDataProvider.class, groups = "UCTime", priority = 1)
    public void checkUpdateAndCreateTime(UsersAction usersAction) throws ParseException {
        TestBugInfo testBugInfo = new TestBugInfo();
        try {
            String migrationDate = "2015-04-24";
            //String folder = System.getProperty("user.dir");
            //folder = folder.concat("\\").concat("check_date.txt");
            //File file = new File((folder));
            getService().logIn(otherAgencyEmail, otherAgencyPassword);
            Asset assetData = usersAction.getOneAssetFromXML();
            DateTimeFormatter parserApp = ISODateTimeFormat.dateTimeNoMillis();
            DateTimeFormatter parserCreate = ISODateTimeFormat.dateTime();
            log.debug(assetData.getUniqueName());
            parserCreate = ISODateTimeFormat.dateTimeNoMillis();
            DateTime createData = parserCreate.parseDateTime(removeMSec(assetData.getCreated()));
            DateTime createApp = null;
            testBugInfo.setA4Id(usersAction.getOneAssetFromXML().getAssetGUID());
            testBugInfo.setUniqueName(usersAction.getOneAssetFromXML().getUniqueName());
            String a5id = getA5Id(usersAction.getOneAssetFromXML().getAssetGUID());
            if (a5id.isEmpty()) {
                testBugInfo.setBug(true);
                testBugInfo.addReason("Current asset hasn't get a5id");
                Assert.fail(usersAction.getOneAssetFromXML().getUniqueName() + " isn't migrated. GUID = " + usersAction.getOneAssetFromXML().getAssetGUID());
            }
            testBugInfo.setA5Id(a5id);
            Content assetApp = getService().getAsset(a5id);
            if (assetApp == null) {
                testBugInfo.setBug(true);
                testBugInfo.addReason("Asset with a5id = " + a5id + " hasn't get object asset. Response from core is empty");
            }
            String modifyAppStr = "";
            try {
                createApp = parserApp.parseDateTime(removeMSec(assetApp.getCreated().toString()));
                modifyAppStr = removeTime(assetApp.getModified().toString());
            }
            catch (Throwable t) {
                t.printStackTrace();
                testBugInfo.setBug(true);
                testBugInfo.addReason("Exception was threw when data from application was parsed. Data values create: " + assetApp.getCreated().toString() + " modified: " + assetApp.getModified().toString());
                //FileManager.saveIntoFile(file.getName(), "A4GUID = " + assetData.getAssetGUID() + " clock_number = " +  assetData.getUniqueName() + " a5ID = " + a5id + " exception was throwed\n", true);
                FileManager.saveIntoFile(reportFileName.toString(), "A4GUID = " + assetData.getAssetGUID() + " clock_number = " +  assetData.getUniqueName() + " a5ID = " + a5id + " exception was throwed\n", true);
                Assert.fail();
            }
            String info = "|" + usersAction.getOneAssetFromXML().getAssetGUID()+ "|" + assetData.getUniqueName() + "|" + createApp + "|" + createData + "|\n";
            //FileManager.saveIntoFile(file.getName(), info, true);
//            FileManager.saveIntoFile(reportFileName.toString(), info, true);
            try {
                assertThat(String.format("Create date from XML: %s. Create date from APP: %s \n Asset name %s", createData, createApp, assetData.getUniqueName()), createData, equalTo(createApp));
            } catch (AssertionError ar) {
                testBugInfo.setBug(true);
                testBugInfo.addReason(String.format("Create date from XML: %s. Create date from APP: %s. Asset name %s", createData, createApp, assetData.getUniqueName()));
                Assert.fail(String.format("Create date from XML: %s. Create date from APP: %s \n Asset name %s", createData, createApp, assetData.getUniqueName()));
            }
            try {
                assertThat("", modifyAppStr, equalTo(migrationDate));
            } catch (AssertionError ar) {
                testBugInfo.setBug(true);
                testBugInfo.addReason("Modification date from app: " + modifyAppStr + " but this date must be " + migrationDate);
                Assert.fail("Modification date from app: " + modifyAppStr + " but this date must be " + migrationDate);
            }


        } finally {
            resultOfTestsGroup.add(testBugInfo);
        }
    }

    @Test(dataProvider = "allVideoAssets", dataProviderClass = MigrationDataProvider.class, groups = "g1")
    public void checkVideoInformation(UsersAction usersAction) {
        TestBugInfo testBugInfo = new TestBugInfo();
        try {
            countOfExamples= (new TestData()).getVideoAssetsFromAgency().size();
//            String password = MongoUtils.getPassword(usersAction.getCurrentUser().getEmail()).trim();
            //getService().logIn(usersAction.getCurrentUser().getEmail(), password);
            getService().logIn(otherAgencyEmail, otherAgencyPassword);
            String a5id = getA5Id(usersAction.getOneAssetFromXML().getAssetGUID());
            if (a5id.isEmpty())
                Assert.fail(usersAction.getOneAssetFromXML().getUniqueName() + " isn't migrated. GUID = " + usersAction.getOneAssetFromXML().getAssetGUID());
            String title = usersAction.getOneAssetFromXML().getTitle();
            Content content = getService().getAsset(a5id);
            testBugInfo.setA4Id(usersAction.getOneAssetFromXML().getAssetGUID());
            testBugInfo.setUniqueName(usersAction.getOneAssetFromXML().getUniqueName());
            testBugInfo.setA5Id(a5id);
            //List<Content> assetsApp = getService().getAllAssetByName(collectionId, usersAction.getOneAssetFromXML().getUniqueName());

            Video assetDataVideo = getVideoByAGUID(usersAction.getOneAssetFromXML().getAssetGUID());
            Asset assetData = usersAction.getOneAssetFromXML();
            String folder = System.getProperty("user.dir");
            folder = folder.concat("\\").concat("md_size.info");
            String folder1 = folder.concat("\\").concat("md_size_error.info");
            String folder3 = folder.concat("\\").concat("md_full_log.info");
            File file = new File((folder));
            File file1 = new File((folder1));
            File file3 = new File((folder3));
            String infoHeader = usersAction.getOneAssetFromXML().getUniqueName() + "/\\ " + usersAction.getOneAssetFromXML().getAssetGUID() + ":\n";
            String info = "";
            AssetInfo assetInfo = new AssetInfo();
            List<String> listOfCommonFields = getAllCommonFieldsDefaultScheme(assetData);
            List<String> listOfA4Fields = getVideoAndAudioFieldsDefaultScheme(assetData);
            boolean commonSizeSaved = false;
            boolean videoSizeSaved = false;
            HashMap<String, String> wrongValues = new HashMap<>();
            for (String sectionKey: content.getCm().keySet()) {
                assetInfo.setAssetName(assetData.getTitle());
                assetInfo.setWrongValues(wrongValues);
                if (sectionKey.equalsIgnoreCase("common")) {
                    if (listOfCommonFields.size() != content.getCm().getOrCreateNode(sectionKey).size() && !commonSizeSaved) {
                        FileManager.saveIntoFile(file1.getName(), usersAction.getOneAssetFromXML().getUniqueName() + "/\\ " + usersAction.getOneAssetFromXML().getAssetGUID() + "COMMON SIZE!: waited/current" + listOfCommonFields.size() + "/" + content.getCm().getOrCreateNode(sectionKey).size() + "\n");
                        testBugInfo.addReason("It's waited count of common fields (in the XML) " + listOfCommonFields.size() + " but in the common section of A5 count of fields is: " + content.getCm().getOrCreateNode(sectionKey).size());
                        testBugInfo.setBug(true);
                        commonSizeSaved = true;
                    }
                    List<String> commonFields = new ArrayList<>();
                    assetInfo.setCommonEmptyFields(commonFields);
                    for (String field: listOfCommonFields) {
                        if (!content.getCm().getOrCreateNode(sectionKey).containsKey(field)) {
                            commonFields.add(field);
                        }
                        else {
                            String value = "";


                            if (content.getCm().getOrCreateNode(sectionKey).get(field) instanceof String)
                                value = String.valueOf(content.getCm().getOrCreateNode(sectionKey).get(field));
                            else if (content.getCm().getOrCreateNode(sectionKey).get(field) instanceof ArrayList)
                                value = content.getCm().getOrCreateNode(sectionKey).getStringArray(field)[0];
                            String valueData = getFieldsValue(assetData, field, false);
                            if (!value.equalsIgnoreCase(valueData)) {
                                wrongValues.put(field, "waited " + valueData + " is " + value);
                                testBugInfo.addReason("Field: '" + field + "' in the XML has value " + valueData + " but in the A5 has value: " + value);
                                testBugInfo.setBug(true);
                            }
                            info +=  "field: " + field + " value: " + value + "\n";
                        }
                    }

                }

                if (sectionKey.equalsIgnoreCase("video")) {
                    List<String> videoEmptyFields = new ArrayList<>();
                    assetInfo.setVideoEmptyFields(videoEmptyFields);
                    if (listOfA4Fields.size() != content.getCm().getOrCreateNode(sectionKey).size() && !videoSizeSaved) {
                        FileManager.saveIntoFile(file1.getName(), usersAction.getOneAssetFromXML().getUniqueName() + "/\\ " + usersAction.getOneAssetFromXML().getAssetGUID() + "VIDEO SIZE!: waited/current" + listOfCommonFields.size() + "/" + content.getCm().getOrCreateNode(sectionKey).size() + "\n");
                        testBugInfo.addReason("It's waited count of video fields (in the XML) " + listOfA4Fields.size() + " but in the video section of A5 count of fields is: " + content.getCm().getOrCreateNode(sectionKey).size());
                        testBugInfo.setBug(true);
                        videoSizeSaved = true;
                    }
                    //FileManager.saveIntoFile(file1.getName(), assetData.getUniqueName() + " A4/A5 = [" + listOfA4Fields.size() + "/" + content.getCm().getOrCreateNode(sectionKey).size() + "]\n");
                    for (String field: listOfA4Fields) {
                        if (!content.getCm().getOrCreateNode(sectionKey).containsKey(field)) {
                            FileManager.saveIntoFile(file1.getName(), usersAction.getOneAssetFromXML().getUniqueName() + "/\\ " + usersAction.getOneAssetFromXML().getAssetGUID() + " isn't contains " + field + " in the XML this value is: " + getFieldsValue(assetData, field, false) + "\n");
                            videoEmptyFields.add(field);
                        }
                        else {
                            if (field.equalsIgnoreCase("Producer")) {
                                continue;
                            }
                            String value = "";
                            if (content.getCm().getOrCreateNode(sectionKey).get(field) instanceof String)
                                value = String.valueOf(content.getCm().getOrCreateNode(sectionKey).get(field));
                            else if (content.getCm().getOrCreateNode(sectionKey).get(field) instanceof ArrayList)
                                value = content.getCm().getOrCreateNode(sectionKey).getStringArray(field)[0];
                            String valueData = getFieldsValue(assetData, field, false);
                            if (!value.equalsIgnoreCase(valueData))
                                if (!field.equalsIgnoreCase("airDate") && !field.equalsIgnoreCase("duration"))
                                    wrongValues.put(field, "waited " + valueData + " is " + value);
                            if (field.equalsIgnoreCase("airDate")) {

                                DateTimeFormatter parserApp = ISODateTimeFormat.dateTimeNoMillis();
                                DateTime firstAirApp = parserApp.parseDateTime(removeMSec(value));
                                DateTime firstAirDate = parserApp.parseDateTime(removeMSec(valueData));
                                if (firstAirApp.compareTo(firstAirDate)!= 0)
                                    wrongValues.put(field, "waited " + valueData + " is " + value);

                            }

                            info +=  "field: " + field + " value: " + value + "\n";
                        }

                    }
                }

            }
            FileManager.saveIntoFile(file3.getName(), infoHeader + info);
            FileManager.saveIntoFile(file3.getName(), "---------------------------------------------------\n");
            assetInfoList.add(assetInfo);

            if (assetInfoList.size() == countOfExamples) {
                String folder2 = folder.concat("\\").concat("md_result_error.info");
                File file2 = new File((folder2));
                for (AssetInfo assetInfo1: assetInfoList) {
                    FileManager.saveIntoFile(file2.getName(), assetInfo1.getAssetName() + "\n");
                    if (assetInfo1.getCommonEmptyFields()!= null) {
                        for (String common: assetInfo1.getCommonEmptyFields()) {
                            FileManager.saveIntoFile(file2.getName(), "Common field: " + common + "\n");
                        }

                    }
                    if (assetInfo1.getVideoEmptyFields()!= null) {
                        for (String video: assetInfo1.getVideoEmptyFields()) {
                            FileManager.saveIntoFile(file2.getName(), "Video field: " + video + "\n");
                        }
                    }
                    if (assetInfo1.getWrongValues()!= null) {
                        for (Map.Entry<String, String> map: assetInfo1.getWrongValues().entrySet()) {
                            FileManager.saveIntoFile(file2.getName(), map.getKey() + "-->" + map.getValue() + "\n");
                        }
                    }
                }
            }
        }finally {
            resultOfTestsGroup.add(testBugInfo);
        }
    }

    @Test(dataProvider = "allAudioAssets", dataProviderClass = MigrationDataProvider.class)
    public void checkAudioInformation(UsersAction usersAction) {
        //asset.getCm().getOrCreateNode("video").getString("clockNumber")
        countOfExamples= (new TestData()).getAudioAssetsFromAgency().size();
        String password = MongoUtils.getPassword(usersAction.getCurrentUser().getEmail()).trim();
        //String password = "1";
        getService().logIn(otherAgencyEmail, otherAgencyPassword);
        String a5id = getA5Id(usersAction.getOneAssetFromXML().getAssetGUID());
        if (a5id.isEmpty())
            Assert.fail(usersAction.getOneAssetFromXML().getUniqueName() + " isn't migrated. GUID = " + usersAction.getOneAssetFromXML().getAssetGUID());
        String title = usersAction.getOneAssetFromXML().getTitle();
        Content content = getService().getAsset(a5id);

        //List<Content> assetsApp = getService().getAllAssetByName(collectionId, usersAction.getOneAssetFromXML().getUniqueName());

        Audio assetDataVideo = getAudioByAGUID(usersAction.getOneAssetFromXML().getAssetGUID());
        Asset assetData = usersAction.getOneAssetFromXML();
        String folder = System.getProperty("user.dir");
        folder = folder.concat("\\").concat("md_size.info");
        String folder1 = folder.concat("\\").concat("md_size_error.info");
        String folder3 = folder.concat("\\").concat("md_full_log.info");
        File file = new File((folder));
        File file1 = new File((folder1));
        File file3 = new File((folder3));
        String folder2 = folder.concat("\\").concat("md_result_error.info");
        File file2 = new File((folder2));

        String infoHeader = usersAction.getOneAssetFromXML().getUniqueName() + "/\\ " + usersAction.getOneAssetFromXML().getAssetGUID() + ":\n";
        String info = "";
        AssetInfo assetInfo = new AssetInfo();
        List<String> listOfCommonFields = getAllCommonFieldsDefaultScheme(assetData);
        List<String> listOfA4Fields = getVideoAndAudioFieldsDefaultScheme(assetData);
        boolean commonSizeSaved = false;
        boolean videoSizeSaved = false;
        for (String sectionKey: content.getCm().keySet()) {
            assetInfo.setAssetName(assetData.getTitle());
            HashMap<String, String> wrongValues = new HashMap<>();
            assetInfo.setWrongValues(wrongValues);
            if (sectionKey.equalsIgnoreCase("common")) {
                if (listOfCommonFields.size() != content.getCm().getOrCreateNode(sectionKey).size() && !commonSizeSaved) {
                    if (listOfCommonFields.size() > content.getCm().getOrCreateNode(sectionKey).size()) {
                        FileManager.saveIntoFile(file1.getName(), usersAction.getOneAssetFromXML().getUniqueName() + "/\\ " + usersAction.getOneAssetFromXML().getAssetGUID() + "COMMON SIZE!: waited/current" + listOfCommonFields.size() + "/" + content.getCm().getOrCreateNode(sectionKey).size() + "\n");
                        commonSizeSaved = true;
                    }
                }
                List<String> commonFields = new ArrayList<>();
                assetInfo.setCommonEmptyFields(commonFields);
                for (String field: listOfCommonFields) {
                    if (!content.getCm().getOrCreateNode(sectionKey).containsKey(field)) {
                        commonFields.add(field);
                    }
                    else {
                        String value = "";
                        if (content.getCm().getOrCreateNode(sectionKey).get(field) instanceof String)
                            value = String.valueOf(content.getCm().getOrCreateNode(sectionKey).get(field));
                        else if (content.getCm().getOrCreateNode(sectionKey).get(field) instanceof ArrayList)
                            value = content.getCm().getOrCreateNode(sectionKey).getStringArray(field)[0];
                        String valueData = getFieldsValue(assetData, field, false);
                        if (!value.equalsIgnoreCase(valueData))
                            if (!field.equalsIgnoreCase("airDate") && !field.equalsIgnoreCase("duration"))
                                //wrongValues.put(field, "waited " + valueData + " is " + value);
                                FileManager.saveIntoFile(file2.getName(), "Asset  " + usersAction.getOneAssetFromXML().getUniqueName() + " field: " + field  + " --> value " +  "waited " + valueData + " is " + value + "\n");

                        info +=  "field: " + field + " value: " + value + "\n";

                    }
                }

            }

            if (sectionKey.equalsIgnoreCase("audio")) {
                List<String> videoEmptyFields = new ArrayList<>();
                assetInfo.setVideoEmptyFields(videoEmptyFields);
                if (listOfA4Fields.size() != content.getCm().getOrCreateNode(sectionKey).size() && !videoSizeSaved) {
                    if (listOfA4Fields.size() > content.getCm().getOrCreateNode(sectionKey).size()) {
                        FileManager.saveIntoFile(file1.getName(), usersAction.getOneAssetFromXML().getUniqueName() + "/\\ " + usersAction.getOneAssetFromXML().getAssetGUID() + "VIDEO SIZE!: waited/current" + listOfA4Fields.size() + "/" + content.getCm().getOrCreateNode(sectionKey).size() + "\n");
                        videoSizeSaved = true;
                    }
                }
                //FileManager.saveIntoFile(file1.getName(), assetData.getUniqueName() + " A4/A5 = [" + listOfA4Fields.size() + "/" + content.getCm().getOrCreateNode(sectionKey).size() + "]\n");
                for (String field: listOfA4Fields) {
                    if (!content.getCm().getOrCreateNode(sectionKey).containsKey(field)) {
                        FileManager.saveIntoFile(file1.getName(), usersAction.getOneAssetFromXML().getUniqueName() + "/\\ " + usersAction.getOneAssetFromXML().getAssetGUID() + " isn't contains " + field + " in the XML this value is: " + getFieldsValue(assetData, field, true) + "\n");
                        videoEmptyFields.add(field);
                    }
                    else {
                        String value = "";
                        if (content.getCm().getOrCreateNode(sectionKey).get(field) instanceof String)
                            value = String.valueOf(content.getCm().getOrCreateNode(sectionKey).get(field));
                        else if (content.getCm().getOrCreateNode(sectionKey).get(field) instanceof ArrayList)
                            value = content.getCm().getOrCreateNode(sectionKey).getStringArray(field)[0];
                        else if (content.getCm().getOrCreateNode(sectionKey).get(field) instanceof String[])
                            value = content.getCm().getOrCreateNode(sectionKey).getStringArray("Producer")[0];
                        String valueData = getFieldsValue(assetData, field, true);
                        if (!value.equalsIgnoreCase(valueData))
                            if (!field.equalsIgnoreCase("airDate") && !field.equalsIgnoreCase("duration"))
                                //wrongValues.put(field, "waited " + valueData + " is " + value);
                                FileManager.saveIntoFile(file2.getName(), "Asset  " + usersAction.getOneAssetFromXML().getUniqueName() + " field: " + field  + " --> value " +  "waited " + valueData + " is " + value + "\n");
                        if (field.equalsIgnoreCase("airDate")) {

                            DateTimeFormatter parserApp = ISODateTimeFormat.dateTimeNoMillis();
                            DateTime firstAirApp = parserApp.parseDateTime(removeMSec(value));
                            DateTime firstAirDate = parserApp.parseDateTime(removeMSec(valueData));
                            if (firstAirApp.compareTo(firstAirDate)!= 0)
                                wrongValues.put(field, "waited " + valueData + " is " + value);

                        }

                        info +=  "field: " + field + " value: " + value + "\n";
                    }

                }
            }

        }
        FileManager.saveIntoFile(file3.getName(), infoHeader + info);
        FileManager.saveIntoFile(file3.getName(), "---------------------------------------------------\n");
        assetInfoList.add(assetInfo);

        /*if (assetInfoList.size() == countOfExamples) {
            for (AssetInfo assetInfo1: assetInfoList) {
                FileManager.saveIntoFile(file2.getName(), assetInfo1.getAssetName() + "\n");
                if (assetInfo1.getCommonEmptyFields()!= null) {
                    for (String common: assetInfo1.getCommonEmptyFields()) {
                        FileManager.saveIntoFile(file2.getName(), "Common field: " + common + "\n");
                    }

                }
                if (assetInfo1.getVideoEmptyFields()!= null) {
                    for (String video: assetInfo1.getVideoEmptyFields()) {
                        FileManager.saveIntoFile(file2.getName(), "Video field: " + video + "\n");
                    }
                }
                if (assetInfo1.getWrongValues()!= null) {
                    for (Map.Entry<String, String> map: assetInfo1.getWrongValues().entrySet()) {
                        FileManager.saveIntoFile(file2.getName(), map.getKey() + "-->" + map.getValue() + "\n");
                    }
                }
            }
        } */
    }

    @Test(dataProvider = "oneUserOneAsset", dataProviderClass = MigrationDataProvider.class)
    public void checkPreview(UsersAction usersAction) {
        String folder = System.getProperty("user.dir");
        getService().logIn(otherAgencyEmail, otherAgencyPassword);
        //getService().logIn(otherAgencyEmail, otherAgencyPassword);
        Asset assetData = usersAction.getOneAssetFromXML();
        String a5id = getA5Id(usersAction.getOneAssetFromXML().getAssetGUID());
        if (a5id.isEmpty())
            Assert.fail(usersAction.getOneAssetFromXML().getUniqueName() + " isn't migrated. GUID = " + usersAction.getOneAssetFromXML().getAssetGUID());
        Content assetApp = getService().getAsset(a5id);
        List<ProxyAsset> proxyAssetList = getProxyAssets(assetData.getAssetGUID());
        String folder1 = folder.concat("\\").concat("proxy_size_error.info");
        File file1 = new File((folder1));
        if (assetApp.getRevisions()[0].getPreview().size()< proxyAssetList.size()) {
            //FileManager.saveIntoFile(file1.getName(), "Asset: has wrong count of preview elements. A4 GUID " + assetData.getAssetGUID() + "\nclockNumber:" + assetData.getUniqueName() + "\n A5 ID" + assetApp.getId() + "\n");
            FileManager.saveIntoFile(file1.getName(), "Asset: has wrong count of preview elements. ClockNumber:" + assetData.getUniqueName() + "\n");
            FileManager.saveIntoFile(file1.getName(), "XML count / A5 count " + proxyAssetList.size() + " / " + assetApp.getRevisions()[0].getPreview().size() +"\n");
            FileManager.saveIntoFile(file1.getName(), "--------------------------------------------------------------------\n");
            return;
        }
//        assertThat("", assetApp.getRevisions()[0].getPreview().size(), equalTo(proxyAssetList.size()));
        assertThat("", assetApp.getRevisions()[0].getPreview().size(), greaterThanOrEqualTo(proxyAssetList.size()));
        folder = folder.concat("\\").concat("proxy_empty_fileID.info");
        File file = new File((folder));
        String folder2 = folder.concat("\\").concat("proxy_data_error.info");
        File file2 = new File((folder2));


        for (ProxyAsset proxyAsset: proxyAssetList) {
            if (proxyAsset.getFileId()==null) {
                FileManager.saveIntoFile(file.getName(), "Asset: " + proxyAsset.getAssetGUID() + "hasn't fileID in the XML\n");
            }
            else {
                String fileId = proxyAsset.getFileId();
                List<ProxyAsset> list = getAllAssetsWithFileId(proxyAssetList, fileId);
                if (list.size()> 1) {
                    System.out.println("A4Guid has " + list.size() + " proxies in the XML");


                }
                for (FilePreview filePreview: assetApp.getRevisions()[0].getPreview()) {
                    if (filePreview.getFileID().equals(fileId)) {
                        boolean specDocDBWasFounded = false;
                        if (list.size() > 1) {
                            if (!filePreview.getSpecDbDocID().equals(proxyAsset.getSpecDBDocID())) {
                                continue;
                            }
                            else {
                                specDocDBWasFounded= true;
                            }
                        }
                        else
                            specDocDBWasFounded= true;
                        assertThat("", specDocDBWasFounded, equalTo(true));
                        try {
                            if (filePreview.getA5Type().equalsIgnoreCase("thumbnail")) {
                                //System.out.println();
                            }
                            assertThat("", proxyAsset.getFileName(), equalTo(filePreview.getName()));
                            /*if (proxyAsset.getFileSize() != null)
                                assertThat("", proxyAsset.getFileSize(), equalTo(String.valueOf(filePreview.getFileSize())));
                            else
                                assertThat("", "0", equalTo(String.valueOf(filePreview.getFileSize())));
                                */
                            if (proxyAsset.getSpecDBDocID()!= null && !proxyAsset.getSpecDBDocID().isEmpty()) {
                                if (proxyAsset.getSpecDBDocID().contains("streaming")) {
                                    System.out.println(proxyAsset.getSpecDBDocID());
                                }
                                assertThat("", proxyAsset.getSpecDBDocID(), equalTo(filePreview.getSpecDbDocID()));

                            }
                        }
                        catch (AssertionError ae) {
                            FileManager.saveIntoFile(file1.getName(), "Asset: has wrong data in the preview elements. A4 GUID " + assetData.getAssetGUID() + "\nclockNumber:" + assetData.getUniqueName() + "\n A5 ID" + assetApp.getId() + "\n");
                            FileManager.saveIntoFile(file1.getName(), "proxyAsset.getFileSize() / filePreview.getFileSize() " + proxyAsset.getFileSize() + " / " + filePreview.getFileSize() +"\n");
                            FileManager.saveIntoFile(file1.getName(), "proxyAsset.getFileName() / filePreview.getFileName() " + proxyAsset.getFileName() + " / " + filePreview.getName() +"\n");
                            FileManager.saveIntoFile(file1.getName(), "proxyAsset.getSpecDBDocID() / filePreview.getSpecDBDocID() " + proxyAsset.getSpecDBDocID() + " / " + filePreview.getSpecDbDocID() +"\n");
                            FileManager.saveIntoFile(file1.getName(), "FileID = " + fileId + "\n");
                            FileManager.saveIntoFile(file1.getName(), "--------------------------------------------------------------------\n");

                        }
                    }
                }
            }
        }
    }


    @Test
    public void checkUsageRights() {
        getService().logIn("traffic.nl@adstream.com", "Adstream");
        String folder = System.getProperty("user.dir");
        folder = folder.concat("\\").concat("temp.xml");
        String folderInfo = folder.concat("\\").concat("mr_XML_info.info");
        String folderError = folder.concat("\\").concat("mr_errors.info");
        File file = new File(folder);
        File fileInfo = new File(folderInfo);
        File fileError = new File(folderError);

        for (Asset assetData: XMLParser.getNewDataSet().getAsset()) {
            if (assetData.getAssetXML()!= null && (!assetData.getAssetXML().isEmpty())) {
                String infoHeader = "A4 GUID = " + assetData.getAssetGUID() + " ClockNumber = " + assetData.getUniqueName() + "\n";
                String a5Id = getA5Id(assetData.getAssetGUID());
                Content assetApp = getService().getAsset(a5Id);
                String assetXML = assetData.getAssetXML();
                FileManager.saveIntoFile(file.getName(), assetXML, false);
                AssetInner assetInner = JAXB.unmarshal(file, AssetInner.class);
                BaseUsageRight baseUsageRight = getService().getUsageRight(assetApp.getId());
                if (assetInner.getMusicRightsFieldsList()==null) {
                    try {
                        assertThat("", baseUsageRight.getUsages().length, equalTo(0));
                        continue;
                    }catch (AssertionError ae) {
                        FileManager.saveIntoFile(fileError.getName(), infoHeader + "Hasn't music fields, but length of UR in the A5: " + a5Id + " is " + baseUsageRight.getUsages().length);
                        continue;
                    }

                }
                try {
                    assertThat("", baseUsageRight.getUsages().length, equalTo(assetInner.getMusicRightsFieldsList().get(0).getMusicRightsFields().size())); // for JWT all AssetXML has 1 or 0 MusicRightsFieldsList
                }catch (AssertionError ae) {
                    FileManager.saveIntoFile(fileError.getName(), infoHeader + "Waited that count of UR would be: " + baseUsageRight.getUsages().length + " but count of UR is: " + assetInner.getMusicRightsFieldsList().get(0).getMusicRightsFields().size());
                    continue;
                }
                FileManager.saveIntoFile(fileInfo.getName(), infoHeader);
                try {
                    for (MusicRightsFieldsList musicRightsFieldsList: assetInner.getMusicRightsFieldsList()) {
                        for (MusicRightsFields musicRightsFields: musicRightsFieldsList.getMusicRightsFields()) {
                            boolean isUsageRights= false;
                            for (int i=0; i< baseUsageRight.getUsages().length; i++) {
                                if (musicRightsFields.getTitle().equals(baseUsageRight.getUsages()[i].getOrCreateNode("Music").getString("trackTitle"))) {
                                    isUsageRights= true;
                                    try {
                                        if (baseUsageRight.getUsages()[0].getOrCreateNode("Music").getString("publicationPublisher")!= null)
                                            assertThat("", baseUsageRight.getUsages()[0].getOrCreateNode("Music").getString("publicationPublisher"), equalTo(musicRightsFields.getPublisher()));
                                        if (baseUsageRight.getUsages()[0].getOrCreateNode("Music").getString("composer")!= null)
                                            assertThat("", baseUsageRight.getUsages()[0].getOrCreateNode("Music").getString("composer"), equalTo(musicRightsFields.getComposer()));
                                        if (baseUsageRight.getUsages()[0].getOrCreateNode("Music").getString("recordLabel")!= null)
                                            assertThat("", baseUsageRight.getUsages()[0].getOrCreateNode("Music").getString("recordLabel"), equalTo(musicRightsFields.getRecordCompany()));
                                        if (baseUsageRight.getUsages()[0].getOrCreateNode("Music").getString("artist")!= null)
                                            assertThat("", baseUsageRight.getUsages()[0].getOrCreateNode("Music").getString("artist"), equalTo(musicRightsFields.getArtist()));
                                        if (baseUsageRight.getUsages()[0].getOrCreateNode("Music").getString("ISRCNumber")!= null)
                                            assertThat("", baseUsageRight.getUsages()[0].getOrCreateNode("Music").getString("ISRCNumber"), equalTo(musicRightsFields.getCatalogueNumber()));

                                    }catch (Throwable t) {
                                        FileManager.saveIntoFile(fileError.getName(), infoHeader + "Field 'publicationPublisher': A5 -> A4 " + baseUsageRight.getUsages()[0].getOrCreateNode("Music").getString("publicationPublisher") + " -> " + musicRightsFields.getPublisher()+ "\n");
                                        FileManager.saveIntoFile(fileError.getName(), "Field 'composer': A5 -> A4 " + baseUsageRight.getUsages()[0].getOrCreateNode("Music").getString("composer") + " -> " + musicRightsFields.getComposer()+ "\n");
                                        FileManager.saveIntoFile(fileError.getName(), "Field 'recordLabel': A5 -> A4 " + baseUsageRight.getUsages()[0].getOrCreateNode("Music").getString("recordLabel") + " -> " + musicRightsFields.getRecordCompany()+ "\n");
                                        FileManager.saveIntoFile(fileError.getName(), "Field 'artist': A5 -> A4 " + baseUsageRight.getUsages()[0].getOrCreateNode("Music").getString("artist") + " -> " + musicRightsFields.getArtist()+ "\n");
                                        FileManager.saveIntoFile(fileError.getName(), "Field 'ISRCNumber': A5 -> A4 " + baseUsageRight.getUsages()[0].getOrCreateNode("Music").getString("ISRCNumber") + " -> " + musicRightsFields.getCatalogueNumber()+ "\n");
                                    }
                                }
                            }
                            if (!isUsageRights) {
                                FileManager.saveIntoFile(fileError.getName(), infoHeader + "Hasn't title from A4\n");
                            }

                            FileManager.saveIntoFile(fileInfo.getName(), "Title: " + musicRightsFields.getTitle() + "\n");
                            FileManager.saveIntoFile(fileInfo.getName(), "Artist: " + musicRightsFields.getArtist() + "\n");
                            FileManager.saveIntoFile(fileInfo.getName(), "CatalogueNumber: " + musicRightsFields.getCatalogueNumber() + "\n");
                            FileManager.saveIntoFile(fileInfo.getName(), "Composer: " + musicRightsFields.getComposer() + "\n");
                            FileManager.saveIntoFile(fileInfo.getName(), "IDNumber: " + musicRightsFields.getiDNumber() + "\n");
                            FileManager.saveIntoFile(fileInfo.getName(), "Publisher: " + musicRightsFields.getPublisher() + "\n");
                            FileManager.saveIntoFile(fileInfo.getName(), "RecordCompany: " + musicRightsFields.getRecordCompany() + "\n");
                            FileManager.saveIntoFile(fileInfo.getName(), "***************** NEW musicRightsFields ***********************\n");
                        }
                        FileManager.saveIntoFile(fileInfo.getName(), "@@@@@@@@@@@@@@@@@@@@@ NEW musicRightsFieldsList @@@@@@@@@@@@@@@@@@@@@\n");
                    }
                }catch (Throwable t) {
                    FileManager.saveIntoFile(fileInfo.getName(), "Exception");
                }
                FileManager.saveIntoFile(fileInfo.getName(), "-------------------------------------------------------------------\n");
            }
        }
    }

    @Test(dataProvider = "allVideoAssets", dataProviderClass = MigrationDataProvider.class)
    public void checkStoryBoard(UsersAction usersAction) {
        String folder = System.getProperty("user.dir");
        folder = folder.concat("\\").concat("check_date.txt");
        File file = new File((folder));
        String password = MongoUtils.getPassword(usersAction.getCurrentUser().getEmail());
        getService().logIn(usersAction.getCurrentUser().getEmail(), password);
        Asset assetData = usersAction.getOneAssetFromXML();
        log.debug(assetData.getUniqueName() + " started ... ");
        String a5id = getA5Id(usersAction.getOneAssetFromXML().getAssetGUID());
        //List<ProxyAsset> proxyAssetList = getProxyAssets(assetData.getAssetGUID());
        if (a5id.isEmpty())
            Assert.fail(usersAction.getOneAssetFromXML().getUniqueName() + " isn't migrated. GUID = " + assetData.getAssetGUID());
        Content assetApp = getService().getAsset(a5id);
        if (assetApp.getRevisions()[0].getPreview().size()==0)
            Assert.fail();
        assertThat("Asset: A4GUID = " + assetData.getAssetGUID() + " has other count of storyboard elements" , getCountElementsByA5Type(assetApp, "storyboard"), equalTo(8));
        List<ProxyAsset> proxyAssetList = getProxyAssets(assetData.getAssetGUID());
        assertThat("Asset: A4GUID = " + assetData.getAssetGUID() + " has other count of storyboard elements" , getCountElementsByA5Type(assetApp, "thumbnail"), equalTo(1));
        for (ProxyAsset proxyAsset: proxyAssetList) {
            if (proxyAsset.getAssetTypeID().equals("2") && proxyAsset.getSubAssetTypeID().equals("1") && proxyAsset.getSortOrder().equals("2"))
                assertThat("Asset: A4GUID = " + assetData.getAssetGUID() + " has other count of storyboard elements" , getCountElementsByA5Type(assetApp, "thumbnail"), equalTo(1));
            /*else
                assertThat("Asset: A4GUID = " + assetData.getAssetGUID() + " has other count of storyboard elements" , getCountElementsByA5Type(assetApp, "thumbnail"), equalTo(0));
                */
        }
    }

    @Test(dataProvider = "oneUserOneAsset", dataProviderClass = MigrationDataProvider.class, groups = "UCTime")
    public void checkOriginators(UsersAction usersAction) {
        String password = MongoUtils.getPassword(usersAction.getCurrentUser().getEmail());
        getService().logIn(usersAction.getCurrentUser().getEmail(), password);
        Asset assetData = usersAction.getOneAssetFromXML();
        String a5id = getA5Id(usersAction.getOneAssetFromXML().getAssetGUID());
        if (a5id.isEmpty()) {
            Assert.fail(usersAction.getOneAssetFromXML().getUniqueName() + " isn't migrated. GUID = " + usersAction.getOneAssetFromXML().getAssetGUID());
        }
        Content assetApp = getService().getAsset(a5id);
        if (assetApp == null) {
            Assert.fail(usersAction.getOneAssetFromXML().getUniqueName() + " for this asset a5id has incorect define. GUID = " + usersAction.getOneAssetFromXML().getAssetGUID());
        }
        if (assetData.getAgencyName()!=null && !assetData.getAgencyName().isEmpty()) {
            assertThat("", assetApp.getOriginator().getName(), equalTo(assetData.getAgencyName()));
        }
        else {
            System.out.println();
        }
    }

    @Test(dataProvider = "allAudioAssets", dataProviderClass = MigrationDataProvider.class)
    public void checkAudioWithoutCM(UsersAction usersAction) {
        String password = MongoUtils.getPassword(usersAction.getCurrentUser().getEmail()).trim();
        //String password = "1";
        getService().logIn(usersAction.getCurrentUser().getEmail(), password);
        String a5id = getA5Id(usersAction.getOneAssetFromXML().getAssetGUID());
        if (a5id.isEmpty())
            Assert.fail(usersAction.getOneAssetFromXML().getUniqueName() + " isn't migrated. GUID = " + usersAction.getOneAssetFromXML().getAssetGUID());
        String title = usersAction.getOneAssetFromXML().getTitle();
        Content content = getService().getAsset(a5id);
        Asset assetData = usersAction.getOneAssetFromXML();
        List<String> listOfCommonFields = getAllCommonFieldsDefaultScheme(assetData);
        List<String> listOfCommonWithoutCMFields = new ArrayList<>();
        listOfCommonWithoutCMFields.add("name");
        listOfCommonWithoutCMFields.add("mediaType");
        listOfCommonWithoutCMFields.add("mediaSubType");
        List<String> listOfA4Fields = getVideoAndAudioFieldsDefaultScheme(assetData);
        List<String> listOfAudioWithoutCMFields = new ArrayList<>();
        listOfAudioWithoutCMFields.add("ClockNumber");
        listOfAudioWithoutCMFields.add("duration");
        assertThat("", content.getCm().getOrCreateNode("audio").size(), equalTo(2));
        assertThat("", content.getCm().getOrCreateNode("common").size(), equalTo(3));
        for (Map.Entry customMetadata: content.getCm().getOrCreateNode("audio").entrySet()) {
            assertThat("", customMetadata.getKey().toString(), isIn(listOfAudioWithoutCMFields));
        }
        for (Map.Entry customMetadata: content.getCm().getOrCreateNode("common").entrySet()) {
            assertThat("", customMetadata.getKey().toString(), isIn(listOfCommonWithoutCMFields));
        }

        if (listOfA4Fields.contains("Director"))
            assertThat("", content.getCm().getOrCreateNode("video").containsKey("Director"), equalTo(false));

    }

    @Test(dataProvider = "allVideoAssets", dataProviderClass = MigrationDataProvider.class)
    public void checkVideoWithoutCM(UsersAction usersAction) {
        String password = MongoUtils.getPassword(usersAction.getCurrentUser().getEmail()).trim();
        //String password = "1";
        getService().logIn(usersAction.getCurrentUser().getEmail(), password);
        String a5id = getA5Id(usersAction.getOneAssetFromXML().getAssetGUID());
        if (a5id.isEmpty())
            Assert.fail(usersAction.getOneAssetFromXML().getUniqueName() + " isn't migrated. GUID = " + usersAction.getOneAssetFromXML().getAssetGUID());
        String title = usersAction.getOneAssetFromXML().getTitle();
        Content content = getService().getAsset(a5id);
        Asset assetData = usersAction.getOneAssetFromXML();
        List<String> listOfCommonFields = getAllCommonFieldsDefaultScheme(assetData);
        List<String> listOfCommonWithoutCMFields = new ArrayList<>();
        listOfCommonWithoutCMFields.add("name");
        listOfCommonWithoutCMFields.add("mediaType");
        listOfCommonWithoutCMFields.add("mediaSubType");
        listOfCommonWithoutCMFields.add("status");
        List<String> listOfA4Fields = getVideoAndAudioFieldsDefaultScheme(assetData);
        List<String> listOfVideoWithoutCMFields = new ArrayList<>();
        listOfVideoWithoutCMFields.add("clockNumber");
        listOfVideoWithoutCMFields.add("duration");
        assertThat("", content.getCm().getOrCreateNode("video").size(), equalTo(2));
        assertThat("", content.getCm().getOrCreateNode("common").size(), equalTo(4));
        for (Map.Entry customMetadata: content.getCm().getOrCreateNode("video").entrySet()) {
            assertThat("", customMetadata.getKey().toString(), isIn(listOfVideoWithoutCMFields));
        }
        for (Map.Entry customMetadata: content.getCm().getOrCreateNode("common").entrySet()) {
            assertThat("", customMetadata.getKey().toString(), isIn(listOfCommonWithoutCMFields));
        }

        if (listOfA4Fields.contains("Director"))
            assertThat("", content.getCm().getOrCreateNode("video").containsKey("Director"), equalTo(false));
    }

    @Test(dataProvider = "oneUserOneAsset", dataProviderClass = MigrationDataProvider.class)
    public void checkOdtWithEmptyFileID(UsersAction usersAction) {
        String password = MongoUtils.getPassword(usersAction.getCurrentUser().getEmail()).trim();
        getService().logIn(usersAction.getCurrentUser().getEmail(), password);
        String a5id = getA5Id(usersAction.getOneAssetFromXML().getAssetGUID());
        //List<Asset> assetRelationsList = getRelations(usersAction.getOneAssetFromXML().getAssetGUID());
        Map<String, List<Asset>> assetRelations = getChildAssets(usersAction.getOneAssetFromXML().getAssetGUID());
        List<Asset> list = assetRelations.get(usersAction.getOneAssetFromXML().getAssetGUID());
        if (a5id.isEmpty())
            Assert.fail(usersAction.getOneAssetFromXML().getUniqueName() + " isn't migrated. GUID = " + usersAction.getOneAssetFromXML().getAssetGUID());
        Content content = getService().getAsset(a5id);
        String folder = System.getProperty("user.dir");
        folder = folder.concat("\\").concat("odt_full_log.info");
        String folderA= folder.concat("\\").concat("odt_empty_fid.info");
        File file = new File((folder));
        File fileA = new File((folderA));
        FileManager.saveIntoFile(file.getName(), usersAction.getOneAssetFromXML().getUniqueName() + " is checking now. It asset has " + (content.getRevisions()[0].getOdtElement()!=null?content.getRevisions()[0].getOdtElement().size():0) + " ODT elements\n");
        for (OdtElement odtElement: content.getRevisions()[0].getOdtElement()) {
            if (odtElement.getFileID() == null || odtElement.getFileID().isEmpty()) {
                FileManager.saveIntoFile(fileA.getName(), content.getId() + " - " + usersAction.getOneAssetFromXML().getUniqueName() + " has ODT element with empty fileID\n");
                Assert.fail(usersAction.getOneAssetFromXML().getUniqueName() + " has ODT element with empty fileID");
            }

        }
    }

    @Test(dataProvider = "oneUserOneAsset", dataProviderClass = MigrationDataProvider.class)
    public void checkOdtElements(UsersAction usersAction) {
        String password = MongoUtils.getPassword(usersAction.getCurrentUser().getEmail()).trim();
        getService().logIn(usersAction.getCurrentUser().getEmail(), password);
        String a5id = getA5Id(usersAction.getOneAssetFromXML().getAssetGUID());
        //List<Asset> assetRelationsList = getRelations(usersAction.getOneAssetFromXML().getAssetGUID());
        //Map<String, List<Asset>> assetRelations = getChildAssets(usersAction.getOneAssetFromXML().getAssetGUID());
        Map<String, List<Asset>> assetRelations = getProductionMasters(usersAction.getOneAssetFromXML().getAssetGUID(), false);
        List<Asset> list = assetRelations.get(usersAction.getOneAssetFromXML().getAssetGUID());
        countOfOdtXML += list.size();

        if (a5id.isEmpty())
            Assert.fail(usersAction.getOneAssetFromXML().getUniqueName() + " isn't migrated. GUID = " + usersAction.getOneAssetFromXML().getAssetGUID());
        Content content = getService().getAsset(a5id);
        String folder = System.getProperty("user.dir");
        String folderA = System.getProperty("user.dir");
        folder = folder.concat("\\").concat("odt_size.info");
        File file = new File((folder));
        String folderData = folder.concat("\\").concat("odt_data.info");
        File fileData = new File((folderData));
        String folderInfo = folder.concat("\\").concat("odt_info.info");
        File fileInfo = new File((folderInfo));
        String folderCount = folder.concat("\\").concat("odt_count.info");
        File fileCount = new File((folderCount));

        String folderFolder = folderA.concat("\\").concat("Z\\").concat(usersAction.getOneAssetFromXML().getAssetGUID()).concat(".log");
        File fileFolder = new File(folderFolder);
        FileManager.saveIntoFile(fileInfo.getName(), "Asset: " + usersAction.getOneAssetFromXML().getAssetGUID() + " starting... \n");
        countOfOdtA5 += content.getRevisions()[0].getOdtElement().size();
        if (list.size() == 0) {
            assertThat(" GUID = " + usersAction.getOneAssetFromXML().getAssetGUID(), content.getRevisions()[0].getOdtElement().size(), equalTo(0));
            FileManager.saveIntoFile(fileInfo.getName(), "This asset hasn't ODT files \n");
            FileManager.saveIntoFile(fileFolder.getAbsolutePath(), "Asset: " + usersAction.getOneAssetFromXML().getAssetGUID() + " hasn't ODT files ");
            return;
        }

        try {
            FileManager.saveIntoFile(fileFolder.getAbsolutePath(), "Asset: " + usersAction.getOneAssetFromXML().getAssetGUID() + " start check count of ODT\n");
            FileManager.saveIntoFile(fileInfo.getName(), "start check count of ODT... \n");
            assertThat(" GUID = " + usersAction.getOneAssetFromXML().getAssetGUID(), content.getRevisions()[0].getOdtElement().size(), equalTo(list.size()));
            FileManager.saveIntoFile(fileFolder.getAbsolutePath(), "Asset: " + usersAction.getOneAssetFromXML().getAssetGUID() + " count of ODT is correct\n");
            FileManager.saveIntoFile(fileInfo.getName(), "count of ODT is correct\n");

        } catch (AssertionError ae) {
            FileManager.saveIntoFile(fileFolder.getAbsolutePath(), "A4 AssetGuid: " + usersAction.getOneAssetFromXML().getAssetGUID() + "\n");
            FileManager.saveIntoFile(fileFolder.getAbsolutePath(), "ClockNumber: " + usersAction.getOneAssetFromXML().getUniqueName() + "\n");
            FileManager.saveIntoFile(fileFolder.getAbsolutePath(), "AssetType: " + usersAction.getOneAssetFromXML().getAssetType() + "\n");
            FileManager.saveIntoFile(fileFolder.getAbsolutePath(), "A5: ID " + content.getId() + "\n");
            FileManager.saveIntoFile(fileFolder.getAbsolutePath(), "SIZE XML/ODT " + list.size() + "/" + content.getRevisions()[0].getOdtElement().size() + "\n");
            FileManager.saveIntoFile(fileInfo.getName(), "A4 AssetGuid: " + usersAction.getOneAssetFromXML().getAssetGUID() + "\n");
            FileManager.saveIntoFile(fileInfo.getName(), "ClockNumber: " + usersAction.getOneAssetFromXML().getUniqueName() + "\n");
            FileManager.saveIntoFile(fileInfo.getName(), "AssetType: " + usersAction.getOneAssetFromXML().getAssetType() + "\n");
            FileManager.saveIntoFile(fileInfo.getName(), "A5: ID " + content.getId() + "\n");
            FileManager.saveIntoFile(fileInfo.getName(), "SIZE XML/ODT " + list.size() + "/" + content.getRevisions()[0].getOdtElement().size() + "\n");

            for (Asset asset: list) {
                FileManager.saveIntoFile(fileFolder.getAbsolutePath(), "A4 GUID = " + asset.getAssetGUID() + "\n");
                FileManager.saveIntoFile(fileFolder.getAbsolutePath(), "FileID = " + (asset.getFileID()==null?"null":asset.getFileID()) + "\n");
                FileManager.saveIntoFile(fileInfo.getName(), "A4 GUID = " + asset.getAssetGUID() + "\n");
                FileManager.saveIntoFile(fileInfo.getName(), "FileID = " + (asset.getFileID()==null?"null":asset.getFileID()) + "\n");

            }
            Assert.fail();
        }
        boolean isExist = false;
        for (OdtElement odtElement: content.getRevisions()[0].getOdtElement()) {
            for (Asset assetRelation: list) {
                if (assetRelation.getFileID() == null) {
                    FileManager.saveIntoFile(file.getName(), "AssetGUID = " + assetRelation.getAssetGUID() + " clockNumer = " + usersAction.getOneAssetFromXML().getUniqueName() +  " hasn't fileID\n");
                    FileManager.saveIntoFile(fileFolder.getAbsolutePath(), "AssetGUID = " + assetRelation.getAssetGUID() + " hasn't fileID\n");
                    FileManager.saveIntoFile(fileInfo.getName(), "AssetGUID = " + assetRelation.getAssetGUID() + " clockNumer = " + usersAction.getOneAssetFromXML().getUniqueName() +  " hasn't fileID\n");
                    FileManager.saveIntoFile(fileInfo.getName(), "AssetGUID = " + assetRelation.getAssetGUID() + " hasn't fileID\n");

                    return;
                }

                if (assetRelation.getFileID().equalsIgnoreCase(odtElement.getFileID())) {
                    isExist = true;
                    try {
                        FileManager.saveIntoFile(fileFolder.getAbsolutePath(), "Asset: " + usersAction.getOneAssetFromXML().getAssetGUID() + " start check tha ODT is correct ");
                        assertThat("", String.valueOf(odtElement.getFileSize()), equalTo(assetRelation.getFileSize()));
                        if (assetRelation.getSpecDBDocID()==null || assetRelation.getSpecDBDocID().isEmpty()) {
                            FileManager.saveIntoFile(fileCount.getName(), "Asset with name " + usersAction.getOneAssetFromXML().getUniqueName() + " has odt with empty specification");
                        }
                        assertThat("", odtElement.getSpecDbDocID(), equalTo(changeSpecDBName(assetRelation)));
                        assertThat("", odtElement.getName(), equalTo(assetRelation.getFileName()));
                        FileManager.saveIntoFile(fileFolder.getAbsolutePath(), "Asset: " + usersAction.getOneAssetFromXML().getAssetGUID() + " checked! ODT - Ok\n");
                    }
                    catch (Throwable t) {
                        FileManager.saveIntoFile(fileData.getName(), String.format("for Asset with GUID = %s and clock number %s\n", usersAction.getOneAssetFromXML().getAssetGUID(), usersAction.getOneAssetFromXML().getUniqueName()));
                        Assert.fail();
                    }
                }
            }
        }
        if (!isExist) {
            FileManager.saveIntoFile(fileFolder.getAbsolutePath(), "Asset: " + usersAction.getOneAssetFromXML().getAssetGUID() + " isExist = false \n");
            FileManager.saveIntoFile(fileData.getName(), String.format("for Asset with GUID = %s and clock number %s\n there isn't FileID", usersAction.getOneAssetFromXML().getAssetGUID(), usersAction.getOneAssetFromXML().getUniqueName()));
            Assert.fail();
        }
        else
            FileManager.saveIntoFile(fileFolder.getAbsolutePath(), "\n");
        FileManager.saveIntoFile(fileCount.getName(), "XML / A5 = " + countOfOdtXML + " / " + countOfOdtA5 + "\n");

    }

    @Test(dataProvider = "wipAssets", dataProviderClass = MigrationDataProvider.class)
    public void checkWIP(UsersAction usersAction) {
        String password = MongoUtils.getPassword(usersAction.getCurrentUser().getEmail()).trim();
        getService().logIn(usersAction.getCurrentUser().getEmail(), password);
        String a5id = getA5Id(usersAction.getOneAssetFromXML().getAssetGUID());
        if (a5id.isEmpty())
            Assert.fail(usersAction.getOneAssetFromXML().getUniqueName() + " isn't migrated. GUID = " + usersAction.getOneAssetFromXML().getAssetGUID());
        Content content = getService().getAsset(a5id);
        log.info("WIP: " + usersAction.getOneAssetFromXML().getUniqueName());
        assertThat("", content.getName(), equalTo(usersAction.getOneAssetFromXML().getTitle()));
        if (content.getCm().containsKey("audio"))
            assertThat("", content.getCm().getOrCreateNode("audio").getString("ClockNumber"), equalTo(usersAction.getOneAssetFromXML().getUniqueName()));
        else
            assertThat("", content.getCm().getOrCreateNode("video").getString("clockNumber"), equalTo(usersAction.getOneAssetFromXML().getUniqueName()));

    }

    @Test(dataProvider = "oneUserOneAsset", dataProviderClass = MigrationDataProvider.class)
    public void checkWithoutProductionMasters(UsersAction usersAction) {
        String password = MongoUtils.getPassword(usersAction.getCurrentUser().getEmail()).trim();
        getService().logIn(usersAction.getCurrentUser().getEmail(), password);
        String a5id = getA5Id(usersAction.getOneAssetFromXML().getAssetGUID());
        //List<Asset> assetRelationsList = getRelations(usersAction.getOneAssetFromXML().getAssetGUID());
        //Map<String, List<Asset>> assetRelations = getProductionMasters(usersAction.getOneAssetFromXML().getAssetGUID(), true);
        //List<Asset> list = assetRelations.get(usersAction.getOneAssetFromXML().getAssetGUID());
        //countOfOdtXML += list.size();

        if (a5id.isEmpty())
            Assert.fail(usersAction.getOneAssetFromXML().getUniqueName() + " isn't migrated. GUID = " + usersAction.getOneAssetFromXML().getAssetGUID());
        Content content = getService().getAsset(a5id);
        assertThat("A4 GUID: " + usersAction.getOneAssetFromXML().getAssetGUID() + " clockNumber= " + usersAction.getOneAssetFromXML().getUniqueName(), content.getRevisions()[0].getOdtElement().size(), equalTo(0));

        /*for (OdtElement odtElement: content.getRevisions()[0].getOdtElement()) {
            if (odtElement.getSpecDbDocID().contains("production") && odtElement.getSpecDbDocID().contains("Production")) {
                Assert.fail("Info: A4: " + usersAction.getOneAssetFromXML().getAssetGUID() + " clockNumber: " + usersAction.getOneAssetFromXML().getUniqueName());
            }

        } */
    }

    @Test(dataProvider = "oneUserOneAsset", dataProviderClass = MigrationDataProvider.class)
    public void checkParameterWithODTIsFalse(UsersAction usersAction) {
        String password = MongoUtils.getPassword(usersAction.getCurrentUser().getEmail()).trim();
        getService().logIn(usersAction.getCurrentUser().getEmail(), password);
        String a5id = getA5Id(usersAction.getOneAssetFromXML().getAssetGUID());
        if (a5id.isEmpty())
            Assert.fail(usersAction.getOneAssetFromXML().getUniqueName() + " isn't migrated. GUID = " + usersAction.getOneAssetFromXML().getAssetGUID());
        Content content = getService().getAsset(a5id);
        assertThat("A4 GUID: " + usersAction.getOneAssetFromXML().getAssetGUID() + " clockNumber= " + usersAction.getOneAssetFromXML().getUniqueName(), content.getRevisions()[0].getOdtElement().size(), equalTo(0));

    }

    @Test(dataProvider = "allVideoAssets", dataProviderClass = MigrationDataProvider.class)
    public void ediAssetMetadataVideo(UsersAction usersAction) {
        //List<String> categories = DictionaryUtils.getDictionaryForAgency(usersAction.getOneAssetFromXML().getAgencyName(), "Category_1388675170700");
        //List<String> categories = DictionaryUtils.getDictionaryForAgency(usersAction.getOneAssetFromXML().getAgencyName(), "Category");
        String password = MongoUtils.getPassword(usersAction.getCurrentUser().getEmail()).trim();
        getService().logIn(usersAction.getCurrentUser().getEmail(), password);
        //getService().logIn(otherAgencyEmail, otherAgencyPassword);
        String a5id = getA5Id(usersAction.getOneAssetFromXML().getAssetGUID());
        if (a5id.isEmpty())
            Assert.fail(usersAction.getOneAssetFromXML().getUniqueName() + " isn't migrated. GUID = " + usersAction.getOneAssetFromXML().getAssetGUID());
        Content content = getService().getAsset(a5id);
        //String newCategory = "Alcoholic Drinks"; //categories.get(random.nextInt(categories.size()));
        String newCountry = "UA"; //categories.get(random.nextInt(categories.size()));
        //content.getCm().getOrCreateNode("video").put("Category", asList(newCategory));
        content.getCm().getOrCreateNode("video").put("country", asList(newCountry));
        Content contentAfterUpdate = getService().updateAsset(content);
        String newCategoriesValue = contentAfterUpdate.getCm().getOrCreateNode("video").getStringArray("country")[0];
        assertThat("Asset: clockNumber = " + usersAction.getOneAssetFromXML().getUniqueName() + " weren't updated", newCategoriesValue, equalTo(newCountry));
    }


    @Test(dataProvider = "allAudioAssets", dataProviderClass = MigrationDataProvider.class)
    public void ediAssetMetadataAudio(UsersAction usersAction) {
        //DeliveryLocation_1386320179491
        //BroadcastDestination_1386320281913
        //BroadcastFormat_1389108329355
        //List<String> deliveryLocation = DictionaryUtils.getDictionaryForAgency(usersAction.getOneAssetFromXML().getAgencyName(), "DeliveryLocation_1386320179491");
        //List<String> broadcastDestination = DictionaryUtils.getDictionaryForAgency(usersAction.getOneAssetFromXML().getAgencyName(), "BroadcastDestination_1386320281913");
        //List<String> broadcastFormat = DictionaryUtils.getDictionaryForAgency(usersAction.getOneAssetFromXML().getAgencyName(), "BroadcastFormat_1389108329355");
        String password = MongoUtils.getPassword(usersAction.getCurrentUser().getEmail()).trim();
        getService().logIn(usersAction.getCurrentUser().getEmail(), password);
        String a5id = getA5Id(usersAction.getOneAssetFromXML().getAssetGUID());
        if (a5id.isEmpty())
            Assert.fail(usersAction.getOneAssetFromXML().getUniqueName() + " isn't migrated. GUID = " + usersAction.getOneAssetFromXML().getAssetGUID());
        Content content = getService().getAsset(a5id);
        //String deliveryLocationValue = deliveryLocation.get(random.nextInt(deliveryLocation.size()));
        //String broadcastDestinationValue = broadcastDestination.get(random.nextInt(broadcastDestination.size()));
        //String broadcastFormatValue = broadcastFormat.get(random.nextInt(broadcastFormat.size()));
        //content.getCm().getOrCreateNode("audio").put("DeliveryLocation_1386320179491", asList(deliveryLocationValue));
        //content.getCm().getOrCreateNode("audio").put("BroadcastDestination_1386320281913", asList(broadcastDestinationValue));
        //content.getCm().getOrCreateNode("audio").put("BroadcastFormat_1389108329355", asList(broadcastFormatValue));
        String newCategory = "Alcoholic Drinks"; //categories.get(random.nextInt(categories.size()));
        content.getCm().getOrCreateNode("audio").put("Category", asList(newCategory));

        Content contentAfterUpdate = getService().updateAsset(content);
        /*String newDeliveryLocationValue = contentAfterUpdate.getCm().getOrCreateNode("audio").getStringArray("DeliveryLocation_1386320179491")[0];
        String newBroadcastDestinationValue = contentAfterUpdate.getCm().getOrCreateNode("audio").getStringArray("BroadcastDestination_1386320281913")[0];
        String newBroadcastFormatValue = contentAfterUpdate.getCm().getOrCreateNode("audio").getStringArray("BroadcastFormat_1389108329355")[0];*/
        String newCategoriesValue = contentAfterUpdate.getCm().getOrCreateNode("audio").getStringArray("Category")[0];
        assertThat("Asset: clockNumber = " + usersAction.getOneAssetFromXML().getUniqueName() + " weren't updated", newCategoriesValue, equalTo(newCategory));

/*        assertThat("Asset: clockNumber = " + usersAction.getOneAssetFromXML().getUniqueName() + " weren't updated", newDeliveryLocationValue, equalTo(deliveryLocationValue));
        assertThat("Asset: clockNumber = " + usersAction.getOneAssetFromXML().getUniqueName() + " weren't updated", newBroadcastDestinationValue, equalTo(broadcastDestinationValue));
        assertThat("Asset: clockNumber = " + usersAction.getOneAssetFromXML().getUniqueName() + " weren't updated", newBroadcastFormatValue, equalTo(broadcastFormatValue));*/
    }

    @Test(dataProvider = "oneUserOneAsset", dataProviderClass = MigrationDataProvider.class)
    public void checkAddUsageRights(UsersAction usersAction) {
        Random random = new Random(System.currentTimeMillis());
        BaseTest.getService().logIn("admin", "abcdefghA1");
        List<String> countries = BaseTest.getService().getDictionary(DictionaryType.COUNTRY).getValues().getKeys();
        String password = MongoUtils.getPassword(usersAction.getCurrentUser().getEmail()).trim();
        //getService().logIn(usersAction.getCurrentUser().getEmail(), password);
        getService().logIn(otherAgencyEmail, otherAgencyPassword);
        String a5id = getA5Id(usersAction.getOneAssetFromXML().getAssetGUID());
        if (a5id.isEmpty())
            Assert.fail(usersAction.getOneAssetFromXML().getUniqueName() + " isn't migrated. GUID = " + usersAction.getOneAssetFromXML().getAssetGUID());
        Content asset = getService().getAsset(a5id);
        CountriesUsageRight countriesUsageRight = new CountriesUsageRight();
        Expiration expiration = new Expiration();
        expiration.setStartDate(System.currentTimeMillis() - 24*60*60*1000);
        expiration.setExpireDate(System.currentTimeMillis() + 2*24*60*60*1000);
        expiration.setExpireType("date");
        UsageCountry usageCountry = new UsageCountry();
        usageCountry.setUsageCountry(new String[] {countries.get(random.nextInt(countries.size()))});
        countriesUsageRight.setExpiration(expiration);
        countriesUsageRight.setCountries(usageCountry);
        usersAction.addUsageRight(countriesUsageRight);
        List<UsageRight> usageRights = new ArrayList<>();
        usageRights.add(countriesUsageRight);
        getService().addUsageRights(asset.getId(), usageRights);
        Common.sleep(2000);
        BaseUsageRight baseUsageRight = getService().getUsageRight(asset.getId());
        String info = "|" + usersAction.getOneAssetFromXML().getAssetGUID() + "|" + usersAction.getOneAssetFromXML().getUniqueName() + "|" + usersAction.getOneAssetFromXML().getAssetType() + "|";
        String folder = System.getProperty("user.dir");
        folder = folder.concat("\\").concat("UR_add_error.xml");
        File file = new File(folder);

        try {
            assertThat("", baseUsageRight.getUsages()[0].getOrCreateNodeForPath("Countries").getArrayForClass("usageCountry", String.class)[0],
                    equalTo(((CountriesUsageRight)usersAction.getUsageRight().get(0)).getCountries().getUsageCountry()[0]));
            assertThat("", baseUsageRight.getUsages()[0].getOrCreateNode("expiration").getLong("startDate"),
                    equalTo(expiration.getStartDate()));
            assertThat("", baseUsageRight.getUsages()[0].getOrCreateNode("expiration").getLong("expireDate"),
                    equalTo(expiration.getExpireDate()));
        }
        catch (Throwable t) {
            FileManager.saveIntoFile(file.getName(), info + " has problems with UR. A5ID = " + a5id + "\n");
            Assert.fail(info + " weren't added");
        }


    }

    @Test
    public void deleteAllAssets() {
        //getService().logIn(XMLParser.getFirstDeptAdminFromCurrentXML().getEmail(), XMLParser.getFirstDeptAdminFromCurrentXML().getPassword());
        //getService().logIn("nick@the-embassy.co.za", "Nick2011");
        getService().logIn(otherAgencyEmail, otherAgencyPassword);
        String collectionId = getService().getAssetsFilterByName("Everything", "").getId();
        List<Content> contentList = getService().getAllAssetByName(collectionId);
        int i= 0;
        int k= 0;
        for (Content asset: contentList) {
            if (MongoUtils.isA4Id(asset.getId())) {
                getService().deleteAsset(asset.getId());
                System.out.println("need delete= " + ++i);
            }
            else {
                System.out.println("left= " + ++k);
            }
        }
    }

    @Test
    public void checlStreamingSpecification() {
        getService().logIn(otherAgencyEmail, otherAgencyPassword);
        String collectionId = getService().getAssetsFilterByName("Everything", "").getId();
        List<Content> contentList = getService().getAllAssetByName(collectionId);
        for (Content asset: contentList) {
            System.out.println();
        }

    }

    @Test
    public void deleteAllAssetsUseA4FromFile() {
        String sourceFile = "migration/src/main/resources/ex_list_need.txt";
        List<String> a4IDs = FileManager.readTextFile(System.getProperty("user.dir").concat("\\").concat(sourceFile));
        getService().logIn(otherAgencyEmail, otherAgencyPassword);
        int i= 0;
        int emptyCount= 0;
        int notEmpty= 0;
        for (String a4id: a4IDs) {
            String a5Id = getA5Id(a4id.toLowerCase());
            if (a5Id.isEmpty())
                emptyCount++;
            else {
                notEmpty++;
                getService().deleteAsset(a5Id);
                System.out.println("need delete= " + ++i);
            }


        }
        System.out.println(emptyCount);
        System.out.println(notEmpty);
    }


    private List<ProxyAsset> getAllAssetsWithFileId(List<ProxyAsset> source, String fileId) {
        List<ProxyAsset> result = new ArrayList<>();
        for (ProxyAsset proxyAsset: source) {
            if (proxyAsset.getFileId()!= null && proxyAsset.getFileId().equals(fileId))
                result.add(proxyAsset);
        }
        return result;
    }


    @Test(dataProvider = "allVideoAssets", dataProviderClass = MigrationDataProvider.class)
    public void getAllFirstAirDate(UsersAction usersAction) {
        String password = MongoUtils.getPassword(usersAction.getCurrentUser().getEmail()).trim();
        getService().logIn(usersAction.getCurrentUser().getEmail(), password);
        String a5id = getA5Id(usersAction.getOneAssetFromXML().getAssetGUID());
        if (a5id.isEmpty())
            Assert.fail(usersAction.getOneAssetFromXML().getUniqueName() + " isn't migrated. GUID = " + usersAction.getOneAssetFromXML().getAssetGUID());
        String title = usersAction.getOneAssetFromXML().getTitle();
        Content assetApp = getService().getAsset(a5id);
        int size = assetApp.getCm().getOrCreateNode("video").size();
        assertThat("asset's name: " + title, size, greaterThan(0));

        String folder = System.getProperty("user.dir");
        folder = folder.concat("\\").concat("FAD.info");
        String folder1 = folder.concat("\\").concat("FAD1.info");
        File file = new File((folder));
        File file1 = new File((folder1));
        Video assetDataVideo = getVideoByAGUID(usersAction.getOneAssetFromXML().getAssetGUID());
        try {
            FileManager.saveIntoFile(file.getName(), usersAction.getOneAssetFromXML().getTitle() + " has airDate: " + assetApp.getCm().getOrCreateNode("video").get("airDate").toString() + "\n");
        }
        catch (NullPointerException npe) {
            if (assetDataVideo.getFirstAirDate()!= null && !assetDataVideo.getFirstAirDate().isEmpty())
                FileManager.saveIntoFile(file1.getName(), usersAction.getOneAssetFromXML().getTitle() + " hasn't airDate\n");
        }

    }




    private Map<String, List<Asset>> getProductionMasters(String aGuid, boolean needPM) {
        List<AssetRelationship> assetRelationshipList = new ArrayList<>();
        List<Asset> result = new ArrayList<>();

        Map<String, List<Asset>> parentChildsRelation = new HashMap<>();
        List<Asset> childsAssetGUID = new ArrayList<>();
        parentChildsRelation.put(aGuid, childsAssetGUID);
        for (Asset childAsset: XMLParser.getNewDataSet().getAsset()) {
            boolean isProduction = changeSpecDBName(childAsset).contains("production");
            boolean condition = needPM?isProduction:!isProduction;
            if (childAsset.getParentAssetGuid()!= null && childAsset.getParentAssetGuid().equals(aGuid) && childAsset.getAssetTypeID().equals("999") && condition) {
                childsAssetGUID.add(childAsset);
            }
        }
        for (AssetRelationship assetRelationship: XMLParser.getNewDataSet().getAssetRelationship()) {
            if (assetRelationship.getParentAssetGUID().equals(aGuid)) {
                assetRelationshipList.add(assetRelationship);
            }
        }
        for (AssetRelationship assetRelationship: assetRelationshipList) {
            for (Asset asset: XMLParser.getNewDataSet().getAsset()) {
                boolean isProduction = changeSpecDBName(asset).contains("production");
                boolean condition = needPM?isProduction:!isProduction;
                if (asset.getAssetGUID().equals(assetRelationship.getChildAssetGUID()) && asset.getAssetTypeID().equals("999") && asset.getFileID()!=null && !asset.getFileID().isEmpty() && condition) {
                    childsAssetGUID.add(asset);
                    break;
                }
            }
        }

        return parentChildsRelation;

    }

    private String changeSpecDBName(Asset asset) {
        if (asset.getSpecDBDocID()==null || asset.getSpecDBDocID().isEmpty() || asset.getSpecDBDocID().equalsIgnoreCase("fake")) {
            int subAssetType = Integer.parseInt(asset.getSubAssetTypeID());
            switch (subAssetType) {
                case 1:
                    return "f1:audio:custom:Unknown:Unknown:Unknown";
                case 2:
                    return "f1:video:custom:Unknown:Unknown:Unknown";
                case 3:
                    return "f1:image:custom:Unknown:Unknown:Unknown";
                case 4:
                    return "f1:document:custom:Unknown:Unknown:Unknown";
                case 5:
                    return "f1:font:custom:Unknown:Unknown:Unknown";
                case 6:
                    return "f1:script:custom:Unknown:Unknown:Unknown";
                case 7:
                    return "f1:online:custom:Unknown:Unknown:Unknown";
                case 8:
                    return "f1:print:custom:Unknown:Unknown:Unknown";
                case 9:
                    return "f1:video:production:Unknown:Unknown:Unknown";
                case 10:
                    return "f1:audio:production:Unknown:Unknown:Unknown";
                case 11:
                    return "f1:print:production:Unknown:Unknown:Unknown";
                case 12:
                    return "f1:other:production:Unknown:Unknown:Unknown";
                case 999:
                    return "f1:undetermined:custom:Unknown:Unknown:Unknown";

            }
        }
        return asset.getSpecDBDocID();
    }

    private List<String> getAllCommonFieldsDefaultScheme(Asset asset) {
        AssetType assetType = asset.getAssetType().equalsIgnoreCase("video")?AssetType.VIDEO:AssetType.AUDIO;
        Video video = getVideoByAGUID(asset.getAssetGUID()); // Уменьшить количество обращений
        List<String> result = new ArrayList<>();
        //if (asset.getTitle()!= null && !asset.getTitle().isEmpty())
        //result.add("name");
        if (asset.getAdvertiser()!= null && !asset.getAdvertiser().isEmpty())
            result.add("advertiser");
        if (asset.getProduct()!= null && !asset.getProduct().isEmpty())
            result.add("brand");
        if (asset.getCampaignName()!= null && !asset.getCampaignName().isEmpty())
            result.add("Campaign");
        //if (video.getArtDirector()!= null && !video.getArtDirector().isEmpty())
        //    result.add("Region");
        if (!asset.getLifecycleID().isEmpty() && Integer.parseInt(asset.getLifecycleID())> 0)
            result.add("mediaSubType");
        if (assetType == AssetType.VIDEO) {
            result.add("status");
        }
        result.add("name"); // Always
        result.add("mediaType");
        return result;
    }

    private List<String> getVideoAndAudioFieldsDefaultScheme(Asset asset) {
        List<String> result = new ArrayList<>();
        AssetType assetType = asset.getAssetType().equalsIgnoreCase("video")?AssetType.VIDEO:AssetType.AUDIO;
        Video video = getVideoByAGUID(asset.getAssetGUID());
        Audio audio = getAudioByAGUID(asset.getAssetGUID());

        if (asset.getRegulatoryApproval()!= null && !asset.getRegulatoryApproval().isEmpty() && assetType == AssetType.VIDEO)
            result.add("AgencyJobreference");
        if (asset.getComment()!= null && !asset.getComment().isEmpty())
            result.add("Description");

        if (assetType == AssetType.VIDEO) {
            if (asset.getUniqueName()!= null && !asset.getUniqueName().isEmpty())
                result.add("clockNumber");
            if (video.getFirstAirDate() != null && !video.getFirstAirDate().isEmpty())
                result.add("airDate");
            if (video.getCreativeDirector()!=null && !video.getCreativeDirector().isEmpty())
                result.add("CreativeDirector");
            if (video.getDirector()!= null && !video.getDirector().isEmpty())
                result.add("Director");
            if (video.getPostProduction()!= null && !video.getPostProduction().isEmpty())
                result.add("Postproduction");
            if (video.getProductionCompany()!= null && !video.getProductionCompany().isEmpty())
                result.add("Productioncompany");
            if (video.getProducer()!= null && !video.getProducer().isEmpty()) {
                result.add("ProductionCompanyProducer");
                //result.add("Producer"); // ToDo - убрать после фикса 11420
            }
            if (video.getArtDirector()!= null && !video.getArtDirector().isEmpty())
                result.add("region");


        }
        if (assetType == AssetType.AUDIO) {
            if (asset.getUniqueName()!= null && !asset.getUniqueName().isEmpty())
                result.add("ClockNumber");
            if (audio.getDirector()!= null && !audio.getDirector().isEmpty())
                result.add("CreativeDirector");
            if (audio.getProducer()!= null && !audio.getProducer().isEmpty())
                result.add("Producer");
            if (audio.getCopyWriter()!= null && !audio.getCopyWriter().isEmpty())
                result.add("Copywriter");
            if (audio.getAudioEngineer()!= null && !audio.getAudioEngineer().isEmpty())
                result.add("RecordingEngineer");
            if (audio.getRecordedAt()!= null && !audio.getRecordedAt().isEmpty())
                result.add("MusicCompany");
            if (audio.getjCNNumber()!= null && !audio.getjCNNumber().isEmpty())
                result.add("JCNNumber");
            if (audio.getVoiceOverArtist()!= null && !audio.getVoiceOverArtist().isEmpty())
                result.add("VoiceOverArtist");
            if (audio.getFirstTransmission()!= null &&!audio.getFirstTransmission().isEmpty())
                result.add("airDate");

        }

        result.add("duration");

        return result;
    }

    private String getFieldsValue(Asset asset, String field, boolean isAudio) {
        AssetType assetType = asset.getAssetType().equalsIgnoreCase("video")?AssetType.VIDEO:AssetType.AUDIO;
        if (field.equalsIgnoreCase("name"))
            if (asset.getTitle()!= null && !asset.getTitle().isEmpty())
                return asset.getTitle();
            else
                return asset.getUniqueName();
        if (field.equalsIgnoreCase("advertiser"))
            return asset.getAdvertiser();
        if (field.equalsIgnoreCase("Product") || field.equalsIgnoreCase("brand"))
            return asset.getProduct();
        if (field.equalsIgnoreCase("Campaign"))
            return asset.getCampaignName();
        if (field.equalsIgnoreCase("clockNumber"))
            return asset.getUniqueName();
        Video video = getVideoByAGUID(asset.getAssetGUID());
        Audio audio = getAudioByAGUID(asset.getAssetGUID());
        if (field.equalsIgnoreCase("RecordingEngineer") && isAudio)
            return audio.getAudioEngineer();
        if (field.equalsIgnoreCase("CreativeDirector") && assetType == AssetType.VIDEO)
            return video.getCreativeDirector();
        if (field.equalsIgnoreCase("CreativeDirector") && assetType == AssetType.AUDIO)
            return audio.getDirector();
        if (assetType == AssetType.AUDIO && field.equalsIgnoreCase("Producer"))
            return audio.getProducer();
        if (field.equalsIgnoreCase("Director"))
            return video.getDirector();
        if (field.equalsIgnoreCase("Productioncompany") && !isAudio)
            return video.getProductionCompany();
        if (field.equalsIgnoreCase("ProductionCompanyProducer") && !isAudio)
            return video.getProducer();

        if (field.equalsIgnoreCase("Postproduction"))
            return video.getPostProduction();
        if (field.equalsIgnoreCase("Description"))
            return asset.getComment();
        if (field.equalsIgnoreCase("airDate") && assetType == AssetType.VIDEO)
            return video.getFirstAirDate();
        if (field.equalsIgnoreCase("airDate") && assetType == AssetType.AUDIO)
            return audio.getFirstTransmission();

        if (field.equalsIgnoreCase("AgencyJobreference"))
            return asset.getRegulatoryApproval();

        if (field.equalsIgnoreCase("mediaSubType")) {     // ToDo проверить что в АУДИО
            if (asset.getLifecycleID().equals("3"))
                return "QC-ed master";
            if (asset.getLifecycleID().equals("2"))
                return "Generic Master";
            return "";
        }
        if (field.equalsIgnoreCase("status"))
            return "TVC Ingested OK";
        if (field.equalsIgnoreCase("mediaType"))
            return asset.getAssetType();
        if (field.equalsIgnoreCase("Copywriter") && isAudio)
            return audio.getCopyWriter();
        if (field.equalsIgnoreCase("MusicCompany") && isAudio)
            return audio.getRecordedAt();
        if (field.equalsIgnoreCase("region"))
            return video.getArtDirector();
        if (field.equalsIgnoreCase("VoiceOverArtist"))
            return audio.getVoiceOverArtist();
        if (field.equalsIgnoreCase("JCNNumber"))
            return audio.getjCNNumber();

        return "";
    }

    private List<String> getAllNeedfulAudioFieldsFromXML(Asset asset, boolean isAudio) {
        List<String> result = new ArrayList<>();
        Audio audio = getAudioByAGUID(asset.getAssetGUID());
        if (!asset.getUniqueName().isEmpty()) // Clock number
            result.add("ClockNumber");

        /*if (!video.getArtDirector().isEmpty())
            result.add("ArtDirector");*/
        if ((audio.getProducer()!= null) && !audio.getProducer().isEmpty())
            result.add("Producer");
        if ((audio.getDirector()!= null) && !audio.getDirector().isEmpty() && isAudio)
            result.add("Copywriter");
        if ((audio.getjCNNumber()!= null) && !audio.getjCNNumber().isEmpty())
            result.add("JCNNumber");
        if ((audio.getCopyWriter()!= null) && !audio.getCopyWriter().isEmpty())
            result.add("AccountManager");
        if ((audio.getAudioEngineer()!= null) && !audio.getAudioEngineer().isEmpty())
            result.add("RecordingEngineer_1389015565438");

        /*if (!video.getContactAtPostProduction().isEmpty())
            result.add("ContactAtPostProduction");
        if (!video.getContactPhone().isEmpty())
            result.add("ContactPhone");*/
        if ((audio.getRecordedAt()!= null) && !audio.getRecordedAt().isEmpty())
            result.add("MusicCompany");
        if ((asset.getRegulatoryApproval()!= null) && !asset.getRegulatoryApproval().isEmpty())
            result.add("AgencyJobreference");

        result.add("duration");
        return result;
    }

    private Video getVideoByAGUID(String aGuid) {
        for (Video video: XMLParser.getNewDataSet().getVideo() ) {
            if (video.getAssetGUID().equals(aGuid))
                return video;
        }
        return null;
    }

    private Audio getAudioByAGUID(String aGuid) {
        if (XMLParser.getNewDataSet().getAudio()== null)
            return null;
        for (Audio audio: XMLParser.getNewDataSet().getAudio() ) {
            if (audio.getAssetGUID().equals(aGuid))
                return audio;
        }
        return null;
    }

    @Test(dataProvider = "oneUserOneAsset", dataProviderClass = MigrationDataProvider.class)
    public void getSpecWithFile(UsersAction usersAction) {
        String password = MongoUtils.getPassword(usersAction.getCurrentUser().getEmail()).trim();
        getService().logIn(usersAction.getCurrentUser().getEmail(), password);
        Map<String, List<Asset>> assetRelations = getChildAssetsAndSpec(usersAction.getOneAssetFromXML().getAssetGUID());
        List<Asset> list = assetRelations.get(usersAction.getOneAssetFromXML().getAssetGUID());

        String folder = System.getProperty("user.dir");
        String folderA = System.getProperty("user.dir");
        folder = folder.concat("\\").concat("speca.info");
        File file = new File((folder));
        for (Map.Entry<String, List<Asset>> map: assetRelations.entrySet()) {
            for (Asset asset: map.getValue()) {
                FileManager.saveIntoFile(file.getName(), "Asset with clockNumer: " + usersAction.getOneAssetFromXML().getUniqueName() + " and A4 GUID = " + usersAction.getOneAssetFromXML().getAssetGUID() + " has FileID = " + asset.getFileID() + " and SpecDocDbID = " + asset.getSpecDBDocID() + "\n");
            }
        }

    }

    private List<ProxyAsset> getProxyAssets(String aGuid) {
        List<ProxyAsset> result = new ArrayList<>();
        for (ProxyAsset proxyAsset: XMLParser.getNewDataSet().getProxyAsset()) {
            //&&
            if (proxyAsset.getParentAssetGuid().equals(aGuid) )
                if (proxyAsset.getSpecDBDocID()!=null && !proxyAsset.getSpecDBDocID().isEmpty())
                    result.add(proxyAsset);
                else
                if (proxyAsset.getAssetTypeID().equals("4") || proxyAsset.getAssetTypeID().equals("1"))
                    result.add(proxyAsset);
        }
        return result;
    }

    private Map<String, List<Asset>> getChildAssets(String aGuid) {
        List<AssetRelationship> assetRelationshipList = new ArrayList<>();
        List<Asset> result = new ArrayList<>();

        Map<String, List<Asset>> parentChildsRelation = new HashMap<>();
        List<Asset> childsAssetGUID = new ArrayList<>();
        parentChildsRelation.put(aGuid, childsAssetGUID);
        for (Asset childAsset: XMLParser.getNewDataSet().getAsset()) {
            if (childAsset.getParentAssetGuid()!= null && childAsset.getParentAssetGuid().equals(aGuid) && childAsset.getAssetTypeID().equals("999") && childAsset.getFileID()!=null && !childAsset.getFileID().isEmpty()) {
                childsAssetGUID.add(childAsset);
            }
        }
        for (AssetRelationship assetRelationship: XMLParser.getNewDataSet().getAssetRelationship()) {
            if (assetRelationship.getParentAssetGUID().equals(aGuid)) {
                assetRelationshipList.add(assetRelationship);
            }
        }
        for (AssetRelationship assetRelationship: assetRelationshipList) {
            for (Asset asset: XMLParser.getNewDataSet().getAsset()) {
                if (asset.getAssetGUID().equals(assetRelationship.getChildAssetGUID()) && asset.getAssetTypeID().equals("999") && asset.getFileID()!=null && !asset.getFileID().isEmpty()) {
                    childsAssetGUID.add(asset);
                    break;
                }
            }
        }

        return parentChildsRelation;
    }

    private Map<String, List<Asset>> getChildAssetsAndSpec(String aGuid) {
        List<AssetRelationship> assetRelationshipList = new ArrayList<>();
        List<Asset> result = new ArrayList<>();

        Map<String, List<Asset>> parentChildsRelation = new HashMap<>();
        List<Asset> childsAssetGUID = new ArrayList<>();
        parentChildsRelation.put(aGuid, childsAssetGUID);
        for (Asset childAsset: XMLParser.getNewDataSet().getAsset()) {
            if (childAsset.getParentAssetGuid()!= null && childAsset.getParentAssetGuid().equals(aGuid) && childAsset.getAssetTypeID().equals("999") && childAsset.getFileID()!=null && !childAsset.getFileID().isEmpty() && childAsset.getSpecDBDocID()!= null && (childAsset.getSpecDBDocID().contains("Unknown") || childAsset.getSpecDBDocID().contains("unknown"))) {
                childsAssetGUID.add(childAsset);
            }
        }
        for (AssetRelationship assetRelationship: XMLParser.getNewDataSet().getAssetRelationship()) {
            if (assetRelationship.getParentAssetGUID().equals(aGuid)) {
                assetRelationshipList.add(assetRelationship);
            }
        }
        for (AssetRelationship assetRelationship: assetRelationshipList) {
            for (Asset asset: XMLParser.getNewDataSet().getAsset()) {
                if (asset.getAssetGUID().equals(assetRelationship.getChildAssetGUID()) && asset.getAssetTypeID().equals("999") && asset.getFileID()!=null && !asset.getFileID().isEmpty() && asset.getSpecDBDocID()!= null && (asset.getSpecDBDocID().contains("Unknown") || asset.getSpecDBDocID().contains("unknown"))) {
                    childsAssetGUID.add(asset);
                    break;
                }
            }
        }

        return parentChildsRelation;
    }

    private List<Asset> getRelations(String aGuid) {
        List<AssetRelationship> assetRelationshipList = new ArrayList<>();
        List<Asset> result = new ArrayList<>();
        for (AssetRelationship assetRelationship: XMLParser.getNewDataSet().getAssetRelationship()) {
            if (assetRelationship.getParentAssetGUID().equals(aGuid)) {
                assetRelationshipList.add(assetRelationship);
            }
        }
        for (AssetRelationship assetRelationship: assetRelationshipList) {
            for (Asset asset: XMLParser.getNewDataSet().getAsset()) {
                if (asset.getAssetGUID().equals(assetRelationship.getChildAssetGUID())) {
                    result.add(asset);
                    break;
                }
            }
        }
        return result;
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

    private int getCountElementsByA5Type(Content assetApp, String name) {
        int result= 0;
        for (FilePreview filePreview: assetApp.getRevisions()[0].getPreview()) {
            if (filePreview.getA5Type().equalsIgnoreCase(name))
                result++;
        }
        return result;
    }

}
