package com.adstream.automate.babylon.data;

/**
 * User: konstantin.lynda
 * Date: 22.02.13 13:31
 */
public enum CustomMetadataFieldType {
    STRING("String"),
    DATE("Date"),
    MULTILINE("Multiline"),
    PHONE("Phone"),
    DROPDOWN("Dropdown"),
    CATALOGUE_STRUCTURE("Catalogue Structure"),
    ADDRESS("Address"),
    RADIO_BUTTONS("Radio Buttons"),
    HYPERLINK("Hyperlink"),
    SECTION_BREAK("Section Break");

    private String value;

    private CustomMetadataFieldType(String value) {
        this.value = value;
    }

    public String toString() {
        return value;
    }

    public static CustomMetadataFieldType getForValue(String value) {
        for (CustomMetadataFieldType fieldType : values()) {
            if (fieldType.toString().equals(value)) {
                return fieldType;
            }
        }
        throw new IllegalArgumentException("Unknown type: " + value);
    }
}