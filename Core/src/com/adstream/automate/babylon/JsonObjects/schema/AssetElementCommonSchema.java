package com.adstream.automate.babylon.JsonObjects.schema;

import com.adstream.automate.babylon.JsonObjects.CustomMetadata;
import java.util.Map;

/**
 * User: Konstantin Lynda
 * Date: 26.07.13 10:00
 */
public class AssetElementCommonSchema extends Schema {
    public AssetElementCommonSchema() {}

    public AssetElementCommonSchema(CustomMetadata schema) {
        super(schema);
    }

    public void createCMField(Map<String,String> properties) {
        properties.put("OrderGroupContainer", String.format("asset_%s", properties.get("Section")));
        super.createCMField(properties);
    }

    public void updateCMField(Map<String,String> properties) {
        properties.put("OrderGroupContainer", String.format("asset_%s", properties.get("Section")));
        super.updateCMField(properties);
    }

    public void moveFieldFromGroupToOtherGroup(String section, String fromGroupId, String toGroupId, String description) {
        super.moveFieldFromGroupToOtherGroup(section, "asset_" + section, fromGroupId, toGroupId, description);
    }
}