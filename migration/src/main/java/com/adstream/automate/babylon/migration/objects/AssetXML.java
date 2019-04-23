package com.adstream.automate.babylon.migration.objects;

import javax.xml.bind.annotation.XmlElement;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/6/14
 * Time: 12:06 PM

 */
public class AssetXML {
    private AssetInner[] asset;

    @XmlElement(name = "Asset")
    public AssetInner[] getAsset() {
        return asset;
    }

    public void setAsset(AssetInner[] assetInner) {
        this.asset = assetInner;
    }

}
