package com.adstream.automate.babylon.migration.actions;

import com.adstream.automate.utils.Gen;
import org.apache.commons.io.IOUtils;


import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

/**
 * Created with IntelliJ IDEA.
 * User: User
 * Date: 12.10.13
 * Time: 21:06

 */
public class PrepareUpload {
    // ToDo подготавливает файл к аплоаду

    private void uploadFile(Integer filesCount, String folderId) {
        if (filesCount != null) {
            for (int i = 0; i < filesCount; i++) {
                try {
                    File file = File.createTempFile(Gen.getString(10), Gen.getString(3));
                    IOUtils.write("0", new FileWriter(file));
                    //service.uploadFile(file, folderId);
                    file.delete();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
