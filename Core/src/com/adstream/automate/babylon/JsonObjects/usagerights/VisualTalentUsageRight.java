package com.adstream.automate.babylon.JsonObjects.usagerights;

import com.google.gson.annotations.SerializedName;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/23/13
 * Time: 6:57 PM

 */
public class VisualTalentUsageRight implements UsageRight {

    @SerializedName("Visual Talent")
    private VisualTalent visualTalent;
    public Expiration expiration;

    public VisualTalent getVisualTalent() {
        return visualTalent;
    }

    public void setVisualTalent(VisualTalent visualTalent) {
        this.visualTalent = visualTalent;
    }

    public Expiration getExpiration() {
        return expiration;
    }

    public void setExpiration(Expiration expiration) {
        this.expiration = expiration;
    }
}
