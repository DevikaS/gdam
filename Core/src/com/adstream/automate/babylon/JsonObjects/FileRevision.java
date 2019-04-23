package com.adstream.automate.babylon.JsonObjects;

import com.google.gson.annotations.SerializedName;
import org.joda.time.DateTime;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

/**
 * User: ruslan.semerenko
 * Date: 19.07.12 16:46
 */
public class FileRevision {
    @SerializedName("annotation-proxy")
    private FilePreview annotationProxy;
    private List<FilePreview> preview;
    private FileRevision master;
    private Long fileSize;
    private DateTime _created;
    private String fileID;
    private String MD5;
    private String specDbDocID;
    private Map<String, Object> metadata;
    private Integer revisionId;
    @SerializedName("odt-element")
    private List<OdtElement> odtElement;

    public FileRevision() {}

    public FileRevision(CustomMetadata cm) {
        if (cm.containsKey("annotation-proxy")) {
            setAnnotationProxy(cm.getForClass("annotation-proxy", FilePreview.class));
        }
        if (cm.containsKey("preview")) {
            setPreview(Arrays.asList(cm.getArrayForClass("preview", FilePreview.class)));
        }
        setMaster(cm.getForClass("master", FileRevision.class));
        setFileSize(cm.getLong("fileSize"));
        setCreated(cm.getDateTime("_created"));
        setFileID(cm.getString("fileID"));
        setMD5(cm.getString("MD5"));
        setSpecDbDocID(cm.getString("specDbDocID"));
        setMetadata((Map<String, Object>) cm.get("metadata"));
        setRevisionId(cm.getInteger("revisionId"));
    }

    public FilePreview getAnnotationProxy() {
        return annotationProxy;
    }

    public void setAnnotationProxy(FilePreview annotationProxy) {
        this.annotationProxy = annotationProxy;
    }

    public List<FilePreview> getPreview() {
        return preview;
    }

    public void setPreview(List<FilePreview> preview) {
        this.preview = preview;
    }

    public FileRevision getMaster() {
        return master;
    }

    public void setMaster(FileRevision master) {
        this.master = master;
    }

    public Long getFileSize() {
        return fileSize;
    }

    public void setFileSize(Long fileSize) {
        this.fileSize = fileSize;
    }

    public DateTime getCreated() {
        return _created;
    }

    public void setCreated(DateTime created) {
        _created = created;
    }

    public String getFileID() {
        return fileID;
    }

    public void setFileID(String fileID) {
        this.fileID = fileID;
    }

    public String getMD5() {
        return MD5;
    }

    public void setMD5(String MD5) {
        this.MD5 = MD5;
    }

    public String getSpecDbDocID() {
        return specDbDocID;
    }

    public void setSpecDbDocID(String specDbDocID) {
        this.specDbDocID = specDbDocID;
    }

    public Map<String, Object> getMetadata() {
        return metadata;
    }

    public void setMetadata(Map<String, Object> metadata) {
        this.metadata = metadata;
    }

    public Integer getRevisionId() {
        return revisionId;
    }

    public void setRevisionId(Integer revisionId) {
        this.revisionId = revisionId;
    }

    public List<OdtElement> getOdtElement() {
        return odtElement;
    }

    public void setOdtElement(List<OdtElement> odtElement) {
        this.odtElement = odtElement;
    }
}
