package com.adstream.automate.babylon.JsonObjects.usagerights;

import com.google.gson.annotations.SerializedName;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/23/13
 * Time: 7:06 PM

 */
public class VoiceOverArtistUsageRight implements UsageRight {

    @SerializedName("Voice-over Artist")
    private VoiceOverArtist voiceOverArtist;
    public Expiration expiration;

    public VoiceOverArtist getVoiceOverArtist() {
        return voiceOverArtist;
    }

    public void setVoiceOverArtist(VoiceOverArtist voiceOverArtist) {
        this.voiceOverArtist = voiceOverArtist;
    }

    public Expiration getExpiration() {
        return expiration;
    }

    public void setExpiration(Expiration expiration) {
        this.expiration = expiration;
    }
}
