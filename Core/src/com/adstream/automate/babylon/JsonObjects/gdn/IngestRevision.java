package com.adstream.automate.babylon.JsonObjects.gdn;

import java.util.Map;

/**
 * Created by Ramababu.Bendalam on 27/04/2016.
 */
public class IngestRevision {

    long fileSize;
    String name;
    String specDbDocID;
    String fileID;
    String MD5;
    IngestDuration duration;
    // IngestAudioTracks audioTracks;
    Map<String, String>[] audioTracks;

    public long getFileSize() {
        return fileSize;
    }

    public void setFileSize(long fileSize) {
        this.fileSize = fileSize;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSpecDbDocID() {
        return specDbDocID;
    }

    public void setSpecDbDocID(String specDbDocID) {
        this.specDbDocID = specDbDocID;
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

    public IngestDuration getDuration() {
        return duration;
    }

    public void setDuration(IngestDuration duration) {
        this.duration = duration;
    }

    public Map<String, String>[] getAudioTracks() {
        return audioTracks;
    }

    public void setAudioTracks(Map<String, String>[] audioTracks) {
        this.audioTracks = audioTracks;
    }
}
