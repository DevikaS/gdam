package com.adstream.automate.babylon.migration.tests.cases;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.FilePreview;
import com.adstream.automate.babylon.JsonObjects.SearchResult;
import com.adstream.automate.babylon.JsonObjects.usagerights.*;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.migration.objects.*;
import com.adstream.automate.babylon.migration.utils.FileManager;
import com.adstream.automate.babylon.migration.utils.MongoUtils;
import com.adstream.automate.babylon.migration.utils.XMLParser;
import com.adstream.automate.utils.Common;
import com.google.gson.internal.LinkedTreeMap;
import com.adstream.automate.babylon.migration.tests.BaseTest;
import org.joda.time.DateTime;
import org.testng.annotations.Test;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.File;
import java.io.IOException;
import java.io.StringWriter;
import java.util.*;

/**
 * Created with IntelliJ IDEA.
 * User: User
 * Date: 24.10.13
 * Time: 9:16

 */
public class DevTests extends BaseTest {

    @Test
    public void simpleOrdersTest() {
        getService().logIn(otherAgencyEmail, otherAgencyPassword);
        ProductOrder[] productOrders = XMLParser.getNewDataSet("[UPDATED XML OUTPUT] Beaumont Tiles_Created_2015-5-27T20-16-38-0000_Period_1753-1-01_2015-5-28.xml").getProductOrder();
        long allCount = productOrders.length;
        long errorCount = 0;
        Map<String, List<String>> orderItemsIdForVerify = new HashMap<>();
        for (ProductOrder productOrder: productOrders) {
            String a5orderId = MongoUtils.getOrderByA4GUID(productOrder.getProductOrderGUID());
            if (a5orderId == "0") {
                System.out.println(productOrder.getProductOrderGUID());
            }
            List<String> orderItemsGUID = MongoUtils.getOrderItems(a5orderId);
            //long countMongo = MongoUtils.getCountOfOrderItems(a5orderId);
            long countMongo = 0;
            for (String orderItem: orderItemsGUID) {
                countMongo+= MongoUtils.getTotalCountForOrderItems(orderItem);
            }
            long countXML = 0;
            if (productOrder.getProductOrderItems()!= null && productOrder.getProductOrderItems().getOrderItemsGUID()!=null)
                countXML = productOrder.getProductOrderItems().getOrderItemsGUID().length;
            if (countMongo != countXML) {
                orderItemsIdForVerify.put(a5orderId, orderItemsGUID);
                System.out.println(productOrder.getProductOrderGUID() + " XML/Mongo: [" + countXML + "/" + countMongo + "]  errors: " + ++errorCount + "/" + allCount);
            }

        }
        System.out.println();
    }


    @Test
    public void addAllInfoAboutAsset() {
        String sourceFile = "migration/src/main/resources/clock_numbers.txt";
        List<String> clockNumbers = FileManager.readTextFile(System.getProperty("user.dir").concat("\\").concat(sourceFile));
        for (String clockNumber: clockNumbers) {
            String fileName = clockNumber + ".xml";

        }

    }

    @Test
    public void getContent() {
        getService().logIn("a5-agencyadmin@test.com" ,"abcdefghA1");
        Content asset = getService().getContent("54180272e4b0eb7a44a06cf5");
        System.out.println();
    }

    @Test
    public void getUsersFromApp() {
        String sourceFile = "migration/src/main/resources/users_list.txt";
        List<String> usefulCN = FileManager.readTextFile(System.getProperty("user.dir").concat("\\").concat(sourceFile));
        BaseTest.getService().logIn("admin", "abcdefghA1");
        for (String str: usefulCN) {
            com.adstream.automate.babylon.JsonObjects.User appUser = getService().getUserByEmail(str);
            if (appUser!= null)
                System.out.println(appUser.getEmail() + " agency " + appUser.getAgency().getName());
        }

    }

    @Test
    public void getAssetInXlsxNoneXml() {
        String sourceFile = "migration/src/main/resources/1.txt";
        List<String> usefulCN = FileManager.readTextFile(System.getProperty("user.dir").concat("\\").concat(sourceFile));
        Map<String, String> map = new HashMap<>();
        for (String a4id: usefulCN) {
            map.put(a4id.split(";")[0].toUpperCase().trim(), a4id.split(";")[1].trim());
        }

        List<String> assetGUID = new ArrayList<>();
        for (Asset asset: XMLParser.getNewDataSet().getAsset()) {
            assetGUID.add(asset.getAssetGUID().toUpperCase());
        }
        for (String aaa: usefulCN) {
            if (!assetGUID.contains(aaa.split(";")[0].toUpperCase().trim()))
                System.out.println("GUID = " + aaa.split(";")[0].toUpperCase().trim() + " clock = " + map.get(aaa.split(";")[0].toUpperCase().trim()));
        }
    }

    @Test
    public void getAllUsersFromXML() {
        String sourceFile = "migration/src/main/resources/users_list3.txt";
        List<String> usefulCN = FileManager.readTextFile(System.getProperty("user.dir").concat("\\").concat(sourceFile));
        List<String> usersGUIDs = new ArrayList<>();
        String resultFile = "migration/src/main/resources/usersFromApp.txt";
        for (User user: XMLParser.getNewDataSet().getUser()) {
            if (usefulCN.contains(user.getEmail())) {
                usersGUIDs.add(user.getUserGUID());
                FileManager.saveIntoFile(System.getProperty("user.dir").concat("\\").concat(resultFile), user.getUserGUID() + " # " + user.getEmail() + "\n");
            }

        }
        for (Asset asset: XMLParser.getNewDataSet().getAsset()) {
            System.out.println(asset.getCreatedBy());
            //if (usersGUIDs.contains(asset.getCreatedBy().toUpperCase()))
            //System.out.println(asset.getAssetGUID() + " " + asset.getUniqueName());
        }
    }

    @Test
    public void getAssetsAreCreatedByUsersThisXMLAndOtherAgencies() {
        String sourceFile = "migration/src/main/resources/users_list3.txt";
        List<String> usefulCN = FileManager.readTextFile(System.getProperty("user.dir").concat("\\").concat(sourceFile));

    }

    @Test
    public void checkAllUsersFromXML() {
        BaseTest.getService().logIn("admin", "abcdefghA1");
        String sourceFile = "migration/src/main/resources/usersFromApp.txt";
        int allUsersSize = XMLParser.getNewDataSet().getUser().length;
        int counter = 1;
        for (User user: XMLParser.getNewDataSet().getUser()) {
            com.adstream.automate.babylon.JsonObjects.User appUser = getService().getUserByEmail(user.getEmail());
            if (appUser == null)
                FileManager.saveIntoFile(System.getProperty("user.dir").concat("\\").concat(sourceFile), user.getUserGUID() + " # " + user.getEmail() + ":                                                       empty\n");
            else {
                try {
                    FileManager.saveIntoFile(System.getProperty("user.dir").concat("\\").concat(sourceFile), user.getUserGUID() + " # " + user.getEmail() + ":                                                    " + appUser.getAgency().getName() + "\n");
                }
                catch (Throwable t) {
                    FileManager.saveIntoFile(System.getProperty("user.dir").concat("\\").concat(sourceFile), user.getUserGUID() + " # " + user.getEmail() + "\n");
                }

            }
            System.out.println("Progress: " +  counter++ + " / " + allUsersSize);
        }
    }

    @Test
    public void getOtherTypes() {
        String sourceFile = "migration/src/main/resources/xlr8_add_assets.txt";
        List<String> usefulCN = FileManager.readTextFile(System.getProperty("user.dir").concat("\\").concat(sourceFile));
        List<String> usersGUIDs = new ArrayList<>();
        for (Asset asset: XMLParser.getNewDataSet().getAsset()) {
            if (asset.getStatus()!=null && asset.getStatus().startsWith("Awaiting")) {
                usersGUIDs.add(asset.getAssetGUID().toUpperCase());
            }
        }
        for (String str: usefulCN) {
            if (!usersGUIDs.contains(str))
                System.out.println(str);
        }
    }

    @Test
    public void getCampaignByUniqueName() {
        String sourceFile = "migration/src/main/resources/ex_list_need.txt";
        List<String> usefulCN = FileManager.readTextFile(System.getProperty("user.dir").concat("\\").concat(sourceFile));
        for (String clockNumber: usefulCN) {
            for (Asset asset: XMLParser.getNewDataSet().getAsset()) {
                if (asset.getUniqueName()!= null && asset.getUniqueName().equalsIgnoreCase(clockNumber)) {
                    if (asset.getCampaignName()!= null) {
                        System.out.println(clockNumber + " -> " + asset.getCampaignName());
                        break;
                    }
                }
            }
        }
    }

    @Test
    public void getAssetsNotInList() {
        String sourceFile = "migration/src/main/resources/ex_list_need.txt";
        List<String> usefulCN = FileManager.readTextFile(System.getProperty("user.dir").concat("\\").concat(sourceFile));
        List<String> assetsGUIDs = new ArrayList<>();
        SortedMap<String, Integer> map = new TreeMap<>();
        int counter = 0;
        for (Asset asset: XMLParser.getNewDataSet().getAsset()) {
            if (!asset.getAssetTypeID().equals("999")) {
                counter++;
                if (map.containsKey(asset.getUniqueName())) {
                    Integer counter1 = map.get(asset.getUniqueName());
                    counter1++;
                    map.put(asset.getUniqueName(), counter1);
                }
                else
                    map.put(asset.getUniqueName(), 1);
                if (!usefulCN.contains(asset.getUniqueName())) {
                    assetsGUIDs.add(asset.getUniqueName());
                    System.out.println(asset.getUniqueName());

                }

            }
        }
        for (Map.Entry<String, Integer> iterator: map.entrySet()) {
            if (iterator.getValue()> 1)
                System.out.println(iterator.getKey() + " -> " + iterator.getValue());
        }
    }

    @Test
    public void getA5IdIntoFile() {
        String sourceFile = "migration/src/main/resources/ex_list_need.txt";
        String resultFile = "migration/src/main/resources/FerefA5Id.txt";
        List<String> a4IDs = FileManager.readTextFile(System.getProperty("user.dir").concat("\\").concat(sourceFile));
        getService().logIn(otherAgencyEmail, otherAgencyPassword);
        int emptyCount= 0;
        for (String a4id: a4IDs)  {
            FileManager.saveIntoFile(System.getProperty("user.dir").concat("\\").concat(resultFile), getA5Id(a4id)  + "\n");
        }
    }

    @Test
    public void ediAssetMetadataAssetsFromXML() {
        //List<String> categories = DictionaryUtils.getDictionaryForAgency(usersAction.getOneAssetFromXML().getAgencyName(), "Category_1388675170700");
        //List<String> categories = DictionaryUtils.getDictionaryForAgency(usersAction.getOneAssetFromXML().getAgencyName(), "Category");
        String sourceFile = "migration/src/main/resources/ex_list_need.txt";
        List<String> a4IDs = FileManager.readTextFile(System.getProperty("user.dir").concat("\\").concat(sourceFile));
        getService().logIn(otherAgencyEmail, otherAgencyPassword);
        int emptyCount= 0;
        for (String a4id: a4IDs) {
            String a5Id = getA5Id(a4id);
            if (a5Id.isEmpty())
                emptyCount++;
            else {
                Content content = getService().getAsset(a5Id);
                String CreativeAgency_1398765336987 = "KIEVTEST migration";
                //content.getCm().getOrCreateNode("common").put("CreativeAgency_1398765336987", asList(CreativeAgency_1398765336987));
                //content.getCm().getOrCreateNode("common").put("Campaign", asList(CreativeAgency_1398765336987));
                content.getCm().getOrCreateNode("common").put("Campaign", CreativeAgency_1398765336987);
                //content.getCm().getOrCreateNode("common").put("InformationSecurityClassification_1398766259802", asList("Public"));
                //content.getCm().getOrCreateNode("common").put("ContentLanguage_1398766392819", asList("English"));
                Content contentAfterUpdate = getService().updateAsset(content);
                //String newCategoriesValue = contentAfterUpdate.getCm().getOrCreateNode("common").getStringArray("CreativeAgency_1398765336987")[0];
                String newCategoriesValue = contentAfterUpdate.getCm().getOrCreateNode("common").getString("Campaign");

            }
            //System.out.println("Info: Updated / ALL [" + updatedCount + " / " + a4IDs.size() + "] and empty: " + emptyCount + " and isn't updated: " + wrongUpdate);
        }

    }

    @Test
    public void checkClocksForSpecialCollection() {
        String sourceFile = "migration/src/main/resources/ex_list_need1.txt";
        List<String> clockNumbers = FileManager.readTextFile(System.getProperty("user.dir").concat("\\").concat(sourceFile));
        getService().logIn(otherAgencyEmail, otherAgencyPassword);
        List<Content> allAssets = getService().getAllAssetByName("542e30dae4b0c8b9d46b4029");
        if (clockNumbers.size() == allAssets.size()) {
            for (int i=0; i< clockNumbers.size(); i++) {
                if (!clockNumbers.contains(allAssets.get(i).getCm().getOrCreateNode("video").get("clockNumber"))) {
                    System.out.println("CN = " + allAssets.get(i).getCm().getOrCreateNode("video").get("clockNumber"));
                }
            }
        }
    }


    @Test
    public void getAssetsCount() {
        int counter = 0;
        int counterODT = 0;
        int counterTVC = 0;
        int counterAudio = 0;

        //String sourceFile = "migration/src/main/resources/all_a4IDs.txt";
        int a = XMLParser.getNewDataSet().getVideo().length;
        for (Asset asset: XMLParser.getNewDataSet().getAsset()) {
            if (!asset.getAssetTypeID().equals("999")) {
                counter++;
            }

            else
                counterODT++;
            if (asset.getAssetTypeID()!=null) {
                if (asset.getAssetTypeID().equals("4")) {
                    counterAudio++;
                    if (Integer.parseInt(asset.getLifecycleID())>1)
                        System.out.println();
                    //FileManager.saveIntoFile(System.getProperty("user.dir").concat("\\").concat(sourceFile), asset.getAssetGUID() + "\n");
                }
                else {
                    if (asset.getStatus()!=null && asset.getStatus().startsWith("TVC")) {
                        counterTVC++;
                        if (Integer.parseInt(asset.getLifecycleID())>1)
                            System.out.println();
                        //FileManager.saveIntoFile(System.getProperty("user.dir").concat("\\").concat(sourceFile), asset.getAssetGUID() + "\n");
                    }

                }
            }

        }
        System.out.println(counter);
        System.out.println(counterODT);
        System.out.println(counterTVC);
        System.out.println(counterAudio);
    }

    @Test
    public void checkA5IdBySpecialA4Id() {
        String sourceFile = "migration/src/main/resources/all_a4IDs.txt";
        List<String> a4IDs = FileManager.readTextFile(System.getProperty("user.dir").concat("\\").concat(sourceFile));
        getService().logIn(otherAgencyEmail, otherAgencyPassword);
        List<String> noneA4IDs = new ArrayList<>();
        int emptyA5Id = 0;
        int noneEmptyA5Id = 0;
        for (String a4Id: a4IDs) {
            String a5id = getA5Id(a4Id);
            if (a5id.isEmpty()) {
                emptyA5Id++;
                System.out.println("A4 = " + a4Id);
                noneA4IDs.add(a4Id);
            }
            else {
                System.out.println(++noneEmptyA5Id);
            }

        }
        for (String str: noneA4IDs) {
            System.out.println(str);
        }
        System.out.println(emptyA5Id);
        System.out.println(noneEmptyA5Id);
    }

    @Test
    public void checkXMLAndCollections() {
        String sourceFile = "migration/src/main/resources/storageA4IDs1.txt";
        List<String> a4IDs = FileManager.readTextFile(System.getProperty("user.dir").concat("\\").concat(sourceFile));
        int counter = 0;
        for (Asset asset: XMLParser.getNewDataSet().getAsset()) {
            if (!asset.getAssetTypeID().equals("999")) {
                if (!a4IDs.contains(asset.getAssetGUID())) {
                    counter++;
                    System.out.println(asset.getUniqueName());
                }
            }
        }
        System.out.println("counter = " + counter);
    }

    @Test
    public void getAllAssetsGUID() {
        List<String> newList = new ArrayList<>();
        for (Asset asset: XMLParser.getNewDataSet().getAsset()) {
            if (!asset.getAssetTypeID().equals("999")) {
                newList.add(asset.getAssetGUID());
            }
        }
        Collections.sort(newList);
        for (String str: newList) {
            System.out.println(str.toUpperCase());
        }
    }

    @Test
    public void findProxyWithStreaming() {
        Map<String, Long> map = new TreeMap<>();
        for (ProxyAsset proxyAsset: XMLParser.getNewDataSet().getProxyAsset()) {
            if (proxyAsset.getSpecDBDocID()!=null && !proxyAsset.getSpecDBDocID().isEmpty()) {
                if (map.containsKey(proxyAsset.getSpecDBDocID())) {
                    Long count = map.get(proxyAsset.getSpecDBDocID());
                    map.put(proxyAsset.getSpecDBDocID(), ++count);
                }
                else
                    map.put(proxyAsset.getSpecDBDocID(), 1L);
            }
        }
        for (Map.Entry<String, Long> map1: map.entrySet()) {
            System.out.println(map1.getKey() + " ---> " + map1.getValue());
        }
    }

    @Test
    public void getA5ByA4() {
        String sourceFile = "migration/src/main/resources/a4_work.txt";
        String resultFile = "migration/src/main/resources/a5_work.txt";
        getService().logIn(otherAgencyEmail, otherAgencyPassword);

        List<String> a4IDs = FileManager.readTextFile(System.getProperty("user.dir").concat("\\").concat(sourceFile));
        for (String a4: a4IDs) {
            FileManager.saveIntoFile(System.getProperty("user.dir").concat("\\").concat(resultFile), getA5Id(a4) + "\n");
        }
    }

    @Test
    public void findProxyWithSomeVideoProxy() {
        String resultFileA4Double = "migration/src/main/resources/a4_double.txt";
        String resultFileA4ClockDouble = "migration/src/main/resources/a4_double_proxies.txt";

        String resultFileA4MustWork = "migration/src/main/resources/a4_work.txt";
        String resultFileA4ClockMustWork = "migration/src/main/resources/a4_clock_work.txt";

        String resultFileA4DoesNotWork = "migration/src/main/resources/a4_not_work.txt";
        String resultFileA4ClockDoesNotWork = "migration/src/main/resources/a4_invalid_proxies.txt";

        String resultFileA4EmptyProxies = "migration/src/main/resources/a4_empty.txt";
        String resultFileA4ClocksEmptyProxies = "migration/src/main/resources/a4_empty_proxies.txt";

        //

        Map<String, Integer> map = new HashMap<>();
        int failCounter = 0;
        for (Asset asset: XMLParser.getNewDataSet().getAsset()) {
            if (asset.getAssetTypeID().equals("999")) continue;
            boolean ingested = (asset.getAssetTypeID().equals("3") && asset.getSubAssetTypeID().equals("1") && !asset.getStatusID().equals("5"));
            if (ingested) continue;
            List<ProxyAsset> proxyAssetList = getProxyAssets(asset.getAssetGUID());
            if (proxyAssetList.size() == 0) {
                System.out.println(asset.getUniqueName());
                FileManager.saveIntoFile(System.getProperty("user.dir").concat("\\").concat(resultFileA4EmptyProxies), asset.getAssetGUID() + "\n");
                FileManager.saveIntoFile(System.getProperty("user.dir").concat("\\").concat(resultFileA4ClocksEmptyProxies), "A4 GUID = " + asset.getAssetGUID()  +  ", ClockNumber = " + asset.getUniqueName() + "\n");

                continue;
            }
            int counter= 0;

            String a4GUID = "";
            String clockNumber = "";
            boolean isFileID = true;
            boolean isFileSize = true;
            for (ProxyAsset proxyAsset: proxyAssetList) {
                if (proxyAsset.getSpecDBDocID()!= null && (proxyAsset.getSpecDBDocID().contains(":video:proxy:") || proxyAsset.getSpecDBDocID().contains(":video:streaming"))) {
                    a4GUID = asset.getAssetGUID();
                    clockNumber = asset.getUniqueName();
                    if (proxyAsset.getFileId()==null || proxyAsset.getFileId().isEmpty())
                        isFileID= false;
                    if (proxyAsset.getFileId()!= null && (proxyAsset.getFileSize()==null || proxyAsset.getFileId().isEmpty() || proxyAsset.getFileId().equals("0")))
                        isFileSize= false;

                    counter++;
                }
            }
            if (counter>1) {
                FileManager.saveIntoFile(System.getProperty("user.dir").concat("\\").concat(resultFileA4Double), asset.getAssetGUID() + "\n");
                FileManager.saveIntoFile(System.getProperty("user.dir").concat("\\").concat(resultFileA4ClockDouble), "A4 GUID = " + asset.getAssetGUID()  +  ", ClockNumber = " + asset.getUniqueName() + "\n");

            }

            else {
                if (!isFileID) {
                    FileManager.saveIntoFile(System.getProperty("user.dir").concat("\\").concat(resultFileA4DoesNotWork), asset.getAssetGUID() + "\n");
                    FileManager.saveIntoFile(System.getProperty("user.dir").concat("\\").concat(resultFileA4ClockDoesNotWork), "A4 GUID = " + asset.getAssetGUID()  +  ", ClockNumber = " + asset.getUniqueName() + "\n");
                }
                else {
                    FileManager.saveIntoFile(System.getProperty("user.dir").concat("\\").concat(resultFileA4MustWork), asset.getAssetGUID() + "\n");
                    FileManager.saveIntoFile(System.getProperty("user.dir").concat("\\").concat(resultFileA4ClockMustWork), "A4 GUID = " + asset.getAssetGUID()  +  ", ClockNumber = " + asset.getUniqueName() + "\n");

                }
            }
        }
        for (Map.Entry<String, Integer> iterator: map.entrySet()) {
            //System.out.println(iterator.getKey() + " -> " + iterator.getValue());
        }

    }

    @Test
    public void prepareStreamingAssets() {
        String sourceFile = "migration/src/main/resources/assets_streaming_PG.txt";
        List<ProxyAsset> streamingPA = new LinkedList<>();
        List<String> streamingPAParentGUIDs = new LinkedList<>();
        List<Asset> streamingAssets = new LinkedList<>();
        for (ProxyAsset proxyAsset: XMLParser.getNewDataSet().getProxyAsset()) {
            if (proxyAsset.getSpecDBDocID()!= null && proxyAsset.getSpecDBDocID().contains("streaming")) {
                streamingPA.add(proxyAsset);
                streamingPAParentGUIDs.add(proxyAsset.getParentAssetGuid());
            }
        }
        for (Asset asset: XMLParser.getNewDataSet().getAsset()) {
            if (streamingPAParentGUIDs.contains(asset.getAssetGUID()) && !asset.getAssetTypeID().equals("999")) {
                streamingAssets.add(asset);
                FileManager.saveIntoFile(System.getProperty("user.dir").concat("\\").concat(sourceFile), asset.getAssetGUID().toUpperCase() + "\n");
            }
        }
        int counterTVC= 0;
        int counterVideoNotTVC= 0;
        int counterAudio= 0;
        int counterVideo= 0;
        for (Asset asset: streamingAssets) {
            if (asset.getAssetType().equalsIgnoreCase("Video")) {
                counterVideo++;
                if (asset.getStatus()!= null && asset.getStatus().equalsIgnoreCase("TVC Ingested OK"))
                    counterTVC++;
                else
                    counterVideoNotTVC++;
            }
            else
                counterAudio++;

        }
        System.out.println(counterTVC);
        System.out.println(counterVideoNotTVC);
        System.out.println(counterAudio);
        System.out.println(counterVideo);
    }

    @Test
    public void getUsersCountInDb() {
        LuceneSearchingParams query = new LuceneSearchingParams();
        //"agency._id":ObjectId("53c42541e4b01466dd7341ee"
        //query.setQuery("agency._id:ObjectId(\"53c42541e4b01466dd7341ee\")");
        query.setQuery("_id:\"526105ece4b0eebced9f5288\"");
        query.setResultsOnPage(1000);
        // BaseTest.getService().logIn("procterandgamble@hotmail.co.uk.ua", "welcome");
        BaseTest.getService().logIn("admin", "abcdefghA1");

        List<com.adstream.automate.babylon.JsonObjects.User> users = getService().findUsers(query).getResult();
        int i=0;
        int k=0;
        for (com.adstream.automate.babylon.JsonObjects.User user: users) {
            //if (!user.getEmail().endsWith(".ua"))
            //    System.out.println("Wrong " + ++k);
            /*if (user.getEmail().endsWith(".ua")) continue;*/
            String newEmail = user.getEmail().concat(".ua");
            user.setEmail(newEmail);
            com.adstream.automate.babylon.JsonObjects.User newUser = getService().updateUser(user.getId(), user);
            System.out.println(++i);
        }
        System.out.println();
    }

    @Test
    public void checkXMLCreatedBy() {
        int is= 0;
        int isNot = 0;
        for (Asset asset: XMLParser.getNewDataSet().getAsset()) {
            if (asset.getCreatedBy().equalsIgnoreCase("929bac26-9b22-4195-98cf-572c75087363"))
                is++;
            else {
                isNot++;
                System.out.println(asset.getAssetGUID() + " - type: " + asset.getAssetTypeID());
            }

        }
        System.out.println("is = " + is);
        System.out.println("isNot = " + isNot);
    }


    @Test
    public void updateUser() {
        BaseTest.getService().logIn("admin", "abcdefghA1");
        String userId = getService().getUserByEmail("traffic.nl@adstream.com").getId();
        //getService().executePost(userId);
    }

    @Test
    public void getA5InfoForDebug() {
        String a4Id = "8b970453-2105-48dd-9fb8-ef3de997de26";
        String a5Id = getA5Id(a4Id);
        getService().logIn("andrea.ulmx@adstream.com", "adstream01");
        Content assetApp = getService().getAsset(a5Id);
        System.out.println();
    }

    @Test
    public void getInfoAboutAgency() {
        String mainAgency = "18912456-6c46-4ae1-8881-e71cf020b292";
        int countOfOtherAsset= 0;
        int countOfPGAsset= 0;
        Map<String, Long> agencies = new HashMap<>();
        //for (Asset asset: XMLParser.getNewDataSet().getAsset() ) {
        for (User asset: XMLParser.getNewDataSet().getUser() ) {
            if (asset.getAgencyGUID()== null) continue;
            if (agencies.containsKey(asset.getAgencyGUID())) {
                long count = agencies.get(asset.getAgencyGUID());
                count++;
                agencies.put(asset.getAgencyGUID(), count);
            }
            else {
                agencies.put(asset.getAgencyGUID(), 1L);
            }
            /*if (asset.getAgencyGUID()== null) {
                countOfOtherAsset++;
            }
            else if (asset.getAgencyGUID().equalsIgnoreCase(mainAgency)) {
                countOfPGAsset++;
            }
            else
                countOfOtherAsset++;*/
        }

        for (Map.Entry<String, Long> map: agencies.entrySet()) {
            System.out.println(map.getKey() + " :     " + map.getValue());
        }
        System.out.println("countOfOtherAsset = " + countOfOtherAsset);
        System.out.println("countOfPGAsset = " + countOfPGAsset);
    }


    @Test
    public void checkSpec() {
        int generalCounter = 0;
        int successfulCounter= 0;
        for (Asset asset: XMLParser.getNewDataSet().getAsset() ) {
            if (asset.getAssetTypeID().equals("999")) {
                generalCounter++;
                if (asset.getSpecDBDocID()== null || asset.getSpecDBDocID().isEmpty() ||asset.getSpecDBDocID().equalsIgnoreCase("fake")) {
                    continue;
                }
                String realSpecDoc = asset.getSpecDBDocID();
                String customSpecDoc = changeSpecDBName(asset);
                String[] realSpecDocArray = realSpecDoc.split(":");
                String[] customSpecDocArray = customSpecDoc.split(":");
                successfulCounter++;
                if (!realSpecDocArray[1].equals(customSpecDocArray[1]) || !realSpecDocArray[2].equals(customSpecDocArray[2])) {
                    System.out.println("Checked: All / Condition " + generalCounter + " / " + successfulCounter + asset.getAssetGUID() + " " + asset.getUniqueName());
                }
                else {
                    System.out.println("Checked: All / Condition " + generalCounter + " / " + successfulCounter);
                }

            }
        }
    }

    public static void updateNode() throws IOException, SAXException, ParserConfigurationException, TransformerException {
        DocumentBuilderFactory dbf =
                DocumentBuilderFactory.newInstance();
        DocumentBuilder db = dbf.newDocumentBuilder();
        Document doc = db.parse (new File("migration/src/main/resources/ADOPTED_2014_06_20_0001_Initiative Argentina.xml"));
        String generalAgencyName = "Initiative Argentina";
        String generalAgencyGUID = "27f2574d-4ac1-4320-973a-f21e3c995417";
        String userCreator = "aad54366-124a-42a2-af10-04392f9e05e1";
        updateAttribute(doc, "CreatedBy", "Asset", userCreator);
        updateAttribute(doc, "LastUpdatedBy", "Asset", userCreator);
        updateAttribute(doc, "AgencyName", "Asset", generalAgencyName);
        updateAttribute(doc, "AgencyGUID", "Asset", generalAgencyGUID);
        updateAttribute(doc, "AgencyName", "User", generalAgencyName);
        updateAttribute(doc, "AgencyGUID", "User", generalAgencyGUID);

        printXML(doc);
    }

    public static void updateAttribute(Document doc, String name, String parentName, String value) {
        NodeList nodes = doc.getElementsByTagName(parentName);
        for (int i = 0; i < nodes.getLength(); i++) {
            Element person = (Element)nodes.item(i);
            Element name1 = (Element)person.getElementsByTagName(name).item(0);
            String beamAgencyID = "e4cda978-d392-47ee-998e-b8f5fe772328";
            String beamUserID = "aad54366-124a-42a2-af10-04392f9e05e1";
            String iaAgencyID = "27f2574d-4ac1-4320-973a-f21e3c995417";
            String iaUserID = "b71b51cb-85cb-46a0-834a-085301a4818b";
            if (person.getElementsByTagName("AgencyName").item(0) == null || person.getElementsByTagName("AgencyName").item(0).getTextContent().isEmpty()) continue;
            if (name.endsWith("By")) {
                String agencyID = person.getElementsByTagName("AgencyGUID").item(0).getTextContent();
                if (name1!=null && agencyID.equalsIgnoreCase(beamAgencyID)) {
                    name1.setTextContent(beamUserID);
                }
                if (name1!=null && agencyID.equalsIgnoreCase(iaAgencyID)) {
                    name1.setTextContent(iaUserID);
                }

            }
            else {
                if (name1!=null && !name1.getTextContent().equalsIgnoreCase(value))
                    name1.setTextContent(value);
            }
        }

    }

    public static void deleteNode() throws ParserConfigurationException, IOException, SAXException, TransformerException {
        DocumentBuilderFactory dbf =
                DocumentBuilderFactory.newInstance();
        DocumentBuilder db = dbf.newDocumentBuilder();
        Document doc = db.parse (new File("migration/src/main/resources/0_ADOPTED_2014_06_20_0001_Unilever Mexico.xml"));
        //deleteAsset(doc, "Audio");
        deleteAttribute(doc, "CreativeDirector", "Video");
        deleteAttribute(doc, "PostProduction", "Video");
        deleteAttribute(doc, "ProductionCompany", "Video");
        deleteAttribute(doc, "ArtDirector", "Video");
        deleteAttribute(doc, "Producer", "Video");
        deleteAttribute(doc, "Director", "Video");
        deleteAttribute(doc, "RegulatoryApproval", "Asset");
        deleteAttribute(doc, "RegulatoryApprovalGUID", "Asset");

        printXML(doc);
    }

    public static void deleteAttribute(Document doc, String name, String parentName) {
        NodeList nodes = doc.getElementsByTagName(parentName);
        for (int i = 0; i < nodes.getLength(); i++) {
            Element person = (Element)nodes.item(i);
            Element name1 = (Element)person.getElementsByTagName(name).item(0);
            if (name1!= null) {
                person.removeChild(name1);
            }
        }
    }

    public static void deleteAsset(Document doc, String assetType) {
        NodeList nodes = doc.getElementsByTagName("Asset");

        for (int i = 0; i < nodes.getLength(); i++) {
            Element person = (Element)nodes.item(i);
            // <name>
            Element name = (Element)person.getElementsByTagName("AssetType").item(0);
            String pName = name.getTextContent();
            System.out.println(pName);
            if (pName.trim().equalsIgnoreCase(assetType)) {
                person.getParentNode().removeChild(person);
            }
        }
    }

    public static void printXML(Document doc)
            throws TransformerException {
        Transformer transformer = TransformerFactory.newInstance().newTransformer();
        transformer.setOutputProperty(OutputKeys.INDENT, "yes");

        StreamResult result = new StreamResult(new StringWriter());
        DOMSource source = new DOMSource(doc);
        transformer.transform(source, result);

        String xmlString = result.getWriter().toString();
        FileManager.saveIntoFile("C:\\0_ADOPTED_2014_06_20_0001_Unilever Mexico.xml", xmlString);
    }

    @Test
    public void additionScript() {
        String[] assetsName = new String[] {
                "AD-Imago-tag-010",
                "BMW-Joyride-tvc-025",
                "ETOS-tag-005",
                "BEPA-Scratches-tvc-020",
                "CORA-Fury-CHDE-V3-tvc-020",
                "ANDR-Teddy-tvc-040",
                "ANDR-Game-tvc-030",
                "ANDR-Leven-tvc-040",
                "ANDR-Nucleus-tag-015",
                "ANDR-Nachtwonder-tag-015",
                "CORA-Fury-CHDE-V3-tvc-020"
        };
        getService().logIn("traffic.nl@adstream.com", "Adstream");
        String collectionId = getService().getAssetsFilterByName("Everything", "").getId();
        List<String> assetsId = new ArrayList<>();
        for (String assetName: assetsName) {
            List<Content> assetApp = getService().getAllAssetByName(collectionId, assetName);
            for (Content content: assetApp) {
                log.info(assetName+ ": " + content.getId());
                assetsId.add(content.getId());
            }
        }
        for (String id: assetsId) {
            getService().getAsset(id);
        }
    }

    @Test
    public void checkDBQuery() {
        String a5id = getA5Id("cc4917b3-52ff-4e58-841c-43fad0a1f674");
        System.out.println();
    }

    @Test
    public void getMigrationReport() {
        MongoUtils.getMigrationReport();
    }

    @Test
    public void checkA4IDsOfSpecialCollection() {
        String sourceFile = "migration/src/main/resources/storageA4IDs1.txt";
        getService().logIn(otherAgencyEmail, otherAgencyPassword);
        String collectionId = "54046db0e4b02f6ba6f9c249";
        List<Content> contentList = new ArrayList<>();
        List<String> a5idList = new ArrayList<>();
        boolean isMore = true;
        int page= 1;
        LuceneSearchingParams query = new LuceneSearchingParams();
        query.setResultsOnPage(900);
        query.setSortingField("_created");
        query.setSortingOrder("desc");
        while (isMore) {
            query.setPageNumber(page++);
            SearchResult<Content> assets = getService().findAssets(collectionId, query);
            for (Content asset: assets.getResult()) {
                contentList.add(asset);
                if (a5idList.contains(asset.getId())) {
                    System.out.println();
                }
                a5idList.add(asset.getId());
            }
            isMore = assets.hasMore();

        }
        int correctAssets= 0;
        int wrongAssets= 0;
        for (Content asset: contentList) {
            /*if (checkPreviewContainsStreaming(asset))
                correctAssets++;
            else {
                wrongAssets++;
                System.out.println(asset.getId());
            } */
            String a4Id = getA4IdByA5Id(asset.getId());
            FileManager.saveIntoFile(System.getProperty("user.dir").concat("\\").concat(sourceFile), a4Id + "\n");


        }
        System.out.println("Correct = " + correctAssets);
        System.out.println("Wrong = " + wrongAssets);
    }

    @Test
    public void compareDeletePGAssetsWithXML() {
        String sourceFile = "migration/src/main/resources/storageA4IDs.txt";
        List<String> a4IDs = FileManager.readTextFile(System.getProperty("user.dir").concat("\\").concat(sourceFile));
        int counter= 0;
        for (Asset asset: XMLParser.getNewDataSet().getAsset()) {
            if (!a4IDs.contains(asset.getAssetGUID())) {
                System.out.println(asset.getAssetGUID());
                counter++;
            }
        }
        System.out.println("COUNTER = " + counter);
    }

    @Test
    public void checkFile() {
        String sourceFile = "migration/src/main/resources/storageA4IDs1.txt";
        String resultFile = "migration/src/main/resources/storageA4IDs11.txt";
        List<String> a4IDs = FileManager.readTextFile(System.getProperty("user.dir").concat("\\").concat(sourceFile));
        List<String> newA4IDs = new ArrayList<>();
        int doubleIds = 0;
        for (String a4: a4IDs) {
            if (!newA4IDs.contains(a4)) {
                newA4IDs.add(a4);
                FileManager.saveIntoFile(System.getProperty("user.dir").concat("\\").concat(resultFile), a4 + "\n");
            }
            else
                doubleIds++;
        }
        System.out.println("double: " + doubleIds);
    }

    @Test
    public void getClocksAndOther() {
        //String sourceAPPFile = "migration/src/main/resources/a4_isinAPP.txt";
        String sourceAPPFile = "migration/src/main/resources/all_a4IDs.txt";
        String resultStreamingFile = "migration/src/main/resources/Streaming2.txt";
        List<String> a4APPIDs = FileManager.readTextFile(System.getProperty("user.dir").concat("\\").concat(sourceAPPFile));
        getService().logIn(otherAgencyEmail, otherAgencyPassword);
        int countStreaming = 0;
        int countNoneStreaming = 0;
        int countNullContent = 0;
        int countWithoutProxy = 0;
        List<String> streaming = new ArrayList<>();
        for (String a4: a4APPIDs) {
            boolean isStreaming = false;
            String a5id = getA5Id(a4);
            Content asset = getService().getAsset(a5id);
            if (asset!= null) {
                isStreaming = false;
                try {
                    isStreaming = checkPreviewContainsStreaming(asset);
                }catch (Throwable t) {
                    countWithoutProxy++;
                }

                if (isStreaming) {
                    System.out.println("Streaming: " + countStreaming++);
                    streaming.add(a4);
                }
                else {
                    System.out.println("None streaming: " + countNoneStreaming++);
                }
            }
            else {
                countNullContent++;
                System.out.println("Null: " + countNullContent);
            }
            //System.out.println(asset.getCm().getOrCreateNode("video").getStringArray("clockNumber")[0] + " contains streaming: " + isStreaming + " A5 Id: " + a5id);
        }
        System.out.println("Streaming: " + countStreaming);
        System.out.println("Not Streaming: " + countNoneStreaming);
        System.out.println("Null: " + countNullContent);
        System.out.println("Content without proxy: " + countWithoutProxy);
        for (String str: streaming) {
            FileManager.saveIntoFile(System.getProperty("user.dir").concat("\\").concat(resultStreamingFile), str + "\n");
        }
    }

    @Test
    public void checkDifferenceBetweenA4IDs() {
        String sourceAPPFile = "migration/src/main/resources/storageA4IDs1.txt";
        String sourceXMLFile = "migration/src/main/resources/ex_list_need.txt";
        List<String> a4APPIDs = FileManager.readTextFile(System.getProperty("user.dir").concat("\\").concat(sourceAPPFile));
        List<String> a4XMLIDs = FileManager.readTextFile(System.getProperty("user.dir").concat("\\").concat(sourceXMLFile));
        List<String> isInAppNoneXML = new ArrayList<>();
        List<String> isInXMLNoneApp = new ArrayList<>();
        for (String a4: a4APPIDs) {
            if (!a4XMLIDs.contains(a4.toUpperCase())) {
                isInAppNoneXML.add(a4);
                System.out.println("It is in APP none XML " + a4);
            }
        }
        for (String a4: a4XMLIDs) {
            if (!a4APPIDs.contains(a4.toLowerCase())) {
                isInXMLNoneApp.add(a4);
                System.out.println("It is in XML none APP " + a4);
            }
        }

    }

    public static void main(String[] args) throws ParserConfigurationException, TransformerException, SAXException, IOException {
        DevTests devTests = new DevTests();
        String sourceFile = "migration/src/main/resources/ex_list_need.txt";
        String sourceA5File = "migration/src/main/resources/FerefA5Id.txt";
        List<String> a4IDs = FileManager.readTextFile(System.getProperty("user.dir").concat("\\").concat(sourceFile));
        List<String> a5IDs = FileManager.readTextFile(System.getProperty("user.dir").concat("\\").concat(sourceA5File));
        getService().logIn(otherAgencyEmail, otherAgencyPassword);
        int emptyCount= 0;
        int updatedCount= 0;
        int wrongUpdate = 0;
        List<String> a5isEmpty = new ArrayList<>();
        //for (String a4id: a4IDs) {
        for (String a5Id: a5IDs) {
            //String a5Id = devTests.getA5Id(a4id.toLowerCase());
            if (a5Id.isEmpty()) {
                emptyCount++;
                //System.out.println("A4 = " + a4id);
                //a5isEmpty.add(a4id);
            }

            else {
                boolean isUpdated = false;
                int repeatCount = 0;
                try {
                    Content content = getService().getAsset(a5Id);
                    //String CreativeAgency_1398765336987 = "KIEVTEST migration";
                    String Fordeletion_1412248077182 = "KIEVTEST migration";
                    //String year = "2000";
                    //String KievTestdrop_1409576245148 = "second deletion";
                    //String KIEVTESTmigration_1409818652198 = "for deletion";
                    content.getCm().getOrCreateNode("video").put("Fordeletion_1412313012140", Fordeletion_1412248077182);
                    //content.getCm().getOrCreateNode("common").put("CreativeAgency_1398765336987", asList(CreativeAgency_1398765336987));
                    //content.getCm().getOrCreateNode("common").put("KievTestdrop_1409576245148", asList(KievTestdrop_1409576245148));
                    //content.getCm().getOrCreateNode("common").put("KIEVTESTmigration_1409818652198", asList(KIEVTESTmigration_1409818652198));
                    //content.getCm().getOrCreateNode("common").put("InformationSecurityClassification_1398766259802", asList("Public"));
                    //content.getCm().getOrCreateNode("common").put("ContentLanguage_1398766392819", asList("English"));
                    Content contentAfterUpdate = getService().updateAsset(content);
                    //String newCategoriesValue = contentAfterUpdate.getCm().getOrCreateNode("common").getStringArray("CreativeAgency_1398765336987")[0];
                    //String newCategoriesValue = contentAfterUpdate.getCm().getOrCreateNode("common").getStringArray("CreativeAgency_1398765336987")[0];
                    String newCategoriesValue = contentAfterUpdate.getCm().getOrCreateNode("video").getString("Fordeletion_1412313012140");
                    updatedCount++;
                    isUpdated= true;
                } catch (Throwable t) {
                    wrongUpdate++;
                    repeatCount++;
                    //System.out.println("A4 / A5 [" + a4id + " / " + a5Id + "] has problem.");
                    //a5isEmpty.add(a4id);
                }


            }
            System.out.println("Info: Updated / ALL [" + updatedCount + " / " + a4IDs.size() + "] and empty: " + emptyCount + " and isn't updated: " + wrongUpdate);
        }



        //deleteNode();
        //updateNode();
        /*String assetId = "5268aef6e4b0226294a51405";
        List<UsageRight> list = new ArrayList<UsageRight>();
        GeneralUsageRight generalUsageRight = new GeneralUsageRight();
        generalUsageRight.setGeneral(new Object());
        Expiration expiration = new Expiration();
        expiration.setUseAirDate(true);
        expiration.setStartDate(DateTime.now().getMillis());
        expiration.setExpireDate(DateTime.now().getMillis() + 1000*60*60*24);
        generalUsageRight.setExpiration(expiration);
        list.add(generalUsageRight);
        CountriesUsageRight countriesUsageRight = new CountriesUsageRight();
        UsageCountry usageCountry = new UsageCountry();
        usageCountry.setUsageCountry(new String[] {"AZ"});
        countriesUsageRight.setCountries(usageCountry);
        expiration = new Expiration();
        expiration.setUseAirDate(false);
        expiration.setStartDate(DateTime.now().getMillis());
        expiration.setExpireDate(DateTime.now().getMillis() + 1000 * 60 * 60 * 72);
        countriesUsageRight.setExpiration(expiration);
        list.add(countriesUsageRight);
        MediaTypesUsageRight mediaTypesUsageRight = new MediaTypesUsageRight();
        MediaTypes[] mediaTypes = new MediaTypes[7];
        MediaTypes mediaType = new MediaTypes();
        mediaType.setEnabled(false);
        mediaType.setComment("");
        mediaTypes[0] = mediaType;
        mediaType = new MediaTypes();
        mediaType.setEnabled(true);
        mediaType.setComment("ta ta ta");
        mediaTypes[1] = mediaType;

        mediaType = new MediaTypes();
        mediaType.setEnabled(true);
        mediaType.setComment("rota ta ta");
        mediaTypes[2] = mediaType;

        mediaType = new MediaTypes();
        mediaType.setEnabled(true);
        mediaType.setComment("rita ta ta");
        mediaTypes[3] = mediaType;

        mediaType = new MediaTypes();
        mediaType.setEnabled(true);
        mediaType.setComment("ruta ta ta");
        mediaTypes[4] = mediaType;

        mediaType = new MediaTypes();
        mediaType.setEnabled(true);
        mediaType.setComment("reta ta ta");
        mediaTypes[5] = mediaType;

        mediaType = new MediaTypes();
        mediaType.setEnabled(true);
        mediaType.setComment("zata ta ta");
        mediaTypes[6] = mediaType;

        mediaTypesUsageRight.setMediaTypes(mediaTypes);
        list.add(mediaTypesUsageRight);

        VisualTalentUsageRight visualTalentUsageRight = new VisualTalentUsageRight();
        VisualTalent visualTalent = new VisualTalent();
        visualTalent.setArtistName("artist");
        visualTalent.setArtistRole("artistRole");
        visualTalentUsageRight.setVisualTalent(visualTalent);
        list.add(visualTalentUsageRight);

        VoiceOverArtistUsageRight voiceOverArtistUsageRight = new VoiceOverArtistUsageRight();
        VoiceOverArtist voiceOverArtist = new VoiceOverArtist();
        voiceOverArtist.setAgent("sdsdsd");
        voiceOverArtist.setAgentTel("12345");
        voiceOverArtist.setArtistName("sdsdsd");
        voiceOverArtist.setBaseFee("dfbd34t");
        voiceOverArtist.setEmail("rrrtttrr@test.com");
        voiceOverArtist.setMoreInfo("dlkjfkdjfklsdjflshvkjdfhgkjfdghfdg\nsdfkskjrweljtrwejtr");
        voiceOverArtist.setRole("fRoleF");
        voiceOverArtist.setUnion("dfdfdfe32342412");
        voiceOverArtistUsageRight.setVoiceOverArtist(voiceOverArtist);
        list.add(voiceOverArtistUsageRight);


        getCore().auth("anita.lotten@jwtamsterdam.nl.ua", "1");
        getCore().addUsageRights(assetId, list);

        Common.sleep(3000);
        BaseUsageRight aaa = getCore().getUsageRight("5268aef6e4b0226294a51405");
        System.out.println();
        */
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

    @Test
    public void getUsersAndAssets() {
        int counter = 1;
        for (Asset asset: XMLParser.getNewDataSet().getAsset()) {
            if (asset.getSpecDBDocID()!= null && asset.getSpecDBDocID().toLowerCase().contains("fromhd") && asset.getFileID()!= null && !asset.getFileID().isEmpty()) {
                System.out.println(counter + " " + asset.getSpecDBDocID());
                counter++;

            }

/*            boolean ingested = (asset.getAssetTypeID().equals("3") && asset.getSubAssetTypeID().equals("1") && !asset.getStatusID().equals("5"));
            if (asset.getAgencyGUID().equalsIgnoreCase("d5c14ff8-8d86-47c2-9e95-f0e5cc983d98") && (Integer.parseInt(asset.getLifecycleID()) > 1) && !ingested) {
                System.out.println(counter + " " + asset.getSpecDBDocID());
                counter++;
            }*/
            //}

        }
    }

    public boolean checkPreviewContainsStreaming(Content asset) {
        for (FilePreview filePreview: asset.getRevisions()[0].getPreview()) {
            if (filePreview.getSpecDbDocID().contains(":streaming"))
                return true;
        }
        return false;
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

    @Test
    public void getProxiesAgencyName() {
        String needName = "Lipsync post";
        //String needName = "JWT Amsterdam Agency NGN-28";
        int proxyCounter= 0;
        Map<String, Long> map = new TreeMap<>();
        int allProxies = XMLParser.getNewDataSet().getProxyAsset().length;
        for (ProxyAsset proxyAsset: XMLParser.getNewDataSet().getProxyAsset()) {
            //System.out.println("Progress: [" + ++proxyCounter + " / " + allProxies + "]" );
            if (!proxyAsset.getAgencyName().equalsIgnoreCase(needName)) {
                if (map.containsKey(proxyAsset.getAgencyName())) {
                    long counter = map.get(proxyAsset.getAgencyName());
                    counter++;
                    map.put(proxyAsset.getAgencyName(), counter);
                }
                else {
                    map.put(proxyAsset.getAgencyName(), 1L);
                }
                //System.out.println(proxyAsset.getAgencyName()+ " and progress: " + proxyCounter);
            }
        }

        for (Map.Entry<String, Long> entry: map.entrySet()) {
            //System.out.println(entry.getKey() + " : " + entry.getValue());
            System.out.println("<AgencyName>" + entry.getKey() + "</AgencyName>");
        }
        System.out.println();
    }


}

