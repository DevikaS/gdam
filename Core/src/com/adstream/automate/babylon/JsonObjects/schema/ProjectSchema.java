package com.adstream.automate.babylon.JsonObjects.schema;

import com.adstream.automate.babylon.JsonObjects.CustomMetadata;
import com.adstream.automate.babylon.JsonObjects.schema.cm.section.FieldContent;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * User: Konstantin Lynda
 * Date: 26.07.13 10:00
 */
public class ProjectSchema extends Schema {
    public ProjectSchema() {}

    public ProjectSchema(CustomMetadata schema) {
        super(schema);
    }

    public void createCMField(Map<String,String> properties) {
        properties.put("Section", "common");
        properties.put("OrderGroupContainer", "project_common");
        super.createCMField(properties);
    }

    public void updateCMField(Map<String,String> properties) {
        properties.put("Section", "common");
        properties.put("OrderGroupContainer", "project_common");
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

    public void moveFieldFromGroupToOtherGroup(String section, String fromGroupId, String toGroupId, String description) {
        super.moveFieldFromGroupToOtherGroup(section, "project_common", fromGroupId, toGroupId, description);
    }

    public CustomMetadata getCampaignDates() {
        return getSchema().getOrCreateNodeForPath("properties._cm.properties.common.properties.campaignDates.properties");
    }

    public FieldContent getField(String description) {
        for (String fieldId : getCmSectionProperties("common").keySet()) {
            FieldContent field = new FieldContent(getCmSectionProperties("common").getOrCreateNode(fieldId));
            if (description.equalsIgnoreCase(field.getDescription())) return field;
        }

        for (String key : getCampaignDates().keySet()) {
            FieldContent field = new FieldContent(getCampaignDates().getOrCreateNode(key));
            if (description.equals(field.getDescription())) return field;
        }

        return null;
    }

    public List<FieldContent> getCompulsoryFields() {
        List<FieldContent> fields = new ArrayList<FieldContent>();
        CustomMetadata section = getCmSectionProperties("common");

        for (String fieldId : section.keySet()) {
            fields.add(new FieldContent(section.getOrCreateNode(fieldId)));
        }
        return fields;
    }
}