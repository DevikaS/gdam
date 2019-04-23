package com.adstream.automate.babylon.JsonObjects.schema;

import com.adstream.automate.babylon.JsonObjects.BaseObject;
import com.adstream.automate.babylon.JsonObjects.CustomMetadata;
import com.adstream.automate.babylon.JsonObjects.ordering.AutoGenerate;
import com.adstream.automate.babylon.JsonObjects.schema.cm.section.FieldContent;
import com.adstream.automate.babylon.JsonObjects.schema.view.groups.FieldsGroup;
import java.util.*;

/**
 * User: ruslan.semerenko
 * Date: 22.05.13 15:02
 */
public class Schema extends BaseObject {
    private CustomMetadata schema;

    public Schema() {}

    public Schema(CustomMetadata schema) {
        super(schema);
        this.schema = schema;
    }

    public CustomMetadata getSchema() {
        return schema;
    }

    public CustomMetadata getViewGroupsSection(String section) {
        return getSchema().getOrCreateNodeForPath("view.groups." + section);
    }

    public CustomMetadata getCmSectionProperties(String section) {
        return getSchema().getOrCreateNodeForPath("properties._cm.properties." + section + ".properties");
    }

    public CustomMetadata getCmSectionPropertiesNodeByDescription(String section, String description) {
        return getCmSectionProperties(section).getOrCreateNode(getCMFieldIdFromSectionByDescription(section, description));
    }

    public String[] getTags(String section, String nodeName) {
        return getCmSectionPropertiesNodeByDescription(section, nodeName).getStringArray("tags");
    }

    public void setTags(String section, String nodeName, String[] tags) {
        getCmSectionPropertiesNodeByDescription(section, nodeName).put("tags", tags);
    }

    public boolean isCommonForOrder(String section, String nodeName) {
        return getCmView(getCmSectionPropertiesNodeByDescription(section, nodeName)).getBoolean("commonForOrder");
    }

    public void setCommonForOrder(String section, String nodeName, boolean isCommonForOrder) {
        getCmView(getCmSectionPropertiesNodeByDescription(section, nodeName)).put("commonForOrder", isCommonForOrder);
    }

    public boolean isAvailableForBilling(String section, String nodeName) {
        return getCmView(getCmSectionPropertiesNodeByDescription(section, nodeName)).getBoolean("availableForBilling");
    }

    public void setAvailableForBilling(String section, String nodeName, boolean isAvailableForBilling) {
        getCmView(getCmSectionPropertiesNodeByDescription(section, nodeName)).put("availableForBilling", isAvailableForBilling);
    }

    // custom code part
    public AutoGenerate getAutoGenerate(String section, String nodeName) {
        return getCmSectionPropertiesNodeByDescription(section, nodeName).getForClass("autogenerate", AutoGenerate.class);
    }

    public void setAutoGenerate(String section, String nodeName, AutoGenerate autoGenerate) {
        getCmSectionPropertiesNodeByDescription(section, nodeName).put("autogenerate", autoGenerate);
    }

    public String getCMFieldIdFromSectionByDescription(String section, String description) {
        CustomMetadata fields = getCmSectionProperties(section);
        for (String fieldId : fields.keySet())
            if (description.equalsIgnoreCase(fields.getOrCreateNode(fieldId).getString("description")))
                return fieldId;
        return null;
    }

    public String getCMVisibleFieldIdFromSectionByDescription(String section, String description) {
        CustomMetadata fields = getCmSectionProperties(section);

        for (String fieldId : fields.keySet()) {
            if (description.equalsIgnoreCase(fields.getOrCreateNode(fieldId).getString("description"))
                    && (fields.getOrCreateNode(fieldId).getOrCreateNodeForPath("view.e").get("visible") == null
                    || fields.getOrCreateNode(fieldId).getOrCreateNodeForPath("view.e").getBoolean("visible"))) {
                return fieldId;
            }
        }

        return null;
    }

    public Double getCMFieldOrderFromSectionByFieldId(String section, String fieldId, String container) {
        return getCmSectionProperties(section).getOrCreateNodeForPath(fieldId + ".view.v.order").getDouble(container);
    }

    public String getCMFieldGroupFromSectionByFieldId(String section, String fieldId, String container) {
        return getCmSectionProperties(section).getOrCreateNodeForPath(fieldId + ".view.v.group").getString(container);
    }

    public String getGroupIdFromSectionByDescription(String section, String description) {
        if (description.equalsIgnoreCase("_default")) description = "";
        CustomMetadata groups = getViewGroupsSection(section);
        for (String groupId : groups.keySet())
            if (description.equalsIgnoreCase(groups.getOrCreateNode(groupId).getString("description")))
                return groupId;

        return null;
    }

    public String getFieldDictionaryIdFromSectionByDescription(String section, String description) {
        return getCmSectionProperties(section).getOrCreateNode(getCMFieldIdFromSectionByDescription(section, description)).getString("name");
    }

    // business logic layer
    public void createCMField(Map<String,String> properties) {
        String fieldType = properties.get("FieldType").toLowerCase();
        String fieldId = properties.get("FieldId");
        String section = properties.get("Section");
        String parent = properties.get("Parent");
        String orderGroupContainer = properties.get("OrderGroupContainer");

        if (fieldType.equalsIgnoreCase("catalogueStructure") && parent != null && !parent.isEmpty()) {
            properties.put("Parent", getCMFieldIdFromSectionByDescription(section, parent));
            String dictionaryId = getFieldDictionaryIdFromSectionByDescription(section, parent);
            parent = properties.get("Parent");
            properties.put("ParentPath", String.format("_cm.%s.%s", section, parent));
            properties.put("DictionaryId", dictionaryId); // all child elements should contain name of root element of whole catalogue structure, but not name of previous parent element

            for (String container : orderGroupContainer.split(",")) {
                properties.put(container + "Group", getCMFieldGroupFromSectionByFieldId(section, parent, container));
                properties.put(container + "Order", getCMFieldOrderFromSectionByFieldId(section, parent, container).toString());
            }
        } else if (fieldType.equals("dropdown") || fieldType.equals("radiobuttons") || fieldType.equals("cataloguestructure")) {
            properties.put("DictionaryId", fieldId);
        }

        getCmSectionProperties(section).put(fieldId, new FieldContent().build(properties));
//        for (String container : orderGroupContainer.split(",")) reorderFieldsInSectionForGroup(section, container, "_default");
    }

    protected void updateCMField(Map<String,String> properties) {
        String fieldId = getCMFieldIdFromSectionByDescription(properties.get("Section"), properties.get("Description"));
        CustomMetadata field = new FieldContent(getCmSectionProperties(properties.get("Section")).getOrCreateNode(properties.get("FieldId"))).update(properties);
        if(properties.containsKey("Parent"))
            if(properties.get("Parent").isEmpty())
                field.remove("depends");
        getCmSectionProperties(properties.get("Section")).put(fieldId, field);
    }

    protected void createFieldGroup(Map<String,String> properties) {
        CustomMetadata group = new FieldsGroup().build(properties);

        for (String section : properties.get("Section").split(",")) {
            getViewGroupsSection(section).put(properties.get("GroupId"), group);
            reorderGroupsInSection(section);
        }
    }

    protected void moveFieldFromGroupToOtherGroup(String section, String container, String fromGroupId, String toGroupId, String description) {
        section = getCMFieldIdFromSectionByDescription(section, description) == null ? "common" : section;

        for (String fieldId : getCmSectionProperties(section).keySet()) {
            FieldContent field = new FieldContent(getCmSectionProperties(section).getOrCreateNode(fieldId));

            if (description.equalsIgnoreCase(field.getDescription()) && fromGroupId.equals(field.getGroup(container))) {
                field.setGroup(container, toGroupId);
                field.setOrder(container, 0.0);
                getCmSectionProperties(section).remove(fieldId);
                getCmSectionProperties(section).put(fieldId, field.getField());
                reorderFieldsInSectionForGroup(section, container, toGroupId);
                return;
            }
        }
    }

    private CustomMetadata getCmView(CustomMetadata cm) {
        return cm.getOrCreateNode("view");
    }

    private void reorderFieldsInSectionForGroup(String section, String container, String group) {
        List<CustomMetadata> fields = getFieldsByGroupName(getCmSectionProperties(section), container).get(group);

        for (CustomMetadata field : sortFieldsByOrderInContainer(fields, container)) {
            for (String fieldId : field.keySet()) {
                FieldContent fieldContent = new FieldContent(field.getOrCreateNode(fieldId));
                fieldContent.setOrder(container, fieldContent.getOrder(container) + 1.0);

                getCmSectionProperties(section).remove(fieldId);
                getCmSectionProperties(section).put(fieldId, fieldContent.getField());
            }
        }
    }

    private void reorderGroupsInSection(String section) {
        List<CustomMetadata> groups = sortGroups(getGroupsList(getViewGroupsSection(section)));

        for (int i = 0; i < groups.size(); i++) {
            for (String groupId : groups.get(i).keySet()) {
                groups.get(i).getOrCreateNode(groupId).put("order", i + 1);
                getViewGroupsSection(section).remove(groupId);
                getViewGroupsSection(section).put(groupId, groups.get(i).get(groupId));
            }
        }
    }

    protected void reorderFieldGroups(String group, String sections) {
        for (String section : sections.split(",")) {
            String groupId = getGroupIdFromSectionByDescription(section, group);
            getViewGroupsSection(section).getOrCreateNode(groupId).put("order", 0);
            reorderGroupsInSection(section);
        }
    }

    // helper layer
    private static Map<String,List<CustomMetadata>> getFieldsByGroupName(CustomMetadata fields, String container) {
        Map<String,List<CustomMetadata>> groupedFields = new HashMap<String, List<CustomMetadata>>();

        for (String fieldId : fields.keySet()) {
            String group = new FieldContent(fields.getOrCreateNode(fieldId)).getGroup(container);
            if (groupedFields.get(group) == null) groupedFields.put(group, new ArrayList<CustomMetadata>());
            CustomMetadata field = new CustomMetadata();
            field.put(fieldId, fields.get(fieldId));
            groupedFields.get(group).add(field);
        }

        return groupedFields;
    }

    private static List<CustomMetadata> getGroupsList(CustomMetadata groups) {
        List<CustomMetadata> groupsList = new ArrayList<CustomMetadata>();

        for (String key : groups.keySet()) {
            CustomMetadata group = new CustomMetadata();
            group.put(key, groups.get(key));
            groupsList.add(group);
        }

        return groupsList;
    }

    private static List<CustomMetadata> sortFieldsByOrderInContainer(List<CustomMetadata> fields, final String container) {
        Collections.sort(fields, new Comparator<CustomMetadata>() {
            @Override
            public int compare(CustomMetadata field1, CustomMetadata field2) {
                Double order1 = 0.0;
                for (String fieldId : field1.keySet())
                    order1 = new FieldContent(field1.getOrCreateNode(fieldId)).getOrder(container);

                Double order2 = 0.0;
                for (String fieldId : field2.keySet())
                    order2 = new FieldContent(field2.getOrCreateNode(fieldId)).getOrder(container);

                return (int) Math.signum(order1 - order2);
            }
        });

        return fields;
    }

    private static List<CustomMetadata> sortGroups(List<CustomMetadata> groups) {
        Collections.sort(groups, new Comparator<CustomMetadata>() {
            @Override
            public int compare(CustomMetadata group1, CustomMetadata group2) {
                Double order1 = 0.0;
                Double order2 = 0.0;
                for (String groupId : group1.keySet()) order1 = group1.getOrCreateNode(groupId).getDouble("order");
                for (String groupId : group2.keySet()) order2 = group2.getOrCreateNode(groupId).getDouble("order");

                return (int) Math.signum(order1 - order2);
            }
        });

        return groups;
    }
}