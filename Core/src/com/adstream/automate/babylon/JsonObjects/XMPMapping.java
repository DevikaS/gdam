package com.adstream.automate.babylon.JsonObjects;

import com.google.gson.annotations.SerializedName;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by sobolev-a on 26.09.2014.
 */
public class XMPMapping {

    public XMPMapping(String jsonPaths, TagMapping xPaths) {
        this.jsonPaths.add(jsonPaths);
        this.xpaths.add(xPaths);
    }

    @SerializedName("jsonPaths")
    private List<String> jsonPaths = new ArrayList<>();

    @SerializedName("xPaths")
    private List<TagMapping> xpaths = new ArrayList<>();

    public static class TagMapping {

        public TagMapping(String xpath, String mediaType) {
            this.xpath = xpath;
            this.mediaType = mediaType;
        }

        @SerializedName("xPath")
        private String xpath;

        @SerializedName("mediaType")
        private String mediaType;
    }
}