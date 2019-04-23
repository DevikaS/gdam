package com.adstream.automate.babylon;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonPrimitive;

/**
 * Created with IntelliJ IDEA.
 * User: daddy
 * Date: 11/5/12
 * Time: 5:11 PM
 */
public class JsonObjectBuilder {
    private JsonObject mainObject;
    private JsonObject currentObject;

    public JsonObjectBuilder() {
        this(new JsonObject());
    }

    public JsonObjectBuilder(JsonObject jsonObject) {
        this.mainObject = jsonObject;
        this.currentObject = jsonObject;
    }

    public JsonObjectBuilder forNode(String path) {
        for (String item : path.split("\\.")) {
            if (!currentObject.has(item)) {
                currentObject.add(item, new JsonObject());
            }
            currentObject = currentObject.get(item).getAsJsonObject();
        }
        return this;
    }

    public JsonObjectBuilder forRootNode() {
        currentObject = mainObject;
        return this;
    }

    public JsonObjectBuilder add(String key, String value) {
        if (value != null) {
            currentObject.addProperty(key, value);
        }
        return this;
    }

    public JsonObjectBuilder add(String key, Number value) {
        if (value != null) {
            currentObject.addProperty(key, value);
        }
        return this;
    }

    public JsonObjectBuilder add(String key, Boolean value) {
        if (value != null) {
            currentObject.addProperty(key, value);
        }
        return this;
    }

    public JsonObjectBuilder add(String key, JsonElement value) {
        if (value != null) {
            currentObject.add(key, value);
        }
        return this;
    }

    public JsonObjectBuilder addArray(String key, String... value) {
        JsonArray arr = new JsonArray();
        for (String item : value) {
            arr.add(new JsonPrimitive(item));
        }
        add(key, arr);
        return this;
    }

    public JsonObjectBuilder addArray(String key, Number... value) {
        JsonArray arr = new JsonArray();
        for (Number item : value) {
            arr.add(new JsonPrimitive(item));
        }
        add(key, arr);
        return this;
    }

    public JsonObjectBuilder addArray(String key, Boolean... value) {
        JsonArray arr = new JsonArray();
        for (Boolean item : value) {
            arr.add(new JsonPrimitive(item));
        }
        add(key, arr);
        return this;
    }

    public JsonObjectBuilder addArray(String key, JsonElement... value) {
        JsonArray arr = new JsonArray();
        for (JsonElement item : value) {
            arr.add(item);
        }
        add(key, arr);
        return this;
    }

    public JsonObject build() {
        return mainObject;
    }
}
