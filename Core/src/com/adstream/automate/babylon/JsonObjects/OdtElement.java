package com.adstream.automate.babylon.JsonObjects;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/6/14
 * Time: 1:10 PM
 */

public class OdtElement {
    private Long fileSize;
    private String specDbDocID;
    private String fileID;
    private String a5_type;
    private String name;

    public Long getFileSize() {
        return fileSize;
    }

    public void setFileSize(Long fileSize) {
        this.fileSize = fileSize;
    }

    public String getSpecDbDocID() {
        return specDbDocID;
    }

    public void setSpecDbDocID(String specDbDocID) {
        this.specDbDocID = specDbDocID;
    }

    public String getFileID() {
        return fileID;
    }

    public void setFileID(String fileID) {
        this.fileID = fileID;
    }

    public String getA5_type() {
        return a5_type;
    }

    public void setA5_type(String a5_type) {
        this.a5_type = a5_type;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
