package com.adstream.automate.babylon.tests.steps.domain.ingest;

import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import org.apache.commons.io.FileUtils;


import java.io.File;
import java.io.IOException;

/**
 * Created by Ramababu.Bendalam on 14/01/2016.
 */
public class TemplatesHelper extends BaseStep{

    public  String getAssetGUIDTemplate() throws IOException {
        String filePath = getFilePath("getAssetGUID.sql");
        return FileUtils.readFileToString(
                new File(filePath)
        );
    }
 }
