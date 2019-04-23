package com.adstream.automate.babylon.JsonObjects.adcost.enums;

/*
 * Created by Arti Sharma on 27.09.17.
 */
public enum Commodity {
    VIDEO("Video", "Video Production"),
    DIGITAL("Digital","Video Production"),
    AUDIO("Audio","Radio Production"),
    STILLIMAGE("Still Image","Print and Image Production"),
    DISTRIBUTIONANDTRAFFICKING("Distribution and Trafficking","Multimedia Distribution and Traffic"),
    CELEBRITY("Celebrity","Talent and Celebrity"),
    BRANDRESIDUALSSAG("Brand Residuals SAG (USA only)","Talent and Celebrity"),
    MODEL("Model","Talent and Celebrity"),
    ATHLETES("Athletes","Talent and Celebrity"),
    ORGANIZATION("Organization","Talent and Celebrity"),
    FILM("Film","Talent and Celebrity"),
    ACTOR("Actor","Talent and Celebrity"),
    FOOTAGE("Footage(stock pack-shots UGC etc","Talent and Celebrity"),
    ILUSTRATOR("Ilustrator","Talent and Celebrity"),
    COUNTRYAIRINGRIGHTS("Country Airing Rights(Brazil Russia and Ukraine Only)","Talent and Celebrity"),
    PHOTOGRAPHY("Photography","Music"),
    MUSIC("Music","Music"),
    VOICEOVER("Voice-Over","Music");

    private String contentType;
    private String commodity;

    private Commodity(String contentType, String commodity) {
        this.contentType = contentType;
        this.commodity = commodity;
    }

    @Override
    public String toString() {
        return contentType;
    }

    public String getCommodity() {
        return commodity;
    }

    public static Commodity findByType(String contentType) {
        for (Commodity comm : values())
            if (comm.toString().equalsIgnoreCase(contentType))
                return comm;
        throw new IllegalArgumentException("Unknown metadata field: " + contentType);
    }
}