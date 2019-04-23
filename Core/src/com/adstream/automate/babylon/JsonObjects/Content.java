package com.adstream.automate.babylon.JsonObjects;

import com.google.gson.annotations.SerializedName;

import java.util.List;

import static java.util.Arrays.asList;

/**
 * User: ruslan.semerenko
 * Date: 04.04.12 18:39
 */
public class Content extends BaseObject {
    // common with files and folders
    private CustomMetadata _cm;
    private Identity project;
    private String short_id;

    // for folders in trash
    private List<Content> content;

    //only for files
    private String element_guid;
    private String adBanked;
    @SerializedName("tmp-path")
    private String tmpPath;
    private FileRevision[] revisions;
    private BaseObject[] attachedFiles;
    private Agency originator;

    //for delete
    private String folderId;
    private String[] _permissions;
    private String path;

    //for migration A4->A5
    private Long _a4version;

    private MultiPartUploadCompleteData multiPartUploadCompleteData;

    public Identity getProject() {
        return project;
    }

    public void setProject(Identity project) {
        this.project = project;
    }

    public String getShortId() {
        return short_id;
    }

    public void setShortId(String shortId) {
        this.short_id = shortId;
    }

    public List<Content> getSubFoldersInTrash() {
        return content;
    }

    public String getElementGuid() {
        return this.element_guid;
    }

    public void setElementGuid(String elementGuid) {
        this.element_guid = elementGuid;
    }

    public String getDdBanked() {
        return this.adBanked;
    }

    public void setDdBanked(String adBanked) {
        this.adBanked = adBanked;
    }

    public String getTmpPath() {
        return this.tmpPath;
    }

    public void setTmpPath(String tmpPath) {
        this.tmpPath = tmpPath;
    }

    public String getFolderId() {
        return this.folderId;
    }

    public void setFolderId(String folderId) {
        this.folderId = folderId;
    }

    public String[] getPermissions() {
        return this._permissions;
    }

    public void setPermissions(String[] permissions) {
        this._permissions = permissions;
    }

    public String getPath() {
        return this.path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public FileRevision[] getRevisions() {
        return this.revisions;
    }

    public void setRevisions(FileRevision[] revisions) {
        this.revisions = revisions;
    }

    public FileRevision getLastRevision() {
        FileRevision max = null;
        for (FileRevision current : getRevisions()) {
            if (max == null || max.getRevisionId() < current.getRevisionId()) {
                max = current;
            }
        }
        return max;
    }

    public BaseObject[] getAttachedFiles() {
        if (attachedFiles == null) {
            attachedFiles = new BaseObject[0];
        }
        return attachedFiles;
    }

    public void setAttachedFiles(BaseObject[] attachedFiles) {
        this.attachedFiles = attachedFiles;
    }

    public Agency getOriginator() {
        return originator;
    }

    public void setOriginator(Agency originator) {
        this.originator = originator;
    }

    @Override
    public String getName() {
        return getCmCommon().getString("name");
    }

    @Override
    public void setName(String name) {
        getCmCommon().put("name", name);
    }

    public Boolean isPlayout() {
        return getCmCommon().getBoolean("isPlayout");
    }

    public void setPlayout(Boolean isPlayout) {
        getCmCommon().put("isPlayout", isPlayout);
    }

    public String getStatus() {
        return getCmCommon().getString("status");
    }

    public void setStatus(String status) {
        getCmCommon().put("status", status);
    }

    public String getMediaSubType() {
        return getArrayFirstElement(getCmCommon().getStringArray("mediaSubType"));
    }

    public void setMediaSubType(String mediaSubType) {
        getCmCommon().put("mediaSubType", asList(mediaSubType));
    }

    public String getMediaType() {
        return getArrayFirstElement(getCmCommon().getStringArray("mediaType"));
    }

    public void setMediaType(String mediaType) {
        getCmCommon().put("mediaType", asList(mediaType));
    }

    public String getAdvertiser() {
        return getArrayFirstElement(getCmCommon().getStringArray("advertiser"));
    }

    public void setAdvertiser(String advertiser) {
        getCmCommon().put("advertiser", asList(advertiser));
    }

    public String getBrand() {
        return getArrayFirstElement(getCmCommon().getStringArray("brand"));
    }

    public void setBrand(String brand) {
        getCmCommon().put("brand", asList(brand));
    }

    public Long get_a4version() {
        return _a4version;
    }

    public void set_a4version(Long _a4version) {
        this._a4version = _a4version;
    }

    public void setMetadataField(String type, String key, Object value) {
        if (type == null || type.isEmpty() || key == null || key.isEmpty() || value == null)  return;
        if (value instanceof String && ((String) value).isEmpty()) return;
        getCm().getOrCreateNode(type).put(key, value);
    }

    public CustomMetadata getCm() {
        if (_cm == null) _cm = new CustomMetadata();
        return _cm;
    }

    public CustomMetadata getCmCommon() {
        return getCm().getOrCreateNode("common");
    }

    public MultiPartUploadCompleteData getMultiPartUploadCompleteData() {
        return multiPartUploadCompleteData;
    }

    public void setMultiPartUploadCompleteData(MultiPartUploadCompleteData multiPartUploadCompleteData) {
        this.multiPartUploadCompleteData = multiPartUploadCompleteData;
    }

    public String getCampaign() {
        return getArrayFirstElement(getCmCommon().getStringArray("campaign"));
    }

    public void setCampaign(String campaign) {
        getCmCommon().put("Campaign", campaign);
    }

    private String getArrayFirstElement(String[] arr) {
        if (arr == null || arr.length == 0) {
            return null;
        } else {
            return arr[0];
        }
    }

    public String getMarket() {
        return getCm().getString("market");
    }


    public void setMarket(String[] name) {
        getCm().put("market", name);
    }

    public void setMarketId(String[] name) {
        getCm().put("marketId", name);
    }

}