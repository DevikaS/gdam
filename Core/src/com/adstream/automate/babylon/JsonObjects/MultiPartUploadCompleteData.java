package com.adstream.automate.babylon.JsonObjects;

/**
 * Created by Ramababu.Bendalam on 20/02/2017.
 */
public class MultiPartUploadCompleteData {

    private String storageId;
    private String uploadId;
    private String[] eTags;

    public String getStorageId() {
        return storageId;
    }

    public void setStorageId(String storageId) {
        this.storageId = storageId;
    }

    public String getUploadId() {
        return uploadId;
    }

    public void setUploadId(String uploadId) {
        this.uploadId = uploadId;
    }

    public String[] geteTags() {
        return eTags;
    }

    public void seteTags(String[] eTags) {
        this.eTags = eTags;
    }
}
