package com.adstream.automate.babylon.JsonObjects.gdn;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 06.08.13
 * Time: 12:58
 */
public class GDNFileRegister {
    private RegistrationFileInfo[] files;
    private String storageId;

    public RegistrationFileInfo[] getFiles() {
        return files;
    }

    public void setFiles(RegistrationFileInfo[] files) {
        this.files = files;
    }

    public String getStorageId() {
        return storageId;
    }

    public void setStorageId(String storageId) {
        this.storageId = storageId;
    }
}