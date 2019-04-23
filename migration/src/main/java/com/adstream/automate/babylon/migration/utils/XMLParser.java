package com.adstream.automate.babylon.migration.utils;

import com.adstream.automate.babylon.migration.objects.Asset;
import com.adstream.automate.babylon.migration.objects.NewDataSet;
import com.adstream.automate.babylon.migration.objects.User;
import com.adstream.automate.babylon.migration.objects.*;

import javax.xml.bind.JAXB;
import java.io.File;
import java.util.*;


/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/7/13
 * Time: 7:15 PM

 */
public class XMLParser {

    private static File xmlFile;
    private static String filePath = "2015-5-06T11-17-36_BETC - RITA Production_0000.xml";

    private static NewDataSet newDataSet;
    private static Map<User, List<Asset>> usersAssets;
    static int counter = 0;

    protected final String userForCheckMigration = "adstream.initiative@adstream.com";
    protected final String password = "";

    public static void main(String[] args) {
        File file1 = new File("migration/src/main/resources/temp.xml");
        File file2 = new File("migration/src/main/resources/temp1.xml");
        File file3 = new File("migration/src/main/resources/temp2.xml");
        getFirstDeptAdminFromCurrentXML();
        AssetInner assetInner = JAXB.unmarshal(file1, AssetInner.class);
        MusicRightsFields musicRightsFields = JAXB.unmarshal(file2, MusicRightsFields.class);
        MusicRightsFieldsList musicRightsFieldsList = JAXB.unmarshal(file3, MusicRightsFieldsList.class);
        Iterator iterator = getUsersAssets().entrySet().iterator();
        while (iterator.hasNext()) {
            Map.Entry map = (Map.Entry)iterator.next();
            User user = (User)map.getKey();
            List<Asset> listA = (List<Asset>)map.getValue();
            for (Asset la: listA) {
                System.out.println(++counter + " user: " + user.getEmail() + " asset: " + la.getUniqueName() + " user agency " + user.getAgencyName());
            }

        }
    }


    public static NewDataSet getNewDataSet() {
        if (newDataSet == null) {
            if (xmlFile == null) {
                xmlFile = new File(filePath);
            }
            newDataSet = JAXB.unmarshal(xmlFile, NewDataSet.class);
        }
        return newDataSet;
    }

    public static NewDataSet getNewDataSet(String fileName) {
        NewDataSet newDataSet = JAXB.unmarshal(fileName, NewDataSet.class);
        return newDataSet;
    }


    public static void setXmlFile(File xmlFile) {
        XMLParser.xmlFile = xmlFile;
    }

    public static String getFilePath() {
        return filePath;
    }

    public static void setFilePath(String filePath) {
        XMLParser.filePath = filePath;
    }

    public static Map<User, List<Asset>> getUsersAssets() {
        if (usersAssets == null) {
            usersAssets = new HashMap<User, List<Asset>>();
            if (newDataSet == null)
                getNewDataSet();
            for (User user: newDataSet.getUser()) {
                if (user.getAgencyName().length() == 0) continue;
                List<Asset> assetsList = new ArrayList<Asset>();
                for (Asset asset: newDataSet.getAsset()) {
                    if (asset.getCreatedBy().equals(user.getUserGUID())) {
                        assetsList.add(asset);
                    }
                }
                usersAssets.put(user, assetsList);
            }
        }
        return usersAssets;
    }

    public static User getFirstDeptAdminFromCurrentXML() {
        for (User user: getNewDataSet().getUser()) {
            if (user.isDeptAdmin() && !user.isDisabled())
                return user;
        }
        return null;
    }
}
