package com.adstream.automate.babylon.tests.steps.domain.ingest;

import com.adstream.automate.babylon.tests.steps.core.GdnBase;
import com.adstream.automate.utils.database.ConnectionPool;
import org.apache.log4j.Logger;

import java.io.IOException;
import java.util.Stack;

/**
 * Created by Ramababu.Bendalam on 14/01/2016.
 */
public class AssetGUIDgetterThread extends Thread {

    private static Logger log = Logger.getLogger(AssetGUIDgetterThread.class);
    private static Stack<String> pool = new Stack<String>();

    public static void addClock(String clock){
        pool.push(clock);
    }

    public static void getAssetGuid(String clock){
        try {
            String assetGUID = ConnectionPool.selectCell(
                    new TemplatesHelper().getAssetGUIDTemplate(),
                    clock
            );
            GdnBase.addAssetGUID(assetGUID);
            GdnBase.addClockGuidMap(clock, assetGUID);
            if (assetGUID == null
                    || assetGUID == "NULL"
                    || assetGUID == "Null"
                    || assetGUID == "null"){
                GdnBase.setErr();
            }

        } catch (IOException e) {
            e.printStackTrace();
            log.error(e.toString());
            GdnBase.setErr();
        }
 }
}
