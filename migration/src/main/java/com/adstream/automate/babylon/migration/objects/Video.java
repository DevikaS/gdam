package com.adstream.automate.babylon.migration.objects;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/6/14
 * Time: 12:11 PM
 * To change this template use File | Settings | File Templates.
 */
@XmlRootElement
@XmlType(propOrder = {
        "assetGUID",
        "creativeDirector",
        "artDirector",
        "producer",
        "director",
        "productionCompany",
        "postProduction",
        "contactAtPostProduction",
        "contactPhone",
        "dateOfProduction",
        "firstAirDate",
        "audioFormat",
        "audioChannels",
        "closedCaptionStatusID",
        "closedCaptionsText",
        "fullDurationInFrames",
        "adDurationInFrames",
        "firstActiveFrame",
        "revisionA4"

})
public class Video {

    @XmlAttribute
    private String xmlns;

    private String assetGUID;
    private String dateOfProduction;
    private String creativeDirector;
    private String artDirector;
    private String producer;
    private String director;
    private String productionCompany;
    private String postProduction;
    private String contactAtPostProduction;
    private String contactPhone;
    private String firstAirDate;
    private String audioFormat;
    private int audioChannels;
    private int closedCaptionStatusID;
    private String closedCaptionsText;
    private String revisionA4;
    private int fullDurationInFrames;
    private int adDurationInFrames;
    private int firstActiveFrame;

    @XmlElement(name = "AssetGUID")
    public String getAssetGUID() {
        return assetGUID;
    }

    public void setAssetGUID(String assetGUID) {
        this.assetGUID = assetGUID;
    }

    @XmlElement(name = "CreativeDirector")
    public String getCreativeDirector() {
        return creativeDirector;
    }

    public void setCreativeDirector(String creativeDirector) {
        this.creativeDirector = creativeDirector;
    }

    @XmlElement(name = "ArtDirector")
    public String getArtDirector() {
        return artDirector;
    }

    public void setArtDirector(String artDirector) {
        this.artDirector = artDirector;
    }

    @XmlElement(name = "Producer")
    public String getProducer() {
        return producer;
    }

    public void setProducer(String producer) {
        this.producer = producer;
    }

    @XmlElement(name = "Director")
    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    @XmlElement(name = "ProductionCompany")
    public String getProductionCompany() {
        return productionCompany;
    }

    public void setProductionCompany(String productionCompany) {
        this.productionCompany = productionCompany;
    }

    @XmlElement(name = "PostProduction")
    public String getPostProduction() {
        return postProduction;
    }

    public void setPostProduction(String postProduction) {
        this.postProduction = postProduction;
    }

    @XmlElement(name = "ContactAtPostProduction")
    public String getContactAtPostProduction() {
        return contactAtPostProduction;
    }

    public void setContactAtPostProduction(String contactAtPostProduction) {
        this.contactAtPostProduction = contactAtPostProduction;
    }

    @XmlElement(name = "ContactPhone")
    public String getContactPhone() {
        return contactPhone;
    }

    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }

    @XmlElement(name = "FirstAirDate")
    public String getFirstAirDate() {
        return firstAirDate;
    }

    public void setFirstAirDate(String firstAirDate) {
        this.firstAirDate = firstAirDate;
    }

    @XmlElement(name = "AudioFormat")
    public String getAudioFormat() {
        return audioFormat;
    }

    public void setAudioFormat(String audioFormat) {
        this.audioFormat = audioFormat;
    }

    @XmlElement(name = "AudioChannels")
    public int getAudioChannels() {
        return audioChannels;
    }

    public void setAudioChannels(int audioChannels) {
        this.audioChannels = audioChannels;
    }

    @XmlElement(name = "ClosedCaptionStatusID")
    public int getClosedCaptionStatusID() {
        return closedCaptionStatusID;
    }

    public void setClosedCaptionStatusID(int closedCaptionStatusID) {
        this.closedCaptionStatusID = closedCaptionStatusID;
    }

    @XmlElement(name = "ClosedCaptionsText")
    public String getClosedCaptionsText() {
        return closedCaptionsText;
    }

    public void setClosedCaptionsText(String closedCaptionsText) {
        this.closedCaptionsText = closedCaptionsText;
    }

    @XmlElement(name = "FullDurationInFrames")
    public int getFullDurationInFrames() {
        return fullDurationInFrames;
    }

    public void setFullDurationInFrames(int fullDurationInFrames) {
        this.fullDurationInFrames = fullDurationInFrames;
    }

    @XmlElement(name = "AdDurationInFrames")
    public int getAdDurationInFrames() {
        return adDurationInFrames;
    }

    public void setAdDurationInFrames(int adDurationInFrames) {
        this.adDurationInFrames = adDurationInFrames;
    }

    @XmlElement(name = "FirstActiveFrame")
    public int getFirstActiveFrame() {
        return firstActiveFrame;
    }

    public void setFirstActiveFrame(int firstActiveFrame) {
        this.firstActiveFrame = firstActiveFrame;
    }

    @XmlElement(name = "DateOfProduction")
    public String getDateOfProduction() {
        return dateOfProduction;
    }

    public void setDateOfProduction(String dateOfProduction) {
        this.dateOfProduction = dateOfProduction;
    }

    @XmlElement(name = "RevisionA4")
    public String getRevisionA4() {
        return revisionA4;
    }

    public void setRevisionA4(String revisionA4) {
        this.revisionA4 = revisionA4;
    }
}
