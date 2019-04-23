package com.adstream.automate.babylon.JsonObjects.schema.cm.section;

import com.adstream.automate.babylon.JsonObjects.CustomMetadata;
import java.util.HashMap;
import java.util.Map;
import static java.util.Arrays.asList;

/**
 * Created with IntelliJ IDEA.
 * User: lynda-k
 * Date: 16.09.13
 * Time: 16:36
 */
public class FieldContent {
    CustomMetadata field;

    public FieldContent() {
        field = new CustomMetadata();
    }

    public FieldContent(CustomMetadata field) {
        this.field = field;
    }

    public CustomMetadata getField() {
        return field;
    }

    public void setField(CustomMetadata field) {
        this.field = field;
    }

    private void setType(String type) {
        field.put("type", type);
    }

    public String getDescription() {
        return field.getString("description");
    }

    private void setDescription(String description) {
        field.put("description", description);
    }

    private void setRequired(Boolean required) {
        field.put("required", required);
    }

    public Boolean getRequired() {
        return field.getBoolean("required");
    }

    private CustomMetadata getFieldView() {
        return field.getOrCreateNode("view");
    }

    private void setSchemaName(String schemaName) {
        getFieldView().put("schemaName", schemaName);
    }

    private void setName(String name) {
        field.put("name", name);
    }

    private void setScope(String scope) {
        field.put("scope", scope);
    }

    private void setMaxItems(Integer maxItems) {
        field.put("maxItems", maxItems);
    }

    private void removeMaxItems() {
        if (field.get("maxItems") != null) field.remove("maxItems");
    }

    private void setIncludeInAll(Boolean includeInAll) {
        field.put("include_in_all", includeInAll);
    }

    private void setExtendable(String extendable) {
        field.put("extendable", Boolean.parseBoolean(extendable));
    }

    private void setValidate(Boolean validate) {
        field.put("validate", validate);
    }

    private void setOrderingTags(String availableInDelivery){
        if (Boolean.parseBoolean(availableInDelivery)) field.put("tags", new String[]{"ordering"});
    }

    private void setDependField(String parentFieldId, String parentFieldPath) {
        field.getOrCreateNode("depends").put(parentFieldId, parentFieldPath);
    }

    private void setTemplate(String template) {
        getFieldView().put("template", template);
    }

    private void setIsMultilevel(Boolean isMultilevel) {
        getFieldView().put("isMultilevel", isMultilevel);
    }

    private void setIsdeleted(Boolean isdeleted) {
        getFieldView().put("deleted", isdeleted);
    }

    private void setIsMultiField(Boolean isMultiField) {
        getFieldView().put("isMultiField", isMultiField);
    }

    private void setCommonForOrder(Boolean isCommonForOrder) {
        getFieldView().put("commonForOrder", isCommonForOrder);
    }

    private void setAvailableForBilling(Boolean isAvailableForBilling) {
        getFieldView().put("availableForBilling", isAvailableForBilling);
    }

    private void setAddHttp(Boolean addHttp) {
        getFieldView().put("addHttp", addHttp);
    }

    private void setWithText(Boolean withText) {
        getFieldView().put("withText", withText);
        if (withText) {
            field.getOrCreateNodeForPath("properties.linkText").put("type", "string");
            field.getOrCreateNodeForPath("properties.linkText").put("required", false);
            field.getOrCreateNodeForPath("properties.linkText").put("include_in_all", true);
            field.getOrCreateNodeForPath("properties.linkText").put("description", "Link");
            field.getOrCreateNodeForPath("properties.linkText.view").put("useParent", true);

        } else {
            field.getOrCreateNode("properties").remove("linkText");
        }
    }

    private void setVisible(Boolean order) {
        field.getOrCreateNodeForPath("view.e").put("visible", order);
        field.getOrCreateNodeForPath("view.v").put("visible", order);
    }

    private void setWidth(String size) {
        Integer width = size != null && size.equals("Half Width") ? 2 : 1;
        field.getOrCreateNodeForPath("view.e").put("width", width);
        field.getOrCreateNodeForPath("view.v").put("width", width);
    }

    private void setRows(String lines) {
        Integer rows = lines == null || lines.isEmpty() ? 5 : Integer.parseInt(lines);
        field.getOrCreateNodeForPath("view.e").put("rows", rows);
        field.getOrCreateNodeForPath("view.v").put("rows", rows);
    }

    public String getDateType() {
        return field.getOrCreateNodeForPath("view.e").getString("dateType");
    }

    private void setDateType(String dateType) {
        Map<String,String> dateTypes = new HashMap<String, String>();
        dateTypes.put("MM/DD/YEAR", "MM/dd/yyyy");
        dateTypes.put("DD/MM/YEAR", "dd/MM/yyyy");
        dateTypes.put("Month DD, Year", "MMMM dd, yyyy");
        dateTypes.put("DD Month, Year", "dd MMMM, yyyy");
        dateType = dateType != null && !dateType.isEmpty() ? dateTypes.get(dateType) : "MM/dd/yyyy";
        field.getOrCreateNodeForPath("view.e").put("dateType", dateType);
        field.getOrCreateNodeForPath("view.v").put("dateType", dateType);
    }

    private void setPhoneFormat(String phoneFormat) {
        phoneFormat = asList("USA", "Europe", "Universal").contains(phoneFormat) ? phoneFormat : "Universal";
        field.getOrCreateNodeForPath("view.e").put("phoneFormat", phoneFormat);
        field.getOrCreateNodeForPath("view.v").put("phoneFormat", phoneFormat);
    }

    public Double getOrder(String container) {
        return field.getOrCreateNodeForPath("view.e.order").getDouble(container);
    }

    public void setOrder(String container, Double order) {
        field.getOrCreateNodeForPath("view.e.order").put(container, order);
        field.getOrCreateNodeForPath("view.v.order").put(container, order);
    }

    public String getGroup(String container) {
        return field.getOrCreateNodeForPath("view.e.group").getString(container);
    }

    public void setGroup(String container, String group) {
        field.getOrCreateNodeForPath("view.e.group").put(container, group);
        field.getOrCreateNodeForPath("view.v.group").put(container, group);
    }

    public boolean isDateType() {
        return "date".equals(field.get("type"));
    }

    public boolean isStringType() {
        return "string".equals(field.get("type"));
    }

    /**
     * Build and return new custom metadata field
     *
     * @param properties
     *        hash with field information
     *        required properties: FieldType, Description, SchemaName, OrderGroupContainer
     *        optional properties: Hidden, Compulsory, FieldSize
     *
     *        other properties depends on 'FieldType' property
     *          string
     *            no other fields required
     *          multiline
     *            optional: NumberOfLines
     *          date
     *            optional: FieldFormat
     *          radioButtons
     *            required: DictionaryId
     *          dropdown
     *            required: DictionaryId
     *            optional: AddOnFly, MultipleChoices
     *          catalogueStructure
     *            required: DictionaryId
     *            optional: AddOnFly, Parent, ParentPath(required if Parent given)
    */
    public CustomMetadata build(Map<String,String> properties) {
        Boolean visible = !Boolean.parseBoolean(properties.get("Hidden"));
        Boolean required = visible && Boolean.parseBoolean(properties.get("Compulsory"));
        String fieldType = properties.get("FieldType");

        setIncludeInAll(true);
        setDescription(properties.get("Description"));
        setRequired(required);
        setSchemaName(properties.get("SchemaName"));
        setVisible(visible);
        setWidth(properties.get("FieldSize"));

        for (String container : properties.get("OrderGroupContainer").split(",")) {
            if (fieldType.equalsIgnoreCase("catalogueStructure") && properties.get("Parent") != null && !properties.get("Parent").isEmpty()) {
                setOrder(container, Double.parseDouble(properties.get(container + "Order")) + 0.1);
                setGroup(container, properties.get(container + "Group"));
            } else {
                setOrder(container, 0.0);
                setGroup(container, "_default");
            }
        }

        if (fieldType.equalsIgnoreCase("string")) {
            setType("string");
        } else if (fieldType.equalsIgnoreCase("multiline")) {
            setType("text");
            setTemplate("textarea");
            setRows(properties.get("NumberOfLines"));
        } else if (fieldType.equalsIgnoreCase("hyperlink")) {
            setType("object");
            setTemplate("hyperlink");
            setIsMultiField(true);
            setAddHttp(Boolean.parseBoolean(properties.get("AddHttp")));
            setWithText(properties.get("FieldFormat") != null && properties.get("FieldFormat").equalsIgnoreCase("TextLink"));
            setValidate(true);
            field.getOrCreateNodeForPath("properties.linkUrl").put("type", "string");
            field.getOrCreateNodeForPath("properties.linkUrl").put("required", false);
            field.getOrCreateNodeForPath("properties.linkUrl").put("include_in_all", true);
            field.getOrCreateNodeForPath("properties.linkUrl").put("description", "Link");
            field.getOrCreateNodeForPath("properties.linkUrl.view").put("useParent", true);
        } else if (fieldType.equalsIgnoreCase("date")) {
            setType("date");
            setDateType(properties.get("FieldFormat"));
        } else if (fieldType.equalsIgnoreCase("phone")) {
            setType("text");
            setTemplate("phone");
            setPhoneFormat(properties.get("PhoneFormat"));
        } else if (fieldType.equalsIgnoreCase("dropdown")) {
            setType("dictionary");
            setName(properties.get("DictionaryId"));
            setScope("agency");
            setExtendable(properties.get("AddOnFly"));
            if (!Boolean.parseBoolean(properties.get("MultipleChoices"))) setMaxItems(1);
            setIsMultilevel(false);
        } else if (fieldType.equalsIgnoreCase("radioButtons")) {
            setType("dictionary");
            setName(properties.get("DictionaryId"));
            setScope("agency");
            setExtendable("false");
            setTemplate("radio");
            setIsMultilevel(false);
        } else if (fieldType.equalsIgnoreCase("catalogueStructure")) {
            setType("dictionary");
            setScope("agency");

            if (properties.get("Parent") != null && !properties.get("Parent").isEmpty()) {
                setDependField(properties.get("Parent"), properties.get("ParentPath"));
                setName(properties.get("DictionaryId"));
            } else {
                setName(properties.get("DictionaryId"));
            }

            setExtendable(properties.get("AddOnFly"));
            setOrderingTags(properties.get("AvailableInDelivery"));
            setCommonForOrder(Boolean.parseBoolean(properties.get("CommonForOrder")));
            setAvailableForBilling(Boolean.parseBoolean(properties.get("AvailableForBilling")));
            setMaxItems(1);
            setIsMultilevel(true);
        } else {
            throw new IllegalArgumentException(String.format("Unknown field type: '%s'", fieldType));
        }

        return field;
    }

    /**
     * Update and existing custom metadata field
     *
     * @param properties
     *        hash with field update information
     *        required properties: FieldType, Description
     *        optional properties: Hidden, Compulsory, FieldSize
     *
     *        other properties depends on 'FieldType' property
     *          string
     *            no other fields required
     *          multiline
     *            optional: NumberOfLines
     *          date
     *            optional: FieldFormat
     *          radioButtons
     *            no other fields required
     *          dropdown
     *            optional: AddOnFly, MultipleChoices
     *          catalogueStructure
     *            optional: AddOnFly
     */
    public CustomMetadata update(Map<String,String> properties) {
        Boolean visible = !Boolean.parseBoolean(properties.get("Hidden"));
        Boolean required = visible && Boolean.parseBoolean(properties.get("Compulsory"));
        String fieldType = properties.get("FieldType");

        if (properties.get("NewDescription") != null && !properties.get("NewDescription").isEmpty()) {
            setDescription(properties.get("NewDescription"));
        }
        setRequired(required);
        setVisible(visible);
        setWidth(properties.get("FieldSize"));

        if (fieldType.equalsIgnoreCase("string")) {
        } else if (fieldType.equalsIgnoreCase("multiline")) {
            if (properties.get("NumberOfLines") != null && !properties.get("NumberOfLines").isEmpty()) {
                setRows(properties.get("NumberOfLines"));
            }
        } else if (fieldType.equalsIgnoreCase("hyperlink")) {
            setAddHttp(Boolean.parseBoolean(properties.get("AddHttp")));
            setWithText(properties.get("FieldFormat").equalsIgnoreCase("TextLink"));
        } else if (fieldType.equalsIgnoreCase("radioButtons")) {
        } else if (fieldType.equalsIgnoreCase("date")) {
            if (properties.get("FieldFormat") != null && !properties.get("FieldFormat").isEmpty()) setDateType(properties.get("FieldFormat"));
        } else if (fieldType.equalsIgnoreCase("phone")) {
            setPhoneFormat(properties.get("PhoneFormat"));
        } else if (fieldType.equalsIgnoreCase("dropdown") || fieldType.equalsIgnoreCase("catalogueStructure")) {
            setExtendable(properties.get("AddOnFly"));

            if(properties.containsKey("Validate"))
                setValidate(properties.get("Validate").equals("false")?false:true);
            if(properties.containsKey("Parent"))
                if (properties.get("Parent") == null && properties.get("Parent").isEmpty()) {
                setDependField(properties.get("Parent"), properties.get("ParentPath"));
                setName(properties.get("DictionaryId"));
                }
            if(properties.containsKey("Deleted"))
                setIsdeleted(properties.get("Deleted").equals("false")?false:true);
            if (Boolean.parseBoolean(properties.get("MultipleChoices"))) {
                removeMaxItems();
            } else {
                setMaxItems(1);
            }
        } else {
            throw new IllegalArgumentException(String.format("Unknown field type: '%s'", fieldType));
        }

        return field;
    }
}