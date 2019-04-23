package com.adstream.automate.babylon.performance.yadn;

import com.adstream.automate.babylon.BabylonServiceWrapper;
import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.UploadListener;
import com.adstream.automate.babylon.core.BabylonCoreService;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.Gen;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import java.io.File;
import java.util.Properties;

/**
 * User: ruslan.semerenko
 * Date: 13.09.12 16:40
 */
public class YadnUploadTest {
    private static Logger log = Logger.getLogger(YadnUploadTest.class);
    private static Config config;

    public static void main(String[] args) {
        loadConfig(args[0]);
        doTest();
    }

    private static void doTest() {
        long start = System.currentTimeMillis();
        int threadsCreated = 0;
        long totalBytes = 0;
        long totalTimeChunkUpload = 0;
        int totalAmountChunk = 0;
        YadnUploadThread[] threads = new YadnUploadThread[config.getThreadsCount()];
        while (threadsCreated < config.getUploadsCount()) {
            for (int i = 0; i < threads.length; i++) {
                YadnUploadThread thread = threads[i];
                if (thread == null || !thread.isAlive()) {
                    if (thread != null)
                        totalBytes += thread.getBytesTotal();
                    thread = new YadnUploadThread(getService(), getFileForUpload(), isUseGDN());
                    thread.start();
                    threads[i] = thread;
                    threadsCreated++;
                    log.info("Started thread #" + threadsCreated);
                }
            }
            Common.sleep(100);
        }
        boolean finished;
        do {
            finished = true;
            for (YadnUploadThread thread : threads) {
                if (thread.isAlive()) finished = false;
            }
            Common.sleep(100);
        } while (!finished);
        for (YadnUploadThread thread : threads) {
            totalBytes += thread.getBytesTotal();
            totalTimeChunkUpload += thread.getTotalChunkUploadTime();
            totalAmountChunk += thread.getTotalAmountChunk();
        }
        long time = System.currentTimeMillis() - start;
        log.info(String.format("Finished. Total volume transferred: %s. Total time: %d s. Avg speed: %s/s, Avg time upload chunk: %s ms",
                bytesToHumanString(totalBytes), time / 1000, bytesToHumanString(1000 * totalBytes / time), totalTimeChunkUpload / totalAmountChunk));
    }

    private static File getFileForUpload() {
        int max = config.getUploadFilePath().length;
        return new File(config.getUploadFilePath()[Gen.getInt(max)]);
    }

    private static void loadConfig(String path) {
        config = Config.loadConfig(path);
        Properties properties = new Properties();
        properties.putAll(config.getLog4jProperties());
        PropertyConfigurator.configure(properties);
    }

    private static BabylonServiceWrapper getService() {
        BabylonServiceWrapper service = new BabylonServiceWrapper(new BabylonCoreService(config.getCoreUrl()), null);
        service.logIn(config.getAgencyAdminLogin(), config.getAgencyAdminPassword());
        return service;
    }

    private static boolean isUseGDN() {
        return config.getUseGDN();
    }

    public static String bytesToHumanString(long bytes) {
        String[] suf = new String[] {"b", "kb", "Mb", "Gb", "Tb"};
        if (bytes < 1024) return bytes + " b";
        int i = 0;
        double result = bytes;
        while (result >= 1024) {
            result /= 1024.0;
            i++;
        }
        return String.format("%.3f %s", result, suf[i]);
    }
}

class YadnUploadThread extends Thread implements UploadListener {
    private Logger log = Logger.getLogger(this.getClass());
    private BabylonServiceWrapper service;
    private File uploadFile;
    private long bytesUploaded = 0;
    private long bytesTotal = 0;
    private int chunkLength = 0;
    private long lastChunkTime = 0;
    private long totalTime = 0;
    private String targetFileName = "";
    private boolean useGDN;
    private long totalChunkUploadTime = 0;
    private int totalAmountChunk = 0;

    public YadnUploadThread(BabylonServiceWrapper service, File uploadFile, boolean useGDN) {
        this.service = service;
        this.uploadFile = uploadFile;
        this.useGDN = useGDN;
    }

    @Override
    public void run() {
        String folderId = getNewFolderId();
        log.info("Start uploading file " + uploadFile.getName());
        service.uploadFile(uploadFile, folderId);
    }

    @Override
    public void chunkUploadComplete(long bytesUploaded, long bytesTotal, int chunkLength, long lastChunkTime, long totalTime, String targetFileName) {
        this.bytesUploaded = bytesUploaded;
        this.bytesTotal = bytesTotal;
        this.chunkLength = chunkLength;
        this.lastChunkTime = lastChunkTime;
        this.totalTime = totalTime;
        this.targetFileName = targetFileName;
        this.totalChunkUploadTime += lastChunkTime;
        this.totalAmountChunk = totalAmountChunk + 1;
        log.info(String.format("File %s. Uploaded: %s/%s; speed: %s/s (avg: %s/s); Chunk time upload: %s ms",
                targetFileName,
                YadnUploadTest.bytesToHumanString(bytesUploaded),
                YadnUploadTest.bytesToHumanString(bytesTotal),
                YadnUploadTest.bytesToHumanString(1000L * chunkLength / lastChunkTime),
                YadnUploadTest.bytesToHumanString(1000 * bytesUploaded / totalTime),
                lastChunkTime));
    }

    @Override
    public void uploadComplete(String targetFileName, String fileId) {
        log.info(String.format("File %s uploading finished.", targetFileName));
    }

    public long getTotalChunkUploadTime() {
        return totalChunkUploadTime;
    }

    public int getTotalAmountChunk() {
        return totalAmountChunk;
    }

    public long getBytesUploaded() {
        return bytesUploaded;
    }

    public long getBytesTotal() {
        return bytesTotal;
    }

    public int getChunkLength() {
        return chunkLength;
    }

    public long getLastChunkTime() {
        return lastChunkTime;
    }

    public long getTotalTime() {
        return totalTime;
    }

    public String getTargetFileName() {
        return targetFileName;
    }

    private String getNewFolderId() {
        Project project = service.createProject(new BabylonBillets(service).getProjectBillet());
        Content folder = service.createFolder(project.getId(), Gen.getHumanReadableString(6, true));
        return folder.getId();
    }
}