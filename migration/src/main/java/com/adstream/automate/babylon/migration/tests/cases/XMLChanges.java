package com.adstream.automate.babylon.migration.tests.cases;

import com.adstream.automate.babylon.migration.objects.Asset;
import com.adstream.automate.babylon.migration.objects.NewDataSet;
import com.adstream.automate.babylon.migration.objects.User;
import com.adstream.automate.babylon.migration.objects.Video;
import com.adstream.automate.babylon.migration.utils.FileManager;
import com.adstream.automate.babylon.migration.utils.XMLParser;
import com.adstream.automate.utils.Common;
import org.w3c.dom.*;
import org.xml.sax.SAXException;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.*;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.File;
import java.io.IOException;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/6/14
 * Time: 1:50 PM
 */

public class XMLChanges {

    //private static final String pgAgencyName = "Procter & Gamble";
    //private static final String pgAgencyName = "Initiative Argentina";
    //private static final String pgAgencyGUID = "18912456-6c46-4ae1-8881-e71cf020b292";
    //private static final String pgAgencyGUID = "27f2574d-4ac1-4320-973a-f21e3c995417";
    //private static final String pgAgencyGUID = "83557916-d4b1-4062-810b-d7e12d8854d0";
    //private static final String pgAgencyGUID = "8712cef6-bd4f-4dc1-96cf-9fdf69230900";
    //private static final String pgAgencyGUID = "1fe824ba-654c-4ee7-a053-aa3102d2ab14";
    //private static final String pgAgencyGUID = "ac894830-4133-4103-a786-0760f5c0bc1a";
    //private static final String pgAgencyGUID = "8e450228-2a38-4d3f-aeb0-f4830eb182ef";
    //private static final String pgAgencyGUID = "96362808-5599-4d5f-b2ec-ad9d22316e4f";
    //private static final String pgAgencyGUID = "53ddbefc-67f7-497a-9709-10aabef92d38";
    //private static final String pgAgencyGUID = "7db89a56-3255-4e8c-b2b4-83f7f15b653a";
    //private static final String pgAgencyGUID = "c4fc117b-308f-4c30-b402-27f32548a1cc";
    //private static final String pgAgencyGUID = "a8d07d26-1422-42e8-a160-d4e2fe3129db";
    private static final String pgAgencyGUID = "7ac06a75-b0cc-4025-a383-50a7526e0718";
    //  private static final String pgAgencyGUID = "924ebf50-eb45-458f-9dba-84ff5495efc7";

    //private static final  String emptyUser = "ba8b6bb8-31c8-4ffe-9b6f-dfe01bb146b1";
    //private static final  String emptyUser = "7c21a350-f151-48f0-95d4-0c6eee6cff4d";
    //private static final  String emptyUser = "1e4b9418-4453-457f-af7d-66cbc8e5ebb2";
    //private static final  String emptyUser = "2521c99c-4dd1-4c45-9422-5b42e77c3f7f";
    //private static final  String emptyUser = "230ce1e3-3226-402a-a369-b6d9657993ad";
    //private static final  String emptyUser = "2813800e-4ae5-46a6-885c-8f2ff7d68f3f";
    //private static final  String emptyUser = "7c21a350-f151-48f0-95d4-0c6eee6cff4d";
    //private static final  String emptyUser = "1e4b9418-4453-457f-af7d-66cbc8e5ebb2";
    //private static final  String emptyUser = "ba8b6bb8-31c8-4ffe-9b6f-dfe01bb146b1";
    //private static final  String emptyUser = "7280e812-4396-4f60-a739-72d11358979b";
    //private static final  String emptyUser = "1e4b9418-4453-457f-af7d-66cbc8e5ebb2";
    //private static final  String emptyUser = "56882e37-dbc8-47e2-bf92-96f617fb31c5";
    private static final  String emptyUser = "a9a8b0f5-5496-4737-97fc-c2a70133b730";

    private static Map<String, List<String>> a4Id_u4AllIds = new HashMap<>();
    private static Map<String, String> a4Id_u4AllId = new HashMap<>();

    private static List<String> usersWithoutAgencies = new ArrayList<>();
    private static Map<String, String> otherAgencyAndUsers = new HashMap<>();

    private static String superEmail = "themill@adstream.com";

    /*

    *
    * */

    public static void main(String[] args) {
        //getInfoAboutAddedAssets();
        //getUsersWithoutAgency();
        //calcAgency();
        //checkCorrectAssetChange();
        //Document doc = initXMLDocument();
        //deleteNode(doc);
        //deleteNode(doc);
        //deleteNode(doc);
        //deleteAllUsers(doc);
        //checkAllAssetsIsExist(doc);
        //removeAllIncorrectAssets(doc);
        //deletePartOfVideoInfo(doc);
        //deleteAttribute(doc, new String[] {"CreativeDirector", "ArtDirector", "Producer", "Director", "ProductionCompany", "PostProduction", "ContactAtPostProduction", "ContactPhone", "FirstAirDate", "AudioFormat", "AudioChannels", "ClosedCaptionStatusID", "FullDurationInFrames", "AdDurationInFrames", "FirstActiveFrame", "ClosedCaptionStatus", "WatermarkStatus", "VideoSpecificationGuid"}, "Video");
        //deleteAttribute(doc, new String[] {"AudioFormat", "DurationInSeconds", "FirstTransmission", "RecordedAt", "AudioEngineer",	"VoiceOverArtist", "CopyWriter", "Producer", "Director", "JCNNumber", "RABApproval"}, "Audio");

        //deleteExcessProxies(doc);
        //writeDocument(doc, XMLParser.getFilePath().replace(".xml", "_rm_node.xml"));
        Document doc = initXMLDocument();
        initMap();
        System.out.println("InitXMLDocument was finished");
        initUsersAndAgenciesMaps(doc);
        System.out.println("users was changed");
        updateAsset(doc);
        System.out.println("assets was changed");
        writeDocument(doc, XMLParser.getFilePath().replace(".xml", "_adopted.xml"));
        //saveDocument(doc, XMLParser.getFilePath().replace(".xml", "_adopted.xml"));
    }

    public static void initMap() {
        otherAgencyAndUsers.put("70bc4c65-4e7c-4053-95ed-960e4b7c1b0e", "f6776cfe-c090-400a-ad2a-1c90fa69ff13");
        otherAgencyAndUsers.put("f66a7fbd-88ca-460e-b051-e3c3ce89cebf", "b45da98e-c05c-4448-9ab0-32ac3a7614c8");
        otherAgencyAndUsers.put("18edf37d-3c8c-4c7a-bb88-3f14a035c435", "cb013557-7508-4621-9300-e18314b57574");
        otherAgencyAndUsers.put("ac894830-4133-4103-a786-0760f5c0bc1a", "19007bbc-93d5-498a-8719-899e333e4412");
        otherAgencyAndUsers.put("90b0505a-c45f-469c-a120-f075044c4172", "92bda511-752d-497c-89b8-f93836c5f15e");
        otherAgencyAndUsers.put("abbb5778-c144-49f2-a038-6319277cca23", "4b5b8317-91e6-4c85-b4fe-d421c592008a");

        //f6776cfe-c090-400a-ad2a-1c90fa69ff13
        //b45da98e-c05c-4448-9ab0-32ac3a7614c8
        //cb013557-7508-4621-9300-e18314b57574
        //19007bbc-93d5-498a-8719-899e333e4412
        //92bda511-752d-497c-89b8-f93836c5f15e
        //4b5b8317-91e6-4c85-b4fe-d421c592008a
    }

    public static Document initXMLDocument() {
        DocumentBuilderFactory dbf =
                DocumentBuilderFactory.newInstance();
        DocumentBuilder db = null;
        Document doc = null;
        try {
            db = dbf.newDocumentBuilder();
            try {
                doc = db.parse (new File(XMLParser.getFilePath()));
            } catch (SAXException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
        } catch (ParserConfigurationException e) {
            e.printStackTrace();
        }
        return doc;
    }

    public static Document deleteAllAudioAssets() {
        Document doc = initXMLDocument();
        NodeList nodes = doc.getElementsByTagName("Asset");

        for (int i = 0; i < nodes.getLength(); i++) {
            Element person = (Element)nodes.item(i);
            Element name = (Element)person.getElementsByTagName("AssetType").item(0);
            if (name==null) continue;
            String pName = name.getTextContent();
            System.out.println(pName);
            if (pName.trim().equalsIgnoreCase("Audio")) {
                person.getParentNode().removeChild(person);
                i--;
            }
        }

        nodes = doc.getElementsByTagName("Audio");
        for (int i = 0; i < nodes.getLength(); i++) {
            Element person = (Element)nodes.item(i);
            person.getParentNode().removeChild(nodes.item(i));
            i--;
        }
        return doc;
    }

    public static void deleteExcessProxies(Document doc) {
        String sourceFile = "migration/src/main/resources/ex_list_need.txt";
        List<String> assetsGUIDs = FileManager.readTextFile(System.getProperty("user.dir").concat("\\").concat(sourceFile));
        NodeList nodes = doc.getElementsByTagName("ProxyAsset");
        int count = nodes.getLength();
        int proxyDeleted = 0;
        for (int i=0; i< count; i++) {
            try {
                Element person = (Element)nodes.item(i);
                Element name = (Element)person.getElementsByTagName("ParentAssetGuid").item(0);
                if (name==null) continue;
                String pName = name.getTextContent();
                if (!assetsGUIDs.contains(pName)) {
                    person.getParentNode().removeChild(person);
                    i--;
                    proxyDeleted++;
                }
                System.out.println("Current / All [" + i + " / " + count + "] and were deleted = " + proxyDeleted);
            } catch (Throwable t) {
                t.printStackTrace();
            }
        }

    }

    public static void saveDocument(Document doc, String filePath) {
        DOMSource source = new DOMSource(doc);
        Node node = source.getNode();
        int length = node.getChildNodes().getLength();
        NodeList upperList = node.getChildNodes();
        for (int i=0; i< length; i++){
            Element upperElement = (Element)upperList.item(i);
            String recordToFile = "  <" + upperElement.getNodeName() + ">";

            FileManager.saveIntoFile(System.getProperty("user.dir").concat("\\").concat(filePath), recordToFile, true);
        }
    }

    public static void writeDocument(Document doc, String filePath) {
        Transformer transformer = null;
        FileManager.saveIntoFile(System.getProperty("user.dir").concat("\\").concat(filePath), "");
        try {
            transformer = TransformerFactory.newInstance().newTransformer();
        } catch (TransformerConfigurationException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
        transformer.setOutputProperty(OutputKeys.INDENT, "yes");

        StreamResult result = new StreamResult(new StringWriter());

        DOMSource source = new DOMSource(doc);
        try {
            transformer.transform(source, result);
        } catch (TransformerException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
        source= null;
        transformer = null;
        String xmlString = result.getWriter().toString();
        result= null;
        Common.sleep(10000);
        FileManager.saveIntoFile(System.getProperty("user.dir").concat("\\").concat(filePath), xmlString);
/*        for (String str: xmlString.split("\n")) {
            FileManager.saveIntoFile(System.getProperty("user.dir").concat("\\").concat(filePath), str, true);
            str= null;
        }*/
        //

    }

    public static void getAgencyIdAndUserId(Document doc, String mainAgencyID)  {
        NodeList nodes = doc.getElementsByTagName("User");
        Map<String, String> u4id_A4id = new HashMap<>();
        for (int i = 0; i < nodes.getLength(); i++) {
            Element person = (Element)nodes.item(i);
            if (person.getElementsByTagName("AgencyName").item(0) == null || person.getElementsByTagName("AgencyName").item(0).getTextContent().isEmpty()) continue;
            if (!person.getElementsByTagName("AgencyGUID").item(0).getTextContent().equalsIgnoreCase(mainAgencyID)) {
                u4id_A4id.put(person.getElementsByTagName("UserGUID").item(0).getTextContent(), person.getElementsByTagName("AgencyGUID").item(0).getTextContent());
            }
        }
    }

    public static void initUsersAndAgenciesMaps(Document doc) {
        NodeList nodes = doc.getElementsByTagName("User");
        int count = nodes.getLength();
        //String emptyUser = "29b8c814-327a-43cf-b719-fda716d464b9";
        //String emptyUser = "2521c99c-4dd1-4c45-9422-5b42e77c3f7f";
        //String emptyUser = "e25cb612-a042-46dd-baa3-b8d4c1af71b1";
        //String emptyUser = "2813800e-4ae5-46a6-885c-8f2ff7d68f3f";
        for (int i = 0; i < count; i++) {
            System.out.println("Started ... [" + i + "/" + count + "]");
            Element person = (Element)nodes.item(i);
            if (person.getElementsByTagName("AgencyGUID").item(0) == null && person.getElementsByTagName("UserGUID").item(0).getTextContent().equalsIgnoreCase(emptyUser)) {
                if (person.getElementsByTagName("UserGUID").item(0) != null) {
                    usersWithoutAgencies.add(person.getElementsByTagName("UserGUID").item(0).getTextContent());
                    Element name1 = (Element)person.getElementsByTagName("UserGUID").item(0);
                    Node rootNode = name1.getParentNode();
                    Element newElement = doc.createElement("AgencyGUID");
                    Text newElementValue = doc.createTextNode(pgAgencyGUID);
                    newElement.appendChild(newElementValue);
                    name1.getParentNode().appendChild(newElement);
                    String firstName = "EmptyAgency";
                    String lastName = "EmptyAgency";
                    String password = "Adstream01";
                    String email = "EmptyAgency_migrate_user" + i + "@adbank.me";
                    name1 = (Element)person.getElementsByTagName("FirstName").item(0);
                    if (name1!= null)
                        name1.setTextContent(firstName);

                    name1 = (Element)person.getElementsByTagName("LastName").item(0);
                    if (name1!= null)
                        name1.setTextContent(lastName);

                    name1 = (Element)person.getElementsByTagName("Password").item(0);
                    if (name1!= null)
                        name1.setTextContent(password);

                    name1 = (Element)person.getElementsByTagName("Email").item(0);
                    if (name1!= null)
                        name1.setTextContent(email);

                }
            }
            /*else if (person.getElementsByTagName("AgencyGUID").item(0).getTextContent().isEmpty()) {
                if (person.getElementsByTagName("UserGUID").item(0) != null) {
                    usersWithoutAgencies.add(person.getElementsByTagName("UserGUID").item(0).getTextContent());
                    String firstName = "EmptyAgency";
                    String lastName = "EmptyAgency";
                    String password = "Adstream01";
                    String email = "EmptyAgency_migrate_user" + i + "@adbank.me";
                    Element name1 = (Element)person.getElementsByTagName("FirstName").item(0);
                    if (name1!= null)
                        name1.setTextContent(firstName);

                    name1 = (Element)person.getElementsByTagName("LastName").item(0);
                    if (name1!= null)
                        name1.setTextContent(lastName);

                    name1 = (Element)person.getElementsByTagName("Password").item(0);
                    if (name1!= null)
                        name1.setTextContent(password);

                    name1 = (Element)person.getElementsByTagName("Email").item(0);
                    if (name1!= null)
                        name1.setTextContent(email);
                    name1 = (Element)person.getElementsByTagName("AgencyGUID").item(0);
                    if (name1!= null)
                        name1.setTextContent(pgAgencyGUID);
                    else {
                        name1 = (Element)person.getElementsByTagName("UserGUID").item(0);
                        Node rootNode = name1.getParentNode();
                        Element newElement = doc.createElement("AgencyGUID");
                        Text newElementValue = doc.createTextNode(pgAgencyGUID);
                        newElement.appendChild(newElementValue);
                        name1.getParentNode().appendChild(newElement);
                    }

                }
            }      */
            if (person.getElementsByTagName("AgencyGUID").item(0) != null && !person.getElementsByTagName("AgencyGUID").item(0).getTextContent().equalsIgnoreCase(pgAgencyGUID)) {
                if (a4Id_u4AllIds.containsKey(person.getElementsByTagName("AgencyGUID").item(0).getTextContent())) {
                    List<String> list = a4Id_u4AllIds.get(person.getElementsByTagName("AgencyGUID").item(0).getTextContent());
                    list.add(person.getElementsByTagName("UserGUID").item(0).getTextContent());
                }
                else {
                    List<String> list = new ArrayList<>();
                    list.add(person.getElementsByTagName("UserGUID").item(0).getTextContent());
                    a4Id_u4AllIds.put(person.getElementsByTagName("AgencyGUID").item(0).getTextContent(), list);
                }
                // ToDo user must be updated here
                String firstName = person.getElementsByTagName("AgencyName").item(0).getTextContent();
                String lastName = person.getElementsByTagName("AgencyGUID").item(0).getTextContent();
                String password = "Adstream01";
                String email = "AgencyGUID_" + lastName + "_migrate_user@adbank.me";
                Element name1 = (Element)person.getElementsByTagName("FirstName").item(0);
                if (name1!= null)
                    name1.setTextContent(firstName);

                name1 = (Element)person.getElementsByTagName("LastName").item(0);
                if (name1!= null)
                    name1.setTextContent(lastName);

                name1 = (Element)person.getElementsByTagName("Password").item(0);
                if (name1!= null)
                    name1.setTextContent(password);

                name1 = (Element)person.getElementsByTagName("Email").item(0);
                if (name1!= null)
                    name1.setTextContent(email);

                /*name1 = (Element)person.getElementsByTagName("AgencyName").item(0);
                if (name1!= null)
                    name1.setTextContent(pgAgencyName);
                else {
                    name1 = (Element)person.getElementsByTagName("UserGUID").item(0);
                    Node rootNode = name1.getParentNode();
                    Element newElement = doc.createElement("AgencyName");
                    Text newElementValue = doc.createTextNode("AgencyName");
                    newElement.appendChild(newElementValue);
                    name1.getParentNode().appendChild(newElement);
                } */
                name1 = (Element)person.getElementsByTagName("AgencyGUID").item(0);
                if (name1!= null)
                    name1.setTextContent(pgAgencyGUID);
                /*else {
                    name1 = (Element)person.getElementsByTagName("UserGUID").item(0);
                    Node rootNode = name1.getParentNode();
                    Element newElement = doc.createElement("AgencyGUID");
                    Text newElementValue = doc.createTextNode(pgAgencyGUID);
                    newElement.appendChild(newElementValue);
                    name1.getParentNode().appendChild(newElement);
                } */

            }
        }
        for (Map.Entry<String, List<String>> map: a4Id_u4AllIds.entrySet()) {
            a4Id_u4AllId.put(map.getKey(), map.getValue().get(0));
        }

    }

    public static void updateAsset(Document doc) {
        NodeList nodes = doc.getElementsByTagName("Asset");
        int count = nodes.getLength();
        //String emptyUser = "29b8c814-327a-43cf-b719-fda716d464b9"; //usersWithoutAgencies.get(0);
        //String emptyUser = "2521c99c-4dd1-4c45-9422-5b42e77c3f7f";
        //String emptyUser = "e25cb612-a042-46dd-baa3-b8d4c1af71b1";
        for (int i=0; i< count; i++) {
            Element person = (Element)nodes.item(i);
            System.out.println("Started ... [" + i + "/" + count + "]");
            if (person.getElementsByTagName("AgencyGUID").item(0) == null) {
                Element name1 = (Element)person.getElementsByTagName("AssetGUID").item(0);
                Node rootNode = name1.getParentNode();
                Element newElement = doc.createElement("AgencyGUID");
                Text newElementValue = doc.createTextNode(pgAgencyGUID);
                newElement.appendChild(newElementValue);
                name1.getParentNode().appendChild(newElement);
                name1 = (Element)person.getElementsByTagName("CreatedBy").item(0);
                name1.setTextContent(emptyUser);
                name1 = (Element)person.getElementsByTagName("LastUpdatedBy").item(0);
                name1.setTextContent(emptyUser);

            }
            else {
                if (person.getElementsByTagName("AgencyGUID").item(0).getTextContent().isEmpty()) {
                    Element name1 = (Element)person.getElementsByTagName("CreatedBy").item(0);
                    name1.setTextContent(emptyUser);
                    name1 = (Element)person.getElementsByTagName("LastUpdatedBy").item(0);
                    name1.setTextContent(emptyUser);
                }
                else if (!person.getElementsByTagName("AgencyGUID").item(0).getTextContent().equalsIgnoreCase(pgAgencyGUID)) {
                    String oldAgencyUser = a4Id_u4AllId.get(person.getElementsByTagName("AgencyGUID").item(0).getTextContent());
                    if (oldAgencyUser == null || oldAgencyUser.isEmpty()) {
                        //oldAgencyUser = otherAgencyAndUsers.get(person.getElementsByTagName("AgencyGUID").item(0).getTextContent());
                        oldAgencyUser = emptyUser;
                    }
                    Element name1 = (Element)person.getElementsByTagName("CreatedBy").item(0);
                    name1.setTextContent(oldAgencyUser);
                    name1 = (Element)person.getElementsByTagName("LastUpdatedBy").item(0);
                    name1.setTextContent(oldAgencyUser);
                }
            }
            Element name1 = (Element)person.getElementsByTagName("AgencyGUID").item(0);
            name1.setTextContent(pgAgencyGUID);
            /*name1 = (Element)person.getElementsByTagNam("AgencyName").item(0);
            if (name1!= null)
                name1.setTextContent(pgAgencyName);
            else {
                // Add child
            } */

        }
    }



    public static void checkCorrectAssetChange() {
        //String adoptedFilePath = "migration/src/main/resources/2014_07_30_0001_Procter & Gamble_UAOnly_adopted.xml";
        //String adoptedFilePath = "migration/src/main/resources/ADOPTED_2014_06_20_0001_Initiative Argentina_adopted.xml";
        //String adoptedFilePath = "migration/src/main/resources/ADOPTED_2014_06_20_0001_Unilever Mexico_adopted.xml";
        //String adoptedFilePath = "migration/src/main/resources/[OUTPUT XML] 2014_08_05_0001_eg+ worldwide_adopted.xml";
        //String adoptedFilePath = "migration/src/main/resources/[OUTPUT XML] 2014_08_05_0001_Hogarth London_adopted.xml";
        //String adoptedFilePath = "migration/src/main/resources/[OUTPUT XML] 2014_08_05_0001_Tag Europe Ltd_adopted.xml";
        //String adoptedFilePath = "migration/src/main/resources/[OUTPUT XML] 2014_08_05_0001_Prime Focus World_adopted.xml";
        //String adoptedFilePath = "migration/src/main/resources/[OUTPUT XML] 2014_08_05_0001_Hogarth Worldwide Pte Ltd_adopted.xml";
        //String adoptedFilePath = "migration/src/main/resources/[OUTPUT XML] 2014_08_05_0001_eg+ worldwide_0811_adopted.xml";
        //String adoptedFilePath = "migration/src/main/resources/[OUTPUT XML] 2014_08_05_0001_eg+ worldwide_adopted_rm_adopted.xml";
        //String adoptedFilePath = "migration/src/main/resources/[OUTPUT XML] 2014_08_05_0001_Hogarth London_adopted_rm_adopted.xml";
        String adoptedFilePath = "migration/src/main/resources/[OUTPUT XML] 2014_08_05_0001_eg+ worldwide(1)_adopted.xml";
        Map<String, String> beforeAssetId_AgencyId = new HashMap<>();
        Map<String, String> beforeUserID_AgencyId = new HashMap<>();
        Map<String, String> afterAssetId_UserId = new HashMap<>();
        int correctAsset = 0;
        int wrongAsset = 0;
        int specialUser = 0;
        for (User user: XMLParser.getNewDataSet().getUser()) {
            if (user.getAgencyGUID() != null && !user.getAgencyGUID().isEmpty())
                beforeUserID_AgencyId.put(user.getUserGUID(), user.getAgencyGUID());
            else
                beforeUserID_AgencyId.put(user.getUserGUID(), "Empty agency");
        }
        for (Asset asset : XMLParser.getNewDataSet().getAsset()) {
            if (asset.getAgencyGUID() != null && !asset.getAgencyGUID().isEmpty())
                beforeAssetId_AgencyId.put(asset.getAssetGUID(), asset.getAgencyGUID());
            else
                beforeAssetId_AgencyId.put(asset.getAssetGUID(), "Empty agency");
        }
        NewDataSet adoptedDataSet = XMLParser.getNewDataSet(System.getProperty("user.dir").concat("\\").concat(adoptedFilePath));
        for (Asset asset : adoptedDataSet.getAsset()) {
            afterAssetId_UserId.put(asset.getAssetGUID(), asset.getCreatedBy());
        }

        for (Map.Entry<String, String> map: afterAssetId_UserId.entrySet()) {
            String userId = map.getValue();
            String agencyId = beforeUserID_AgencyId.get(userId.toLowerCase());
            if (beforeAssetId_AgencyId.get(map.getKey().toLowerCase())==null) {
                System.out.println();       // 0ebb68d9-84c2-459b-920f-6e764d3e43a9=
            }
            if (beforeAssetId_AgencyId.get(map.getKey().toLowerCase()).equals(agencyId) || userId.equalsIgnoreCase(emptyUser)/*|| agencyId.equalsIgnoreCase("Empty agency")*/ )
                correctAsset++;
            else {
                wrongAsset++;
                System.out.println(agencyId);

            }
            //if (userId.equals("29b8c814-327a-43cf-b719-fda716d464b9"))
            //if (userId.equals("2521c99c-4dd1-4c45-9422-5b42e77c3f7f"))
            if (userId.equalsIgnoreCase(emptyUser))
                specialUser++;


        }
        System.out.println("Correct = " + correctAsset);
        System.out.println("Wrong = " + wrongAsset);
        System.out.println("specialUser = " + specialUser);
        //"_id" : ObjectId("53db6ab8e4b0260298a412dc")
    }

    public static void deleteAllUsers(Document doc) {
        NodeList nodes = doc.getElementsByTagName("User");
        int count = nodes.getLength();
        for (int i = 0; i < count; i++) {
            Element person = (Element)nodes.item(i);
            Element name = null;
            if (person!= null)
                name = (Element)person.getElementsByTagName("Email").item(0);
            else
                continue;
            if (name==null) continue;
            String email = name.getTextContent();
            if (!email.equals(superEmail)) {
                person.getParentNode().removeChild(person);
                i--;
                System.out.println(email);

            }
        }
    }

    public static void deletePartOfVideoInfo(Document doc) {
        NodeList nodes = doc.getElementsByTagName("Video");
        int count = nodes.getLength();
        for (int i = 0; i < count; i++) {
            Element person = (Element)nodes.item(i);
            if (!person.getTagName().equalsIgnoreCase("AssetGUID")) {
                person.getParentNode().removeChild(person);
            }
        }
    }

    public static void removeAllIncorrectAssets(Document doc) {
        String sourceFile = "migration/src/main/resources/ex_list_need.txt";
        List<String> usefulCN = FileManager.readTextFile(System.getProperty("user.dir").concat("\\").concat(sourceFile));
        int deletedAssets = 0;
        NodeList nodes = doc.getElementsByTagName("Asset");
        int count = nodes.getLength();
        for (int i = 0; i < count; i++) {
            Element person = (Element)nodes.item(i);
            Element name = null;
            if (person!= null)
                name = (Element)person.getElementsByTagName("AssetGUID").item(0);
                //name = (Element)person.getElementsByTagName("UniqueName").item(0);
            else
                continue;
            Element typeAsset = (Element)person.getElementsByTagName("AssetTypeID").item(0);
            if (name==null) continue;
            if (typeAsset == null) continue;
            if (typeAsset.getTextContent().equals("999")) continue;
            String pName = name.getTextContent();
            if (!usefulCN.contains(pName.toUpperCase())) {
                person.getParentNode().removeChild(person);
                i--;
                deletedAssets++;
            }
            else {
                System.out.println();
            }
            System.out.println("Current / Deleted / ALL " + i + " / " + deletedAssets + " / " + count);
        }
        System.out.println("deletedAssets = " + deletedAssets);
    }

    public static void checkAllAssetsIsExist(Document doc) {
        String sourceFile = "migration/src/main/resources/ex_list_need.txt";
        List<String> usefulCN = FileManager.readTextFile(System.getProperty("user.dir").concat("\\").concat(sourceFile));
        int deletedAssets = 0;
        NodeList nodes = doc.getElementsByTagName("Asset");
        int count = nodes.getLength();
        for (int i = 0; i < count; i++) {
            Element person = (Element)nodes.item(i);
            Element name = null;
            if (person!= null)
                name = (Element)person.getElementsByTagName("AssetGUID").item(0);
            else
                continue;
            Element typeAsset = (Element)person.getElementsByTagName("AssetTypeID").item(0);
            if (name==null) continue;
            if (typeAsset == null) continue;
            if (typeAsset.getTextContent().equals("999")) continue;
            String pName = name.getTextContent();
            if (!usefulCN.contains(pName.toUpperCase())) {
                System.out.println(pName);
            }
        }

    }

    public static void getInfoAboutAddedAssets() {
        String sourceFile = "migration/src/main/resources/xlr8_add_assets.txt";
        List<String> usefulCN = FileManager.readTextFile(System.getProperty("user.dir").concat("\\").concat(sourceFile));

        NewDataSet newDataSet = new NewDataSet();
        List<Asset> newAssets = new ArrayList<>();

        // String[] y = x.toArray(new String[0])
        for (Asset asset: XMLParser.getNewDataSet().getAsset()) {
            if (usefulCN.contains(asset.getUniqueName())) {
                newAssets.add(asset);
            }
        }
        for (Video video: XMLParser.getNewDataSet().getVideo()) {
            //if ()
        }
        newDataSet.setAsset(newAssets.toArray(new Asset[newAssets.size()]));
        marshalExample(newDataSet);

    }

    public static void marshalExample(NewDataSet newDataSet) {
        try {
            JAXBContext context = JAXBContext.newInstance(newDataSet.getClass());
            Marshaller marshaller = context.createMarshaller();
            marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);
            marshaller.marshal(newDataSet, System.out);
            System.out.println();
        } catch (JAXBException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
    }

    public static void deleteAttribute(Document doc, String[] names, String parentName) {
        NodeList nodes = doc.getElementsByTagName(parentName);
        int count = nodes.getLength();
        int allDeletedNotes = count*names.length;
        int nCounter = 0;
        for (int i = 0; i < count; i++) {
            Element person = (Element)nodes.item(i);
            for (String name: names) {
                Element name1 = (Element)person.getElementsByTagName(name).item(0);
                if (name1!= null) {
                    person.removeChild(name1);
                    System.out.println("Nodes info: " + ++nCounter + " / " + allDeletedNotes + " was removed. Name: " + name1.getTagName() );
                }
            }
            System.out.println("Video node: " + i + " / " + count + " was prepared");
        }
    }

    public static void deleteNode(Document doc) {
        //deleteAsset(doc, "Audio");
        deleteAttribute(doc, "CreativeDirector", "Video");
        deleteAttribute(doc, "PostProduction", "Video");
        deleteAttribute(doc, "ProductionCompany", "Video");
        deleteAttribute(doc, "ArtDirector", "Video");
        deleteAttribute(doc, "Producer", "Video");
        deleteAttribute(doc, "Director", "Video");
        deleteAttribute(doc, "RegulatoryApproval", "Asset");
        deleteAttribute(doc, "RegulatoryApprovalGUID", "Asset");

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


}