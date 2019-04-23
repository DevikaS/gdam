package com.adstream.automate.babylon.performance.config;

import java.net.URL;

/**
 * User: ruslan.semerenko
 * Date: 22.06.12 18:16
 */
public class Destination {
    private Boolean isA5 = true;
    private DestinationType type;
    private URL url;
    private URL paperPusherUrl;

    public Boolean isA5() {
        return isA5;
    }

    public void setIsA5(Boolean isA5) {
        this.isA5 = isA5;
    }

    public DestinationType getType() {
        return type;
    }

    public void setType(DestinationType type) {
        this.type = type;
    }

    public URL getUrl() {
        return url;
    }

    public void setUrl(URL url) {
        this.url = url;
    }

    public URL getPaperPusherUrl() {
        return paperPusherUrl;
    }

    public void setPaperPusherUrl(URL paperPusherUrl) {
        this.paperPusherUrl = paperPusherUrl;
    }
}