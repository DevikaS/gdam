package com.adstream.automate.babylon.JsonObjects.schema;

import com.adstream.automate.babylon.JsonObjects.CustomMetadata;

import java.util.Map;

/**
 * User: Konstantin Lynda
 * Date: 26.07.13 10:00
 */
public class AssetSchema extends Schema {
    public AssetSchema() {}

    public AssetSchema(CustomMetadata schema) {
        super(schema);
    }

    public void createCMField(Map<String,String> properties) {
        properties.put("Section", "common");
        properties.put("OrderGroupContainer", "asset_common");
        super.createCMField(properties);
    }

    public void createFieldGroup(Map<String,String> properties) {
        super.createFieldGroup(properties);
    }

    public void updateFieldGroup(Map<String,String> properties) {
    }

    public void reorderFieldGroups(String group, String section) {
        super.reorderFieldGroups(group, section);
    }
}