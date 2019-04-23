package com.adstream.automate.babylon.migration.objects;

import javax.xml.bind.annotation.XmlElement;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 1/9/15
 * Time: 6:59 PM

 */
public class OdtElement {
    private String assetGUID;
    private String parentAssetGuid;

    @XmlElement(name = "assetGUID")
    public String getAssetGUID() {
        return assetGUID;
    }

    public void setAssetGUID(String assetGUID) {
        this.assetGUID = assetGUID;
    }

    @XmlElement(name = "parentAssetGuid")
    public String getParentAssetGuid() {
        return parentAssetGuid;
    }

    public void setParentAssetGuid(String parentAssetGuid) {
        this.parentAssetGuid = parentAssetGuid;
    }
}
