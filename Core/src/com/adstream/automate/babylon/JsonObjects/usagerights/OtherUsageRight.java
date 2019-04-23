package com.adstream.automate.babylon.JsonObjects.usagerights;

import com.google.gson.annotations.SerializedName;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/23/13
 * Time: 7:20 PM

 */
public class OtherUsageRight implements UsageRight {

    @SerializedName("Other usage")
    private OtherUsageRight otherUsageRight;
    public Expiration expiration;

    public OtherUsageRight getOtherUsageRight() {
        return otherUsageRight;
    }

    public void setOtherUsageRight(OtherUsageRight otherUsageRight) {
        this.otherUsageRight = otherUsageRight;
    }

    public Expiration getExpiration() {
        return expiration;
    }

    public void setExpiration(Expiration expiration) {
        this.expiration = expiration;
    }
}
