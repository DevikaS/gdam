package com.adstream.automate.babylon.migration.objects;

import javax.xml.bind.annotation.XmlElement;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/6/14
 * Time: 12:07 PM
 */
public class Audio {
    private String assetGUID;
    private String audioFormat;
    private int durationInSeconds;
    private String firstTransmission;
    private String recordedAt;
    private String audioEngineer;
    private String voiceOverArtist;
    private String copyWriter;
    private String producer;
    private String director;
    private String jCNNumber;
    private boolean rABApproval;


    @XmlElement(name = "AssetGUID")
    public String getAssetGUID() {
        return assetGUID;
    }

    public void setAssetGUID(String assetGUID) {
        this.assetGUID = assetGUID;
    }

    @XmlElement(name = "AudioFormat")
    public String getAudioFormat() {
        return audioFormat;
    }

    public void setAudioFormat(String audioFormat) {
        this.audioFormat = audioFormat;
    }

    @XmlElement(name = "DurationInSeconds")
    public int getDurationInSeconds() {
        return durationInSeconds;
    }

    public void setDurationInSeconds(int durationInSeconds) {
        this.durationInSeconds = durationInSeconds;
    }

    @XmlElement(name = "FirstTransmission")
    public String getFirstTransmission() {
        return firstTransmission;
    }

    public void setFirstTransmission(String firstTransmission) {
        this.firstTransmission = firstTransmission;
    }

    @XmlElement(name = "RecordedAt")
    public String getRecordedAt() {
        return recordedAt;
    }

    public void setRecordedAt(String recordedAt) {
        this.recordedAt = recordedAt;
    }

    @XmlElement(name = "AudioEngineer")
    public String getAudioEngineer() {
        return audioEngineer;
    }

    public void setAudioEngineer(String audioEngineer) {
        this.audioEngineer = audioEngineer;
    }

    @XmlElement(name = "VoiceOverArtist")
    public String getVoiceOverArtist() {
        return voiceOverArtist;
    }

    public void setVoiceOverArtist(String voiceOverArtist) {
        this.voiceOverArtist = voiceOverArtist;
    }

    @XmlElement(name = "CopyWriter")
    public String getCopyWriter() {
        return copyWriter;
    }

    public void setCopyWriter(String copyWriter) {
        this.copyWriter = copyWriter;
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

    @XmlElement(name = "JCNNumber")
    public String getjCNNumber() {
        return jCNNumber;
    }

    public void setjCNNumber(String jCNNumber) {
        this.jCNNumber = jCNNumber;
    }

    @XmlElement(name = "RABApproval")
    public boolean isrABApproval() {
        return rABApproval;
    }

    public void setrABApproval(boolean rABApproval) {
        this.rABApproval = rABApproval;
    }
}
