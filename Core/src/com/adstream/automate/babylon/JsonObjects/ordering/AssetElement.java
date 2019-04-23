package com.adstream.automate.babylon.JsonObjects.ordering;

import com.adstream.automate.babylon.JsonObjects.CustomMetadata;
import org.joda.time.DateTime;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 12.10.13
 * Time: 17:12
 */
public class AssetElement {
    private CustomMetadata _cm;
    private CustomMetadata metadata;
    private CustomMetadata preview;

    //cm.common part
    public String getName() {
        return getCmCommon().getString("name");
    }

    public void setName(String name) {
        getCmCommon().put("name", name);
    }

    public Boolean isPlayout() {
        return getCmCommon().getBoolean("isPlayout");
    }

    public void setIsPlayout(boolean isPlayout) {
        getCmCommon().put("isPlayout", isPlayout);
    }

    public String getStatus() {
        return getCmCommon().getString("status");
    }

    public void setStatus(String status) {
        getCmCommon().put("status", status);
    }

    public String[] getMediaType() {
        return getCmCommon().getStringArray("mediaType");
    }

    public void setMediaType(String[] mediaType) {
        getCmCommon().put("mediaType", mediaType);
    }

    public String[] getAdvertiser() {
        return getCmCommon().getStringArray("advertiser");
    }

    public void setAdvertiser(String[] advertiser) {
        getCmCommon().put("advertiser", advertiser);
    }

    public String[] getBrand() {
        return getCmCommon().getStringArray("brand");
    }

    public void setBrand(String[] brand) {
        getCmCommon().put("brand", brand);
    }

    public String[] getSubBrand() {
        return getCmCommon().getStringArray("sub_brand");
    }

    public void setSubBrand(String[] sub_brand) {
        getCmCommon().put("sub_brand", sub_brand);
    }

    public String[] getProduct() {
        return getCmCommon().getStringArray("product");
    }

    public void setProduct(String[] product) {
        getCmCommon().put("product", product);
    }

    // cm.video part
    public String getDuration() {
        return getCmVideo().getString("duration");
    }

    public void setDuration(String duration) {
        getCmVideo().put("duration", duration);
    }

    public DateTime getAirDate() {
        return getCmVideo().getDateTime("airDate");
    }

    public void setAirDate(DateTime airDate) {
        getCmVideo().put("airDate", airDate);
    }

    public String getClockNumber() {
        return getCmVideo().getString("clockNumber");
    }

    public void setClockNumber(String clockNumber) {
        getCmVideo().put("clockNumber", clockNumber);
    }

    // metadata part
    public String getFileType() {
        return getMetadata().getString("fileType");
    }

    public void setFileType(String fileType) {
        getMetadata().put("fileType", fileType);
    }

    public String getFormatProfile() {
        return getMetadata().getString("formatProfile");
    }

    public void setFormatProfile(String formatProfile) {
        getMetadata().put("formatProfile", formatProfile);
    }

    public String getVideoFormatProfile() {
        return getMetadata().getString("videoFormatProfile");
    }

    public void setVideoFormatProfile(String videoFormatProfile) {
        getMetadata().put("videoFormatProfile", videoFormatProfile);
    }

    public String getWidth() {
        return getMetadata().getString("width");
    }

    public void setWidth(String width) {
        getMetadata().put("width", width);
    }

    public String getChannels() {
        return getMetadata().getString("channels");
    }

    public void setChannels(String channels) {
        getMetadata().put("channels", channels);
    }

    public String getSpecDbProfileName() {
        return getMetadataSpecDb().getString("profileName");
    }

    public void setSpecDbProfileName(String profileName) {
        getMetadataSpecDb().put("profileName", profileName);
    }

    public String getFormat() {
        return getMetadata().getString("format");
    }

    public void setFormat(String format) {
        getMetadata().put("format", format);
    }

    public String getMetadataMediaType(){
        return getMetadata().getString("mediaType");
    }

    public void setMetadataMediaType(String mediaType) {
        getMetadata().put("mediaType", mediaType);
    }

    public String getFormatLongName() {
        return getMetadata().getString("formatLongName");
    }

    public void setFormatLongName(String formatLongName) {
        getMetadata().put("formatLongName", formatLongName);
    }

    public String getSampleRate() {
        return getMetadata().getString("sampleRate");
    }

    public void setSampleRate(String sampleRate) {
        getMetadata().put("sampleRate", sampleRate);
    }

    public String getMetadataDuration() {
        return getMetadata().getString("duration");
    }

    public void setMetadataDuration(String duration) {
        getMetadata().put("duration", duration);
    }

    public String getHeight() {
        return getMetadata().getString("height");
    }

    public void setHeight(String height) {
        getMetadata().put("height", height);
    }

    public String getFormatVersion() {
        return getMetadata().getString("formatVersion");
    }

    public void setFormatVersion(String formatVersion) {
        getMetadata().put("formatVersion", formatVersion);
    }

    public String getFormatGeneral() {
        return getMetadata().getString("formatGeneral");
    }

    public void setFormatGeneral(String formatGeneral) {
        getMetadata().put("formatGeneral", formatGeneral);
    }

    public String getFileName() {
        return getMetadata().getString("fileName");
    }

    public void setFileName(String fileName) {
        getMetadata().put("fileName", fileName);
    }

    public String getDisplayAspectRatio() {
        return getMetadata().getString("displayAspectRatio");
    }

    public void setDisplayAspectRatio(String displayAspectRatio) {
        getMetadata().put("displayAspectRatio", displayAspectRatio);
    }

    public String getFrameRate() {
        return getMetadata().getString("frameRate");
    }

    public void setFrameRate(String frameRate) {
        getMetadata().put("frameRate", frameRate);
    }

    public String getFileModifyDateTime() {
        return getMetadata().getString("fileModifyDateTime");
    }

    public void setFileModifyDateTime(String fileModifyDateTime) {
        getMetadata().put("fileModifyDateTime", fileModifyDateTime);
    }

    public String getBitRate() {
        return getMetadata().getString("bitRate");
    }

    public void setBitRate(String bitRate) {
        getMetadata().put("bitRate", bitRate);
    }

    public String getGuise() {
        return getMetadata().getString("guise");
    }

    public void setGuise(String guise) {
        getMetadata().put("guise", guise);
    }

    public String getVideoFormatVersion() {
        return getMetadata().getString("videoFormatVersion");
    }

    public void setVideoFormatVersion(String videoFormatVersion) {
        getMetadata().put("videoFormatVersion", videoFormatVersion);
    }

    public String getMimeType() {
        return getMetadata().getString("mimeType");
    }

    public void setMimeType(String mimeType) {
        getMetadata().put("mimeType", mimeType);
    }

    public String getMediaFileSize() {
        return getMetadata().getString("mediaFileSize");
    }

    public void setMediaFileSize(String mediaFileSize) {
        getMetadata().put("mediaFileSize", mediaFileSize);
    }

    // preview part
    public String getPreviewFileId() {
        return getPreview().getString("fileID");
    }

    public void setPreviewFileId(String fileID) {
        getPreview().put("fileID", fileID);
    }

     /*
    * Private custom metadata helpers
    */

    private CustomMetadata getCm() {
        if (_cm == null) _cm = new CustomMetadata();
        return _cm;
    }

    private CustomMetadata getMetadata() {
        if (metadata == null) metadata = new CustomMetadata();
        return metadata;
    }

    private CustomMetadata getPreview() {
        if (preview == null) preview = new CustomMetadata();
        return preview;
    }

    private CustomMetadata getCmCommon() {
        return getCm().getOrCreateNode("common");
    }

    private CustomMetadata getCmVideo() {
        return getCm().getOrCreateNode("video");
    }

    private CustomMetadata getMetadataSpecDb() {
        return getMetadata().getOrCreateNode("specDb");
    }
}