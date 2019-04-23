package com.adstream.automate.babylon.migration.objects;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/8/13
 * Time: 1:06 PM

 */

@XmlType(propOrder = {
        "assetGUID",
        "agencyGUID",
        "agencyName",
        "assetTypeID",
        "subAssetTypeID",
        "specificationGUID",
        "fileAvailable",
        "statusID",
        "storageDeviceID",
        "fileDirectory",
        "fileName",
        "fileSize",
        "fileCRC32",
        "sortOrder",
        "userAccessible",
        "retainFileName",
        "storageDeviceFilePath",
        "storageDeviceFTPPath",
        "parentAssetGuid",
        "specDBDocID",
        "fileId",
        "revisionA4"

})
public class ProxyAsset {

    private String assetGUID;
    private String agencyGUID;
    private String assetTypeID;
    private String subAssetTypeID;
    private String fileAvailable;
    private String statusID;
    private String specificationGUID;
    private String storageDeviceID;
    private String fileDirectory;
    private String fileName;
    private String fileSize;
    private String fileId;
    private String sortOrder;
    private boolean userAccessible;
    private boolean retainFileName;
    private String storageDeviceFilePath;
    private String storageDeviceFTPPath;
    private String parentAssetGuid;
    private String specDBDocID;
    private String agencyName;
    private String revisionA4;
    private String fileCRC32;

    @XmlElement(name = "AssetGUID")
    public String getAssetGUID() {
        return assetGUID;
    }

    public void setAssetGUID(String assetGUID) {
        this.assetGUID = assetGUID;
    }

    @XmlElement(name = "AgencyGUID")
    public String getAgencyGUID() {
        return agencyGUID;
    }

    public void setAgencyGUID(String agencyGUID) {
        this.agencyGUID = agencyGUID;
    }

    @XmlElement(name = "AssetTypeID")
    public String getAssetTypeID() {
        return assetTypeID;
    }

    public void setAssetTypeID(String assetTypeID) {
        this.assetTypeID = assetTypeID;
    }

    @XmlElement(name = "SubAssetTypeID")
    public String getSubAssetTypeID() {
        return subAssetTypeID;
    }

    public void setSubAssetTypeID(String subAssetTypeID) {
        this.subAssetTypeID = subAssetTypeID;
    }

    @XmlElement(name = "FileAvailable")
    public String getFileAvailable() {
        return fileAvailable;
    }

    public void setFileAvailable(String fileAvailable) {
        this.fileAvailable = fileAvailable;
    }

    @XmlElement(name = "StatusID")
    public String getStatusID() {
        return statusID;
    }

    public void setStatusID(String statusID) {
        this.statusID = statusID;
    }

    @XmlElement(name = "StorageDeviceID")
    public String getStorageDeviceID() {
        return storageDeviceID;
    }

    public void setStorageDeviceID(String storageDeviceID) {
        this.storageDeviceID = storageDeviceID;
    }

    @XmlElement(name = "FileDirectory")
    public String getFileDirectory() {
        return fileDirectory;
    }

    public void setFileDirectory(String fileDirectory) {
        this.fileDirectory = fileDirectory;
    }

    @XmlElement(name = "FileName")
    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    @XmlElement(name = "FileSize")
    public String getFileSize() {
        return fileSize;
    }

    public void setFileSize(String fileSize) {
        this.fileSize = fileSize;
    }

    @XmlElement(name = "SortOrder")
    public String getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(String sortOrder) {
        this.sortOrder = sortOrder;
    }

    @XmlElement(name = "UserAccessible")
    public boolean isUserAccessible() {
        return userAccessible;
    }

    public void setUserAccessible(boolean userAccessible) {
        this.userAccessible = userAccessible;
    }

    @XmlElement(name = "RetainFileName")
    public boolean isRetainFileName() {
        return retainFileName;
    }

    public void setRetainFileName(boolean retainFileName) {
        this.retainFileName = retainFileName;
    }

    @XmlElement(name = "StorageDeviceFilePath")
    public String getStorageDeviceFilePath() {
        return storageDeviceFilePath;
    }

    public void setStorageDeviceFilePath(String storageDeviceFilePath) {
        this.storageDeviceFilePath = storageDeviceFilePath;
    }

    @XmlElement(name = "StorageDeviceFTPPath")
    public String getStorageDeviceFTPPath() {
        return storageDeviceFTPPath;
    }

    public void setStorageDeviceFTPPath(String storageDeviceFTPPath) {
        this.storageDeviceFTPPath = storageDeviceFTPPath;
    }

    @XmlElement(name = "ParentAssetGuid")
    public String getParentAssetGuid() {
        return parentAssetGuid;
    }

    public void setParentAssetGuid(String parentAssetGuid) {
        this.parentAssetGuid = parentAssetGuid;
    }

    @XmlElement(name = "FileID")
    public String getFileId() {
        return fileId;
    }

    public void setFileId(String fileId) {
        this.fileId = fileId;
    }

    @XmlElement(name = "SpecDBDocID")
    public String getSpecDBDocID() {
        return specDBDocID;
    }

    public void setSpecDBDocID(String specDBDocID) {
        this.specDBDocID = specDBDocID;
    }

    @XmlElement(name = "AgencyName")
    public String getAgencyName() {
        return agencyName;
    }

    public void setAgencyName(String agencyName) {
        this.agencyName = agencyName;
    }

    @XmlElement(name = "SpecificationGUID")
    public String getSpecificationGUID() {
        return specificationGUID;
    }

    public void setSpecificationGUID(String specificationGUID) {
        this.specificationGUID = specificationGUID;
    }

    @XmlElement(name = "RevisionA4")
    public String getRevisionA4() {
        return revisionA4;
    }

    public void setRevisionA4(String revisionA4) {
        this.revisionA4 = revisionA4;
    }

    @XmlElement(name = "FileCRC32")
    public String getFileCRC32() {
        return fileCRC32;
    }

    public void setFileCRC32(String fileCRC32) {
        this.fileCRC32 = fileCRC32;
    }
}
