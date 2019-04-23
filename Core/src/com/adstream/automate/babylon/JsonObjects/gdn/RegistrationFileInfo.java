package com.adstream.automate.babylon.JsonObjects.gdn;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 06.08.13
 * Time: 13:00
 */
public class RegistrationFileInfo {
    private String attachedFileId;
    private String externalID;
    private String fileId;
    private String fileUri;
    private String status;

    public String getExternalID() {
        return externalID;
    }

    public void setExternalID(String externalID) {
        this.externalID = externalID;
    }

    public String getFileId() {
        return fileId;
    }

    public void setFileId(String fileId) {
        this.fileId = fileId;
    }

    public void setAttachedFileId(String attachedFileId) { this.attachedFileId = attachedFileId;}

    public String getAttachedFileId() { return attachedFileId; }

    public String getFileUri() {
        return fileUri;
    }

    public void setFileUri(String fileUri) {
        this.fileUri = fileUri;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}