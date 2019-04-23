package com.adstream.automate.babylon.JsonObjects.usagerights;

import com.google.gson.annotations.SerializedName;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/23/13
 * Time: 7:14 PM

 */
public class MusicUsageRight implements UsageRight {

    @SerializedName("Music")
    private Music music;
    public Expiration expiration;

    public Music getMusic() {
        return music;
    }

    public void setMusic(Music music) {
        this.music = music;
    }

    public Expiration getExpiration() {
        return expiration;
    }

    public void setExpiration(Expiration expiration) {
        this.expiration = expiration;
    }
}
