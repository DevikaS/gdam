package com.adstream.automate.babylon.JsonObjects.usagerights;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/23/13
 * Time: 5:27 PM
 */
public class GeneralUsageRight extends BaseUsageRight implements UsageRight {
    public Object General;
    public Expiration expiration;

    public Object getGeneral() {
        return General;
    }

    public void setGeneral(Object general) {
        General = general;
    }

    public Expiration getExpiration() {
        return expiration;
    }

    public void setExpiration(Expiration expiration) {
        this.expiration = expiration;
    }
}
