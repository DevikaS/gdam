package com.adstream.automate.babylon.JsonObjects.dictionary;

/**
 * User: Ruslan Semerenko
 * Date: 30.03.13 11:09
 */
public class DictionaryItem {
    private String key;
    private DictionaryValues values;
    // country
    private String name;
    // time_zone
    private String GMT;
    private String DST;

    public String getKey() {
        return key;
    }

    public DictionaryValues getValues() {
        return values;
    }

    public String getName() {
        return name;
    }

    public String getGMT() {
        return GMT;
    }

    public String getDST() {
        return DST;
    }

    public DictionaryItem setKey(String key) {
        this.key = key;
        return this;
    }

    public DictionaryItem setValues(DictionaryValues values) {
        this.values = values;
        return this;
    }

    public String toString() {
        return String.format("{key=\"%s\", values=\"%s\"}", key, values);
    }
}
