package com.adstream.automate.babylon.migration.objects;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/6/14
 * Time: 12:09 PM
 */
@XmlRootElement
public class MusicRightsFields {
    private String musicRightsFieldsGUID;
    private String title;
    private String artist;
    private String composer;
    private String publisher;
    private String recordCompany;
    private String catalogueNumber;
    private String trackDuration;
    private String iDNumber;


    @XmlElement(name = "MusicRightsFieldsGUID")
    public String getMusicRightsFieldsGUID() {
        return musicRightsFieldsGUID;
    }

    public void setMusicRightsFieldsGUID(String musicRightsFieldsGUID) {
        this.musicRightsFieldsGUID = musicRightsFieldsGUID;
    }
    @XmlElement(name = "Title")
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @XmlElement(name = "Artist")
    public String getArtist() {
        return artist;
    }

    public void setArtist(String artist) {
        this.artist = artist;
    }

    @XmlElement(name = "Composer")
    public String getComposer() {
        return composer;
    }

    public void setComposer(String composer) {
        this.composer = composer;
    }

    @XmlElement(name = "Publisher")
    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    @XmlElement(name = "RecordCompany")
    public String getRecordCompany() {
        return recordCompany;
    }

    public void setRecordCompany(String recordCompany) {
        this.recordCompany = recordCompany;
    }

    @XmlElement(name = "CatalogueNumber")
    public String getCatalogueNumber() {
        return catalogueNumber;
    }

    public void setCatalogueNumber(String catalogueNumber) {
        this.catalogueNumber = catalogueNumber;
    }

    @XmlElement(name = "TrackDuration")
    public String getTrackDuration() {
        return trackDuration;
    }

    public void setTrackDuration(String trackDuration) {
        this.trackDuration = trackDuration;
    }

    @XmlElement(name = "IDNumber")
    public String getiDNumber() {
        return iDNumber;
    }

    public void setiDNumber(String iDNumber) {
        this.iDNumber = iDNumber;
    }
}
