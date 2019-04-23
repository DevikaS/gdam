package com.adstream.automate.babylon.JsonObjects.ordering;

import com.adstream.automate.babylon.JsonObjects.CustomMetadata;

/*
 * Created by demidovskiy-r on 25.02.14.
 */
public class Document {
    private String fileId;
    private Integer size;
    private String fileName;
    private Long uploadedTimestamp;
    private String uploaderName;

    public Document(CustomMetadata cm) {
        setFileId(cm.getString("fileId"));
        setSize(cm.getInteger("size"));
        setFileName(cm.getString("fileName"));
        setUploadedTimestamp(cm.getLong("uploadedTimestamp"));
        setUploaderName(cm.getString("uploaderName"));
    }

    public String getFileId() {
        return fileId;
    }

    public void setFileId(String fileId) {
        this.fileId = fileId;
    }

    public Integer getSize() {
        return size;
    }

    public void setSize(Integer size) {
        this.size = size;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public Long getUploadedTimestamp() {
        return uploadedTimestamp;
    }

    public void setUploadedTimestamp(Long uploadedTimestamp) {
        this.uploadedTimestamp = uploadedTimestamp;
    }

    public String getUploaderName() {
        return uploaderName;
    }

    public void setUploaderName(String uploaderName) {
        this.uploaderName = uploaderName;
    }
}