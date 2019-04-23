package com.adstream.automate.babylon.JsonObjects.gdn;

import java.io.File;
import java.util.UUID;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 08.08.13
 * Time: 13:22
 */
// wrapper of file for registering in GDN
public class GDNFileWrapper {
    private File file;
    private String externalId;
    private String agencyId;

    public GDNFileWrapper(File file) {
        this.file = file;
        this.externalId = UUID.randomUUID().toString();  // generate unique externalId
    }

    public GDNFileWrapper(File file, String agencyId) {
        this.file = file;
        this.externalId = UUID.randomUUID().toString();  // generate unique externalId
        this.agencyId = agencyId;
    }

    public File getFile() {
        return file;
    }

    public void setFile(File file) {
        this.file = file;
    }

    public String getName() {
        return file.getName();
    }

    public long getSize() {
        return file.length();
    }

    public String getExternalId() {
        return externalId;
    }

    public String getAgencyId() {
        return agencyId;
    }

    public void setAgencyId(String agencyId) {
        this.agencyId = agencyId;
    }
}