package com.adstream.automate.babylon.JsonObjects.dictionary;

import java.util.ArrayList;
import java.util.List;

/**
 * User: Ruslan Semerenko
 * Date: 30.03.13 11:14
 */
public class DictionaryValues extends ArrayList<DictionaryItem> {
    public List<String> getKeys() {
        List<String> keys = new ArrayList<String>();
        for (DictionaryItem item : this) {
            keys.add(item.getKey());
        }
        return keys;
    }

    public DictionaryItem get(String key) {
        for (DictionaryItem item : this) {
            if(item.getKey().equals(key)) {
                return item;
            }
        }
        return null;
    }
}
