package com.adstream.automate.babylon.JsonObjects.adcost.enums;

/*
 * Created by Arti Sharma on 12.3.17.
 */
public enum CatagoryDPV {
    AUDIOMUSICCOMPANY("Audio/Music Company", "Music Payment Currency"),
    TALENTCOMPANY("Talent Company","Casting Payment Currency"),
    PHOTOGRAPHERCOMPANY("Photographer Company", "Photographer Payment Currency"),
    DIGITALDEVELOPMENTCOMPANY("Digital Development Company","Digital Development Payment Currency"),
    USAGEBUYOUTVENDOR("UsageBuyoutContract","Usage Buyout Contract Payment Currency"),
    TRAFFICDISTRIBUTIONVENDOR("DistributionTrafficking","Distribution & Trafficking Payment Currency");


    private String catagoryType;
    private String currencyFieldName;

    private CatagoryDPV(String catagoryType, String currencyFieldName) {
        this.catagoryType = catagoryType;
        this.currencyFieldName = currencyFieldName;
    }

    @Override
    public String toString() {
        return catagoryType;
    }

    public String getCurrencyFieldName(){return currencyFieldName;}

    public static CatagoryDPV findByType(String catagoryType) {
        for (CatagoryDPV comm : values())
            if (comm.toString().equalsIgnoreCase(catagoryType))
                return comm;
        throw new IllegalArgumentException("Unknown metadata field: " + catagoryType);
    }
}