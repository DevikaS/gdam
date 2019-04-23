package com.adstream.automate.babylon.JsonObjects.usagerights;

import com.google.gson.annotations.SerializedName;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/23/13
 * Time: 6:45 PM

 */
public class MediaTypesUsageRight implements  UsageRight {

    @SerializedName("Media Types")
    private MediaTypes[] mediaTypes;

    public MediaTypes[] getMediaTypes() {
        return mediaTypes;
    }

    public void setMediaTypes(MediaTypes[] mediaTypes) {
        this.mediaTypes = mediaTypes;
    }
}
