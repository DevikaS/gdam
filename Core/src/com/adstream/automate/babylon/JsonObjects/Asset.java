package com.adstream.automate.babylon.JsonObjects;

import org.joda.time.DateTime;
import java.util.Arrays;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 26.09.12
 * Time: 20:28
 */
public class Asset extends BaseObject {
    private CustomMetadata _cm;
    private CustomMetadata qc;
    private List<FilePreview> preview;
    private FileRevision[] revisions;
    private String short_id;
    private Agency originator;

    public Asset() {}

    public Asset(CustomMetadata cm) {
        super(cm);
        if (cm.containsKey("_cm")) {
            _cm = cm.getOrCreateNode("_cm");
        }
        if (cm.containsKey("preview")) setPreview(Arrays.asList(cm.getArrayForClass("preview", FilePreview.class)));
        setRevisions(cm.getArrayForClass("revisions", FileRevision.class));
    }

    // cm part
    public String[] getMarketId() {
        return getCm().getStringArray("marketId");
    }

    public void setMarketId(String[] marketId) {
        getCm().put("marketId", marketId);
    }

    // cm.common part
    @Override
    public String getName() {
        return getCmCommon().getString("name");
    }

    @Override
    public void setName(String name) {
        getCmCommon().put("name", name);
    }

    public String[] getMediaType() {
        return getCmCommon().getStringArray("mediaType");
    }

    public void setMediaType(String[] mediaType) {
        getCmCommon().put("mediaType", mediaType);
    }

    public String[] getMediaSubType() {
        return getCmCommon().getStringArray("mediaSubType");
    }

    public void setMediaSubType(String[] mediaSubType) {
        getCmCommon().put("mediaSubType", mediaSubType);
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

    public String[] getCampaign() {
        return getCmCommon().getStringArray("Campaign");
    }

    public void setCampaign(String[] campaign) {
        getCmCommon().put("Campaign", campaign);
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

    // cm.video part
    public String getClockNumber() {
        return getCmVideo().getString("clockNumber");
    }

    public void setClockNumber(String clockNumber) {
        getCmVideo().put("clockNumber", clockNumber);
    }

    public String getDuration() {
        return getCmVideo().getString("duration");
    }

    public void setDuration(String duration) {
        getCmVideo().put("duration", duration);
    }

    public String getAdditionalInfo() {
        return getCmVideo().getString("additionalInfo");
    }

    public void setAdditionalInfo(String additionalInfo) {
        getCmVideo().put("additionalInfo", additionalInfo);
    }

    public DateTime getAirDate() {
        return getCmVideo().getDateTime("airDate");
    }

    public void setAirDate(DateTime airDate) {
        getCmVideo().put("airDate", airDate);
    }

    public String[] getScreen() {
        return getCmVideo().getStringArray("screen");
    }

    public void setScreen(String[] screen) {
        getCmVideo().put("screen", screen);
    }

    public String[] getAdbankLevelId() {
        return getCmVideoAdbankLevel().getStringArray("id");
    }

    public void setAdbankLevelId(String id) {
        getCmVideoAdbankLevel().put("id", id);
    }

    public String getAdbankLevelName() {
        return getCmVideoAdbankLevel().getString("name");
    }

    public void setAdbankLevelName(String name) {
        getCmVideoAdbankLevel().put("name", name);
    }

    // qc part
    public Boolean isPrimary() {
        return getQc().getBoolean("primary");
    }

    public String getSpecDbStandard() {
        return getQcMetadataSpecDb().getString("standard");
    }

    public void setSpecDbStandard(String standard) {
        getQcMetadataSpecDb().put("standard", standard);
    }

    public String getSpecDbTimeCode() {
        return getQcMetadataSpecDb().getString("timecode");
    }

    public void setSpecDbTimeCode(String timecode) {
        getQcMetadataSpecDb().put("timecode", timecode);
    }

    public String getSpecDbAspectRatio() {
        return getQcMetadataSpecDb().getString("aspectRatio");
    }

    public void setSpecDbAspectRatio(String aspectRatio) {
        getQcMetadataSpecDb().put("aspectRatio", aspectRatio);
    }

    public String getSpecDbEncodingSystem() {
        return getQcMetadataSpecDb().getString("encodingSystem");
    }

    public void setSpecDbEncodingSystem(String encodingSystem) {
        getQcMetadataSpecDb().put("encodingSystem", encodingSystem);
    }

    public String getSpecDbFrameRate() {
        return getQcMetadataSpecDb().getString("frameRate");
    }

    public void setSpecDbFrameRate(String frameRate) {
        getQcMetadataSpecDb().put("frameRate", frameRate);
    }

    public String getSpecDbHeight() {
        return getQcMetadataSpecDb().getString("height");
    }

    public void setSpecDbHeight(String height) {
        getQcMetadataSpecDb().put("height", height);
    }

    public String getSpecDbWidth() {
        return getQcMetadataSpecDb().getString("width");
    }

    public void setSpecDbWidth(String width) {
        getQcMetadataSpecDb().put("width", width);
    }

    public String getSpecDbProfileName() {
        return getQcMetadataSpecDb().getString("profileName");
    }

    public void setSpecDbProfileName(String profileName) {
        getQcMetadataSpecDb().put("profileName", profileName);
    }

    public List<FilePreview> getPreview() {
        return preview;
    }

    public void setPreview(List<FilePreview> preview) {
        this.preview = preview;
    }

    public FileRevision[] getRevisions() {
        return revisions;
    }

    public void setRevisions(FileRevision[] revisions) {
        this.revisions = revisions;
    }

    public String getShort_id() {
        return short_id;
    }

    public void setShort_id(String short_id) {
        this.short_id = short_id;
    }

    public Agency getOriginator() {
        return originator;
    }

    public void setOriginator(Agency originator) {
        this.originator = originator;
    }

        /*
        * Private custom metadata helpers
        */
    private CustomMetadata getCm() {
        if (_cm == null) _cm = new CustomMetadata();
        return _cm;
    }

    private CustomMetadata getQc() {
        if (qc == null) qc = new CustomMetadata();
        return qc;
    }

    private CustomMetadata getCmCommon() {
        return getCm().getOrCreateNode("common");
    }

    private CustomMetadata getCmVideo() {
        return getCm().getOrCreateNode("video");
    }

    private CustomMetadata getCmVideoAdbankLevel() {
        return getCmVideo().getOrCreateNode("adbank_level");
    }

    private CustomMetadata getQcMetadata() {
        return getQc().getOrCreateNode("metadata");
    }

    private CustomMetadata getQcMetadataSpecDb() {
        return getQcMetadata().getOrCreateNode("specDb");
    }
}