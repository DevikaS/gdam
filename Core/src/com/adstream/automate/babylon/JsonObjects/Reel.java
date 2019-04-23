package com.adstream.automate.babylon.JsonObjects;

import org.joda.time.DateTime;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 11.10.12
 * Time: 19:06
 */
public class Reel extends BaseObject {
    private CustomMetadata assets;
    private Object preview;
    private CustomMetadata counter;
    private CustomMetadata _cm;

    /*
    * Assets fields
    */

    public Integer getAssetsDuration() {
        return getAssets().getInteger("duration");
    }

    public void setAssetsDuration(Integer duration) {
        getAssets().put("duration", duration);
    }

    public Integer getAssetsCount() {
        return getAssets().getInteger("count");
    }

    public void setAssetsCount(Integer count) {
        getAssets().put("count", count);
    }

    public Asset[] getAssetsList() {
        return getAssets().getArrayForClass("list", Asset.class);
    }

    public void setAssetsList(Asset[] list) {
        getAssets().put("list", list);
    }

    /*
    * Counter Email fields
    */

    public Integer getCounterEmailSent() {
        return getCounterEmail().getInteger("sent");
    }

    public void setCounterEmailSent(Integer sent) {
        getCounterEmail().put("sent", sent);
    }

    public Integer getCounterEmailBounced() {
        return getCounterEmail().getInteger("bounced");
    }

    public void setCounterEmailBounced(Integer bounced) {
        getCounterEmail().put("bounced", bounced);
    }

    /*
    * Counter View fields
    */

    public Integer getCounterViewViews() {
        return getCounterView().getInteger("views");
    }

    public void setCounterViewViews(Integer views) {
        getCounterView().put("views", views);
    }

    public Integer getCounterViewDownloads() {
        return getCounterView().getInteger("downloads");
    }

    public void setCounterViewDownloads(Integer downloads) {
        getCounterView().put("downloads", downloads);
    }

    /*
    * Custom metadata Common fields
    */

    @Override
    public String getName() {
        return getCmCommon().getString("name");
    }

    @Override
    public void setName(String name) {
        getCmCommon().put("name", name);
    }

    public String getDescription() {
        return getCmCommon().getString("description");
    }

    public void setDescription(String description) {
        getCmCommon().put("description", description);
    }

    public DateTime getCmCommonExpirationDate() {
        return getCmCommon().getDateTime("expirationDate");
    }

    public void setCmCommonExpirationDate(DateTime expirationDate) {
        getCmCommon().put("expirationDate", expirationDate);
    }

    public String getCmCommonPublicUrl() {
        return getCmCommon().getString("publicUrl");
    }

    public void setCmCommonPublicUrl(String publicUrl) {
        getCmCommon().put("publicUrl", publicUrl);
    }


    public Boolean getCmCommonDownloadOriginal() {
        return getCmCommon().getBoolean("downloadOriginal");
    }

    public void setCmCommonDownloadOriginal(Boolean downloadOriginal) {
        getCmCommon().put("downloadOriginal", downloadOriginal);
    }

    /*
    * Custom metadata View fields
    */

    public String getCmViewScreen() {
        return getCmView().getString("screen");
    }

    public void setCmViewScreen(String screen) {
        getCmView().put("screen", screen);
    }

    public String getCmViewScale() {
        return getCmView().getString("scale");
    }

    public void setCmViewScale(String scale) {
        getCmView().put("scale", scale);
    }

    public Integer getCmViewNoDurationFor() {
        return getCmView().getInteger("noDurationFor");
    }

    public void setCmViewNoDurationFor(Integer noDurationFor) {
        getCmView().put("noDurationFor", noDurationFor);
    }

    public Boolean getCmViewAllowDownload() {
        return getCmView().getBoolean("allowDownload");
    }

    public void setCmViewAllowDownload(Boolean allowDownload) {
        getCmView().put("allowDownload", allowDownload);
    }

    public String getCmViewThumbnails() {
        return getCmView().getString("thumbnails");
    }

    public void setCmViewThumbnails(String thumbnails) {
        getCmView().put("thumbnails", thumbnails);
    }

    public String getCmViewTitleFileName() {
        return getCmView().getString("titleFileName");
    }

    public void setCmViewTitleFileName(String titleFileName) {
        getCmView().put("titleFileName", titleFileName);
    }

    public String getCmViewTitleIcon() {
        return getCmView().getString("titleIcon");
    }

    public void setCmViewTitleIcon(String titleIcon) {
        getCmView().put("titleIcon", titleIcon);
    }

    public String getCmViewBackgroundFileName() {
        return getCmView().getString("backgroundFileName");
    }

    public void setCmViewBackgroundFileName(String backgroundFileName) {
        getCmView().put("backgroundFileName", backgroundFileName);
    }

    public Integer getCmViewBetweenAsset() {
        return getCmView().getInteger("betweenAsset");
    }

    public void setCmViewBetweenAsset(Integer betweenAsset) {
        getCmView().put("betweenAsset", betweenAsset);
    }

    public Boolean getCmViewIncludePodcast() {
        return getCmView().getBoolean("includePodcast");
    }

    public void setCmViewIncludePodcast(Boolean includePodcast) {
        getCmView().put("includePodcast", includePodcast);
    }

    public String getCmViewStyle() {
        return getCmView().getString("style");
    }

    public void setCmViewStyle(String style) {
        getCmView().put("style", style);
    }

    public Boolean getCmViewEmailConfirmation() {
        return getCmView().getBoolean("emailConfirmation");
    }

    public void setCmViewEmailConfirmation(Boolean emailConfirmation) {
        getCmView().put("emailConfirmation", emailConfirmation);
    }

    public String getCmViewBackground() {
        return getCmView().getString("background");
    }

    public void setCmViewBackground(String background) {
        getCmView().put("background", background);
    }

    public Boolean getCmViewUseDefaultLogo() {
        return getCmView().getBoolean("useDefaultLogo");
    }

    public void setCmViewUseDefaultLogo(Boolean useDefaultLogo) {
        getCmView().put("useDefaultLogo", useDefaultLogo);
    }

    /*
    * Private helpers
    */

    public CustomMetadata getAssets() {
        if (assets == null) {
            assets = new CustomMetadata();
        }
        return assets;
    }

    private CustomMetadata getCounter() {
        if (counter == null) {
            counter = new CustomMetadata();
        }
        return counter;
    }

    private CustomMetadata getCounterEmail() {
        return getCounter().getOrCreateNode("email");
    }

    private CustomMetadata getCounterView() {
        return getCounter().getOrCreateNode("view");
    }

    private CustomMetadata getCm() {
        if (_cm == null) _cm = new CustomMetadata();
        return _cm;
    }

    private CustomMetadata getCmCommon() {
        return getCm().getOrCreateNode("common");
    }

    private CustomMetadata getCmView() {
        return getCm().getOrCreateNode("view");
    }
}