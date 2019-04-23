package com.adstream.automate.babylon.migration.objects;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/6/14
 * Time: 12:08 PM
 */
public class FullAsset extends Asset {
    private Video video;
    private ProxyAsset proxyAsset;

    public Video getVideo() {
        return video;
    }

    public void setVideo(Video video) {
        this.video = video;
    }

    public ProxyAsset getProxyAsset() {
        return proxyAsset;
    }

    public void setProxyAsset(ProxyAsset proxyAsset) {
        this.proxyAsset = proxyAsset;
    }
}
