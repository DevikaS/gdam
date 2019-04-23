package com.adstream.automate.babylon.JsonObjects.schema;

import com.adstream.automate.babylon.JsonObjects.CustomMetadata;
import com.adstream.automate.babylon.JsonObjects.ordering.enums.CustomMetadataField;
import java.util.Map;

/**
 * User: Konstantin Lynda
 * Date: 26.07.13 10:00
 */
public class AssetElementProjectCommonSchema extends Schema {
    public AssetElementProjectCommonSchema() {}

    public AssetElementProjectCommonSchema(CustomMetadata schema) {
        super(schema);
    }

    public void createCMField(Map<String,String> properties) {
        properties.put("Section", "common");
        properties.put("OrderGroupContainer", "asset_element_project_common_common,project_common,adkit_common,asset_audio,asset_video,asset_print,asset_document,asset_digital,asset_image");
        super.createCMField(properties);
    }

    public void updateCMField(Map<String,String> properties) {
        properties.put("Section", "common");
        properties.put("OrderGroupContainer", "asset_element_project_common_common,project_common,adkit_common,asset_audio,asset_video,asset_print,asset_document,asset_digital,asset_image");
        super.updateCMField(properties);
    }

    public void createFieldGroup(Map<String,String> properties) {
        properties.put("Section", "common");
        super.createFieldGroup(properties);
    }

    public void updateFieldGroup(Map<String,String> properties) {
    }

    public void reorderFieldGroups(String group, String section) {
        super.reorderFieldGroups(group, section);
    }

    public void moveFieldFromGroupToOtherGroup(String section, String fieldGroupContainer, String fromGroupId, String toGroupId, String description) {
        super.moveFieldFromGroupToOtherGroup(section, fieldGroupContainer, fromGroupId, toGroupId, description);
    }

    public boolean isFieldAvailableInDelivery(String fieldName) {
        String[] tags = getTags("common", CustomMetadataField.findByName(fieldName).toString());
        return tags != null && tags[0].equals("ordering");
    }

    public void makeFieldAvailableInDelivery(String fieldName) {
        makeAvailableInDelivery(CustomMetadataField.findByName(fieldName).toString());
    }

    private void makeAvailableInDelivery(String nodeName) {
        setTags("common", nodeName, new String[]{"ordering"});
    }
}