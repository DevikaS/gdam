package com.adstream.automate.babylon.JsonObjects;

/**
 * User: ruslan.semerenko
 * Date: 18.04.12 17:33
 */
public class FileStorage {
    private String fileStorageId;
    private String fileStorageName;
    private String uploadUrl;
    private String downloadUrl;
    private String downloadSecuredUrl;
    private String fileStorageType;
    private String fileStorageSubType;

    public String getFileStorageId() {
        return fileStorageId;
    }

    public void setFileStorageId(String fileStorageId) {
        this.fileStorageId = fileStorageId;
    }

    public String getFileStorageName() {
        return fileStorageName;
    }

    public void setFileStorageName(String fileStorageName) {
        this.fileStorageName = fileStorageName;
    }

    public String getUploadUrl() {
        return uploadUrl != null ? uploadUrl.trim() : null;
    }

    public void setUploadUrl(String uploadUrl) {
        this.uploadUrl = uploadUrl;
    }

    public String getDownloadUrl() {
        return downloadUrl;
    }

    public void setDownloadUrl(String downloadUrl) {
        this.downloadUrl = downloadUrl;
    }

    public String getDownloadSecuredUrl() {
        return downloadSecuredUrl;
    }

    public void setDownloadSecuredUrl(String downloadSecuredUrl) {
        this.downloadSecuredUrl = downloadSecuredUrl;
    }

    public String getFileStorageType() {
        return fileStorageType;
    }

    public void setFileStorageType(String fileStorageType) {
        this.fileStorageType = fileStorageType;
    }

    public String getFileStorageSubType() {
        return fileStorageSubType;
    }

    public void setFileStorageSubType(String fileStorageSubType) {
        this.fileStorageSubType = fileStorageSubType;
    }

    public String toString() {
        return fileStorageName;
    }
}
