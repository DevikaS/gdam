package com.adstream.automate.babylon.tests;

import com.adstream.automate.babylon.TestsContext;

import java.io.File;
import java.io.IOException;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 26.06.12
 * Time: 11:31
 */
public class RelativePathConverter {
    public static String getFullPath(String relativePath) {
        if (relativePath.isEmpty()) {
            return "";
        } else {
            String path = (TestsContext.getInstance().testDataFolderName + "/" + relativePath).replace("\\", "/");
            File file = new File(path);
            try {
                return file.getCanonicalPath();
            } catch (IOException e) {
                e.printStackTrace();
            }
            return null;
        }
    }
}
