package com.adstream.automate.babylon.migration.objects;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/7/13
 * Time: 7:41 PM

 */

@XmlRootElement
public class NewDataSet {
    private Agency[] agency;
    private Address[] address;
    private Asset[] asset;
    private User[] user;
    private ProxyAsset[] proxyAsset;
    private Video[] video;
    private Audio[] audio;
    private AssetRelationship[] assetRelationship;
    private OdtElement[] odtElement;
    private ProductOrder[] productOrder;
    private ProductOrderItem[] productOrderItem;

    @XmlElement(name = "Agency")
    public Agency[] getAgency() {
        return agency;
    }

    public void setAgency(Agency[] agency) {
        this.agency = agency;
    }

    @XmlElement(name= "Address")
    public Address[] getAddress() {
        return address;
    }

    public void setAddress(Address[] address) {
        this.address = address;
    }

    @XmlElement(name = "Asset")
    public Asset[] getAsset() {
        return asset;
    }

    public void setAsset(Asset[] asset) {
        this.asset = asset;
    }

    @XmlElement(name = "User")
    public User[] getUser() {
        return user;
    }

    public void setUser(User[] user) {
        this.user = user;
    }

    @XmlElement(name = "ProxyAsset")
    public ProxyAsset[] getProxyAsset() {
        return proxyAsset;
    }

    public void setProxyAsset(ProxyAsset[] proxyAsset) {
        this.proxyAsset = proxyAsset;
    }

    @XmlElement(name = "Video")
    public Video[] getVideo() {
        return video;
    }

    public void setVideo(Video[] video) {
        this.video = video;
    }

    @XmlElement(name = "Audio")
    public Audio[] getAudio() {
        return audio;
    }

    public void setAudio(Audio[] audio) {
        this.audio = audio;
    }

    @XmlElement(name = "AssetRelationship")
    public AssetRelationship[] getAssetRelationship() {
        return assetRelationship;
    }

    public void setAssetRelationship(AssetRelationship[] assetRelationship) {
        this.assetRelationship = assetRelationship;
    }

    @XmlElement(name = "OdtElement")
    public OdtElement[] getOdtElement() {
        return odtElement;
    }

    public void setOdtElement(OdtElement[] odtElement) {
        this.odtElement = odtElement;
    }

    @XmlElement(name = "ProductOrder")
    public ProductOrder[] getProductOrder() {
        return productOrder;
    }

    public void setProductOrder(ProductOrder[] productOrder) {
        this.productOrder = productOrder;
    }

    @XmlElement(name = "ProductOrderItem")
    public ProductOrderItem[] getProductOrderItem() {
        return productOrderItem;
    }

    public void setProductOrderItem(ProductOrderItem[] productOrderItem) {
        this.productOrderItem = productOrderItem;
    }
}
