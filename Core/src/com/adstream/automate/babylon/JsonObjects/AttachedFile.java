package com.adstream.automate.babylon.JsonObjects;

/**
 * Created by sobolev-a on 23.05.2014.
 */
public class AttachedFile {
    private String id;
    private String name;
    private Long size;
    private Long uploadedTimestamp;
    private String uploaderName;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Long getSize() {
        return size;
    }

    public void setSize(Long size) {
        this.size = size;
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
