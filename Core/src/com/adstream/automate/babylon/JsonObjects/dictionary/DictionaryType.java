package com.adstream.automate.babylon.JsonObjects.dictionary;

/**
 * User: Ruslan Semerenko
 * Date: 30.03.13 11:04
 */
public enum DictionaryType {
    COUNTRY("country"),
    MEDIA_SUB_TYPES("media_sub_types"),
    ORGANISATION_TYPE("organisation_type"),
    PERMISSION("permission"),
    PRINT_MEDIA("print_media"),
    PRINT_STATUS("print_status"),
    PROJECT_MEDIA_TYPE("project_media_type"),
    REEL_PREVIEW_FIELDS("reel_preview_fields"),
    TIME_ZONE("time_zone"),
    USAGE_RIGHTS_TYPE("usage_rights_type"),
    VIDEO_SCREEN("video_screen");

    private String type;

    private DictionaryType(String type) {
        this.type = type;
    }

    public String toString() {
        return type;
    }
}
