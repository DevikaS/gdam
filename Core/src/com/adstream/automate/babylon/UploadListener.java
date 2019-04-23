package com.adstream.automate.babylon;

/**
 * User: ruslan.semerenko
 * Date: 13.09.12 16:08
 */
public interface UploadListener {
    public void chunkUploadComplete(long bytesUploaded, long bytesTotal, int chunkLength, long lastChunkTime, long totalTime, String targetFileName);
    public void uploadComplete(String targetFileName, String fileId);
}
