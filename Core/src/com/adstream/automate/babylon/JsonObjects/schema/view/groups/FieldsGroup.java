package com.adstream.automate.babylon.JsonObjects.schema.view.groups;

import com.adstream.automate.babylon.JsonObjects.CustomMetadata;

import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: lynda-k
 * Date: 17.09.13
 * Time: 10:36
 */
public class FieldsGroup {
    CustomMetadata group;

    public FieldsGroup() {
        group = new CustomMetadata();
    }

    public FieldsGroup(CustomMetadata group) {
        this.group = group;
    }

    public CustomMetadata getGroup() {
        return group;
    }

    public void setGroup(CustomMetadata group) {
        this.group = group;
    }

    public CustomMetadata build(Map<String,String> properties) {
        group.put("description", properties.get("Description"));
        group.put("group", properties.get("GroupId"));
        group.put("order", 0);
        return group;
    }
}
