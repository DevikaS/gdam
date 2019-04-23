package com.adstream.automate.babylon.middleware;

import java.util.Map;

/**
 * User: ruslan.semerenko
 * Date: 09.04.12 14:58
 */
class Dictionary {
    private Map<String, String[]> permission;
    private Map<String, String> mediatype;
    private Map<String,Map<String, String>> country;
    private Map<String,Map<String, String>> timezone;
    private String[] organisation_type;

    public Map<String, String[]> getPermission() {
        return permission;
    }

    public Map<String, String> getMediatype() {
        return mediatype;
    }

    public Map<String, Map<String, String>> getCountry() {
        return country;
    }

    public Map<String, Map<String, String>> getTimezone() {
        return timezone;
    }

    public String[] getOrganisationType() {
        return organisation_type;
    }
}
