package com.adstream.automate.babylon.migration.scripts.dev;

import com.adstream.automate.babylon.migration.objects.*;
import com.adstream.automate.babylon.migration.utils.FileManager;
import com.adstream.automate.babylon.migration.utils.XMLParser;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.transform.OutputKeys;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 4/2/15
 * Time: 9:27 PM

 */
public class CheckXMLs {

    public static void main(String[] args) throws IOException {
        //splitProxies();
        List<File> allXMLs = getAllXMLsFromFolder("./Butch");
        List<Integer> idS = new ArrayList<>();
        for (File file: allXMLs) {
            //System.out.println(file.getName());
            XMLParser.setFilePath(file.getAbsolutePath());
            for (Asset asset: XMLParser.getNewDataSet(file.getAbsolutePath()).getAsset()) {
                if (asset.getMarkets()!= null) {
                    for (Integer market : asset.getMarkets().getMarket()) {
                        if (!idS.contains(market)) {
                             idS.add(market);
                        }
                    }
                }
            }
        }

        System.out.println(idS);
        /*List<File> allXMLs = getAllXMLsFromFolder("./PO");
        List<String> xmlList =  new ArrayList();

        for (File file: allXMLs) {
            System.out.println(file.getName().replace(".xml", "").replace("[UPDATED XML OUTPUT]", ""));
        }
        */
        /*for (File xmlFile: allXMLs) {
            //System.out.println(xmlFile.getName() + " is started...");
            try {
                ProxyAsset[] listOfProxies =  XMLParser.getNewDataSet(xmlFile.getCanonicalPath()).getProxyAsset();
                for (ProxyAsset proxyAsset: listOfProxies) {
                    if (proxyAsset.getSpecDBDocID()!= null && (proxyAsset.getSpecDBDocID().contains(":video:proxy:") || proxyAsset.getSpecDBDocID().contains(":video:streaming"))) {
                        if (proxyAsset.getFileId() == null || proxyAsset.getFileId().isEmpty()) continue;
                        if (proxyAsset.getFileSize().equals("0")) {
                            if (!xmlList.contains(xmlFile.getName()))
                                //xmlList.add(xmlFile.getName());
                            System.out.println(xmlFile.getName() + " AssetGUID " + proxyAsset.getParentAssetGuid());
                        }
                    }
                }
            } catch (Exception n) {
                System.out.println(xmlFile.getName() + " wasn't parsed");
            }
            //System.out.println(xmlFile.getName() + " is finished...");
        }
        System.out.println("-------------------------------------------------------------------");
        for (String name: xmlList) {
            System.out.println(name);
        }    */
    }

    public static List<File> getAllXMLsFromFolder(String filePath) {
        File folder = new File(filePath);
        List<File> result = new ArrayList<>();
        if (folder.isDirectory()) {
            for (File xmlFile : folder.listFiles()) {
                if (xmlFile.getName().toLowerCase().endsWith("xml")) {
                    result.add (xmlFile);
                }
            }
        }
        return result;
    }

    public static void splitProxies() {
        int batchNum = 400;
        List<Agency> sourceAgency = Arrays.asList(XMLParser.getNewDataSet("2015-4-28T05-59-36_Sky Italia_0000.xml").getAgency());
        List<ProxyAsset> proxies = Arrays.asList(XMLParser.getNewDataSet("2015-4-28T05-59-36_Sky Italia_0000.xml").getProxyAsset());
        int splitQuantity = proxies.size() / 10;
        int generalCount = 0;
        while (generalCount < proxies.size()) {
            String fileName = "Proxies only " + batchNum++ + ".xml";
            NewDataSet newDataSet = new NewDataSet();
            List<ProxyAsset> newProxies = new ArrayList<>();
            for (int i=1; i<=splitQuantity; i++) {
                if (generalCount == proxies.size())
                    break;
                newProxies.add(proxies.get(generalCount));
                generalCount++;
            }
            newDataSet.setAgency(sourceAgency.toArray(new Agency[1]));
            newDataSet.setProxyAsset(newProxies.toArray(new ProxyAsset[newProxies.size()]));
            marshalXML(newDataSet, new File(fileName));
        }

    }

    public static void prepareSkyItaliaRandomAssets() {
        File folder = new File("./Jira/allSIIds3.txt");
        for (Asset asset: XMLParser.getNewDataSet("./Jira/2015-4-24T13-57-02_DM9DDB Sul_0000.xml").getAsset()) {
            FileManager.saveIntoFile(folder.getName(), asset.getAssetGUID() + "\n", true);
        }

        List<String> allIds = FileManager.readTextFile("allSIIds2.txt");
        String fileName = "Sky .xml";
        List<String> randomIds = new ArrayList<>();
        List<Asset> sourceAssets = Arrays.asList(XMLParser.getNewDataSet("[UPDATED XML OUTPUT] 2015-4-09T19-38-10_Sky Italia_0000_AssetsOnly.xml").getAsset());
        List<Video> sourceVideo = Arrays.asList(XMLParser.getNewDataSet("[UPDATED XML OUTPUT] 2015-4-09T19-38-10_Sky Italia_0000_AssetsOnly.xml").getVideo());
        NewDataSet newDataSet = new NewDataSet();
        List<Asset> newAssets = new ArrayList<>();
        List<Video> newVideos = new ArrayList<>();

        while (randomIds.size() <= 100) {
            int index = (int)(allIds.size() * Math.random());
            if (!randomIds.contains(allIds.get(index)))
                randomIds.add(allIds.get(index));
        }
        for (String assetGUID: randomIds) {
            for (Asset asset: sourceAssets) {
                if (asset.getAssetGUID().equalsIgnoreCase(assetGUID)) {
                    newAssets.add(asset);
                    break;
                }
            }
            for (Video video: sourceVideo) {
                if (video.getAssetGUID().equalsIgnoreCase(assetGUID)) {
                    newVideos.add(video);
                    break;
                }
            }
        }
        newDataSet.setAsset(newAssets.toArray(new Asset[newAssets.size()]));
        newDataSet.setVideo(newVideos.toArray(new Video[newVideos.size()]));
        marshalXML(newDataSet, new File(fileName));


    }

    public static void prepareSkyItalia() {
        List<String> allIds = FileManager.readTextFile("allSIIds.txt");
        int batchNum = 9000;
        int generalCount = 0;


        List<Agency> sourceAgency = Arrays.asList(XMLParser.getNewDataSet("2015-4-09T19-38-10_Sky Italia_0000_AssetsOnly.xml").getAgency());
        List<Asset> sourceAssets = Arrays.asList(XMLParser.getNewDataSet("2015-4-09T19-38-10_Sky Italia_0000_AssetsOnly.xml").getAsset());
        List<Video> sourceVideo = Arrays.asList(XMLParser.getNewDataSet("2015-4-09T19-38-10_Sky Italia_0000_AssetsOnly.xml").getVideo());


        //for (String assetGUID: allIds) {
        while (generalCount < allIds.size()) {
            String fileName = "Prepared Sky Italia Assets Only " + batchNum++ + ".xml";
            System.out.println(fileName);
            NewDataSet newDataSet = new NewDataSet();
            List<Asset> newAssets = new ArrayList<>();
            List<Video> newVideos = new ArrayList<>();

            while (newAssets.size() < 30000 && generalCount < allIds.size()) {
                while (generalCount < allIds.size()) {
                //for (String assetGUID: allIds) {
                    String assetGUID = allIds.get(generalCount);
                    for (Asset asset: sourceAssets) {
                        if (asset.getAssetGUID().equalsIgnoreCase(assetGUID)) {
                            newAssets.add(asset);
                            generalCount++;
                            break;
                        }
                    }
                    for (Video video: sourceVideo) {
                        if (video.getAssetGUID().equalsIgnoreCase(assetGUID)) {
                            newVideos.add(video);
                            break;
                        }
                    }
                    if (newAssets.size() == 30000) {
                        break;
                    }
                }
            }
            newDataSet.setAgency(sourceAgency.toArray(new Agency[1]));
            newDataSet.setAsset(newAssets.toArray(new Asset[newAssets.size()]));
            newDataSet.setVideo(newVideos.toArray(new Video[newVideos.size()]));
            marshalXML(newDataSet, new File(fileName));

        }
        /*File folder = new File("./Jira/allSIIds.txt");
        for (Asset asset: XMLParser.getNewDataSet("./Jira/2015-4-09T19-38-10_Sky Italia_0000_AssetsOnly.xml").getAsset()) {
            FileManager.saveIntoFile(folder.getName(), asset.getAssetGUID() + "\n", true);
        } */
    }

    public static void marshalXML(NewDataSet newDataSet, File fileOutput) {
        try {
            JAXBContext context = JAXBContext.newInstance(newDataSet.getClass());
            Marshaller marshaller = context.createMarshaller();

            marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);
            //marshaller.setProperty(OutputKeys.INDENT, "yes");
            marshaller.marshal(newDataSet, fileOutput);
        } catch (JAXBException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
    }

}
