package com.adstream.automate.babylon.JsonObjects.ordering.enums;

/*
 * Created by demidovskiy-r on 30.12.13.
 */
public enum CustomMetadataField {
    ADVERTISER("Advertiser", "_cm.common.advertiser", "_cm.asset.common.advertiser"),
    BRAND("Brand", "_cm.common.brand", "_cm.asset.common.brand"),
    SUB_BRAND("Sub Brand", "_cm.common.sub_brand", "_cm.asset.common.sub_brand"),
    PRODUCT("Product", "_cm.common.product", "_cm.asset.common.product"),
    CAMPAIGN("Campaign", "_cm.common.Campaign", "_cm.asset.common.Campaign"),
    TITLE("Title", "_cm.common.title", "_cm.common.title"),
    DURATION("Duration", "_cm.common.duration", "_cm.common.duration");

    private String name;
    private String path;
    private String assetCommonPath;

    private CustomMetadataField(String name, String path, String assetCommonPath) {
        this.name = name;
        this.path = path;
        this.assetCommonPath = assetCommonPath;
    }

    @Override
    public String toString() {
        return name;
    }

    public String getPath() {
        return path;
    }

    public String getAssetCommonPath() {
        return assetCommonPath;
    }

    public static CustomMetadataField findByName(String name) {
        for (CustomMetadataField metadataField : values())
            if (metadataField.toString().equalsIgnoreCase(name))
                return metadataField;
        throw new IllegalArgumentException("Unknown metadata field: " + name);
    }

    // schemaName: common, project, audio, digital, document, image, print, video
    public static String generatePath(String schemaName, String dictionaryId) {
        return String.format("%s%s%s%s", "_cm.", schemaName, ".", dictionaryId);
    }
}