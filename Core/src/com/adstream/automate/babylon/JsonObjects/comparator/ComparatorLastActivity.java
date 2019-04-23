package com.adstream.automate.babylon.JsonObjects.comparator;

import java.util.Comparator;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 06.08.12
 * Time: 10:02
 */
public class ComparatorLastActivity implements Comparator<String> {

    public int compare(String string1, String string2) {
        String strCompare1= string1.split("\n")[1];
        String strCompare2= string2.split("\n")[1];
        String[] strArray1= strCompare1.split(" ");
        String[] strArray2= strCompare2.split(" ");
        if (strArray1[1].equals(strArray2[1])) {
            return Integer.parseInt(strArray2[0]) - Integer.parseInt(strArray1[0]);
        }
        else {
            if (strArray1[1].contains("min")) return -1;
            else if (strArray2[1].contains("min")) return 1;
            else if (strArray1[1].contains("hour")) return -1;
            else if (strArray2[1].contains("hour")) return 1;
            else if (strArray1[1].contains("day")) return -1;
            else return 1;
        }
    }

}
