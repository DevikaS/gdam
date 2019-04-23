package com.adstream.automate.babylon.migration.scripts.dev;

import com.adstream.automate.babylon.migration.googledrive.GoogleDriveExample;
import com.adstream.automate.babylon.migration.scripts.CSVParser;
import com.adstream.automate.babylon.migration.scripts.DataForBatchMigration;
import org.apache.log4j.Logger;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 4/1/15
 * Time: 2:37 PM

 */
public class MigrationInfo {

    protected final static Logger log = Logger.getLogger(MigrationInfo.class);

    private static int buCount;
    private static int successfulBUMigrated;

    public static List<DataForBatchMigration> generateData() {
        log.info("Parsing oh google table is started...");
        String csv = null;
        List<DataForBatchMigration> googleData = null;
        try {
            csv = GoogleDriveExample.getDataFromSpreadSheet();
            CSVParser csvParser = new CSVParser(csv);
            googleData =  csvParser.prepareData();
        } catch (Exception e) {
            e.printStackTrace();
            log.error("Google table wasn't parsed. Migration was  failed");
            return null;
        }
        buCount = googleData.size();
        log.info("Google doc was rad. Count of BU are: " + buCount);
        return googleData;
    }



}
