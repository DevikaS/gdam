package com.adstream.automate.babylon.tests.steps.core;

import com.adstream.automate.babylon.JsonObjects.gdn.*;
import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.tests.steps.domain.ingest.AssetGUIDgetterThread;
import com.adstream.automate.babylon.tests.steps.domain.ingest.FilePut;
import com.adstream.automate.babylon.tests.steps.domain.ingest.MetadataUpdate;
import com.adstream.automate.babylon.tests.steps.domain.ingest.UpdateAsset;
import com.adstream.automate.babylon.tests.steps.domain.ordering.OrderingHelperSteps;
import com.adstream.automate.babylon.tests.steps.utils.gdn.*;
import com.adstream.automate.gdn.activemq.ActiveMQService;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.database.ConnectionPool;
import com.adstream.gdn.api.client.serialization.RegisterJob;
import com.adstream.gdn.api.client.serialization.RegisterJobResponse;
import org.apache.log4j.Logger;
import org.testng.Assert;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

import static org.hamcrest.MatcherAssert.assertThat;


/**
 * Created by Ramababu.Bendalam on 04/02/2016.
 */
public class GdnBase extends BaseStep {

    private final static Logger log = Logger.getLogger(GdnBase.class);
    private static List<AssetGUIDgetterThread> assetGUIDgetterThreads = new ArrayList<AssetGUIDgetterThread>();
    private static Stack<String> assetGUIDsStack = new Stack<String>();
    private static List<String> assetGUIDs = new ArrayList<String>();
    private static Map<String, String> assetGuidToFileId = new HashMap<String, String>();
    private static Map<String, String> clockGuidMap = new HashMap<String, String>();
    public static Map<String, File> uploadedFiles = new ConcurrentHashMap<String, File>();
    private static boolean err = false;
    public static RegisterJobResponse response;
    public static List<String> responses = new ArrayList<String>();

    public static synchronized void setErr() {
        err = true;
    }

    public static synchronized void addAssetGUID(String assetGUID) {
        assetGUIDs.add(assetGUID);
        assetGUIDsStack.push(assetGUID);
    }

    public static synchronized void addClockGuidMap(String clock, String guid) {
        clockGuidMap.put(clock, guid);
    }

    public static synchronized String getGuidByClock(String clock) {
        return clockGuidMap.get(clock);
    }

    // Initalizes SQL server public GdnBase() throws IOException {
    public GdnBase()  {
        ConnectionPool.createDefaultPool(TestsContext.getInstance().DB_CONNECTION,
                TestsContext.getInstance().DB_LOGIN,
                TestsContext.getInstance().DB_PASSWORD,
                10);
    }

    /*For given clockNumber it gets assetGUID using AssetGUIDgetterThread class */
    private static void getAndWriteAssetGUIDs(String ClockNumber) {
         AssetGUIDgetterThread.getAssetGuid(ClockNumber);

        }

   private Stack<String> stackFromList(List<String> list) {
        Stack<String> stack = new Stack<String>();
        for (String line : list) {
            stack.push(line);
        }
        return stack;
    }

   /* connect to sql server and get the assetGuids. */
    private static void getAssetGUIDs(String ClockNumber) throws IOException {
        getAndWriteAssetGUIDs(ClockNumber);

    }

    /* get  fileId from response */
    public static String getfileID(){
        return response.FileID().get();
    }

/* Ingest process */
 public static void ingest(String clockNumber) throws IOException, InterruptedException {
        GdnBase gdn = new GdnBase();
        GdnBase.getAssetGUIDs(clockNumber);
        if (err) {
            return;
        }
        String assetGuid = GdnBase.getGuidByClock(clockNumber);
        File folder = new File(TestsContext.getInstance().ingestDropPath + File.separator + assetGuid);
        File destFileZip = new File(folder, assetGuid + "_Master.zip");
        uploadedFiles.put(assetGuid, destFileZip);
        for (Map.Entry<String, File> fileEntry : uploadedFiles.entrySet()) {
            RegisterJob job = RegisterJobFactory.getRegisterJob(TestsContext.getInstance().storageExtID, fileEntry.getValue(), fileEntry.getKey());
            response = (RegisterJobResponse) getGDNApi().submitJob(job);
            assetGuidToFileId.put(fileEntry.getKey(), response.FileID().get());
            responses.add(response.FileID().get());
            }
     FilePut fileput = new FilePut(new URL(TestsContext.getInstance().A4FileUploadLocation));
     fileput.uploadfile(clockNumber);
     MetadataUpdate metadataupdate = new MetadataUpdate();
     metadataupdate.modifymetadata(clockNumber);
     UpdateAsset updateasset = new UpdateAsset();
     updateasset.saveIngest(clockNumber);
     assetGuidToFileId.clear();
     clockGuidMap.clear();
     uploadedFiles.clear();
}


}
