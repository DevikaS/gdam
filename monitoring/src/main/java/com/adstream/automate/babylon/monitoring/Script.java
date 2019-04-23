package com.adstream.automate.babylon.monitoring;

import java.net.URL;

/**
 * User: ruslan.semerenko
 * Date: 24.07.13 17:35
 */
public class Script {
    private URL applicationURL;
    private Action[] action;

    public URL getApplicationURL() {
        return applicationURL;
    }

    public void setApplicationURL(URL applicationURL) {
        this.applicationURL = applicationURL;
    }

    public Action[] getAction() {
        return action;
    }

    public void setAction(Action[] action) {
        this.action = action;
    }
}
