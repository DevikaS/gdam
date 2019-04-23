package com.adstream.automate.babylon.JsonObjects;

import org.joda.time.DateTime;

/**
 * User: ruslan.semerenko
 * Date: 27.08.12 15:25
 */
public class FilePreview {
    private DateTime _created;
    private Integer fileSize;
    private String fileID;
    private Integer height;
    private String a5_type;
    private Integer width;
    private String name;
    private String specDbDocID;

    public FilePreview() {}

    public FilePreview(CustomMetadata cm) {
        set_created(cm.getDateTime("_created"));
        setFileSize(cm.getInteger("fileSize"));
        setFileID(cm.getString("fileID"));
        setHeight(cm.getInteger("height"));
        setA5Type(cm.getString("a5_type"));
        setWidth(cm.getInteger("width"));
        setName(cm.getString("name"));
        setSpecDbDocID(cm.getString("specDbDocID"));
    }

    public DateTime get_created() {
        return _created;
    }

    public void set_created(DateTime _created) {
        this._created = _created;
    }

    public Integer getFileSize() {
        return fileSize;
    }

    public void setFileSize(Integer fileSize) {
        this.fileSize = fileSize;
    }

    public String getFileID() {
        return fileID;
    }

    public void setFileID(String fileID) {
        this.fileID = fileID;
    }

    public Integer getHeight() {
        return height;
    }

    public void setHeight(Integer height) {
        this.height = height;
    }

    public String getA5Type() {
        return a5_type;
    }

    public void setA5Type(String a5Type) {
        this.a5_type = a5Type;
    }

    public Integer getWidth() {
        return width;
    }

    public void setWidth(Integer width) {
        this.width = width;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSpecDbDocID() {
        return specDbDocID;
    }

    public void setSpecDbDocID(String specDbDocID) {
        this.specDbDocID = specDbDocID;
    }
}