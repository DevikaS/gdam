package com.adstream.automate.babylon.JsonObjects;

import com.google.gson.annotations.SerializedName;

/**
 * Created by sobolev-a on 01.10.2014.
 */
public class VideoProxySet {

    @SerializedName("_id")
    private String id;

    @SerializedName("_rev")
    private String revision;

    private String type;

    private boolean valid;

    private String templateType;

    private String name;

    private String createdAt;

    private String createdBy;

    private String modifiedAt;

    private String modifiedBy;

    private String svnRev;

    private String xmlContent;

    public void setAgencyId(String agencyId) {
        String xml = xmlContent.replaceAll("AGENCY_ID\" == \".*\"", String.format("AGENCY_ID\" == \"%s\"", agencyId));
        this.xmlContent = xml;
    }

}
