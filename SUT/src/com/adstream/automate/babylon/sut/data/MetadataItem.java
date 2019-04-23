package com.adstream.automate.babylon.sut.data;

public class MetadataItem {
    public static final String DEFAULT_SECTION = "default";

    private String section;
    private String key;
    private String value;

    public MetadataItem(String key, String value) {
        this.key = key;
        this.value = value;
    }

    public MetadataItem(String section, String key, String value) {
        this.section = section;
        this.key = key;
        this.value = value;
    }

    public String getSection() {
        return section;
    }

    public void setSection(String section) {
        this.section = section;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        MetadataItem that = (MetadataItem) o;

        if (key != null ? !key.equalsIgnoreCase(that.key) : that.key != null) return false;
        if (section != null ? !section.equalsIgnoreCase(that.section) : that.section != null) return false;
        if (value != null ? !value.equalsIgnoreCase(that.value) : that.value != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = section != null ? section.hashCode() : 0;
        result = 31 * result + (key != null ? key.hashCode() : 0);
        result = 31 * result + (value != null ? value.hashCode() : 0);
        return result;
    }

    @Override
    public String toString() {
        return String.format("section='%s' key='%s' value='%s'",
                section == null ? DEFAULT_SECTION : section, key, value);
    }
}
