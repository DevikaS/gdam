package com.adstream.automate.babylon.JsonObjects;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonPrimitive;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * User: ruslan.semerenko
 * Date: 05.08.13 15:23
 */
public class AssetFilterTerms {
    private Map<String, String[]> terms = new HashMap<>();
    private List<String> categories = new ArrayList<>();

    public AssetFilterTerms add(String fieldName, String... fieldValues) {
        terms.put(fieldName, fieldValues);
        return this;
    }

    public AssetFilterTerms addCategory(String categoryId) {
        categories.add(categoryId);
        return this;
    }

    public JsonObject getQuery() {
        JsonArray jsonTerms = new JsonArray();
        for (Map.Entry<String, String[]> entry : terms.entrySet()) {
            JsonArray jsonTermValue = new JsonArray();
            for (String value : entry.getValue()) {
                jsonTermValue.add(new JsonPrimitive(value));
            }

            JsonObject jsonTermEntry = new JsonObject();
            jsonTermEntry.add(entry.getKey(), jsonTermValue);

            JsonObject jsonTerm = new JsonObject();
            jsonTerm.add("terms", jsonTermEntry);

            jsonTerms.add(jsonTerm);
        }

        if (categories.size() > 0) {
            JsonArray jsonTermValue = new JsonArray();
            for (String categoryId : categories) {
                jsonTermValue.add(new JsonPrimitive(categoryId));
            }

            JsonObject jsonTerm = new JsonObject();
            jsonTerm.add("categories", jsonTermValue);

            jsonTerms.add(jsonTerm);
        }

        JsonObject query = new JsonObject();
        query.add("and", jsonTerms);

        return query;
    }
}
