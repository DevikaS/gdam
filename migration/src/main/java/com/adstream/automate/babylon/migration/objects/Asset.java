package com.adstream.automate.babylon.migration.objects;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/7/13
 * Time: 7:35 PM

 */
@XmlType(propOrder = {
        "assetGUID",
        "assetTypeID",
        "subAssetTypeID",
        "ingestOrderGUID",
        "createdBy",
        "created",
        "lastUpdatedBy",
        "lastUpdated",
        "qualityCheckedBy",
        "regulatoryApprovalGUID",
        "fileAvailable",
        "statusID",
        "version",
        "latestVersion",
        "qualityChecked",
        "releaseQuality",
        "fileExists",
        "preventArchive",
        "adbanked",
        "derived",
        "deleted",
        "cancelled",
        "basket",
        "storageDeviceID",
        "fileDirectory",
        "fileName",
        "fileSize",
        "fileCRC32",
        "uniqueName",
        "uniqueNameSpaced",
        "uniqueNameStripped",
        "advertiserGUID",
        "advertiserProductGUID",
        "title",
        "comment",
        "agencyGUID",
        "agencyName",
        "advertiser",
        "product",
        "assetType",
        "metadataTable",
        "subAssetType",
        "userAccessible",
        "retainFileName",
        "storageDeviceFilePath",
        "storageDeviceFTPPath",
        "status",
        "canOrder",
        "editable",
        "assetXML",
        "campaignGUID",
        "isParentAsset",
        "hasAccessToParentAsset",
        "requiresReview",
        "hasAccessToChildAssets",
        "zipped",
        "campaignName",
        "lifecycleID",
        "specDBDocID",
        "previewInfo",
        "fileID",
        "mediaSubTypeID",
        "mediaSubType",
        "thumbnailInfo",
        "regulatoryApproval",
        "revisionA4",
        "markets",
        "accessAllowed",
        "concurrency",
        "downloadableViaWeb",
        "fileID1",
        "parentAssetGuid",
        "specificationGUID"


})
public class Asset {
    private String assetGUID;
    private String assetTypeID;
    private String subAssetTypeID;
    private String ingestOrderGUID;
    private String createdBy;
    private String created;
    private String lastUpdatedBy;
    private String lastUpdated;
    private String qualityCheckedBy;
    private String specificationGUID;
    private String regulatoryApprovalGUID;
    private String fileAvailable;
    private String statusID;
    private String version;
    private boolean latestVersion;
    private boolean qualityChecked;
    private boolean releaseQuality;
    private boolean fileExists;
    private boolean preventArchive;
    private boolean adbanked;
    private boolean derived;
    private boolean deleted;
    private boolean cancelled;
    private boolean basket;
    private String storageDeviceID;
    private String fileDirectory;
    private String fileName;
    private String fileSize;
    private String fileCRC32;
    private String uniqueName;
    private String uniqueNameSpaced;
    private String uniqueNameStripped;
    private String advertiserGUID;
    private String advertiserProductGUID;
    private String title;
    private String concurrency;
    private String comment;
    private String agencyGUID;
    private String agencyName;
    private String advertiser;
    private String product;
    private String assetType;
    private String metadataTable;
    private String subAssetType;
    private boolean userAccessible;
    private boolean retainFileName;
    private String storageDeviceFilePath;
    private String storageDeviceFTPPath;
    private String status;
    private boolean canOrder;
    private boolean editable;
    private String campaignGUID;
    private boolean isParentAsset;
    private boolean hasAccessToParentAsset;
    private boolean requiresReview;
    private boolean hasAccessToChildAssets;
    private boolean zipped;
    private String campaignName;
    private String lifecycleID;
    private String accessAllowed;
    private String downloadableViaWeb;
    private String specDBDocID;
    private String previewInfo;
    private String fileID;
    private String regulatoryApproval;
    private String fileID1;
    private String parentAssetGuid;
    private String assetXML;
    private Markets markets;
    private String mediaSubTypeID;
    private String mediaSubType;
    private String thumbnailInfo;
    private String revisionA4;



    @XmlElement(name = "AssetGUID")
    public String getAssetGUID() {
        return assetGUID;
    }

    public void setAssetGUID(String assetGUID) {
        this.assetGUID = assetGUID;
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

    @XmlElement(name = "IngestOrderGUID")
    public String getIngestOrderGUID() {
        return ingestOrderGUID;
    }

    public void setIngestOrderGUID(String ingestOrderGUID) {
        this.ingestOrderGUID = ingestOrderGUID;
    }

    @XmlElement(name = "CreatedBy")
    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    @XmlElement(name = "Created")
    public String getCreated() {
        return created;
    }

    public void setCreated(String created) {
        this.created = created;
    }

    @XmlElement(name = "LastUpdatedBy")
    public String getLastUpdatedBy() {
        return lastUpdatedBy;
    }

    public void setLastUpdatedBy(String lastUpdatedBy) {
        this.lastUpdatedBy = lastUpdatedBy;
    }

    @XmlElement(name = "LastUpdated")
    public String getLastUpdated() {
        return lastUpdated;
    }

    public void setLastUpdated(String lastUpdated) {
        this.lastUpdated = lastUpdated;
    }

    @XmlElement(name = "QualityCheckedBy")
    public String getQualityCheckedBy() {
        return qualityCheckedBy;
    }

    public void setQualityCheckedBy(String qualityCheckedBy) {
        this.qualityCheckedBy = qualityCheckedBy;
    }

    @XmlElement(name = "SpecificationGUID")
    public String getSpecificationGUID() {
        return specificationGUID;
    }

    public void setSpecificationGUID(String specificationGUID) {
        this.specificationGUID = specificationGUID;
    }

    @XmlElement(name = "RegulatoryApprovalGUID")
    public String getRegulatoryApprovalGUID() {
        return regulatoryApprovalGUID;
    }

    public void setRegulatoryApprovalGUID(String regulatoryApprovalGUID) {
        this.regulatoryApprovalGUID = regulatoryApprovalGUID;
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

    @XmlElement(name = "Version")
    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    @XmlElement(name = "LatestVersion")
    public boolean isLatestVersion() {
        return latestVersion;
    }

    public void setLatestVersion(boolean latestVersion) {
        this.latestVersion = latestVersion;
    }

    @XmlElement(name = "QualityChecked")
    public boolean isQualityChecked() {
        return qualityChecked;
    }

    public void setQualityChecked(boolean qualityChecked) {
        this.qualityChecked = qualityChecked;
    }

    @XmlElement(name = "ReleaseQuality")
    public boolean isReleaseQuality() {
        return releaseQuality;
    }

    public void setReleaseQuality(boolean releaseQuality) {
        this.releaseQuality = releaseQuality;
    }

    @XmlElement(name = "FileExists")
    public boolean isFileExists() {
        return fileExists;
    }

    public void setFileExists(boolean fileExists) {
        this.fileExists = fileExists;
    }

    @XmlElement(name = "PreventArchive")
    public boolean isPreventArchive() {
        return preventArchive;
    }

    public void setPreventArchive(boolean preventArchive) {
        this.preventArchive = preventArchive;
    }

    @XmlElement(name = "Adbanked")
    public boolean isAdbanked() {
        return adbanked;
    }

    public void setAdbanked(boolean adbanked) {
        this.adbanked = adbanked;
    }

    @XmlElement(name = "Derived")
    public boolean isDerived() {
        return derived;
    }

    public void setDerived(boolean derived) {
        this.derived = derived;
    }

    @XmlElement(name = "Deleted")
    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }

    @XmlElement(name = "Cancelled")
    public boolean isCancelled() {
        return cancelled;
    }

    public void setCancelled(boolean cancelled) {
        this.cancelled = cancelled;
    }

    @XmlElement(name = "Basket")
    public boolean isBasket() {
        return basket;
    }

    public void setBasket(boolean basket) {
        this.basket = basket;
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

    @XmlElement(name = "FileCRC32")
    public String getFileCRC32() {
        return fileCRC32;
    }

    public void setFileCRC32(String fileCRC32) {
        this.fileCRC32 = fileCRC32;
    }

    @XmlElement(name = "UniqueName")
    public String getUniqueName() {
        return uniqueName;
    }

    public void setUniqueName(String uniqueName) {
        this.uniqueName = uniqueName;
    }

    @XmlElement(name = "UniqueNameSpaced")
    public String getUniqueNameSpaced() {
        return uniqueNameSpaced;
    }

    public void setUniqueNameSpaced(String uniqueNameSpaced) {
        this.uniqueNameSpaced = uniqueNameSpaced;
    }

    @XmlElement(name = "UniqueNameStripped")
    public String getUniqueNameStripped() {
        return uniqueNameStripped;
    }

    public void setUniqueNameStripped(String uniqueNameStripped) {
        this.uniqueNameStripped = uniqueNameStripped;
    }

    @XmlElement(name = "AdvertiserGUID")
    public String getAdvertiserGUID() {
        return advertiserGUID;
    }

    public void setAdvertiserGUID(String advertiserGUID) {
        this.advertiserGUID = advertiserGUID;
    }

    @XmlElement(name = "AdvertiserProductGUID")
    public String getAdvertiserProductGUID() {
        return advertiserProductGUID;
    }

    public void setAdvertiserProductGUID(String advertiserProductGUID) {
        this.advertiserProductGUID = advertiserProductGUID;
    }

    @XmlElement(name = "Title")
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @XmlElement(name = "Concurrency")
    public String getConcurrency() {
        return concurrency;
    }

    public void setConcurrency(String concurrency) {
        this.concurrency = concurrency;
    }

    @XmlElement(name = "Comment")
    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    @XmlElement(name = "AgencyGUID")
    public String getAgencyGUID() {
        return agencyGUID;
    }

    public void setAgencyGUID(String agencyGUID) {
        this.agencyGUID = agencyGUID;
    }

    @XmlElement(name = "AgencyName")
    public String getAgencyName() {
        return agencyName;
    }

    public void setAgencyName(String agencyName) {
        this.agencyName = agencyName;
    }

    @XmlElement(name = "Advertiser")
    public String getAdvertiser() {
        return advertiser;
    }

    public void setAdvertiser(String advertiser) {
        this.advertiser = advertiser;
    }

    @XmlElement(name = "Product")
    public String getProduct() {
        return product;
    }

    public void setProduct(String product) {
        this.product = product;
    }

    @XmlElement(name = "AssetType")
    public String getAssetType() {
        return assetType;
    }

    public void setAssetType(String assetType) {
        this.assetType = assetType;
    }

    @XmlElement(name = "MetadataTable")
    public String getMetadataTable() {
        return metadataTable;
    }

    public void setMetadataTable(String metadataTable) {
        this.metadataTable = metadataTable;
    }

    @XmlElement(name = "SubAssetType")
    public String getSubAssetType() {
        return subAssetType;
    }

    public void setSubAssetType(String subAssetType) {
        this.subAssetType = subAssetType;
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

    @XmlElement(name = "Status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @XmlElement(name = "CanOrder")
    public boolean isCanOrder() {
        return canOrder;
    }

    public void setCanOrder(boolean canOrder) {
        this.canOrder = canOrder;
    }

    @XmlElement(name = "Editable")
    public boolean isEditable() {
        return editable;
    }

    public void setEditable(boolean editable) {
        this.editable = editable;
    }

    @XmlElement(name = "CampaignGUID")
    public String getCampaignGUID() {
        return campaignGUID;
    }

    public void setCampaignGUID(String campaignGUID) {
        this.campaignGUID = campaignGUID;
    }

    @XmlElement(name = "IsParentAsset")
    public boolean getIsParentAsset() {
        return isParentAsset;
    }

    public void setParentAsset(boolean parentAsset) {
        isParentAsset = parentAsset;
    }

    @XmlElement(name = "HasAccessToParentAsset")
    public boolean isHasAccessToParentAsset() {
        return hasAccessToParentAsset;
    }

    public void setHasAccessToParentAsset(boolean hasAccessToParentAsset) {
        this.hasAccessToParentAsset = hasAccessToParentAsset;
    }

    @XmlElement(name = "RequiresReview")
    public boolean isRequiresReview() {
        return requiresReview;
    }

    public void setRequiresReview(boolean requiresReview) {
        this.requiresReview = requiresReview;
    }

    @XmlElement(name = "HasAccessToChildAssets")
    public boolean isHasAccessToChildAssets() {
        return hasAccessToChildAssets;
    }

    public void setHasAccessToChildAssets(boolean hasAccessToChildAssets) {
        this.hasAccessToChildAssets = hasAccessToChildAssets;
    }

    @XmlElement(name = "Zipped")
    public boolean isZipped() {
        return zipped;
    }

    public void setZipped(boolean zipped) {
        this.zipped = zipped;
    }

    @XmlElement(name = "CampaignName")
    public String getCampaignName() {
        return campaignName;
    }

    public void setCampaignName(String campaignName) {
        this.campaignName = campaignName;
    }

    @XmlElement(name = "LifecycleID")
    public String getLifecycleID() {
        return lifecycleID;
    }

    public void setLifecycleID(String lifecycleID) {
        this.lifecycleID = lifecycleID;
    }

    @XmlElement(name = "AccessAllowed")
    public String isAccessAllowed() {
        return accessAllowed;
    }

    public void setAccessAllowed(String accessAllowed) {
        this.accessAllowed = accessAllowed;
    }

    @XmlElement(name = "DownloadableViaWeb")
    public String isDownloadableViaWeb() {
        return downloadableViaWeb;
    }

    public void setDownloadableViaWeb(String downloadableViaWeb) {
        this.downloadableViaWeb = downloadableViaWeb;
    }

    @XmlElement(name = "SpecDBDocID")
    public String getSpecDBDocID() {
        return specDBDocID;
    }

    public void setSpecDBDocID(String specDBDocID) {
        this.specDBDocID = specDBDocID;
    }

    @XmlElement(name = "PreviewInfo")
    public String getPreviewInfo() {
        return previewInfo;
    }

    public void setPreviewInfo(String previewInfo) {
        this.previewInfo = previewInfo;
    }

    @XmlElement(name = "FileID")
    public String getFileID() {
        return fileID;
    }

    public void setFileID(String fileID) {
        this.fileID = fileID;
    }

    @XmlElement(name = "RegulatoryApproval")
    public String getRegulatoryApproval() {
        return regulatoryApproval;
    }

    public void setRegulatoryApproval(String regulatoryApproval) {
        this.regulatoryApproval = regulatoryApproval;
    }

    @XmlElement(name = "FileID1")
    public String getFileID1() {
        return fileID1;
    }

    public void setFileID1(String fileID1) {
        this.fileID1 = fileID1;
    }

    @XmlElement(name = "ParentAssetGuid")
    public String getParentAssetGuid() {
        return parentAssetGuid;
    }

    public void setParentAssetGuid(String parentAssetGuid) {
        this.parentAssetGuid = parentAssetGuid;
    }

    @XmlElement(name = "AssetXML")
    public String getAssetXML() {
        return assetXML;
    }

    public void setAssetXML(String assetXML) {
        this.assetXML = assetXML;
    }

    @XmlElement(name = "Markets")
    public Markets getMarkets() {
        return markets;
    }

    public void setMarkets(Markets markets) {
        this.markets = markets;
    }

    @XmlElement(name = "MediaSubTypeID")
    public String getMediaSubTypeID() {
        return mediaSubTypeID;
    }

    public void setMediaSubTypeID(String mediaSubTypeID) {
        this.mediaSubTypeID = mediaSubTypeID;
    }

    @XmlElement(name = "MediaSubType")
    public String getMediaSubType() {
        return mediaSubType;
    }

    public void setMediaSubType(String mediaSubType) {
        this.mediaSubType = mediaSubType;
    }

    @XmlElement(name = "ThumbnailInfo")
    public String getThumbnailInfo() {
        return thumbnailInfo;
    }

    public void setThumbnailInfo(String thumbnailInfo) {
        this.thumbnailInfo = thumbnailInfo;
    }

    @XmlElement(name = "RevisionA4")
    public String getRevisionA4() {
        return revisionA4;
    }

    public void setRevisionA4(String revisionA4) {
        this.revisionA4 = revisionA4;
    }
}
