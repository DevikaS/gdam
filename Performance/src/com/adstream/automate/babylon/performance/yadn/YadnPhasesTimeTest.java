package com.adstream.automate.babylon.performance.yadn;

import com.adstream.automate.babylon.BabylonServiceWrapper;
import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.FileRevision;
import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.core.BabylonCoreService;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.Gen;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import java.io.File;
import java.util.*;

/**
 * User: ruslan.semerenko
 * Date: 12.09.12 11:30
 */
public class YadnPhasesTimeTest {
    private static Logger log = Logger.getLogger(YadnPhasesTimeTest.class);
    private static List<Map<String, Long>> stat = new ArrayList<Map<String, Long>>();
    private static Config config;

    public static void main(String[] args) {
        loadConfig(args[0]);
        doTest();
        showResult();
    }

    private static void doTest() {
        YadnTestThread[] threads = new YadnTestThread[config.getThreadsCount()];
        long testTime = config.getTestTimeMinutes() * 60 * 1000;
        long start = System.currentTimeMillis();
        do {
            for (int i = 0; i < threads.length; i++) {
                YadnTestThread thread = threads[i];
                if (thread == null || !thread.isAlive()) {
                    if (thread != null) {
                        addStat(thread);
                    }
                    thread = new YadnTestThread(getService(), new File(config.getUploadFilePath()[0]), isUseGDN());
                    thread.start();
                    threads[i] = thread;
                }
            }
            Common.sleep(100);
        } while (System.currentTimeMillis() - start < testTime);
        for (YadnTestThread thread : threads) {
            if (thread != null) thread.interrupt();
        }
    }

    private static void loadConfig(String path) {
        config = Config.loadConfig(path);
        Properties properties = new Properties();
        properties.putAll(config.getLog4jProperties());
        PropertyConfigurator.configure(properties);
    }

    private static boolean isUseGDN() {
        return config.getUseGDN();
    }

    private static void addStat(YadnTestThread thread) {
        Map<String, Long> entry = new HashMap<String, Long>();
        entry.put("uploadTime", thread.getUploadTime());
        entry.put("specTime", thread.getSpecTime());
        entry.put("previewTime", thread.getPreviewTime());
        entry.put("totalTime", thread.getTotalTime());
        stat.add(entry);
    }

    private static void showResult() {
        long uploadTime = 0;
        long specTime = 0;
        long previewTime = 0;
        long totalTime = 0;
        for (Map<String, Long> row : stat) {
            uploadTime += row.get("uploadTime");
            specTime += row.get("specTime");
            previewTime += row.get("previewTime");
            totalTime += row.get("totalTime");
        }
        int count = stat.size() * 1000;
        if (count > 0)
            log.info(String.format("Average result:%nUpload: %.3f s%nSpec: %d s%nPreview: %d s%nTotal: %d s%n",
                    uploadTime / (1.0 * count), specTime / count, previewTime / count, totalTime / count));
        else
            log.info("Timeout was reached while waiting for result");
    }

    private static BabylonServiceWrapper getService() {
        BabylonServiceWrapper service = new BabylonServiceWrapper(new BabylonCoreService(config.getCoreUrl()), null);
        service.logIn(config.getAgencyAdminLogin(), config.getAgencyAdminPassword());
        return service;
    }
}

class YadnTestThread extends Thread {
    private boolean process = true;
    private Logger log = Logger.getLogger(this.getClass());
    private BabylonServiceWrapper service;
    private File uploadFile;
    private long uploadTime;
    private long specTime;
    private long previewTime;
    private long totalTime;
    private boolean useGDN;

    public YadnTestThread(BabylonServiceWrapper service, File uploadFile, boolean useGDN) {
        this.service = service;
        this.uploadFile = uploadFile;
        this.useGDN = useGDN;
    }

    public void run() {
        String folderId = getNewFolderId();
        long start = System.currentTimeMillis();

        // upload file
        Content file = service.uploadFile(uploadFile, folderId);
        String fileId = file.getId();
        long fileUploaded = System.currentTimeMillis(); uploadTime = fileUploaded - start;
        log.info(String.format("File %s uploaded for %d ms", file.getId(), uploadTime));

        // wait for specs
        do {
            if (!process) return;
            Common.sleep(1000);
            file = service.getContent(fileId);
        } while (file.getLastRevision().getMaster() == null);
        long fileSpecAvailable = System.currentTimeMillis(); specTime = fileSpecAvailable - fileUploaded;
        FileRevision revision = file.getLastRevision().getMaster();
        Map<String, Object> meta = revision.getMetadata();
        log.info(String.format("File %s spec available for %d ms [type: %s, size: %s, width: %s, height: %s, duration: %s]",
                file.getId(), specTime, meta.get("fileType"), revision.getFileSize(), meta.get("width"), meta.get("height"), meta.get("duration")));

        // wait for preview
        do {
            if (!process) return;
            Common.sleep(1000);
            file = service.getContent(fileId);
        } while (file.getLastRevision().getPreview() == null);
        long filePreviewAvailable = System.currentTimeMillis(); previewTime = filePreviewAvailable - fileSpecAvailable;
        totalTime = filePreviewAvailable - start;
        log.info(String.format("File %s preview available for %d ms", file.getId(), previewTime));
    }

    public void interrupt() {
        process = false;
    }

    public long getUploadTime() {
        return uploadTime;
    }

    public long getSpecTime() {
        return specTime;
    }

    public long getPreviewTime() {
        return previewTime;
    }

    public long getTotalTime() {
        return totalTime;
    }

    private String getNewFolderId() {
        Project project = service.createProject(new BabylonBillets(service).getProjectBillet());
        Content folder = service.createFolder(project.getId(), Gen.getHumanReadableString(6, true));
        return folder.getId();
    }
}