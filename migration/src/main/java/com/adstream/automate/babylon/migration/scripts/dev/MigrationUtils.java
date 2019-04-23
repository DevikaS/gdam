package com.adstream.automate.babylon.migration.scripts.dev;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 4/2/15
 * Time: 9:26 AM

 */
public class MigrationUtils {

    private static String migrationErrorInfo;

    public static String getMigrationErrorInfo() {
        return migrationErrorInfo;
    }

    public static File getFileFromList(String buName, List<File> listOfFiles) {
        File file = null;
        List<File> result = new ArrayList<>();
        for (File xmlFile: listOfFiles) {
            if (xmlFile.getName().toLowerCase().contains(buName.toLowerCase())) {
                result.add(xmlFile);
            }
        }
        if (result.size() == 0) {
            migrationErrorInfo = "There isn't any accordance for BU: " + buName + " among the xml files in the issue";
            return null;
        }
        if (result.size() == 1)
            return result.get(0);
        if (result.size() == 2) {
            for (int i=0; i< result.size(); i++) {
                if (result.get(i).getName().toUpperCase().contains("[UPDATED XML OUTPUT]"))
                    return result.get(i);
            }
        }
        if (result.size() > 2) {
            migrationErrorInfo = "There are " + result.size() + " XML files are founded for BU: " + buName;
            for (File xmlFile: result) {
                migrationErrorInfo += "\n" + xmlFile.getName();
            }
            return null;
        }
        return null;
    }

    public static String getUserNameByAgency(String agencyName) {
        if (agencyName.isEmpty())
            return "";
        String[] tempArray = agencyName.replaceAll("[\\W]", " ").toLowerCase().split(" ");
        String result = "admin";
        for (String temp: tempArray) {
            result+= temp.isEmpty()?"":"."+temp;
        }
        return result + "@adbank.me";
    }

}
