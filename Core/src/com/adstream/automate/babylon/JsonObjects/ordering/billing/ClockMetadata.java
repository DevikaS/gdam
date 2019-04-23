package com.adstream.automate.babylon.JsonObjects.ordering.billing;

/*
 * Created by demidovskiy-r on 07.07.2014.
 */
public class ClockMetadata {
    private String Advertiser;
    private String ClockID;
    private String Title;
    private String Format;
    private Catalogue[] Catalogue;

    public String getAdvertiser() {
        return Advertiser;
    }

    public void setAdvertiser(String advertiser) {
        Advertiser = advertiser;
    }

    public String getClockID() {
        return ClockID;
    }

    public void setClockID(String clockID) {
        ClockID = clockID;
    }

    public String getTitle() {
        return Title;
    }

    public void setTitle(String title) {
        Title = title;
    }

    public String getFormat() {
        return Format;
    }

    public void setFormat(String format) {
        Format = format;
    }

    public Catalogue[] getCatalogue() {
        return Catalogue;
    }

    public void setCatalogue(Catalogue[] catalogue) {
        Catalogue = catalogue;
    }
}